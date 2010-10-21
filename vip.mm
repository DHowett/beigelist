#include <nlist.h>
#include <dlfcn.h>

static NSMutableArray *generateCustomWhiteList() {
	NSMutableArray *whiteList = [NSMutableArray array];

	NSString *lowtidePath = [[NSBundle mainBundle] bundlePath];
	NSString *frapPath = [lowtidePath stringByAppendingPathComponent:@"Appliances"];
	NSDirectoryEnumerator *iterator = [[NSFileManager defaultManager] enumeratorAtPath:frapPath];

	NSString *filePath = nil;
	while((filePath = [iterator nextObject])) {
		if([[filePath pathExtension] isEqualToString:@"frappliance"]) {
			NSBundle *applianceBundle = [NSBundle bundleWithPath:[frapPath stringByAppendingPathComponent:filePath]];
			NSString *applianceClassName = NSStringFromClass([applianceBundle principalClass]);

			if(applianceClassName)
				[whiteList addObject:applianceClassName];
		}
	}
	return whiteList;
}

static id *_sApplianceWhiteList;

static __attribute__((constructor)) void _localInit() {
	NSAutoreleasePool *p = [[NSAutoreleasePool alloc] init];
	void *handle = dlopen("/Library/MobileSubstrate/MobileSubstrate.dylib", RTLD_NOW);
	if(!handle) {
		NSLog(@"Couldn't load MobileSubstrate :(");
		goto _out;
	}

	NSLog(@"Loaded");

	struct nlist nl[2];
	memset(nl, 0, sizeof(nl));
	nl[0].n_name = (char *)"_sApplianceWhiteList";
	nlist("/System/Library/PrivateFrameworks/BackRow.framework/BackRow", nl);
	_sApplianceWhiteList = (id*)nl[0].n_value;
	if(_sApplianceWhiteList == NULL) {
		NSLog(@"Holy crap, everything is exploding (no _sApplianceWhiteList :(). Bail out!");
		goto _out;
	}

	NSLog(@"_sApplianceWhiteList = %16.16x", *(int*)_sApplianceWhiteList);
	NSLog(@"existing whitelist: %@", *(id*)_sApplianceWhiteList);
	[*(id*)_sApplianceWhiteList release];
	*(id*)_sApplianceWhiteList = [generateCustomWhiteList() retain];
	NSLog(@"new whitelist: %@", *(id*)_sApplianceWhiteList);

_out:
	[p drain];
	return;
}
// vim:ft=objc
