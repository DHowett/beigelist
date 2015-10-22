//
//  BLAppMerchantInfo.h
//  beigelist / Espresso
//
//  Created by Brandon Holland on 12-03-08.
//  beigelist and espresso merged / updated and modified by Kevin Bradley
//  Copyright 2012 What a Nutbar Software. All rights reserved.
//

#import "../AppleTV.h"
#import <Foundation/Foundation.h>

@interface BLAppMerchantInfo: BRMerchantInfo 
{
    int padding[32];
    NSString *_menuTitle;
    NSURL *_menuIconURL;
    NSString *_merchantID;
    float _preferredOrder;
}
+ (id) merchantInfo;
- (NSString *) menuTitle;
- (void) setMenuTitle: (NSString *) menuTitle;
- (NSURL *) menuIconURL;
- (void) setMenuIconURL: (NSURL *) menuIconURL;
- (NSString *) merchantID;
- (void) setMerchantID: (NSString *) merchantID;
- (float) preferredOrder;
- (void) setPreferredOrder: (float) preferredOrder;
@end
