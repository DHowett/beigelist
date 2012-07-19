#import "AppleTV.h"

%subclass BLAppLegacyMerchant: ATVMerchant


@implementation BLAppLegacyMerchant
//@dynamic legacyApplianceClass, appliance, showInTopRow, presentedInTopRow;

	static char const * const applianceKey = "Appliance";
	static char const * const legacyApplianceKey = "LegacyAppliance";
	static char const * const showInTopRowKey = "showInTopRow";
	static char const * const presentedInTopRowKey = "presentedInTopRow";



#pragma mark -
#pragma mark Creation + Destruction
#pragma mark

- (id) init
{
   // if((self = [super init]))
    //{
        id info = [NSClassFromString(@"BLAppMerchantInfo") merchantInfo];
        [self setInfo: info];
        
        //_legacyApplianceClass = nil;
        [self setEnabled: YES];
    //}
    return self;
}

//- (void) dealloc
//{
//	[appliance release];
//    [super dealloc];
//}


#define BRAPPMAN NSClassFromString(@"BRApplianceManager")


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
{  return objc_getAssociatedObject(self, legacyApplianceKey); }

- (void) setLegacyApplianceClass: (Class) legacyApplianceClass
{  objc_setAssociatedObject(self, legacyApplianceKey, legacyApplianceClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}

- (id) rootController
{
	id controller = nil;
   id legacyAppliance = [[[self legacyApplianceClass] alloc] init];

	/*
 
 its less than ideal to have to init the legacyAppliance to see if it has applianceInfo that is not nil, but not really sure what else to do
 
 */
	
	
	
	if ([legacyAppliance applianceInfo] != nil)
	{
	//	NSLog(@"legacyApplianceinfo: %@", [legacyAppliance applianceInfo]);
		[[BRAPPMAN singleton] _applianceDidReloadCategories:legacyAppliance];
		controller = [[[NSClassFromString(@"BLApplianceController") alloc] initWithAppliance:legacyAppliance] autorelease];
		[legacyAppliance autorelease];
	
	} else {
	
		[legacyAppliance release];
		legacyAppliance = nil;
		//NSLog(@"applianceInfo == nil");
		Class blalcc = NSClassFromString(@"BLAppLegacyCategoryController");
		controller = [[[blalcc alloc] init] autorelease];
		[controller setListTitle: [self title]];
		id legacyAppliance = [[[self legacyApplianceClass] init] autorelease];
		[controller setLegacyAppliance: legacyAppliance];
		
	}
	
	
	
    return controller;
}

// - (id)info
// {
// 	return [super info];
// }

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

- (id) appliance
{  return objc_getAssociatedObject(self, applianceKey); }

- (void) setAppliance: (id) theAppliance
{  objc_setAssociatedObject(self, applianceKey, theAppliance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}


- (id)applianceInstance
{
	id myAppliance = nil;
	@try {
		myAppliance = [self appliance];
		if (!myAppliance)
		{
			myAppliance = [[[self legacyApplianceClass] alloc] init];
			[self setAppliance:myAppliance];
		}
		
	}
	@catch (NSException *exception) {
		NSLog(@"%s Failed to create appliance for class %@", __FUNCTION__, [self legacyApplianceClass]);
		NSLog(@"%s Exception %@", __FUNCTION__, exception);
	}
	
	return myAppliance;
}

- (BOOL)showInTopRow
{  return [objc_getAssociatedObject(self, showInTopRowKey) boolValue]; }

- (void)setShowInTopRow:(BOOL)show
{ objc_setAssociatedObject(self, showInTopRowKey, [NSNumber numberWithBool:show], OBJC_ASSOCIATION_RETAIN_NONATOMIC);}


- (BOOL)presentedInTopRow
{ return [objc_getAssociatedObject(self, presentedInTopRowKey) boolValue]; }

- (void)setPresentedInTopRow:(BOOL)presented
{ objc_setAssociatedObject(self, presentedInTopRowKey, [NSNumber numberWithBool:presented], OBJC_ASSOCIATION_RETAIN_NONATOMIC);}


@end

%end