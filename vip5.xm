
#import "Classes/BLAppManager.h"
#import "Classes/BLAppLegacyMerchant.h"


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
			if ([[appliances objectAtIndex:i] isKindOfClass:[merchant legacyApplianceClass]] && [merchant showInTopRow])
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
		[[NSClassFromString(@"ATVMerchantCoordinator") singleton] _updateMerchants];
	
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

%end


%class ATVMerchantCoordinator
%ctor {
	NSLog( @"beigelist5 (beigelist5-%s) loaded.", VERSION);
	%init;
	
	[[NSClassFromString(@"BLAppManager") sharedAppManager] loadAppliances];

}
