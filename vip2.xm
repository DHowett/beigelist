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

@interface BRFeatureManager: BRSingleton { }
- (BOOL)isFeatureEnabled:(id)feature;
@end

@interface BRParentalControlManager: BRSingleton { }
- (int)computeAccessModeForAppliance:(id)appliance withCategoryIdentifier:(id)categoryIdentifier;
@end

extern "C" void BRSystemLog(int level, NSString *format, ...);
/* }}} */

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

	id<BRAppliance> appliance = [[principalClass alloc] init];
	if([[appliance applianceCategories] count] == 0 && [applianceInfo hideIfNoCategories]) {
		BRSystemLog(3, @"Appliance %@ not loaded because it doesn't have any categories.", [applianceBundle bundleIdentifier]);
		[appliance release];
		return;
	}

	[MSHookIvar<NSMutableArray *>(self, "_applianceList") addObject:appliance];
	[appliance release];
	return;
}
%end
