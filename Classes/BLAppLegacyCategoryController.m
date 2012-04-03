//
//  BLAppLegacyCategoryController.m
//  beigelist / Espresso
//
//  Created by Brandon Holland on 12-03-09.
//  beigelist and espresso merged / updated and modified by Kevin Bradley
//  Copyright 2012 What a Nutbar Software. All rights reserved.
//

#import "BLAppLegacyCategoryController.h"

@implementation BLAppLegacyCategoryController

#pragma mark -
#pragma mark Creation + Destruction
#pragma mark

- (id) init
{
    if((self = [super init]))
    {
        
        menuItems = [[NSMutableArray alloc] init];
        _legacyAppliance = nil;
        
        [self setUseCenteredLayout: YES];
        [[self list] setDatasource: self];
    }
    return self;
}

- (void) dealloc
{
    [menuItems release];
    [_legacyAppliance release];
    [super dealloc];
}

#pragma mark -
#pragma mark Class Methods
#pragma mark

#pragma mark -
#pragma mark Private Methodse
#pragma mark

- (void) _generateCategoryMenuItems
{
    [menuItems removeAllObjects];
    
    NSArray *categories = [_legacyAppliance applianceCategories];
    for(BRApplianceCategory *category in categories)
    {
        BRMenuItem *menuItem = [[[BRMenuItem alloc] init] autorelease];
        [menuItem setText: [category name] withAttributes: nil];
        [menuItem setIdentifier: [category identifier]];
        [menuItems addObject: menuItem];
    }
    [[self list] reload];
}

#pragma mark -
#pragma mark Public Methods
#pragma mark

- (BRBaseAppliance *) legacyAppliance
{ return _legacyAppliance; }

- (void) setLegacyAppliance: (BRBaseAppliance *) legacyAppliance
{
    [_legacyAppliance release];
    _legacyAppliance = [legacyAppliance retain];
    
    [self _generateCategoryMenuItems];
}

#pragma mark -
#pragma mark BRMenuListItemProvider Methods
#pragma mark

- (long)itemCount
{ return [menuItems count]; }

- (float)heightForRow:(long)rowIndex
{ return 0; }

- (BOOL)rowSelectable:(long)rowIndex
{ return YES; }

- (id)titleForRow:(long)rowIndex
{ return nil; }

- (id)itemForRow:(long)rowIndex
{ return [menuItems objectAtIndex: rowIndex]; }

#pragma mark -
#pragma mark Super Overrides
#pragma mark

- (void) controlWasActivated
{
    [super controlWasActivated];
}

- (void) controlWasDeactivated
{
    [super controlWasDeactivated];
}

- (void)itemSelected:(long)rowIndex
{
    BRMenuItem *itemForRow = [menuItems objectAtIndex: rowIndex];
    BRController *controller = [_legacyAppliance controllerForIdentifier: [itemForRow identifier] args: nil];
    [[self stack] pushController: controller];
}

@end
