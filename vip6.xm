#import "Classes/BLAppManager.h"
//#import "Classes/BLAppLegacyMerchant.h"

//tried doing the fraphooks thing so i could prevent all of this from loading till later. apparently its not hte code in here thats the problem, something in one of hte other classes
//%group FrapHooks 

/*

this was because i couldnt get it to stop complaining about line 88 and maybe another one too, obviously seems wrong. but i dont think this has
anything to do with why its crashing.


*/

@interface BLAppLegacyMerchant : NSObject 

	- (BOOL)showInTopRow;
	- (BOOL)presentedInTopRow;
@end

%hook ATVMerchantCoordinator

@class BLAppManager;

- (id)allMerchants
{
	%log;
	NSArray *merchants = %orig;
    	NSMutableArray *applianceMerchants = [NSMutableArray arrayWithArray:[[BLAppManager sharedAppManager] appliances]];
	
	for (int i = [applianceMerchants count] - 1; i >= 0; i--)
	{
		id merchant = [applianceMerchants objectAtIndex:i];
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

@class BLAppManager;

- (void)loadAppliances
{
	%log;
	%orig;
	
	// this code implicitly adds appliance to BRApplianceManager
	NSArray *applianceMerchants = [[BLAppManager sharedAppManager] appliances];
	for (id merchant in applianceMerchants)
	{
		if ([merchant showInTopRow])
			[[NSClassFromString(@"BRApplianceManager") singleton] _applianceDidReloadCategories:[merchant applianceInstance]];
	}
}

%end


%hook ATVMainMenuController

@class BLAppManager;
@class BLAppLegacyMerchant;

- (id)appliances
{
	%log;
	NSArray* orig = %orig;
	NSMutableArray* appliances = [NSMutableArray arrayWithArray:orig];
	NSArray *applianceMerchants = [[BLAppManager sharedAppManager] appliances];
	BOOL changed = NO;
	
	for (int i = [appliances count] - 1; i >= 0; i--)
	{
		for (BLAppLegacyMerchant *merchant in applianceMerchants)
		{
		if ([appliances objectAtIndex:i] == [merchant applianceInstance] && [merchant showInTopRow])
			{
				BOOL show = (BOOL)[merchant presentedInTopRow];
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

#define BRI NSClassFromString(@"BRImage")

- (id)_imageForAppliance:(id)appliance
{
	%log;
	NSArray *applianceMerchants = [[BLAppManager sharedAppManager] appliances];
	for (id merchant in applianceMerchants)
	{
		if ([appliance isKindOfClass:[merchant legacyApplianceClass]] && [merchant showInTopRow])
		{
			NSBundle* bundle = [NSBundle bundleForClass:[appliance class]];
			id img = [BRI imageWithPath:[bundle pathForResource:@"TopRowIcon" ofType:@"png"]];
			return img;
		}
	}
	
	return %orig;
}

%end

// %end
// 
// %hook LTAppDelegate
// 
// - (void)applicationDidFinishLaunching:(id)application //makes no difference :(
// {
// 	%log;
// 	%orig;
// 		%init(FrapHooks);
// }
// 


%class ATVMerchantCoordinator
%ctor {
	NSLog( @"beigelist6 (beigelist6-%s) loaded.", VERSION);
	%init;
	
//	[[NSClassFromString(@"BLAppManager") sharedAppManager] loadAppliances];

}
