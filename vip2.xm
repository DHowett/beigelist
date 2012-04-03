/* {{{ BackRow Imports */

/*
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
@property (nonatomic, readwrite, retain) NSArray *appliances;
- (id)_loadApplianceAtPath:(NSString *)folder;
@end

*/



/* }}} */

#import "AppleTV.h"
#import "Beigelist.h"
#import "Classes/BLAppManager.h"

static BOOL _8F455Plus = NO;
static BOOL _51Plus = NO;

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
- (id)_loadApplianceAtPath:(NSString *)path {
	
	if(_51Plus)
	{
		NSLog(@"5.1+ just returning the orig!");
		return %orig;
	}
	
	NSBundle *applianceBundle = [NSBundle bundleWithPath:path];
	if(!applianceBundle) return nil;

	BRApplianceInfo *applianceInfo = [BRApplianceInfo infoForApplianceBundle:applianceBundle];
	if(![applianceBundle bundleIdentifier]) return nil;

	Class principalClass = [applianceBundle principalClass];
	if(![principalClass conformsToProtocol:@protocol(BRAppliance)]) {
		NSLog( @"Appliance %@'s principal class %@ does not conform to the BRAppliance protocol.", [applianceBundle bundleIdentifier], NSStringFromClass(principalClass));
		return nil;
	}

	NSDictionary *infoDictionary = [applianceBundle infoDictionary];
	NSString *featureName = [infoDictionary objectForKey:@"FRFeatureName"];
	NSString *antiFeatureName = [infoDictionary objectForKey:@"FRAntiFeatureName"];
	if(featureName) {
		if(![[BRFeatureManager sharedInstance] isFeatureEnabled:featureName]) {
			NSLog( @"Appliance %@ not loaded due to missing feature %@.", [applianceBundle bundleIdentifier], featureName);
			return nil;
		}
	}

	if(antiFeatureName) {
		if([[BRFeatureManager sharedInstance] isFeatureEnabled:antiFeatureName]) {
			NSLog( @"Appliance %@ not loaded due to present anti-feature %@.", [applianceBundle bundleIdentifier], antiFeatureName);
			return nil;
		}
	}

	int access = [[BRParentalControlManager sharedInstance] computeAccessModeForAppliance:[applianceInfo key] withCategoryIdentifier:nil];
	if(access == 1) {
		NSLog( @"Appliance %@ not loaded due parental control.", [applianceBundle bundleIdentifier]);
		return nil;
	}

	for(Class<BeigelistApplianceLoadListener> loadListener in _applianceLoadListeners) {
		if(class_respondsToSelector(object_getClass(loadListener), @selector(shouldLoadApplianceBundle:))) {
			if(![loadListener shouldLoadApplianceBundle:applianceBundle]) return nil;
		}
	}

	id<BRAppliance> appliance = [[[principalClass alloc] init] autorelease];
	if([[appliance applianceCategories] count] == 0 && [applianceInfo hideIfNoCategories]) {
		NSLog( @"Appliance %@ not loaded because it doesn't have any categories.", [applianceBundle bundleIdentifier]);
		return nil;
	}

	if(!_8F455Plus) {
		[MSHookIvar<NSMutableArray *>(self, "_applianceList") addObject:appliance];
	}

	for(Class<BeigelistApplianceLoadListener> loadListener in _applianceLoadListeners) {
		if(class_respondsToSelector(object_getClass(loadListener), @selector(loadedApplianceBundle:))) {
			[loadListener loadedApplianceBundle:applianceBundle];
		}
	}

	return appliance;
}

- (void)loadAppliances {
	%orig;
	
	if(_51Plus)
	{
		NSLog(@"loadAppliances 5.1+ just returning!");
		return;
	}

	NSMutableArray *appliances = (_8F455Plus ? [[self appliances] mutableCopy] : nil);

	NSDirectoryEnumerator *iterator = [[NSFileManager defaultManager] enumeratorAtPath:@"/Library/Appliances"];

	NSString *filePath = nil;
	while((filePath = [iterator nextObject])) {
		if([filePath hasSuffix:@"frappliance"]) {
			id appliance = [self _loadApplianceAtPath:[@"/Library/Appliances" stringByAppendingPathComponent:filePath]];
			[appliances addObject:appliance];
			[iterator skipDescendents];
		}
	}

	if(_8F455Plus) [self setAppliances:[appliances autorelease]];
}
%end




%hook ATVMerchantCoordinator

@class BLAppManager;

- (id)allMerchants
{
	NSArray *merchants = %orig;
	id sharedAppManager = [BLAppManager sharedAppManager];
	NSArray *applianceMerchants = [sharedAppManager appliances];
	
	NSMutableArray *returnArray = [NSMutableArray array];
    [returnArray addObjectsFromArray: merchants];
	[returnArray addObjectsFromArray: applianceMerchants];

    return returnArray;
}

%end


%class BRApplianceManager
%ctor {
	NSLog( @"beigelist (beigelist-%s) loaded.", VERSION);
	%init;
	_8F455Plus = [%c(BRApplianceManager) instancesRespondToSelector:@selector(setAppliances:)];
	_51Plus = [%c(BRApplianceManager) instancesRespondToSelector:@selector(_shouldLoadApp:)];
	if (_51Plus){
		
		Class blam = NSClassFromString(@"BLAppManager");
		[[blam sharedAppManager] loadAppliances];

	}
}
