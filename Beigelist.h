#import <Foundation/Foundation.h>

@protocol BeigelistApplianceLoadListener <NSObject>
@optional
+ (BOOL)shouldLoadApplianceBundle:(NSBundle *)bundle;
+ (void)loadedApplianceBundle:(NSBundle *)bundle;
@end

@interface Beigelist: NSObject
+ (void)registerApplianceLoadListener:(Class<BeigelistApplianceLoadListener>)loadListener;
@end

#define _BEIGELIST NSClassFromString(@"Beigelist")
