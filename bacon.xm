extern "C" void BRSystemLog(int level, NSString *format, ...);

IMP queryParameters_IMP = NULL;

%hook BRMainMenuController
- (void)reloadMainMenu {
	Method queryParameters = class_getInstanceMethod(objc_getClass("NSURL"), @selector(_queryParameters));
	IMP orig = method_setImplementation(queryParameters, queryParameters_IMP);
	%orig;
	method_setImplementation(queryParameters, orig);
}
%end

%ctor {
	%init;
	Method queryParameters = class_getInstanceMethod(objc_getClass("NSURL"), @selector(_queryParameters));
	queryParameters_IMP = method_getImplementation(queryParameters);
	BRSystemLog(3, @"Captured original IMP %p for -[NSURL _queryParameters]", queryParameters_IMP);
}
