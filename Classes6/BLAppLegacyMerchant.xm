#import "AppleTV.h"
//#import "Classes6/BLAppLegacyMerchant.h"


%subclass BLAppLegacyMerchant: ATVMerchant



	static char const * const applianceKey = "Appliance";
	static char const * const legacyApplianceClassKey = "LegacyApplianceClass";
	static char const * const showInTopRowKey = "showInTopRow";
	static char const * const presentedInTopRowKey = "presentedInTopRow";
	static char const * const forceLegacyNav = "forceLegacyNav";



//@implementation BLAppLegacyMerchant
//@dynamic legacyApplianceClass, appliance, showInTopRow, presentedInTopRow;




#pragma mark -
#pragma mark Creation + Destruction
#pragma mark

- (id) init
{
	
	if((self = %orig))
    {
        id info = [%c(BLAppMerchantInfo) merchantInfo];
        [self setInfo: info];
        
        //_legacyApplianceClass = nil;
        [self setEnabled: YES];
    }
    return self;
}

//- (void) dealloc
//{
//	[appliance release];
//    [super dealloc];
//}


#define BRAPPMAN %c(BRApplianceManager)


#pragma mark -
#pragma mark Class Methods
#pragma mark
%new + (id) merchant { return [[[%c(BLAppLegacyMerchant) alloc] init] autorelease]; }


#pragma mark -
#pragma mark Private Methods
#pragma mark

#pragma mark -
#pragma mark Public Methods
#pragma mark
%new -(void)setLegacyApplianceClassString:(NSString *)classString
{ objc_setAssociatedObject(self, legacyApplianceClassKey, classString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}

%new - (Class) legacyApplianceClass
{  return objc_getAssociatedObject(self, legacyApplianceClassKey); }

%new - (void) setLegacyApplianceClass: (Class) legacyApplianceClass

	{ 
	 objc_setAssociatedObject(self, legacyApplianceClassKey, legacyApplianceClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}
	
- (id) rootController
{
	
	id controller = nil;
   id legacyAppliance = [[[self legacyApplianceClass] alloc] initWithApplianceInfo:nil]; 
	
	/*
 
 its less than ideal to have to init the legacyAppliance to see if it has applianceInfo that is not nil, but not really sure what else to do
 
 */
	

	if ([legacyAppliance applianceInfo] != nil && [self forceLegacyNav] == FALSE)
	{
	//	NSLog(@"legacyApplianceinfo: %@", [legacyAppliance applianceInfo]);
		
		if ([[BRAPPMAN singleton] respondsToSelector:@selector(_applianceDidReloadCategories:)])
        {
            [[BRAPPMAN singleton] _applianceDidReloadCategories:legacyAppliance];
        }
        controller = [[[%c(BLApplianceController) alloc] initWithAppliance:legacyAppliance] autorelease];
		[legacyAppliance autorelease];
	
	} else {
	

		
		Class blalcc = %c(BLAppLegacyCategoryController);
		controller = [[[blalcc alloc] init] autorelease];
		
		[controller setListTitle: [self title]];
		
		//id legacyAppliance = [[[[self legacyApplianceClass]alloc] init] autorelease];
		
		[controller setLegacyAppliance: legacyAppliance];
		
		
	}
	
	
	
    return controller;
}

 - (id)info
 {
 	return %orig;
 }


%new - (BOOL)forceLegacyNav
{ return [objc_getAssociatedObject(self, forceLegacyNav) boolValue]; }
%new - (void)setForceLegacyNav:(BOOL)value 
{ objc_setAssociatedObject(self, forceLegacyNav, [NSNumber numberWithBool:value], OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

%new - (NSString *) title
{ return [[self info] menuTitle]; }
%new - (void) setTitle: (NSString *) title
{ [[self info] setMenuTitle: title]; }
%new - (NSString *) identifier
{ return [[self info] merchantID]; }
%new - (void) setIdentifier: (NSString *) identifier
{ [[self info] setMerchantID: identifier]; }
%new - (NSURL *) iconURL
{ return [[self info] menuIconURL]; }
%new - (void) setIconURL: (NSURL *) iconURL
{ [[self info] setMenuIconURL: iconURL]; }
%new - (float) preferredOrder
{ return [[self info] preferredOrder]; }
%new - (void) setPreferredOrder: (float) preferredOrder
{ [[self info] setPreferredOrder: preferredOrder]; }
%new - (id) appliance
{  return objc_getAssociatedObject(self, applianceKey); }
%new - (void) setAppliance: (id) theAppliance
{  objc_setAssociatedObject(self, applianceKey, theAppliance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}

%new - (id)applianceInstance
{
	id myAppliance = nil;
	@try {
		myAppliance = [self appliance];
		if (!myAppliance)
		{
			myAppliance = [[[self legacyApplianceClass] alloc] initWithApplianceInfo:nil];
			[self setAppliance:myAppliance];
		}
		
	}
	@catch (NSException *exception) {
		NSLog(@"%s Failed to create appliance for class %@", __FUNCTION__, [self legacyApplianceClass]);
		NSLog(@"%s Exception %@", __FUNCTION__, exception);
	}
	
	return myAppliance;
}
%new - (BOOL)showInTopRow
{  return [objc_getAssociatedObject(self, showInTopRowKey) boolValue]; }
%new - (void)setShowInTopRow:(BOOL)show
{ objc_setAssociatedObject(self, showInTopRowKey, [NSNumber numberWithBool:show], OBJC_ASSOCIATION_RETAIN_NONATOMIC);}

%new - (BOOL)presentedInTopRow
{ return [objc_getAssociatedObject(self, presentedInTopRowKey) boolValue]; }
%new - (void)setPresentedInTopRow:(BOOL)presented
{ objc_setAssociatedObject(self, presentedInTopRowKey, [NSNumber numberWithBool:presented], OBJC_ASSOCIATION_RETAIN_NONATOMIC);}



//@end

%end