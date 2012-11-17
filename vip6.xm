#import "Classes/BLAppManager.h"


%hook ATVMerchantCoordinator

@class BLAppManager;

/*
 
 5.x beigelist versions we overrode allMerchants instead of enabledMerchants and just setting our legacy merchant class to enabled would be enough to get it filtered in.
 in 6.0 this is not enough, this is a super hacky workaround to get our appliances loaded in. I override enabledMerchants to get it on the main screen, and then when 
 - (id)rootControllerForMerchantIdentifier:(id)merchantIdentifier is called it references merchantWithIdentifier. which will be explained below
 

 ugh so i've tried everything i can think of, orderedMerchantIdentifiers don't see to ever be used in any useful fashion (re - loading) 
 
 the _enabledMerchantsFilterPredicate doesnt appear lend any help either (@'enabled == 1 AND info.loaded-via-addsite != 1 AND identifier != "internet-add-site"')
 
 */

	//applianceIdentifiers

/*

- (NSArray *)orderedMerchantIdentifiers 
{
	%log;
	NSArray *merchantsIDs = %orig;
	id sharedAppManager = [BLAppManager sharedAppManager];
	NSArray *applianceMerchants = [sharedAppManager applianceIdentifiers];
	
	NSMutableArray *returnArray = [NSMutableArray array];
    [returnArray addObjectsFromArray: applianceMerchants];
	[returnArray addObjectsFromArray: merchantsIDs];
	
	return returnArray;
}


- (id)enabledMerchants 
{
		//%log;
	NSArray *merchants = %orig;
	id sharedAppManager = [BLAppManager sharedAppManager];
	NSArray *applianceMerchants = [sharedAppManager appliances];
	
	NSMutableArray *returnArray = [NSMutableArray array];
    [returnArray addObjectsFromArray: applianceMerchants];
	[returnArray addObjectsFromArray: merchants];
	
	
    return returnArray;
}

 */

- (id)allMerchants //having both allMerchants and enabledMerchants doesn't really seem to help, enabledMerchants is a necessity to edit
{
	//%log;
	NSArray *merchants = %orig;
	id sharedAppManager = [BLAppManager sharedAppManager];
	NSArray *applianceMerchants = [sharedAppManager appliances];
	
	NSMutableArray *returnArray = [NSMutableArray array];
    [returnArray addObjectsFromArray: applianceMerchants];
	[returnArray addObjectsFromArray: merchants];
	

    return returnArray;
}


- (id)enabledMerchants
{
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
	

//- (id)allMerchants
//{
//	NSArray *merchants = %orig;
//	NSMutableArray *applianceMerchants = [NSMutableArray arrayWithArray:[[BLAppManager sharedAppManager] appliances]];
//	
//	for (int i = [applianceMerchants count] - 1; i >= 0; i--)
//	{
//		id merchant = [applianceMerchants objectAtIndex:i];
//		if ([merchant presentedInTopRow])
//			[applianceMerchants removeObjectAtIndex:i];
//	}
//    
//	NSMutableArray *returnArray = [NSMutableArray array];
//	[returnArray addObjectsFromArray: merchants];
//	[returnArray addObjectsFromArray: applianceMerchants];
//	
//	return returnArray;
//}

/*
 
 continued: so this is the other half of the hacky workaround to get our rootController working from ATVMainMenuController if [super merchantWithIdentifier:] is nil it /should/
 only happen when its looking for one of our 3rd party merchants, loop through enabledMerchants rather than allMerchants (since currently we are only shoehorned into enabled and not all)
 check the identifier, if it matches, return the merchant. for now this gets us in the door, but it is not elegant, and we have 0 control over sorting.
 
 */

- (id)merchantWithIdentifier:(id)identifier
{
		//%log;
	id merchant = %orig;
	
	if (merchant == nil)
	{
		id allMerchants = [self enabledMerchants];
		for (id merchant in allMerchants)
		{
			NSString *currentID = [merchant identifier];
			if ([currentID isEqualToString:identifier])
			{
					//	NSLog(@"we have a match: %@", merchant);
				return merchant;
			}
		}
		
	}
	
	return %orig;
}

%end

	//FALSE;


%hook BRApplianceManager



- (void)loadAppliances
{
	%log;
	%orig;
	
		// this code implicitly adds appliance to BRApplianceManager
	NSArray *applianceMerchants = [[BLAppManager sharedAppManager] appliances];
	for (id merchant in applianceMerchants)
	{
		if ([merchant showInTopRow])
		{
			[[objc_getClass("BRApplianceManager") singleton] _applianceDidReloadCategories:[merchant applianceInstance]];
		}
			
	}
}

%end

%hook ATVMainMenuController

-(void)_pushControllerForApplianceOrMerchant:(id)merchant
{
	%log;
	%orig;
	
	if ([merchant respondsToSelector:@selector(applianceInfo)])
	{
		NSArray *applianceIds = [[BLAppManager sharedAppManager] applianceIdentifiers];
		NSString *merchantId = [[merchant applianceInfo] key];
		if ([applianceIds containsObject:merchantId])
		{
			NSLog(@"it one of ours!: %@", merchant);
			id ourMerch = [[BLAppManager sharedAppManager] applianceWithIdentifier:merchantId];
			if (ourMerch != nil)
			{
				NSLog(@"got our merchant %@", ourMerch);
				id rootController = [ourMerch rootController];
				if (rootController != nil)
				{
					NSLog(@"got our controller!: %@", rootController);
					id stack = [[%c(BRApplicationStackManager) singleton] stack];
					[stack pushController:rootController];
					
				}
				
			}
		}
	}


	
}


- (id)appliances
{
	NSArray* orig = %orig;
	NSMutableArray* appliances = [NSMutableArray arrayWithArray:orig];
	NSArray *applianceMerchants = [[BLAppManager sharedAppManager] appliances];
	BOOL changed = NO;
	
	for (int i = [appliances count] - 1; i >= 0; i--)
	{
		for (id merchant in applianceMerchants)
		{
			if ([appliances objectAtIndex:i] == [merchant applianceInstance] && [merchant showInTopRow])
			{
				BOOL show = (BOOL)(long)(void *)[merchant presentedInTopRow];
			
				if ([appliances count] > 5)
				{
					[appliances removeObjectAtIndex:i];
					[merchant setPresentedInTopRow:NO];
				}
				else
					[merchant setPresentedInTopRow:YES];
				if (show != (BOOL)(long)(void *)[merchant presentedInTopRow])
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
			[[NSClassFromString(@"ATVMerchantCoordinator") sharedInstance] _updateMerchantServices];
			
		}
		
	}
	
	
	return appliances;
}

- (id)_imageForAppliance:(id)appliance
{
	NSArray *applianceMerchants = [[BLAppManager sharedAppManager] appliances];
	for (id merchant in applianceMerchants)
	{
		if ([appliance isKindOfClass:[merchant legacyApplianceClass]] && [merchant showInTopRow])
		{
			NSBundle* bundle = [NSBundle bundleWithIdentifier:[merchant identifier]];
				//NSLog(@"bundle: %@", bundle);
			id img = [%c(BRImage) imageWithPath:[bundle pathForResource:@"TopRowIcon" ofType:@"png"]];
			return img;
		}
	}
	
	return %orig;
}

%end


%hook LTAppDelegate



- (void)completeNormalApplicationDidFinishLaunching //we need to do the loading here because some classes we inherit from don't exist yet when mobile substrate initializes us
{
	%log;
	%orig;
	[[%c(BLAppManager) sharedAppManager] loadAppliances];
	[[%c(BRApplianceManager) singleton] loadAppliances];
	
}

%end


%class ATVMerchantCoordinator
%ctor {
	NSLog( @"beigelist6 (beigelist6-%s) loaded.", VERSION);
	%init;


	//[[NSClassFromString(@"BLAppManager") sharedAppManager] loadAppliances]; //can't do it here anymore! classes aren't available yet.
	
}
