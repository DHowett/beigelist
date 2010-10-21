#include <dlfcn.h>
#include <stdio.h>
static __attribute__((constructor)) void _localInit() {
	void *handle = dlopen("/Library/MobileSubstrate/MobileSubstrate.dylib", RTLD_NOW);
	if(!handle) {
		fprintf(stderr, "Couldn't load MobileSubstrate :(\n");
		goto _out;
	}
_out:
	return;
}
