#import "../Beigelist.h"

@interface ExampleLoadListener: NSObject <BeigelistApplianceLoadListener>
@end

@implementation ExampleLoadListener
// optional
+ (BOOL)shouldLoadApplianceBundle:(NSBundle *)bundle {
	NSString *l = [[bundle bundlePath] lastPathComponent];
	return [l hasPrefix:@"C"];
}

// optional
+ (void)loadedApplianceBundle:(NSBundle *)bundle {
}

+ (void)load {
	[_BEIGELIST registerApplianceLoadListener:self];
}
@end
