
#import "Classes/BLAppManager.h"

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


%class ATVMerchantCoordinator
%ctor {
	NSLog( @"beigelist5 (beigelist5-%s) loaded.", VERSION);
	%init;
	
	[[NSClassFromString(@"BLAppManager") sharedAppManager] loadAppliances];

}
