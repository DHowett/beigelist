//
//  BLAppLegacyCategoryController.m
//  beigelist / Espresso
//
//  Created by Brandon Holland on 12-03-09.
//  beigelist and espresso merged / updated and modified by Kevin Bradley
//  Copyright 2012 What a Nutbar Software. All rights reserved.
//

//#import "Classes6/BLAppLegacyCategoryController.h"

%subclass BLAppLegacyCategoryController: BRMenuController


@implementation BLAppLegacyCategoryController

	static char const * const menuItemKey = "MenuItems";
	static char const * const legacyApplianceKey = "LegacyAppliance";


//@dynamic menuItems, legacyAppliance;

#pragma mark -
#pragma mark Creation + Destruction
#pragma mark

- (id) init
{
   if((self = %orig))
    {
        NSMutableArray *theArray = [[NSMutableArray alloc] init];
        [self setMenuItems:theArray];
       // _legacyAppliance = nil;
        
        [self setUseCenteredLayout: YES];
        [[self list] setDatasource: self];
    }
    return self;
}

/*

- (void) dealloc
{
    [menuItems release];
    [_legacyAppliance release];
    [super dealloc];
}

*/

%new
- (id)menuItems {
    return objc_getAssociatedObject(self, menuItemKey);}
%new
- (void)setMenuItems:(id)newMenuItems {
    objc_setAssociatedObject(self, menuItemKey, newMenuItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -
#pragma mark Class Methods
#pragma mark

#pragma mark -
#pragma mark Private Methodse
#pragma mark

#define BRMI NSClassFromString(@"BRMenuItem")
%new
- (void) _generateCategoryMenuItems
{
    id items = [self menuItems];
	id legacyApp = [self legacyAppliance];
	
	
	[items removeAllObjects];
    
    NSArray *categories = [legacyApp applianceCategories];
    for(id category in categories)
    {
        id menuItem = [[[BRMI alloc] init] autorelease];
        [menuItem setText: [category name] withAttributes: nil];
        [menuItem setIdentifier: [category identifier]];
        [items addObject: menuItem];
    }
	[self setMenuItems:items];
    [[self list] reload];
}

#pragma mark -
#pragma mark Public Methods
#pragma mark
%new
- (id) legacyAppliance
{ return objc_getAssociatedObject(self, legacyApplianceKey ); }
%new
- (void) setLegacyAppliance: (id) legacyAppliance
{
   objc_setAssociatedObject(self, legacyApplianceKey, legacyAppliance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self _generateCategoryMenuItems];
}

#pragma mark -
#pragma mark BRMenuListItemProvider Methods
#pragma mark
%new
- (long)itemCount
{ return [[self menuItems] count]; }
%new
- (float)heightForRow:(long)rowIndex
{ return 0; }
%new
- (BOOL)rowSelectable:(long)rowIndex
{ return YES; }
%new
- (id)titleForRow:(long)rowIndex
{ return nil; }
%new
- (id)itemForRow:(long)rowIndex
{ return [[self menuItems] objectAtIndex: rowIndex]; }

#pragma mark -
#pragma mark Super Overrides
#pragma mark

// - (void) controlWasActivated
// {
//     [super controlWasActivated];
// }
// 
// - (void) controlWasDeactivated
// {
//     [super controlWasDeactivated];
// }
%new
- (void)itemSelected:(long)rowIndex
{
    id itemForRow = [[self menuItems] objectAtIndex: rowIndex];
    id controller = [[self legacyAppliance] controllerForIdentifier: [itemForRow identifier] args: nil];
    [[self stack] pushController: controller];
}

@end

%end