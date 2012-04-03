//
//  BLAppLegacyCategoryController.h
//  beigelist / Espresso
//
//  Created by Brandon Holland on 12-03-09.
//  beigelist and espresso merged / updated and modified by Kevin Bradley

//  Copyright 2012 What a Nutbar Software. All rights reserved.
//

#import "../AppleTV.h"
#import <Foundation/Foundation.h>

@interface BLAppLegacyCategoryController: BRMenuController 
{
    int padding[32];
    NSMutableArray *menuItems;
    BRBaseAppliance *_legacyAppliance;
}
- (BRBaseAppliance *) legacyAppliance;
- (void) setLegacyAppliance: (BRBaseAppliance *) legacyAppliance;
@end
