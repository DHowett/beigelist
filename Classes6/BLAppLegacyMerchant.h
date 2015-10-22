//
//  BLAppLegacyMerchant.h
//  beigelist / Espresso
//
//  Created by Brandon Holland on 12-03-08.
//  beigelist and espresso merged / updated and modified by Kevin Bradley
//  Copyright 2012 What a Nutbar Software. All rights reserved.
//

#import "../AppleTV.h"
#import <Foundation/Foundation.h>


@interface BLAppLegacyMerchant: ATVMerchant 
{
    int padding[32];
    Class _legacyApplianceClass;
	BRBaseAppliance* appliance;
	BOOL showInTopRow;
	BOOL presentedInTopRow;
}
- (id)info; //attempt to keep the level of warnings of compiler low.
+ (id) merchant;
-(void)setLegacyApplianceClassString:(NSString *)classString;
- (Class) legacyApplianceClass;
- (void) setLegacyApplianceClass: (Class) legacyApplianceClass;
- (NSString *) title;
- (void) setTitle: (NSString *) title;
- (NSString *) identifier;
- (void) setIdentifier: (NSString *) identifier;
- (NSURL *) iconURL;
- (void) setIconURL: (NSURL *) iconURL;
- (float) preferredOrder;
- (void) setPreferredOrder: (float) preferredOrder;
- (BRBaseAppliance*)applianceInstance;
- (BOOL)showInTopRow;
- (void)setShowInTopRow:(BOOL)show;
- (BOOL)presentedInTopRow;
- (void)setPresentedInTopRow:(BOOL)presented;
@end
