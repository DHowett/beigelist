#import "Classes/BLAppManager.h"
#import "Classes/BLAppLegacyMerchant.h"

#import <objc/runtime.h>
 template <typename Type_>
 static inline Type_ &MSHookIvar(id self, const char *name) {
     Ivar ivar(class_getInstanceVariable(object_getClass(self), name));
     void *pointer(ivar == NULL ? NULL : reinterpret_cast<char *>(self) + ivar_getOffset(ivar));
     return *reinterpret_cast<Type_ *>(pointer);
 }

static char const * const kBLMainMenuSelectedApplianceID = "kBLMainMenuSelectedApplianceID";
static char const * const kBLMainMenuSelectedMerchantID = "kBLMainMenuSelectedMerchantID";

%hook ATVMerchantCoordinator

@class BLAppManager;

- (id)allMerchants
{
	NSArray *merchants = %orig;
    	NSMutableArray *applianceMerchants = [NSMutableArray arrayWithArray:[[BLAppManager sharedAppManager] appliances]];
	
	for (int i = [applianceMerchants count] - 1; i >= 0; i--)
	{
		BLAppLegacyMerchant* merchant = [applianceMerchants objectAtIndex:i];
		if ([merchant presentedInTopRow])
			[applianceMerchants removeObjectAtIndex:i];
	}
    
    	NSMutableArray *returnArray = [NSMutableArray array];
	[returnArray addObjectsFromArray: merchants];
    	[returnArray addObjectsFromArray: applianceMerchants];

    	return returnArray;
}

%end


%hook BRApplianceManager

- (void)loadAppliances
{
	%orig;
	
	// this code implicitly adds appliance to BRApplianceManager
	NSArray *applianceMerchants = [[BLAppManager sharedAppManager] appliances];
	for (BLAppLegacyMerchant* merchant in applianceMerchants)
	{
		if ([merchant showInTopRow])
			[[BRApplianceManager singleton] _applianceDidReloadCategories:[merchant applianceInstance]];
	}
}

%end


%hook ATVMainMenuController

- (id)appliances
{
	NSArray* orig = %orig;
	NSMutableArray* appliances = [NSMutableArray arrayWithArray:orig];
	NSArray *applianceMerchants = [[BLAppManager sharedAppManager] appliances];
	BOOL changed = NO;
	
	for (int i = [appliances count] - 1; i >= 0; i--)
	{
		for (BLAppLegacyMerchant* merchant in applianceMerchants)
		{
		if ([appliances objectAtIndex:i] == [merchant applianceInstance] && [merchant showInTopRow])
			{
				BOOL show = [merchant presentedInTopRow];
				if ([appliances count] > 5)
				{
					[appliances removeObjectAtIndex:i];
					[merchant setPresentedInTopRow:NO];
				}
				else
					[merchant setPresentedInTopRow:YES];
				if (show != [merchant presentedInTopRow])
					changed = YES;
			}
		}
	}
	
	if (changed)
	{
		if([NSClassFromString(@"ATVMerchantCoordinator") respondsToSelector:@selector(singleton)])
		{
			[[NSClassFromString(@"ATVMerchantCoordinator") singleton] _updateMerchants];	
		} else {
			[[NSClassFromString(@"ATVMerchantCoordinator") sharedInstance] _updateMerchants];
		}
		
	}
		
	
	return appliances;
}

- (id)_imageForAppliance:(id)appliance
{
	NSArray *applianceMerchants = [[BLAppManager sharedAppManager] appliances];
	for (BLAppLegacyMerchant* merchant in applianceMerchants)
	{
		if ([appliance isKindOfClass:[merchant legacyApplianceClass]] && [merchant showInTopRow])
		{
			NSBundle* bundle = [NSBundle bundleForClass:[appliance class]];
			BRImage* img = [BRImage imageWithPath:[bundle pathForResource:@"TopRowIcon" ofType:@"png"]];
			return img;
		}
	}
	
	return %orig;
}

- (void)controlWasActivated
{
    %orig;

	[NSClassFromString(@"ATVSettingsFacade") initializePlatformFacade];
	if ([[[NSClassFromString(@"ATVSettingsFacade") singleton] versionOS] isEqual:@"5.1.1"])
	{
    	NSString *applianceID = (NSString *)objc_getAssociatedObject(self, kBLMainMenuSelectedApplianceID);
    	NSString *merchantID = (NSString *)objc_getAssociatedObject(self, kBLMainMenuSelectedMerchantID);

		NSLog(@"[beigelist] merchantID %@ applianceID %@", merchantID, applianceID);

    	// restore state of the GUI
    	id grid = MSHookIvar<id>(self, "_internetContentGrid");
    
		if (merchantID)
		{
			grid = MSHookIvar<id>(self, "_internetContentGrid");
			NSArray* merchants = [[grid dataSource] itemsForGrid:grid];
			for (int i = 0; i < [merchants count]; i++)
			{
				BRMerchant* merchant = [merchants objectAtIndex:i];

				if ([[merchant identifier] isEqual:merchantID])
				{
					[MSHookIvar<id>(self, "_containerView") setFocusedControl:[grid parent]];
					[grid setSelection: i];
					break;
				}
			}
		}
		else if (applianceID)
			[self focusApplianceWithIdentifier: applianceID];
	}
}

- (void)controlWasDeactivated
{
	%orig;

	[NSClassFromString(@"ATVSettingsFacade") initializePlatformFacade];
	if ([[[NSClassFromString(@"ATVSettingsFacade") singleton] versionOS] isEqual:@"5.1.1"])
	{
		NSLog(@"[beigelist] will clean up main menu");

		// state of the GUI
		NSString* applianceID = nil;
		NSString* merchantID = nil;

		id grid = MSHookIvar<id>(self, "_internetContentGrid");
		if ([MSHookIvar<id>(self, "_containerView") focusedControl] == [grid parent])
		{
			int merchantIndex = [grid selectedIndex];
			NSArray* merchants = [[grid dataSource] itemsForGrid:grid];

			if (merchantIndex >= 0 && merchantIndex < [merchants count])
				merchantID = [[merchants objectAtIndex:merchantIndex] identifier];
		}
		else
		{
			applianceID = [[[self focusedAppliance] applianceInfo] key];
		}

		objc_setAssociatedObject(self, kBLMainMenuSelectedApplianceID, applianceID, OBJC_ASSOCIATION_RETAIN);
		objc_setAssociatedObject(self, kBLMainMenuSelectedMerchantID, merchantID, OBJC_ASSOCIATION_RETAIN);

		// this seems to resolve memory issues
		[self _reload];
	}
}

%end


%class ATVMerchantCoordinator
%ctor {
	NSLog( @"beigelist5 (beigelist5-%s) loaded.", VERSION);
	%init;
	
	[[NSClassFromString(@"BLAppManager") sharedAppManager] loadAppliances];

}
