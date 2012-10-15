//
//  BLAppManager.h
//  beigelist / Espresso
//
//  Created by Brandon Holland on 12-03-08.
//  beigelist and espresso merged / updated and modified by Kevin Bradley
//  Copyright 2012 What a Nutbar Software. All rights reserved.
//

#import "../AppleTV.h"
#import <Foundation/Foundation.h>

#define kBLPreferedOrder @"BLMerchantPreferedOrderValue"
#define kBLShowInTopRow @"BLShowInFirstRow"
#define MERCHANT_COORD NSClassFromString(@"ATVMerchantCoordinator")
#define kBLForceLegacyNav @"BLForceLegacyNav"

@interface BLAppManager: NSObject 
{    
    NSMutableArray *_appliances;
	NSMutableArray *_applianceIdentifiers;
    BOOL _appliancesLoaded;
}
+ (id) sharedAppManager;

- (NSArray *) appliances;
- (NSArray *) applianceIdentifiers;
- (id)applianceWithIdentifier:(NSString *)theId;
- (BOOL) appliancesLoaded;
- (void) clearAppliances;
- (void) reloadAppliances;
- (void) loadAppliances;

@end
