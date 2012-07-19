#import "Classes/BLAppManager.h"
//#import "Classes/BLAppLegacyMerchant.h"

//tried doing the fraphooks thing so i could prevent all of this from loading till later. apparently its not hte code in here thats the problem, something in one of hte other classes
//%group FrapHooks 

/*

this was because i couldnt get it to stop complaining about line 88 and maybe another one too, obviously seems wrong. but i dont think this has
anything to do with why its crashing.


*/


%hook ATVMerchantCoordinator

@class BLAppManager;

- (id)allMerchants
{
	%log;
	NSArray *merchants = %orig;
	id sharedAppManager = [BLAppManager sharedAppManager];
	NSArray *applianceMerchants = [sharedAppManager appliances];
	
	NSMutableArray *returnArray = [NSMutableArray array];
    [returnArray addObjectsFromArray: merchants];
	[returnArray addObjectsFromArray: applianceMerchants];

    return returnArray;
}


%end



%class ATVMerchantCoordinator
%ctor {
	NSLog( @"beigelist6 (beigelist6-%s) loaded.", VERSION);
	
//	class_setSuperclass(NSClassFromString(@"BLAppLegacyMerchant"), NSClassFromString(@"ATVMerchant"));
%init;
	[[NSClassFromString(@"BLAppManager") sharedAppManager] loadAppliances];
	
}
