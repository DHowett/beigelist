extern "C" void BRSystemLog(int level, NSString *format, ...);

IMP queryParameters_IMP = NULL;

%hook NSURL
- (id)URLWithQueryParameter:(id)parameter value:(id)value {
	Method queryParameters = class_getInstanceMethod(objc_getClass("NSURL"), @selector(_queryParameters));
	IMP orig = method_setImplementation(queryParameters, queryParameters_IMP);
	id ret = %orig;
	method_setImplementation(queryParameters, orig);
	return ret;
}
%end

%ctor {
	BRSystemLog(3, @"0bacon (Save Our Bacon) (beigelist-%s) loaded.", VERSION);
	%init;
	Method queryParameters = class_getInstanceMethod(objc_getClass("NSURL"), @selector(_queryParameters));
	queryParameters_IMP = method_getImplementation(queryParameters);
	BRSystemLog(3, @"Captured original IMP %p for -[NSURL _queryParameters]", queryParameters_IMP);
}
