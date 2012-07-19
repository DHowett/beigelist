//
//  BLAppMerchantInfo.m
//  beigelist / Espresso
//
//  Created by Brandon Holland on 12-03-08.
//  beigelist and espresso merged / updated and modified by Kevin Bradley
//  Copyright 2012 What a Nutbar Software. All rights reserved.
//

//#import "Classes6/BLAppMerchantInfo.h"

%subclass BLAppMerchantInfo: BRMerchantInfo


@implementation BLAppMerchantInfo

	static char const * const menuTitleKey = "menuTitle";
	static char const * const menuIconKey = "menuIconURL";
	static char const * const merchantIDKey = "merchantID";
	static char const * const preferredOrderKey = "preferredOrder";



//@dynamic menuTitle, menuIconURL, merchantID, preferredOrder;

#pragma mark -
#pragma mark Creation + Destruction
#pragma mark

- (id) init
{
   if((self = %orig))
    {
      //  _menuTitle = nil;
//        _menuIconURL = nil;
//        _merchantID = nil;
//        _preferredOrder = 0.0;
    }
    return self;
}

/*
- (void) dealloc
{
    [_menuTitle release];
    [_menuIconURL release];
    [_merchantID release];
    [super dealloc];
}
*/

#pragma mark -
#pragma mark Class Methods
#pragma mark
%new
+ (id) merchantInfo
{ return [[[BLAppMerchantInfo alloc] init] autorelease]; }

#pragma mark -
#pragma mark Private Methods
#pragma mark

#pragma mark -
#pragma mark Public Methods
#pragma mark

%new
- (NSString *) menuTitle
{ return objc_getAssociatedObject(self, menuTitleKey); }
%new
- (void) setMenuTitle: (NSString *) menuTitle
{
     objc_setAssociatedObject(self, menuTitleKey, menuTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
%new
- (NSURL *) menuIconURL
{ return objc_getAssociatedObject(self, menuIconKey); }
%new
- (void) setMenuIconURL: (NSURL *) menuIconURL
{
    objc_setAssociatedObject(self, menuIconKey, menuIconURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
%new
- (NSString *) merchantID
{  return objc_getAssociatedObject(self, merchantIDKey); }

%new
- (void) setMerchantID: (NSString *) merchantID
{
     objc_setAssociatedObject(self, merchantIDKey, merchantID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
%new
- (float) preferredOrder
{ return [objc_getAssociatedObject(self, preferredOrderKey) floatValue]; }
%new
- (void) setPreferredOrder: (float) preferredOrder
{ objc_setAssociatedObject(self, preferredOrderKey, [NSNumber numberWithFloat:preferredOrder], OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

@end

%end
