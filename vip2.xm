/* {{{ BackRow Imports */
@protocol BRAppliance <NSObject>
- (NSArray *)applianceCategories;
@end

@interface BRApplianceInfo: NSObject { }
@property(retain) id key;
@property(assign) BOOL hideIfNoCategories;
+ (BRApplianceInfo *)infoForApplianceBundle:(NSBundle *)bundle;
@end

@interface BRSingleton: NSObject { }
+ (id)sharedInstance;
@end

@interface BRApplianceManager: BRSingleton { }
- (void)_loadApplianceAtPath:(NSString *)folder;
@end

@interface BRFeatureManager: BRSingleton { }
- (BOOL)isFeatureEnabled:(id)feature;
@end

@interface BRParentalControlManager: BRSingleton { }
- (int)computeAccessModeForAppliance:(id)appliance withCategoryIdentifier:(id)categoryIdentifier;
@end

extern "C" void BRSystemLog(int level, NSString *format, ...);
/* }}} */

#import "Beigelist.h"

static NSMutableArray *_applianceLoadListeners = nil;
@implementation Beigelist
+ (void)registerApplianceLoadListener:(Class<BeigelistApplianceLoadListener>)loadListener {
	if(!_applianceLoadListeners) {
		_applianceLoadListeners = [[NSMutableArray alloc] init];
	}
	[_applianceLoadListeners addObject:loadListener];
}
@end

%hook BRApplianceManager
- (void)_loadApplianceAtPath:(NSString *)path {
	NSBundle *applianceBundle = [NSBundle bundleWithPath:path];
	if(!applianceBundle) return;

	BRApplianceInfo *applianceInfo = [BRApplianceInfo infoForApplianceBundle:applianceBundle];
	if(![applianceBundle bundleIdentifier]) return;

	Class principalClass = [applianceBundle principalClass];
	if(![principalClass conformsToProtocol:@protocol(BRAppliance)]) {
		BRSystemLog(3, @"Appliance %@'s principal class %@ does not conform to the BRAppliance protocol.", [applianceBundle bundleIdentifier], NSStringFromClass(principalClass));
		return;
	}

	NSDictionary *infoDictionary = [applianceBundle infoDictionary];
	NSString *featureName = [infoDictionary objectForKey:@"FRFeatureName"];
	NSString *antiFeatureName = [infoDictionary objectForKey:@"FRAntiFeatureName"];
	if(featureName) {
		if(![[BRFeatureManager sharedInstance] isFeatureEnabled:featureName]) {
			BRSystemLog(3, @"Appliance %@ not loaded due to missing feature %@.", [applianceBundle bundleIdentifier], featureName);
			return;
		}
	}

	if(antiFeatureName) {
		if([[BRFeatureManager sharedInstance] isFeatureEnabled:antiFeatureName]) {
			BRSystemLog(3, @"Appliance %@ not loaded due to present anti-feature %@.", [applianceBundle bundleIdentifier], antiFeatureName);
			return;
		}
	}

	int access = [[BRParentalControlManager sharedInstance] computeAccessModeForAppliance:[applianceInfo key] withCategoryIdentifier:nil];
	if(access != 1) {
		BRSystemLog(3, @"Appliance %@ not loaded due parental control.", [applianceBundle bundleIdentifier]);
	}

	for(Class<BeigelistApplianceLoadListener> loadListener in _applianceLoadListeners) {
		if(class_respondsToSelector(object_getClass(loadListener), @selector(shouldLoadApplianceBundle:))) {
			if(![loadListener shouldLoadApplianceBundle:applianceBundle]) return;
		}
	}

	id<BRAppliance> appliance = [[principalClass alloc] init];
	if([[appliance applianceCategories] count] == 0 && [applianceInfo hideIfNoCategories]) {
		BRSystemLog(3, @"Appliance %@ not loaded because it doesn't have any categories.", [applianceBundle bundleIdentifier]);
		[appliance release];
		return;
	}

	[MSHookIvar<NSMutableArray *>(self, "_applianceList") addObject:appliance];
	[appliance release];

	for(Class<BeigelistApplianceLoadListener> loadListener in _applianceLoadListeners) {
		if(class_respondsToSelector(object_getClass(loadListener), @selector(loadedApplianceBundle:))) {
			[loadListener loadedApplianceBundle:applianceBundle];
		}
	}

	return;
}

- (void)loadAppliances {
	%orig;

	NSDirectoryEnumerator *iterator = [[NSFileManager defaultManager] enumeratorAtPath:@"/Library/Appliances"];

	NSString *filePath = nil;
	while((filePath = [iterator nextObject])) {
		if([filePath hasSuffix:@"frappliance"]) {
			[self _loadApplianceAtPath:[@"/Library/Appliances" stringByAppendingPathComponent:filePath]];
			[iterator skipDescendents];
		}
	}
}
%end
