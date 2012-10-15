//
//  BLApplianceController.m
//  beigelist
//
//  Created by Kevin Bradley on 5/26/12.
//  Copyright 2012 nito, LLC. All rights reserved.
//

//#import "Classes6/BLApplianceController.h"

#define ATVMMC %c(ATVMainMenuController)
#define BRAPPM %c(BRApplianceManager)

%subclass BLApplianceController: ATVApplianceController

//@implementation BLApplianceController

/*
 
 inside selectedCategoryDidChangeForApplianceTopPanelControl? 
 
 1. get self appliance - >  ATVApplianceTopPanelControl selectedCategory - >
 
 2. then with BRApplianceManager singleton
 
 -[<BRApplianceManager: 0x451fd0> controllerForApplianceKey:com.firecore.maintenance identifier:mExtraIdentifier args:(null)]
 
 3. then we need BRApplianceManager applianceForInfo (no idea why since we already have the appliance??) //roll our own version?
 
 4. check [self _hostinSubController] for null?
 
 5. topPanelControl selectedCategory
 
 6. appliance.. again?
 
 7. topPanel _accessibilityUpdateSelection
 
 8. setHostingSubcontroller to the instance created in 8
 
 9. [self _applianceView] setContent: subcontroller
 
 
 //NSString *applianceKey = [[self.appliance applianceInfo] key];
 BRApplianceCategory *currentCategory = [selectedPanel selectedCategory];
 NSString *categoryId = [currentCategory identifier];
 
 //BRApplianceManager *theMan = [BRApplianceManager singleton];
 id controller = [[self appliance] controllerForIdentifier:categoryId args:nil];
 NSLog(@"controller: %@", controller);
 [selectedPanel _accessibilityUpdateSelection]; 
 [self hostSubController:controller];
 [self _setHostingSubController:controller];
 [[self _applianceView] setContent:controller];
 
 */


/*
 
 from blProperVersion - > BREventAction are all new for iOS 6
 
 there is a new class called ATVNavigationBar that must need to be overriden differently per controller to determine whether to pop off, or to show the nav bar.
 without these modifications it will always show the nav bar now matter how far you are drilled down. There are two separate BRControllerStacks, one for the main menu
 controls and the BLApplianceController, and then one for the [[view] content] of said BRViewController (BLApplianceController inherits from there iirc)
 
 all i could think of to get this done at the root level was to grab this stack when menu is pressed in BREventAction and check the [[controllers] count] value for 1, if its
 1 just return the default behavior (either pop up the navbar, or if the nav bar is up pop the full BLApplianceController off)
 
 there is one major problem with this, is doesnt appear to be UI thread safe or whatever, however if i try to gra the stack as illustrated in viewStack, everything locks up,
 if i dont (which i dont right now) the animation of popping off a controller looks really choppy and terrible. i used to have a versionCheck for 6.0+ in here but then 
 remebered we only run this on iOS 6 plus, so it was frivolous.
 
 
 
 
 */


%new - (id)viewStack
{
	return [[[self view] content] stack];
	
	
	__block id stack = nil;
	
	dispatch_sync(dispatch_get_main_queue(), ^{
			// code below is executed synchronously
			// access to UI is safe is its a main thread
		stack = [[[self view] content] stack];
	});
	
	return stack;
}

%new - (void)popViewStackController:(id)value
{
	[value popController];
	
	
}

%new - (int)viewStackCount
{
	return [[[self viewStack] controllers] count];
}



- (BOOL)brEventAction:(id)fp8
{
	
	
	int theAction = (int)[fp8 remoteAction];
	int theValue = (int)[fp8 value];
	id theViewStack = nil;
	int theCount;
	switch (theAction)
	{
		case 1:
						
			
				theViewStack = [self viewStack];
				
				theCount = [[theViewStack controllers] count];
				
				if (theCount == 1)
				{
					
					return %orig;
				}
				
				[self performSelectorOnMainThread:@selector(popViewStackController:) withObject:theViewStack waitUntilDone:TRUE];
				
				
				return YES;
				
			
		
			
		default:
			return %orig;
		
	}
	return YES;
}

- (void)wasPopped
{
	//this SHOULDNT conflict with the adding appliances that vie for the top shelf, mainly because we call loadAppliances again at the end.
	
	NSMutableArray *mmcApp = [[NSMutableArray alloc] initWithArray:[[ATVMMC mainMenu] appliances]];
	
	if ([mmcApp containsObject:[self appliance]])
	{
		[mmcApp removeObject:[self appliance]];
	
		
		[[ATVMMC mainMenu] setAppliances:[mmcApp autorelease]];
		
		[[BRAPPM singleton] loadAppliances];
	} else {
		
		[mmcApp release];
		mmcApp = nil;

		
	}
	%orig;
	//NSLog(@"mmcAPp: %@ brApp: %@", [[ATVMainMenuController mainMenu] appliances], [[BRApplianceManager singleton] appliances]);
	//[super wasPopped]; //FIX_ME: HOW THE HELL DO U CALL SUPER??!?!?
}

//- (void)selectedCategoryDidChangeForApplianceTopPanelControl:(ATVApplianceTopPanelControl *)selectedPanel
//{
//	
//	/*
//	 
//	 originally tried to re-create what they do inside here, but any controllers passed the initial ones would never push, so went back to the way it was
//	 in your example, there must be more to it, but in the end it shouldnt matter
//	 
//	 */
//	//NSLog(@"selectedPanel: %@", selectedPanel);
//	[super selectedCategoryDidChangeForApplianceTopPanelControl:selectedPanel];
//	
//	
//	
//}

//@end

%end