//
//  main.m
//  beigelist / Espresso
//
//  Created by Brandon Holland on 10-12-20.
//  Copyright 2010 What a Nutbar Software. All rights reserved.
//

#import "substrate.h"
#import "BLAppManager.h"

#define kEspressoCurrentVersion                 @"0.2(turbo-manatee)"

static IMP merchantcoordinator_allMerchants_old;
id merchantcoordinator_allMerchants_new(id self, SEL cmd)
{
    NSArray *allMerchants = merchantcoordinator_allMerchants_old(self, cmd);
    NSArray *frappuccinoMerchants = [[BLAppManager sharedFrappManager] frappuccinos];
    NSArray *applianceMerchants = [[BLAppManager sharedFrappManager] appliances];
    
    NSMutableArray *returnArray = [NSMutableArray array];
    [returnArray addObjectsFromArray: allMerchants];
    [returnArray addObjectsFromArray: frappuccinoMerchants];
    [returnArray addObjectsFromArray: applianceMerchants];

    return returnArray;
}

MSInitialize
{
    NSAutoreleasePool *localPool = [[NSAutoreleasePool alloc] init];
	
    NSLog(@"beigelist/espresso -> <version %@> loaded", kEspressoCurrentVersion);
    
    NSLog(@"beigelist/espresso -> loading legacy appliances...");
    [[BLAppManager sharedFrappManager] loadAppliances];
    
    NSLog(@"beigelist/espresso -> injecting...");
    
    MSHookMessageEx([ATVMerchantCoordinator class],
					@selector(allMerchants),
					(IMP)merchantcoordinator_allMerchants_new,
					(IMP *)&merchantcoordinator_allMerchants_old);
    
    NSLog(@"Espresso -> ready :)");
    
    [localPool drain];
}