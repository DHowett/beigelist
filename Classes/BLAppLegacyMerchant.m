//
//  BLAppLegacyMerchant.m
//  beigelist / Espresso
//
//  Created by Brandon Holland on 12-03-08.
//  beigelist and espresso merged / updated and modified by Kevin Bradley
//  Copyright 2012 What a Nutbar Software. All rights reserved.
//

#import "BLAppLegacyMerchant.h"
#import "BLAppMerchantInfo.h"
#import "BLAppLegacyCategoryController.h"
#import "BLApplianceController.h"

@implementation BLAppLegacyMerchant

#pragma mark -
#pragma mark Creation + Destruction
#pragma mark

- (id) init
{
    if((self = [super init]))
    {
        BLAppMerchantInfo *info = [BLAppMerchantInfo merchantInfo];
        [self setInfo: info];
        
        _legacyApplianceClass = nil;
        [self setEnabled: YES];
    }
    return self;
}

- (void) dealloc
{
	[appliance release];
    [super dealloc];
}

#pragma mark -
#pragma mark Class Methods
#pragma mark

+ (id) merchant
{ return [[[BLAppLegacyMerchant alloc] init] autorelease]; }

#pragma mark -
#pragma mark Private Methods
#pragma mark

#pragma mark -
#pragma mark Public Methods
#pragma mark

- (Class) legacyApplianceClass
{ return _legacyApplianceClass; }

- (void) setLegacyApplianceClass: (Class) legacyApplianceClass
{ _legacyApplianceClass = legacyApplianceClass; }

- (BRController *) rootController
{
	id controller = nil;
   BRBaseAppliance *legacyAppliance = [[_legacyApplianceClass alloc] init];

	/*
 
 its less than ideal to have to init the legacyAppliance to see if it has applianceInfo that is not nil, but not really sure what else to do
 
 */
	
	
	
	if ([legacyAppliance applianceInfo] != nil)
	{
	//	NSLog(@"legacyApplianceinfo: %@", [legacyAppliance applianceInfo]);
		[[BRApplianceManager singleton] _applianceDidReloadCategories:legacyAppliance];
		controller = [[[BLApplianceController alloc] initWithAppliance:legacyAppliance] autorelease];
		[legacyAppliance autorelease];
	
	} else {
	
		[legacyAppliance release];
		legacyAppliance = nil;
		//NSLog(@"applianceInfo == nil");
		//(BLAppLegacyCategoryController*)controller = [[[BLAppLegacyCategoryController alloc] init] autorelease];
		controller = [[[BLAppLegacyCategoryController alloc] init] autorelease];
        [controller setListTitle: [self title]];
		BRBaseAppliance *legacyAppliance = [[[_legacyApplianceClass alloc] init] autorelease];
		[controller setLegacyAppliance: legacyAppliance];
		
	}
	
	
	
    return controller;
}

- (id)info
{
	return [super info];
}

- (NSString *) title
{ return [[self info] menuTitle]; }

- (void) setTitle: (NSString *) title
{ [[self info] setMenuTitle: title]; }

- (NSString *) identifier
{ return [[self info] merchantID]; }

- (void) setIdentifier: (NSString *) identifier
{ [[self info] setMerchantID: identifier]; }

- (NSURL *) iconURL
{ return [[self info] menuIconURL]; }

- (void) setIconURL: (NSURL *) iconURL
{ [[self info] setMenuIconURL: iconURL]; }

- (float) preferredOrder
{ return [[self info] preferredOrder]; }

- (void) setPreferredOrder: (float) preferredOrder
{ [[self info] setPreferredOrder: preferredOrder]; }

- (BRBaseAppliance*)applianceInstance
{
	@try {
		if (!appliance)
			appliance = [[[self legacyApplianceClass] alloc] init];
	}
	@catch (NSException *exception) {
		NSLog(@"%s Failed to create appliance for class %@", __FUNCTION__, [self legacyApplianceClass]);
		NSLog(@"%s Exception %@", __FUNCTION__, exception);
	}
	
	return appliance;
}

- (BOOL)showInTopRow
{
	return showInTopRow;
}

- (void)setShowInTopRow:(BOOL)show
{
	showInTopRow = show;
}

- (BOOL)presentedInTopRow
{
	return presentedInTopRow;
}

- (void)setPresentedInTopRow:(BOOL)presented
{
	presentedInTopRow = presented;
}

@end
