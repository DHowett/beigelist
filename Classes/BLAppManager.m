//
//  BLAppManager.m
//  beigelist / Espresso
//
//  Created by Brandon Holland on 12-03-08.
//  beigelist and espresso merged / updated and modified by Kevin Bradley
//  Copyright 2012 What a Nutbar Software. All rights reserved.
//

#import "BLAppManager.h"
#import "BLAppLegacyMerchant.h"

@implementation BLAppManager

#pragma mark -
#pragma mark Creation + Destruction
#pragma mark

- (id) init
{
    if((self = [super init]))
    {
		
        _appliances = [[NSMutableArray alloc] init];
		_firstRowCandidates = [[NSMutableArray alloc] init];
		_appliancesLoaded = NO;
    }
    return self;
}

- (void) dealloc
{
    [_firstRowCandidates release];
	[_appliances release];
    [super dealloc];
}

#pragma mark -
#pragma mark Class Methods
#pragma mark

+ (id) sharedAppManager
{
    static BLAppManager *appManager = nil;
    if(!appManager)
    { appManager = [[BLAppManager alloc] init]; }
    return appManager;
}

#pragma mark -
#pragma mark Private Methods
#pragma mark

/*
 
 need to check and see if the afformentioned applicance is in the ATVMainMenuController, check by identifier
 if that controller contains the identifier, filter the item out from merchants
 
 
 */

+ (BOOL)firstRowContainsIdentifier:(NSString *)theIdentifier
{
	if (theIdentifier == nil)
		return (FALSE);
	Class brasm = NSClassFromString(@"BRApplicationStackManager");
	//Class ATVSF = NSClassFromString(@"ATVSettingsFacade");
	//[ATVSF initializePlatformFacade];
	id peekC = [[[brasm singleton] stack] peekController];
	//NSLog(@"peekc: %@", peekC);
	if (peekC == nil)
	{
		return (FALSE);
	}
	Class atvmmc = NSClassFromString(@"ATVMainMenuController");
	id theMainMenu = [atvmmc mainMenu];
	
	if (theMainMenu == nil)
		return (FALSE);
		
	NSArray *appliances = [theMainMenu appliances];
	//NSLog(@"appliances: %@", appliances);
	NSEnumerator *iterator = [appliances objectEnumerator];
	id appliance = nil;
	while((appliance = [iterator nextObject]))
	{
		NSString *ident = [[appliance applianceInfo] key];
		//NSLog(@"ident: %@ compared: %@", ident, theIdentifier);
		if ([ident isEqualToString:theIdentifier])
			return (TRUE);
	}
	return (FALSE);
}

- (void)_enableAllMerchants
{
	NSEnumerator *applianceEnum = [_appliances objectEnumerator];
	id atvmc = [MERCHANT_COORD singleton];
	id appliance = nil;
	while ((appliance = [applianceEnum nextObject]))
	{
		[appliance setEnabled:TRUE];
	}
	[atvmc _updateMerchants];
}

- (void) _enableMerchantWithIdentifier:(NSString *)theIdentifier
{
	NSEnumerator *applianceEnum = [_appliances objectEnumerator];
	id appliance = nil;
	id atvmc = [MERCHANT_COORD singleton];
	NSArray *allMerchants = [atvmc allMerchants];
	while ((appliance = [applianceEnum nextObject]))
	{
		NSString *theId = [appliance identifier];
		if ([theId isEqualToString:theIdentifier])
		{
			//NSLog(@"we have a match!: %@ and %@", theId, theIdentifier);
			//[_appliances removeObject:appliance];
			[appliance setEnabled:TRUE];
			
			[atvmc setLoadedMerchants:allMerchants];
			[atvmc _updateMerchants];
		}
	}
}

- (void) _disableMerchantWithIdentifier:(NSString *)theIdentifier
{
	NSEnumerator *applianceEnum = [_appliances objectEnumerator];
	id appliance = nil;
	while ((appliance = [applianceEnum nextObject]))
	{
		NSString *theId = [appliance identifier];
		if ([theId isEqualToString:theIdentifier])
		{
		//	NSLog(@"we have a match!: %@ and %@", theId, theIdentifier);
			//[_appliances removeObject:appliance];
			[appliance setEnabled:FALSE];
			id atvmc = [MERCHANT_COORD singleton];
			NSArray *allMerchants = [atvmc allMerchants];
			
			
			[atvmc setLoadedMerchants:allMerchants];
			[atvmc _updateMerchants];
		}
	}
}

- (void) _loadAppliances
{    
    NSString *appleTVPath = [[NSBundle mainBundle] bundlePath];
	NSString *frappPath = [appleTVPath stringByAppendingPathComponent: @"Appliances"];
	NSDirectoryEnumerator *iterator = [[NSFileManager defaultManager] enumeratorAtPath: frappPath];
	[_firstRowCandidates removeAllObjects];
    NSString *filePath = nil;
	while((filePath = [iterator nextObject]))
    {
        if([[filePath pathExtension] isEqualToString: @"frappliance"]) 
		{
			NSString *fullPath = [frappPath stringByAppendingPathComponent: filePath];
			NSBundle *frappBundle = [NSBundle bundleWithPath: fullPath];
			NSLog(@"BLAppManager -> attempting to load legacy %@...", [filePath lastPathComponent]);
            
            if([frappBundle load])
            {
                Class frappClass = [frappBundle principalClass];
                NSDictionary *frappBundleInfoDict = [frappBundle infoDictionary];
                NSDictionary *candidate = nil;
				
                BLAppLegacyMerchant *frappMerchant = [BLAppLegacyMerchant merchant];
                [frappMerchant setLegacyApplianceClass: frappClass];
                
                NSString *title = [[frappBundle localizedInfoDictionary] objectForKey: (NSString *)kCFBundleNameKey];
                { [frappMerchant setTitle: title]; }
                
                NSString *identifier = [frappBundleInfoDict objectForKey: (NSString *)kCFBundleIdentifierKey];
                if(identifier)
                { 
					[frappMerchant setIdentifier: identifier]; 
					candidate = [NSDictionary dictionaryWithObject:fullPath forKey:identifier];
				}
                
                NSString *imagePath = [frappBundle pathForResource: @"AppIcon" ofType: @"png"];
                if(imagePath)
                {
                    NSURL *imageURL = [NSURL fileURLWithPath: imagePath];
                    [frappMerchant setIconURL: imageURL];
                }
                //add another key, if it doesnt exist, revert to preferred order... DURR
				
                NSNumber *preferredOrder = [frappBundleInfoDict objectForKey:kBLPreferedOrder];
				
				if (!preferredOrder)
				{
					preferredOrder = [frappBundleInfoDict objectForKey: @"FRAppliancePreferedOrderValue"];
                }
				
				if(preferredOrder)
                { [frappMerchant setPreferredOrder: [preferredOrder floatValue]]; }
				
				[frappMerchant setShowInTopRow:[[frappBundleInfoDict objectForKey:kBLShowInTopRow] boolValue]];
                
				[_appliances addObject: frappMerchant];
				NSLog(@"BLAppManager -> loaded legacy %@", NSStringFromClass(frappClass));
				
				//if (![BLAppManager firstRowContainsIdentifier:identifier])
//				{
//					
//					
//					
//					
//					//now check to see if its eligible of being in the first row
//					
//					if ([[frappBundleInfoDict allKeys] containsObject:kBLShowInTopRow])
//					{
//						BOOL showInFirstRow = [[frappBundleInfoDict objectForKey:kBLShowInTopRow] boolValue];
//							
//						if (showInFirstRow)
//						{
//							//NSLog(@"first row candidate: %@", candidate);
//								
//							if (candidate != nil)
//								[_firstRowCandidates addObject:candidate];
//						}
//						
//							
//						
//					}
//					
//				}
                
            }
            else
            { NSLog(@"BLAppManager -> failed to load legacy %@", [filePath lastPathComponent]); }
		}
    }
	
    _appliancesLoaded = YES;
}


#pragma mark -
#pragma mark Public Methods
#pragma mark

- (NSArray *)firstRowCandidates
{ return _firstRowCandidates; }

- (NSArray *) appliances
{ return _appliances; }

- (BOOL) appliancesLoaded
{ return _appliancesLoaded; }

- (void) clearAppliances
{
    [_appliances removeAllObjects];
    _appliancesLoaded = NO;
}

- (void) reloadAppliances
{
    [self clearAppliances];
    [self _loadAppliances];
}

- (void) loadAppliances
{
    if(!_appliancesLoaded)
    { [self _loadAppliances]; }
}

@end
