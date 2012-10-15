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

%new + (NSString *)blProperVersion
{
	Class cls = NSClassFromString(@"ATVVersionInfo");
	if (cls != nil)
	{ return [cls currentOSVersion]; }
	
	return nil;	
}

%new - (BOOL)blSixPointOhPlus
{
	if ([self respondsToSelector:@selector(controls)])
	{
		return (FALSE);
	}
	
	return (TRUE);
}

%new + (BOOL)blSixPointOhPlus
{
	
	NSString *versionNumber = [%c(BLApplianceController) blProperVersion];
	NSString *baseline = @"6.0";
	NSComparisonResult theResult = [versionNumber compare:baseline options:NSNumericSearch];
		//NSLog(@"properVersion: %@", versionNumber);
		//NSLog(@"theversion: %@  installed version %@", theVersion, installedVersion);
	if ( theResult == NSOrderedDescending )
	{
			//	NSLog(@"%@ is greater than %@", versionNumber, baseline);
		
		return YES;
		
	} else if ( theResult == NSOrderedAscending ){
		
			//NSLog(@"%@ is greater than %@", baseline, versionNumber);
		return NO;
		
	} else if ( theResult == NSOrderedSame ) {
		
			//		NSLog(@"%@ is equal to %@", versionNumber, baseline);
		return YES;
	}
	
	return NO;
}

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

	switch (theAction)
	{
		case 1:
						
			if ([self blSixPointOhPlus])
			{
				id theViewStack = [self viewStack];
				
				int theCount = [[theViewStack controllers] count];
				
					//NSLog(@"theVIewstack: %@ count: %i", theViewStack, theCount);
					//	NSLog(@"is six point oh");
					//NSLog(@"stack controllers: %@", [[self viewStack] controllers]);
				if (theCount == 1)
				{
					
					return %orig;
				}
				
				[self performSelectorOnMainThread:@selector(popViewStackController:) withObject:theViewStack waitUntilDone:TRUE];
				
					//[self popViewStackController];
					//[[self viewStack] popController];
				
				
				return YES;
					//BLApplianceController
			}
			
			
			return NO;
			
					
			return %orig;
				//return YES;
			
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