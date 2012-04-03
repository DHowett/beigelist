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


@interface BLAppManager: NSObject 
{    
    NSMutableArray *_appliances;
	NSMutableArray *_firstRowCandidates;
    BOOL _appliancesLoaded;
}
+ (id) sharedAppManager;

+ (BOOL)firstRowContainsIdentifier:(NSString *)theIdentifier;
- (void)_enableAllMerchants;
- (NSArray *) appliances;
- (NSArray *)firstRowCandidates;
- (BOOL) appliancesLoaded;
- (void) clearAppliances;
- (void) reloadAppliances;
- (void) loadAppliances;

@end
