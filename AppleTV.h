//AppleTV 5.1




@protocol BRAppliance <NSObject>
- (id)initWithApplianceInfo:(id)applianceInfo;
- (id)applianceCategories;
- (id)applianceController;
- (id)applianceInfo;
- (id)controllerForIdentifier:(id)identifier args:(id)args;
- (BOOL)handleObjectSelection:(id)selection userInfo:(id)info;
- (BOOL)handlePlay:(id)play userInfo:(id)info;
- (id)identifierForContentAlias:(id)contentAlias;
- (id)topShelfController;
@end

@interface BRSingleton: NSObject
+ (id)allocWithZone:(NSZone *)zone;	// 0x3037190d
+ (id)sharedInstance;	// 0x30371809
- (id)autorelease;	// 0x303719e9
- (id)copyWithZone:(NSZone *)zone;	// 0x303719dd
- (oneway void)release;	// 0x303719e5
- (id)retain;	// 0x303719e1
- (unsigned)retainCount;	// 0x303719ed
@end

@interface BRFeatureManager: BRSingleton
- (BOOL)isFeatureEnabled:(id)feature;
@end

@interface BRParentalControlManager: BRSingleton
- (int)computeAccessModeForAppliance:(id)appliance withCategoryIdentifier:(id)categoryIdentifier;
@end


@interface BRLocalizedStringManager: BRSingleton
+ (id)_backRowFramework;	// 0x3036bfb5
+ (id)accessibilityLocalizedStringForKey:(id)key;	// 0x3036bb4d
+ (id)appliance:(id)appliance localizedStringForKey:(id)key inFile:(id)file;	// 0x3036bbf1
+ (id)applicationLocalizedStringForKey:(id)key inFile:(id)file;	// 0x3036bbad
+ (id)backRowLocalizedStringForKey:(id)key inFile:(id)file;	// 0x3036bb81
+ (id)localizedLanguageForCode:(id)code;	// 0x3036bf25
+ (id)localizedStringForKey:(id)key inFile:(id)file fromBundle:(id)bundle;	// 0x3036bc85
+ (id)pathForResource:(id)resource ofType:(id)type forBundle:(id)bundle;	// 0x3036be9d
+ (void)setSingleton:(id)singleton;	// 0x3036b9c1
+ (id)singleton;	// 0x3036b9b1
- (id)init;	// 0x3036b9d1
- (id)_currentLanguageNameForBundle:(id)bundle;	// 0x3036c155
- (id)_hashKeyForStringKey:(id)stringKey inFile:(id)file fromBundlePath:(id)bundlePath;	// 0x3036c221
- (void)_languageChanged:(id)changed;	// 0x3036bfb9
- (void)dealloc;	// 0x3036babd
@end

@interface BRImage : NSObject
+ (id)imageWithCGImageRef:(CGImageRef)cgimageRef;	// 0x3023cb7d
+ (id)imageWithData:(id)data;	// 0x3023cb39
+ (id)imageWithName:(id)name ofType:(id)type inBundle:(id)bundle;	// 0x3023cca9
+ (id)imageWithPDFURL:(id)pdfurl;	// 0x3023cbc1
+ (id)imageWithPath:(id)path;	// 0x3023cad1
+ (id)imageWithRotationFromData:(id)data;	// 0x3023cd99
+ (id)imageWithRotationFromPath:(id)path;	// 0x3023cd59
+ (id)imageWithRotationFromURL:(id)url;	// 0x3023cd01
+ (id)imageWithURL:(id)url;	// 0x3023ca8d
- (id)initWithCGImageRef:(CGImageRef)cgimageRef;	// 0x3023cdf1
- (id)initWithData:(id)data;	// 0x3023d07d
- (id)initWithURL:(id)url;	// 0x3023ced1
- (void)_initializeCGImageWithRotation;	// 0x3023de0d
- (id)accessibilityLabel;	// 0x3023d7b1
- (float)aspectRatio;	// 0x3023d3fd
- (id)croppedImageForSize:(CGSize)size;	// 0x3023d8c1
- (void)dealloc;	// 0x3023d239
- (id)deletterboxedImage;	// 0x3023d4e9
- (void)drawImageInContext:(CGContextRef)context rect:(CGRect)rect;	// 0x3023d2d9
- (BOOL)enableCache;	// 0x3023d4d9
- (CGImageRef)image;	// 0x3023d30d
- (BOOL)isAccessibilityElement;	// 0x3023d799
- (BOOL)isImageBufferInMemory;	// 0x3023dc85
- (BOOL)isPowerOfTwo;	// 0x3023d441
- (CGRect)largestSquareRect;	// 0x3023dac1
- (id)mapImageWithSourceRect:(CGRect)sourceRect toSize:(CGSize)size;	// 0x3023d805
- (int)orientation;	// 0x3023dc95
- (CGSize)pixelBounds;	// 0x3023d3d1
- (void)purgeRawData;	// 0x303685dd
- (id)rawData;	// 0x303685d9
- (BOOL)rotationEnabled;	// 0x3023dca5
- (void)setAccessibilityLabel:(id)label;	// 0x3023d7c1
- (void)setEnableCache:(BOOL)cache;	// 0x3023d4a9
- (BOOL)sourceRequiresRotation;	// 0x3023d48d
- (id)squareImageFromNearSquareImageWithAspectRatioLimit:(float)aspectRatioLimit;	// 0x3023dba1
@end

@interface BRApplianceInfo: NSObject
+ (id)infoForApplianceDescription:(id)applianceDescription;	// 0x30245f25
- (id)_initWithMutableDictionary:(id)mutableDictionary;	// 0x30245dc9
- (id)applianceCategoryDescriptors;	// 0x30246281
- (void)dealloc;	// 0x30245e15
- (unsigned)hash;	// 0x30245ed9
- (BOOL)hideIfNoCategories;	// 0x302462a9
- (id)info;	// 0x302462f1
- (BOOL)isEqual:(id)equal;	// 0x30245e61
- (id)key;	// 0x30246151
- (id)localizedStringsFileName;	// 0x30246231
- (id)name;	// 0x30246179
- (float)preferredOrder;	// 0x302461a1
- (BOOL)primaryAppliance;	// 0x30246111
- (id)principalClassName;	// 0x30246259
- (id)requiredRemoteMediaTypes;	// 0x30246209
- (void)setInfo:(id)info;	// 0x30246301
- (id)supportedMediaTypes;	// 0x302461e1
+ (id)infoForApplianceBundle:(id)applianceBundle; //this is just added to keep beigelist from whining, it does NOT exist in 5.1.
@end

@interface BRApplianceCategory: NSObject
+ (id)categoryWithName:(id)name identifier:(id)identifier preferredOrder:(float)order;	// 0x30245625
- (id)init;	// 0x302456b1
- (id)action;	// 0x302459e1
- (void)dealloc;	// 0x30245715
- (id)description;	// 0x30245761
- (BOOL)followsStoreCateogry;	// 0x30245af1
- (id)identifier;	// 0x30245991
- (BOOL)isDefaultCategory;	// 0x30245929
- (BOOL)isStoreCategory;	// 0x30245a5d
- (BOOL)isStoreDependent;	// 0x30245b85
- (id)name;	// 0x30245819
- (float)preferredOrder;	// 0x30245895
- (void)setAction:(id)action;	// 0x302459b9
- (void)setFollowsStoreCategory:(BOOL)category;	// 0x30245a9d
- (void)setIdentifier:(id)identifier;	// 0x30245969
- (void)setIsDefaultCategory:(BOOL)category;	// 0x302458d5
- (void)setIsStoreCategory:(BOOL)category;	// 0x30245a09
- (void)setIsStoreDependent:(BOOL)dependent;	// 0x30245b31
- (void)setName:(id)name;	// 0x302457f1
- (void)setPreferredOrder:(float)order;	// 0x30245841
- (void)setShouldDisplayOnStartup:(BOOL)displayOnStartup;	// 0x30245bc5
- (void)setTextEntryHistoryDisplayBehaviors:(id)behaviors;	// 0x30245d6d
- (void)setTextEntryHistoryDisplayClients:(id)clients;	// 0x30245d11
- (void)setTextEntryHistoryStorageBehavior:(id)behavior;	// 0x30245cb5
- (void)setTextEntryHistoryStorageClient:(id)client;	// 0x30245c59
- (BOOL)shouldDisplayOnStartup;	// 0x30245c19
- (id)textEntryHistoryDisplayBehaviors;	// 0x30245da1
- (id)textEntryHistoryDisplayClients;	// 0x30245d45
- (id)textEntryHistoryStorageBehavior;	// 0x30245ce9
- (id)textEntryHistoryStorageClient;	// 0x30245c8d
@end

@interface BRBaseAppliance: NSObject <BRAppliance>
- (id)init;	// 0x30246325
- (id)initWithApplianceInfo:(id)applianceInfo;	// 0x30246329
- (BOOL)_anySharesAvailable;	// 0x302472b1
- (BOOL)_anyStoreCategoryExistsInMusicStoreCollection:(id)musicStoreCollection;	// 0x30247345
- (id)_applianceCategories;	// 0x30246c6d
- (BOOL)_isCategoryWithIdentifier:(id)identifier memberOfMusicStoreCollection:(id)musicStoreCollection;	// 0x30247225
- (id)accessibilityLabel;	// 0x30246b29
- (id)alertControllerForNoContent;	// 0x30246a55
- (id)alertControllerForNoRemoteContent;	// 0x30246ab5
- (id)applianceCategories;	// 0x30246789
- (id)applianceCategoryDescriptions;	// 0x30246b99
- (id)applianceController;	// 0x302468cd
- (id)applianceInfo;	// 0x30246b61
- (id)baseMediaType;	// 0x30246655
- (id)categoryWithIdentifier:(id)identifier;	// 0x302469bd
- (id)controllerForIdentifier:(id)identifier args:(id)args;	// 0x302468c9
- (void)dealloc;	// 0x3024647d
- (id)description;	// 0x302465d5
- (BOOL)handleObjectSelection:(id)selection userInfo:(id)info;	// 0x302468d1
- (BOOL)handlePlay:(id)play userInfo:(id)info;	// 0x302468d5
- (unsigned)hash;	// 0x30246589
- (id)identifierForContentAlias:(id)contentAlias;	// 0x302468c5
- (BOOL)isEqual:(id)equal;	// 0x30246511
- (id)loadCategories;	// 0x30246bc1
- (id)musicStoreItemWithIdentifier:(id)identifier;	// 0x302468d9
- (int)noContentBRError;	// 0x30246aad
- (int)noRemoteContentBRError;	// 0x30246b0d
- (BOOL)previewError;	// 0x30246b15
- (id)previewErrorIconImage;	// 0x30246b21
- (id)previewErrorSubtext;	// 0x30246b1d
- (id)previewErrorText;	// 0x30246b19
- (void)reloadCategories;	// 0x30246bd1
- (void)setApplianceInfo:(id)info;	// 0x30246b75
- (id)topShelfController;	// 0x30246b25
@end

@interface BRApplianceManager: BRSingleton
+ (void)setSingleton:(id)singleton;	// 0x303234b5
+ (void)showMainMenu;	// 0x303234c5
+ (id)singleton;	// 0x303234a5
- (id)init;	// 0x30323521
- (void)_applianceDidReloadCategories:(id)_appliance;	// 0x30323819
- (id)_applianceForInfo:(id)info;	// 0x30324381
- (id)_controllerForApplianceKey:(id)applianceKey identifier:(id)identifier args:(id)args;	// 0x30323f01
- (void)_handleLanguageChangedNotification:(id)notification;	// 0x30324371
- (void)_handleParentalControlsChangedNotification:(id)notification;	// 0x30324361
- (BOOL)_handlePlay:(id)play userInfo:(id)info;	// 0x303241e5
- (void)_invalidateArrangedAppliances;	// 0x3032446d
- (id)_loadApplianceAtPath:(id)path;	// 0x303248d5
- (void)_loadAppliances;	// 0x30324539
- (BOOL)_shouldLoadApp:(id)app;	// 0x3032447d
- (id)applianceForInfo:(id)info;	// 0x303237dd
- (id)applianceIdentifierToApplianceDictionary;	// 0x30323ec9
- (id)applianceInfoForApplianceIdentifier:(id)applianceIdentifier;	// 0x303237a5
- (id)applianceInfoList;	// 0x30323771
- (id)appliances;	// 0x30323e91
- (id)arrangedAppliances;	// 0x30323661
- (id)controllerForApplianceInfo:(id)applianceInfo identifier:(id)identifier args:(id)args;	// 0x30323bc1
- (id)controllerForApplianceKey:(id)applianceKey identifier:(id)identifier args:(id)args;	// 0x30323bf1
- (id)controllerForMerchant:(id)merchant;	// 0x30323bad
- (void)dealloc;	// 0x303235dd
- (BOOL)handleObjectSelection:(id)selection userInfo:(id)info;	// 0x30323d89
- (BOOL)handlePlay:(id)play userInfo:(id)info;	// 0x30323e0d
- (void)loadAppliances;	// 0x30323671
- (void)setApplianceIdentifierToApplianceDictionary:(id)applianceDictionary;	// 0x30323edd
- (void)setAppliances:(id)appliances;	// 0x30323ea5
@end

@interface BRMerchantInfo: NSObject
+ (id)infoWithVendorBag:(id)vendorBag;	// 0x303487e1
- (id)initWithVendorBag:(id)vendorBag;	// 0x3034881d
- (id)_featureCode;	// 0x303491bd
- (id)appDictionary;	// 0x30349191
- (id)authType;	// 0x30348ebd
- (id)bootstrapResourceURL;	// 0x30348ee9
- (id)bootstrapResourceVersion;	// 0x30348f15
- (void)dealloc;	// 0x30348915
- (int)defaultParentalControlsAccessMode;	// 0x30349025
- (BOOL)enabled;	// 0x30348a2d
- (BOOL)enabledInBag;	// 0x30348b7d
- (id)featureName;	// 0x30348995
- (id)feedResources;	// 0x30349265
- (BOOL)hasBeenRemoved;	// 0x30348b39
- (id)javascriptURL;	// 0x30348f41
- (id)maximumVersion;	// 0x30349101
- (id)menuIconURL;	// 0x30348cc9
- (id)menuIconURLVersion;	// 0x30348df5
- (id)menuTitle;	// 0x30348c71
- (id)merchantID;	// 0x30348ca9
- (id)metadata;	// 0x30349245
- (id)minimumRequiredVersion;	// 0x303490bd
- (float)preferredOrder;	// 0x30348f6d
- (id)rootURL;	// 0x30348e65
- (void)setEnabled:(BOOL)enabled;	// 0x30348ab5
- (void)setFeatureName:(id)name;	// 0x303489ed
- (void)setFeedResources:(id)resources;	// 0x30349275
- (void)setMetadata:(id)metadata;	// 0x30349255
- (id)supportURL;	// 0x30349165
- (id)topShelfURL;	// 0x30348e91
- (void)useDefaultEnablement;	// 0x30348c41
- (BOOL)usesParentalControls;	// 0x30348fe1
- (id)valueForUndefinedKey:(id)undefinedKey;	// 0x30348975
@end

@interface BRMerchant: NSObject 
+ (id)flagstaff;	// 0x301d8bd1
+ (id)itms;	// 0x301d8b4d
+ (id)merchantForControl:(id)control;	// 0x3034803d
+ (id)merchantForControl:(id)control defaultMerchant:(id)merchant;	// 0x30348051
+ (id)merchantForObject:(id)object;	// 0x30347d55
+ (id)merchantForObject:(id)object defaultMerchant:(id)merchant;	// 0x30347d69
+ (id)merchantWithClosestAffinityToURL:(id)url;	// 0x303480ad
+ (id)sedona;	// 0x301d8b8d
- (id)initWithCoder:(id)coder;	// 0x303482a5
- (id)initWithIdentifier:(id)identifier;	// 0x30348211
- (id)initWithVendorBag:(id)vendorBag;	// 0x30348181
- (id)accountType;	// 0x303484c5
- (void)assignToControl:(id)control;	// 0x3034865d
- (BOOL)assignToObject:(id)object;	// 0x3034851d
- (Class)catalogAgent;	// 0x301d8c11
- (id)copyWithZone:(NSZone *)zone;	// 0x303482a1
- (void)dealloc;	// 0x303482ad
- (id)description;	// 0x30348329
- (BOOL)enabled;	// 0x303484c9
- (void)encodeWithCoder:(id)coder;	// 0x303482a9
- (id)evaluatePlist:(id)plist;	// 0x303487d5
- (id)generateRequestForURL:(id)url headers:(id)headers method:(id)method;	// 0x30348695
- (id)generateRequestForURL:(id)url headers:(id)headers method:(id)method body:(id)body;	// 0x303486b9
- (BOOL)hasAffinityToURL:(id)url;	// 0x303487dd
- (id)identifier;	// 0x3034849d
- (id)info;	// 0x3034844d
- (id)localizedStringForKey:(id)key;	// 0x303487c9
- (id)merchantErrorForError:(id)error;	// 0x303487d1
- (id)playerDelegate;	// 0x303487d9
- (oneway void)release;	// 0x30348295
- (id)retain;	// 0x30348291
- (unsigned)retainCount;	// 0x30348299
- (void)setEnabled:(BOOL)enabled;	// 0x303484f1
- (void)setInfo:(id)info;	// 0x3034845d
- (BOOL)updateWithVendorBag:(id)vendorBag;	// 0x303483c9
@end

@interface ATVMerchant: BRMerchant
- (id)initWithIdentifier:(id)identifier;	// 0x301d8c2d
- (BOOL)assignToObject:(id)object;	// 0x301d8df1
- (void)clearFeedResources;	// 0x301d91d1
- (void)dealloc;	// 0x301d8d91
- (id)evaluatePlist:(id)plist;	// 0x301d8f81
- (id)feedResourceNamed:(id)named;	// 0x301d8fa5
- (id)localizedStringForKey:(id)key;	// 0x301d8f45
- (id)rootController;	// 0x301d8fa1
- (id)sessionResource;	// 0x301d91f1
- (void)setFeedResource:(id)resource named:(id)named;	// 0x301d91b1
@end

@interface ATVMerchantCoordinator: BRSingleton
+ (void)_bootstrapCupidAccountsAndAuthentication;	// 0x303ecce1
+ (void)setSingleton:(id)singleton;	// 0x303ece11
+ (id)singleton;	// 0x303ece01
- (id)init;	// 0x303ece21
- (void)_cleanUpAfterLegacyMerchant:(id)merchant;	// 0x303ee5c9
- (void)_cleanupAfterMerchantsHaveBeenRemoved;	// 0x303ee4a5
- (void)_handleParentalControlsChangedNotification:(id)notification;	// 0x303ed085
- (void)_loadAddSiteMerchants;	// 0x303ed869
- (id)_loadedMerchantsFilterPredicate;	// 0x303ed095
- (id)_localBags;	// 0x303ed781
- (void)_musicStorePartnerDataUpdated;	// 0x303ee821
- (id)_newMerchantWithIdentifier:(id)identifier;	// 0x303edd55
- (void)_registerAccountAndAuthenticatorForMerchant:(id)merchant;	// 0x303ede69
- (void)_updateMerchants;	// 0x303ed661
- (void)_updateMerchantsWithVendorBags:(id)vendorBags;	// 0x303ed341
- (id)allMerchants;	// 0x303ee8dd
- (void)dealloc;	// 0x303ecf09
- (id)loadedMerchants;	// 0x303ee8a9
- (id)merchantWithIdentifier:(id)identifier;	// 0x303ecfc9
- (void)setAllMerchants:(id)merchants;	// 0x303ee8ed
- (void)setLoadedMerchants:(id)merchants;	// 0x303ee8b9
@end

@protocol BRFocusContainer <NSObject>
- (CGSize)boundsForFocusCandidate:(id)focusCandidate;
- (id)debugDescriptionForFocusCandidate:(id)focusCandidate;
- (BOOL)eligibilityForFocusCandidate:(id)focusCandidate;
- (id)focusCandidates;
- (id)focusObjectForCandidate:(id)candidate;
- (CGPoint)positionForFocusCandidate:(id)focusCandidate;
@end

@protocol BRResponder <NSObject>
- (BOOL)brEventAction:(id)action;
- (BOOL)brKeyEvent:(id)event;
@end

@interface BRControl: NSObject <BRFocusContainer, BRResponder>
+ (id)control;	// 0x30239729
+ (id)controlWithScaledFrame:(CGRect)scaledFrame;	// 0x30311a39
+ (Class)layerClass;	// 0x30239771
- (id)init;	// 0x3023978d
- (id)initWithLayout:(id)layout;	// 0x302395c5
- (void)_axPrintSubviews:(int)subviews string:(id)string;	// 0x3023fb99
- (id)_axSubviews;	// 0x3023fcf5
- (id)_axSuperviews;	// 0x3023fafd
- (BOOL)_changeFocusTo:(id)to;	// 0x3023c16d
- (void)_dumpControlTree;	// 0x3023c815
- (void)_dumpFocusTree;	// 0x3023c609
- (BOOL)_focusControlTreeForEvent:(id)event nearPoint:(CGPoint)point;	// 0x3023c075
- (BOOL)_focusControlTreeWithDefaults;	// 0x3023c00d
- (id)_focusedLeafControl;	// 0x3023c42d
- (CGPoint)_focusedPointForEvent:(id)event;	// 0x3023befd
- (id)_initialFocus;	// 0x3023c4a1
- (void)_insertSingleControl:(id)control atIndex:(long)index;	// 0x3023b86d
- (id)_parentScrollControl;	// 0x302be42d
- (void)_reevaluateFocusTree;	// 0x3023c44d
- (void)_removeAllControls;	// 0x3023bb5d
- (void)_removeControl:(id)control;	// 0x3023ba3d
- (void)_resizeSubviewsWithOldSize:(CGSize)oldSize;	// 0x3023bbcd
- (void)_resizeWithOldSuperviewSize:(CGSize)oldSuperviewSize;	// 0x3023bc95
- (void)_scrollPoint:(CGPoint)point fromControl:(id)control;	// 0x302be4b1
- (void)_scrollRect:(CGRect)rect fromControl:(id)control;	// 0x302be4e1
- (void)_scrollingCompleted;	// 0x302be2f5
- (void)_scrollingInitiated;	// 0x302be341
- (void)_setControlFocused:(BOOL)focused;	// 0x3023c38d
- (void)_setFocus:(id)focus;	// 0x3023c209
- (CGRect)_visibleRectOfControl:(id)control;	// 0x302be455
- (void)_visibleScrollRectChanged;	// 0x302be521
- (BOOL)acceptsFocus;	// 0x3023b619
- (id)accessibilityAncestor:(Class)ancestor;	// 0x3023f9a9
- (id)accessibilityControls;	// 0x3023f94d
- (BOOL)accessibilityElementIsHidden;	// 0x3023f9f1
- (BOOL)accessibilityIsDescendant:(id)descendant;	// 0x3023f95d
- (BOOL)accessibilityOutputsRangeForChildren;	// 0x3023fa6d
- (id)actionForKey:(id)key;	// 0x3023b80d
- (id)actionForLayer:(id)layer forKey:(id)key;	// 0x30239ec1
- (id)actions;	// 0x3023b84d
- (BOOL)active;	// 0x3023a86d
- (void)addAnimation:(id)animation forKey:(id)key;	// 0x3023b78d
- (void)addControl:(id)control;	// 0x3023a97d
- (CGAffineTransform)affineTransform;	// 0x3023a2e5
- (CGPoint)anchorPoint;	// 0x3023a271
- (id)animationForKey:(id)key;	// 0x3023b7ad
- (unsigned)autoresizingMask;	// 0x3023a52d
- (BOOL)avoidsCursor;	// 0x3023b6f1
- (CGColorRef)backgroundColor;	// 0x3023ae75
- (id)badge;	// 0x30286f65
- (CGColorRef)borderColor;	// 0x3023b20d
- (float)borderWidth;	// 0x3023b24d
- (CGRect)bounds;	// 0x3023a21d
- (CGSize)boundsForFocusCandidate:(id)focusCandidate;	// 0x3023c539
- (BOOL)brEventAction:(id)action;	// 0x30239ac5
- (BOOL)brKeyEvent:(id)event;	// 0x30239d21
- (int)contentMode;	// 0x3023b00d
- (CGAffineTransform)contentModeTransformForSize:(CGSize)size;	// 0x3023a315
- (long)controlCount;	// 0x3023ad25
- (void)controlDidDisplayAsModalDialog;	// 0x30327575
- (id)controlForPoint:(CGPoint)point;	// 0x3023b785
- (void)controlWasActivated;	// 0x3023a87d
- (void)controlWasDeactivated;	// 0x3023a8c1
- (void)controlWasFocused;	// 0x3023b695
- (void)controlWasUnfocused;	// 0x3023b699
- (id)controls;	// 0x3023acf9
- (CGPoint)convertPoint:(CGPoint)point fromControl:(id)control;	// 0x3023a671
- (CGPoint)convertPoint:(CGPoint)point toControl:(id)control;	// 0x3023a6cd
- (CGRect)convertRect:(CGRect)rect fromControl:(id)control;	// 0x3023a729
- (CGRect)convertRect:(CGRect)rect toControl:(id)control;	// 0x3023a78d
- (void)dealloc;	// 0x3023981d
- (id)debugDescriptionForFocusCandidate:(id)focusCandidate;	// 0x3023c605
- (id)defaultFocus;	// 0x3023b579
- (void)drawInContext:(CGContextRef)context;	// 0x3023ae0d
- (void)drawLayer:(id)layer inContext:(CGContextRef)context;	// 0x30239ead
- (BOOL)eligibilityForFocusCandidate:(id)focusCandidate;	// 0x3023c585
- (id)eventDelegate;	// 0x30239fb1
- (id)firstControlNamed:(id)named;	// 0x3023a945
- (id)focusCandidates;	// 0x3023c4f5
- (CGRect)focusCursorFrame;	// 0x3023b721
- (id)focusObjectForCandidate:(id)candidate;	// 0x3023c571
- (id)focusedControl;	// 0x3023b4d5
- (id)focusedControlForEvent:(id)event focusPoint:(CGPoint *)point;	// 0x3023b589
- (CGRect)frame;	// 0x3023a0d1
- (BOOL)handlePlayButton:(id)button;	// 0x3018fd85
- (id)identifier;	// 0x30239a9d
- (BOOL)ignoreDirectionalInfoForFocus;	// 0x30239fe9
- (id)inheritedValueForKey:(id)key;	// 0x30239d91
- (BOOL)inhibitsFocusForChildren;	// 0x3023b65d
- (BOOL)inhibitsScrollFocusForChildren;	// 0x3023b685
- (id)initialFocus;	// 0x3023b31d
- (void)insertControl:(id)control above:(id)above;	// 0x3023aa01
- (void)insertControl:(id)control atIndex:(long)index;	// 0x3023a9c1
- (void)insertControl:(id)control below:(id)below;	// 0x3023aa75
- (BOOL)isFocused;	// 0x3023b69d
- (BOOL)isHidden;	// 0x3023aef5
- (id)keyEventTargetControl;	// 0x30239fa1
- (id)layer;	// 0x30239a15
- (id)layerForBacking;	// 0x302399bd
- (void)layoutSubcontrols;	// 0x3023adad
- (void)layoutSublayersOfLayer:(id)layer;	// 0x30239ed5
- (void)mapDataObject:(id)object withMappings:(id)mappings;	// 0x3017d669
- (BOOL)masksToBounds;	// 0x3023ae31
- (id)name;	// 0x3023a925
- (id)object;	// 0x30239a4d
- (float)opacity;	// 0x3023aeb5
- (id)parent;	// 0x3023a835
- (id)parentScrollControl;	// 0x302be409
- (CGPoint)position;	// 0x3023a125
- (CGPoint)positionForFocusCandidate:(id)focusCandidate;	// 0x3023c515
- (id)preferredActionForKey:(id)key;	// 0x3023b789
- (float)preferredCursorRadius;	// 0x30286f61
- (void)removeAllAnimations;	// 0x3023b7ed
- (void)removeAnimationForKey:(id)key;	// 0x3023b7cd
- (void)removeFromParent;	// 0x3023ad5d
- (id)root;	// 0x3023a7f1
- (CGPoint)scrollControl:(id)control adjustScrollPosition:(CGPoint)position;	// 0x302be421
- (void)scrollPoint:(CGPoint)point;	// 0x302be38d
- (void)scrollRectToVisible:(CGRect)visible;	// 0x302be3a9
- (void)scrollingCompleted;	// 0x302be419
- (void)scrollingInitiated;	// 0x302be41d
- (id)selectionHandler;	// 0x3023b761
- (void)setAcceptsFocus:(BOOL)focus;	// 0x3023b5d9
- (void)setAccessibilityOutputsRangeForChildren:(BOOL)children;	// 0x3023fac1
- (void)setActions:(id)actions;	// 0x3023b82d
- (void)setAffineTransform:(CGAffineTransform)transform;	// 0x3023a2a1
- (void)setAnchorPoint:(CGPoint)point;	// 0x3023a251
- (void)setAutoresizingMask:(unsigned)mask;	// 0x3023a51d
- (void)setAvoidsCursor:(BOOL)cursor;	// 0x3023b6ad
- (void)setBackgroundColor:(CGColorRef)color;	// 0x3023ae55
- (void)setBorderColor:(CGColorRef)color;	// 0x3023b1ed
- (void)setBorderWidth:(float)width;	// 0x3023b22d
- (void)setBounds:(CGRect)bounds;	// 0x3023a155
- (void)setContentMode:(int)mode;	// 0x3023af19
- (void)setControls:(id)controls;	// 0x3023ab15
- (void)setDefaultFocus:(id)focus;	// 0x3023b4e5
- (void)setDefaultFocusWithPoint:(CGPoint)point;	// 0x3023b781
- (void)setEventDelegate:(id)delegate;	// 0x30239fc5
- (BOOL)setFocusToGlyphNamed:(id)glyphNamed;	// 0x3038ddbd
- (void)setFocusedControl:(id)control;	// 0x3023b3f5
- (void)setFrame:(CGRect)frame;	// 0x3023a009
- (void)setHidden:(BOOL)hidden;	// 0x3023aed5
- (void)setIdentifier:(id)identifier;	// 0x30239a75
- (void)setIgnoreDirectionalInfoForFocus:(BOOL)focus;	// 0x30239ff9
- (void)setInhibitsFocusForChildren:(BOOL)children;	// 0x3023b629
- (void)setInhibitsScrollFocusForChildren:(bool)children;	// 0x3023b66d
- (void)setKeyEventTargetControl:(id)control;	// 0x30239f09
- (void)setMasksToBounds:(BOOL)bounds;	// 0x3023ae11
- (void)setName:(id)name;	// 0x3023a905
- (void)setNeedsDisplay;	// 0x3023adb1
- (void)setNeedsDisplayInRect:(CGRect)rect;	// 0x3023add1
- (void)setNeedsLayout;	// 0x3023ad8d
- (void)setObject:(id)object;	// 0x30239a25
- (void)setOpacity:(float)opacity;	// 0x3023ae95
- (void)setPosition:(CGPoint)position;	// 0x3023a105
- (void)setSelectionHandler:(id)handler;	// 0x3023b745
- (void)setSubcontrols:(id)subcontrols;	// 0x3023ab05
- (void)setValue:(id)value forKey:(id)key cascade:(BOOL)cascade;	// 0x30239dd9
- (void)setValue:(id)value forUndefinedKey:(id)undefinedKey;	// 0x30239d71
- (CGSize)sizeThatFits:(CGSize)fits;	// 0x3023a53d
- (void)sizeToFit;	// 0x3023a575
- (id)subcontrols;	// 0x3023aacd
- (int)touchSensitivity;	// 0x3023b77d
- (id)valueForUndefinedKey:(id)undefinedKey;	// 0x30239d51
- (CGRect)visibleScrollRect;	// 0x302be3e1
- (void)visibleScrollRectChanged;	// 0x302be3d1
- (void)windowMaxBoundsChanged;	// 0x3023b26d
@end

@interface BRControllerStack: BRControl
- (id)init;	// 0x3024a7f5
- (void)_addTransaction:(id)transaction;	// 0x3024b421
- (id)_checkSubstitutions:(id)substitutions;	// 0x3024d07d
- (void)_databaseObjectModified:(id)modified;	// 0x3024cedd
- (void)_performDepthLimitedCullingForController:(id)controller;	// 0x3024cce5
- (void)_processPopToClassTransaction:(id)classTransaction;	// 0x3024c379
- (void)_processPopToLabelTransaction:(id)labelTransaction;	// 0x3024c455
- (void)_processPopToTransaction:(id)transaction;	// 0x3024c165
- (void)_processPopTransaction:(id)transaction;	// 0x3024bd41
- (void)_processPushTransaction:(id)transaction;	// 0x3024bc09
- (void)_processRemoveTransaction:(id)transaction;	// 0x3024c521
- (void)_processReplaceAllTransaction:(id)transaction;	// 0x3024c831
- (void)_processReplaceControllersAboveLabelTransaction:(id)transaction;	// 0x3024ca75
- (void)_processSwapTransaction:(id)transaction;	// 0x3024bf21
- (void)_processTransactions;	// 0x3024b46d
- (void)_refreshControllersNotification:(id)notification;	// 0x3024cec9
- (void)_setContent:(id)content direction:(int)direction oldTransition:(id)transition;	// 0x3024b669
- (void)_updateControllerValidity:(id)validity;	// 0x3024cf91
- (void)_updateControllersOnlyLegacy:(BOOL)legacy;	// 0x3024cd79
- (void)_updateStackPathForPoppingController:(id)poppingController;	// 0x3024cff9
- (void)_updateStackPathForPushingController:(id)pushingController;	// 0x3024cfa5
- (id)accessibilityLabel;	// 0x3024b3f9
- (BOOL)brEventAction:(id)action;	// 0x3024b219
- (id)controllers;	// 0x3024b005
- (id)controllersLabeled:(id)labeled;	// 0x3024b031
- (id)controllersOfClass:(Class)aClass;	// 0x3024b115
- (int)count;	// 0x3024b1f9
- (void)dealloc;	// 0x3024a9a1
- (void)layoutSubcontrols;	// 0x3024aaf1
- (id)peekController;	// 0x3024af9d
- (void)popController;	// 0x3024abf9
- (void)popToController:(id)controller;	// 0x3024ac51
- (void)popToControllerOfClass:(Class)aClass;	// 0x3024acb9
- (void)popToControllerWithLabel:(id)label;	// 0x3024ad3d
- (void)pushController:(id)controller;	// 0x3024ab7d
- (void)removeController:(id)controller;	// 0x3024ada5
- (void)replaceAllControllersWithController:(id)controller;	// 0x3024ae89
- (void)replaceControllersAboveLabel:(id)label withController:(id)controller;	// 0x3024af05
- (id)rootController;	// 0x3024afbd
- (id)stackPathForController:(id)controller;	// 0x3024b29d
- (void)swapController:(id)controller;	// 0x3024ae0d
- (void)updateStackPathForController:(id)controller previousIdentifier:(id)identifier;	// 0x3024b33d
@end

@interface BRController: BRControl
+ (id)controllerWithContentControl:(id)contentControl;	// 0x30249d05
- (id)init;	// 0x30249d41
- (void)_contextMenuCancelItemSelected:(id)selected;	// 0x3024a7b9
- (void)_handleWindowMaxBoundsChanged;	// 0x3024a47d
- (void)addLabel:(id)label;	// 0x3024a385
- (BOOL)brEventAction:(id)action;	// 0x30249f19
- (BOOL)canBeRemovedFromStack;	// 0x3024a381
- (int)contextMenuDimOption;	// 0x3024a681
- (BOOL)contextMenuIsVisible;	// 0x3024a609
- (id)controlForContextMenuPositioning;	// 0x3024a601
- (id)controlForContextMenuStart;	// 0x3024a605
- (id)controlToDim;	// 0x3024a67d
- (void)controlWasDeactivated;	// 0x30249ed9
- (void)dealloc;	// 0x30249ded
- (BOOL)depthLimited;	// 0x3024a451
- (id)description;	// 0x3024a1fd
- (void)dismissContextMenu;	// 0x3024a635
- (long)errorNumberForNoContent;	// 0x3024a465
- (id)hostingController;	// 0x3024a5ed
- (BOOL)isLabelled:(id)labelled;	// 0x3024a409
- (BOOL)isNetworkDependent;	// 0x3024a439
- (BOOL)isValidAfterDataUpdate;	// 0x3024a461
- (id)providersForContextMenu;	// 0x3024a5fd
- (BOOL)recreateOnReselect;	// 0x3024a43d
- (void)removeLabel:(id)label;	// 0x3024a3e9
- (void)setDepthLimited:(BOOL)limited;	// 0x3024a441
- (void)setHostingController:(id)controller;	// 0x30249ec9
- (void)setStack:(id)stack;	// 0x3024a331
- (void)setWasBuriedBlock:(id)block;	// 0x3024a595
- (void)setWasExhumedBlock:(id)block;	// 0x3024a5c9
- (void)setWasPoppedBlock:(id)block;	// 0x3024a561
- (void)setWasPushedBlock:(id)block;	// 0x3024a52d
- (id)stack;	// 0x3024a341
- (BOOL)topOfStack;	// 0x3024a351
- (id)transitionType;	// 0x3024a46d
- (void)wasBuried;	// 0x3024a765
- (id)wasBuriedBlock;	// 0x3024a585
- (void)wasExhumed;	// 0x3024a799
- (id)wasExhumedBlock;	// 0x3024a5b9
- (void)wasPopped;	// 0x3024a6ed
- (id)wasPoppedBlock;	// 0x3024a551
- (void)wasPushed;	// 0x3024a685
- (id)wasPushedBlock;	// 0x3024a51d
@end

@interface BRViewController: BRController
- (void)_handleWindowMaxBoundsChanged;	// 0x30260889
- (void)dealloc;	// 0x30260731
- (void)layoutSubcontrols;	// 0x3026081d
- (void)setView:(id)view;	// 0x3026077d
- (id)view;	// 0x3026080d
@end

@interface BRMenuItem: BRControl
- (id)init;	// 0x3030d81d
- (id)_accessoryOfType:(int)type;	// 0x3031024d
- (id)_accessoryOfType:(int)type offset:(float *)offset;	// 0x30310261
- (CGRect)_contentFrameForBounds:(CGRect)bounds;	// 0x303112f5
- (id)_detailedTextAttributes;	// 0x30310bc5
- (id)_firstAccessoryFromAccessories:(id)accessories offset:(float *)offset;	// 0x30310695
- (CGRect)_imageFrame;	// 0x3031108d
- (id)_imageWithName:(id)name;	// 0x30310d6d
- (id)_largeLeftImage;	// 0x30310855
- (float)_largestOrdinalWidth;	// 0x30310e7d
- (id)_ordinalImage;	// 0x303109f9
- (id)_ordinalString;	// 0x30310f61
- (id)_ordinalTypes;	// 0x30310969
- (id)_rightJustifiedIconWithRightOffset:(float *)rightOffset;	// 0x30310705
- (id)_rightTextAttributes;	// 0x30310c09
- (void)_setSpinnerEnabled:(BOOL)enabled;	// 0x30310dd5
- (CGSize)_sizeThatFits:(CGSize)fits;	// 0x303100a1
- (void)_switchToScrollingTextForTextFrame:(CGRect)textFrame;	// 0x30310c8d
- (id)_textAttributes;	// 0x30310c4d
- (void)_updateColorAndContentHeight;	// 0x30310111
- (id)_upperRightImageTypes;	// 0x30310a2d
- (id)_upperRightImages;	// 0x30310b0d
- (id)accessibilityLabel;	// 0x30311371
- (id)accessibilityLanguage;	// 0x303115d5
- (id)accessibilitySecondaryLabel;	// 0x30311465
- (id)accessibilityTraits;	// 0x30311519
- (void)addAccessoryOfType:(int)type;	// 0x3030e665
- (void)cancelLoadDisplayInfo;	// 0x3030dd81
- (id)centeredDetailedTextAttributes;	// 0x3030de61
- (id)centeredTextAttributes;	// 0x3030ddc9
- (void)controlWasActivated;	// 0x3030db79
- (void)controlWasDeactivated;	// 0x3030dc6d
- (void)controlWasFocused;	// 0x3030dab9
- (void)controlWasUnfocused;	// 0x3030db19
- (void)dealloc;	// 0x3030d8f5
- (id)description;	// 0x3030da09
- (id)detailedText;	// 0x3030e165
- (BOOL)dimmed;	// 0x3030e911
- (BOOL)disableAccessoryHighlighting;	// 0x3030e941
- (id)displayInfoLoader;	// 0x3030e655
- (BOOL)dotsTrailImage;	// 0x3030ebf1
- (void)drawInContext:(CGContextRef)context;	// 0x3030ee69
- (CGRect)focusCursorFrame;	// 0x3030edbd
- (BOOL)forceBlueDotLayout;	// 0x3030eb71
- (BOOL)forceCenteredIconLayout;	// 0x3030ebb1
- (BOOL)forceMenuArrowLayout;	// 0x3030ea75
- (BOOL)forceOrdinalLayout;	// 0x3030eb31
- (float)forcedContentHeight;	// 0x3030ea45
- (float)forcedHeight;	// 0x3030ea15
- (BOOL)hasAccessoryOfType:(int)type;	// 0x3030e789
- (BOOL)iconsTrailText;	// 0x3030ec31
- (id)image;	// 0x3030e401
- (float)imageAspectRatio;	// 0x3030e57d
- (float)imageHeight;	// 0x3030ed61
- (float)imageInset;	// 0x3030ecc9
- (id)imageProxy;	// 0x3030e521
- (BOOL)isAccessibilityElement;	// 0x3031136d
- (void)layoutSubcontrols;	// 0x30310001
- (float)leftMargin;	// 0x3030ec7d
- (void)loadDisplayInfo;	// 0x3030dd39
- (CGColorRef)menuItemBackgroundColor;	// 0x3030dead
- (void)removeAccessoryOfType:(int)type;	// 0x3030e711
- (void)removeAllAccessories;	// 0x3030e7a9
- (id)rightJustifiedText;	// 0x3030e235
- (float)rightMargin;	// 0x3030edad
- (void)scrollingCompleted;	// 0x3030dcd9
- (void)setAccessibilityLanguage:(id)language;	// 0x3031005d
- (void)setDefaultImage:(id)image;	// 0x3030e335
- (void)setDetailedText:(id)text;	// 0x3030e029
- (void)setDetailedText:(id)text withAttributes:(id)attributes;	// 0x3030e03d
- (void)setDimmed:(BOOL)dimmed;	// 0x3030e7e5
- (void)setDisableAccessoryHighlighting:(BOOL)highlighting;	// 0x3030e921
- (void)setDisplayInfoLoader:(id)loader;	// 0x3030e58d
- (void)setDotsTrailImage:(BOOL)image;	// 0x3030ebc1
- (void)setForceBlueDotLayout:(BOOL)layout;	// 0x3030eb41
- (void)setForceCenteredIconLayout:(BOOL)layout;	// 0x3030eb81
- (void)setForceMenuArrowLayout:(BOOL)layout;	// 0x3030ea55
- (void)setForceOrdinalLayout:(BOOL)layout ordinal:(id)ordinal largestOrdinal:(id)ordinal3;	// 0x3030ea85
- (void)setForcedContentHeight:(float)height;	// 0x3030ea25
- (void)setForcedHeight:(float)height;	// 0x3030e951
- (void)setIconsTrailText:(BOOL)text;	// 0x3030ec01
- (void)setImage:(id)image;	// 0x3030e255
- (void)setImageAspectRatio:(float)ratio;	// 0x3030e541
- (void)setImageHeight:(float)height;	// 0x3030ed25
- (void)setImageInset:(float)inset;	// 0x3030ec8d
- (void)setImageProxy:(id)proxy;	// 0x3030e50d
- (void)setImageProxy:(id)proxy shouldCropAndFill:(BOOL)fill;	// 0x3030e421
- (void)setLeftMargin:(float)margin;	// 0x3030ec41
- (void)setMenuItemBackgroundColor:(CGColorRef)color;	// 0x3030de85
- (void)setRightJustifiedText:(id)text;	// 0x3030e185
- (void)setRightJustifiedText:(id)text withAttributes:(id)attributes;	// 0x3030e199
- (void)setRightMargin:(float)margin;	// 0x3030ed71
- (void)setText:(id)text;	// 0x3030ded5
- (void)setText:(id)text withAttributes:(id)attributes;	// 0x3030dee9
- (void)setTextPadding:(float)padding;	// 0x3030ecd9
- (CGSize)sizeThatFits:(CGSize)fits;	// 0x3030da71
- (id)text;	// 0x3030e009
- (float)textPadding;	// 0x3030ed15
@end

@interface BRListControl: BRControl
- (id)init;	// 0x3029bfe9
- (long)_backwardIndexForRowCount:(long)rowCount hitBoundary:(BOOL *)boundary;	// 0x3029e099
- (double)_calculateRepeatRate;	// 0x3029f0bd
- (long)_dataIndexFromScrollIndex:(long)scrollIndex;	// 0x3029e56d
- (void)_ensureSelectionFocusable;	// 0x3029e02d
- (void)_enterCurrentSelection;	// 0x3029f289
- (id)_findDividerProviderForProvider:(id)provider;	// 0x3029e4d1
- (long)_forwardIndexForRowCount:(long)rowCount hitBoundary:(BOOL *)boundary;	// 0x3029e12d
- (void)_gridDataUpdated:(id)updated;	// 0x3029d891
- (void)_gridDataWillBeUpdated:(id)_gridData;	// 0x3029d849
- (void)_hideFirstDividerInDividedProviders:(id)dividedProviders;	// 0x3029e28d
- (void)_leaveCurrentSelection;	// 0x3029f375
- (id)_legacyProvider;	// 0x3029e46d
- (void)_listScrollingCompleted:(id)completed;	// 0x3029e7fd
- (void)_listScrollingInitiated:(id)initiated;	// 0x3029e7dd
- (float)_maxWidgetBottomGlowHeight;	// 0x3029f821
- (float)_maxWidgetEdgeGlowWidth;	// 0x3029f881
- (float)_maxWidgetTopGlowHeight;	// 0x3029f7c1
- (void)_performScrollInitiationActivities;	// 0x3029e735
- (void)_performScrollTerminationActivities;	// 0x3029e799
- (void)_pokeTimerFired:(id)fired;	// 0x3029f079
- (void)_postSelectionFinalizedNotification;	// 0x3029f329
- (void)_refillList;	// 0x3029e1c1
- (void)_repeatDownTimerFired:(id)fired;	// 0x3029edf9
- (void)_repeatUpTimerFired:(id)fired;	// 0x3029ef39
- (void)_restoreCurrentSelectionIndex;	// 0x3029f169
- (void)_restorePersistentSavedSelection;	// 0x3029db5d
- (void)_saveCurrentSelectionIndex;	// 0x3029f131
- (BOOL)_scrollDown:(id)down;	// 0x3029df51
- (long)_scrollIndexForDataIndex:(long)dataIndex;	// 0x3029e64d
- (BOOL)_scrollUp:(id)up;	// 0x3029de75
- (void)_setNewScrollIndex:(long)index;	// 0x3029e221
- (void)_slowToStopRepeatTimerMovingDown:(BOOL)stopRepeatTimerMovingDown;	// 0x3029eb81
- (void)_startDownwardAutoScroll:(id)scroll;	// 0x3029e8f1
- (void)_startRepeatTimerMovingDown:(BOOL)down;	// 0x3029e81d
- (void)_startUpwardAutoScroll:(id)scroll;	// 0x3029ea39
- (void)_stopRepeatTimer;	// 0x3029ed89
- (void)_updateGrid;	// 0x3029da0d
- (void)_updatePersistentSavedSelection;	// 0x3029dd75
- (void)_updateProviders;	// 0x3029e315
- (void)_updateScrollPosition;	// 0x3029f3b9
- (void)_updateWidgetFrame;	// 0x3029f541
- (void)_updateWidgetFrameForWidget:(id)widget withItemFrame:(CGRect)itemFrame;	// 0x3029f6b9
- (id)accessibilityLabel;	// 0x3029d435
- (void)addDividerAtIndex:(long)index withLabel:(id)label;	// 0x3029d53d
- (BOOL)brEventAction:(id)action;	// 0x3029c359
- (void)clearSavedSelection;	// 0x3029d07d
- (void)controlWasActivated;	// 0x3029cda5
- (void)controlWasDeactivated;	// 0x3029ce0d
- (void)controlWasFocused;	// 0x3029ce61
- (void)controlWasUnfocused;	// 0x3029ced9
- (long)dataCount;	// 0x3029c6e9
- (id)datasource;	// 0x3029d819
- (void)dealloc;	// 0x3029c251
- (BOOL)displaysSelectionWidget;	// 0x3029d525
- (BOOL)firstDividerVisible;	// 0x3029d3f5
- (BOOL)lastItemCentered;	// 0x3029cd75
- (void)layoutSubcontrols;	// 0x3029d109
- (float)listHeightToMaximum:(float)maximum;	// 0x3029cbc1
- (id)providerForDataAtIndex:(long)index providerIndex:(long *)index2;	// 0x3029c72d
- (id)providers;	// 0x3029c6d9
- (void)reload;	// 0x3029d691
- (void)removeDividerAtIndex:(long)index;	// 0x3029d5b5
- (void)removeDividers;	// 0x3029d625
- (id)scrollControl;	// 0x3029d35d
- (id)selectedObject;	// 0x3029cb61
- (long)selection;	// 0x3029cb41
- (int)selectionLozengeStyle;	// 0x3029ca3d
- (void)setBottomMargin:(float)margin;	// 0x3029d0c9
- (void)setDatasource:(id)datasource;	// 0x3029d795
- (void)setDisplaysSelectionWidget:(BOOL)widget;	// 0x3029d46d
- (void)setFirstDividerVisible:(BOOL)visible;	// 0x3029d3c5
- (void)setLastItemCentered:(BOOL)centered;	// 0x3029ccc1
- (void)setName:(id)name forProvider:(id)provider;	// 0x3029d405
- (void)setProvider:(id)provider;	// 0x3029c645
- (void)setProviders:(id)providers;	// 0x3029c685
- (void)setSelection:(long)selection;	// 0x3029ca4d
- (void)setSelectionLozengeStyle:(int)style;	// 0x3029c779
- (void)setShowsDividers:(BOOL)dividers;	// 0x3029d36d
- (void)setShowsWidgetBackingLayer:(BOOL)layer;	// 0x3029cc4d
- (void)setTopMargin:(float)margin;	// 0x3029d0e9
- (BOOL)showsDividers;	// 0x3029d3b5
- (BOOL)showsWidgetBackingLayer;	// 0x3029ccb1
- (void)updateSavedSelection;	// 0x3029d0b9
- (id)visibleRowsAndRange:(NSRange *)range;	// 0x3029cf61
@end

@interface BRMenuController: BRController
- (id)init;	// 0x3025b4d9
- (BOOL)_itemSelected:(id)selected;	// 0x3025cb21
- (id)accessibilityLabel;	// 0x3025ca15
- (id)accessibilitySecondaryLabel;	// 0x3025ca35
- (void)cancelCurrentListMonitorLoads;	// 0x3025bde5
- (void)clearSavedSelection;	// 0x3025ba89
- (int)contextMenuDimOption;	// 0x3025ca11
- (id)controlForContextMenuPositioning;	// 0x3025c949
- (id)controlForContextMenuStart;	// 0x3025c959
- (id)controlToDim;	// 0x3025c981
- (void)controlWasActivated;	// 0x3025bad5
- (void)dealloc;	// 0x3025b639
- (long)defaultIndex;	// 0x3025cb19
- (id)header;	// 0x3025ba29
- (float)headerWidthFactor;	// 0x3025ba75
- (BOOL)isCurrentSelectionValidForModelData:(id)modelData;	// 0x3025bca1
- (BOOL)isValidAfterDataUpdate;	// 0x3025bd39
- (BOOL)isVolatile;	// 0x3025cb95
- (long)itemCount;	// 0x3025cadd
- (void)itemSelected:(long)selected;	// 0x3025cb15
- (void)layoutSubcontrols;	// 0x3025b72d
- (void)layoutSubcontrolsUsingCenteredLayout;	// 0x3025be59
- (id)list;	// 0x3025b971
- (id)listIcon;	// 0x3025c8a9
- (float)listIconHorizontalOffset;	// 0x3025c8e9
- (float)listIconKerningFactor;	// 0x3025c929
- (id)listTitle;	// 0x3025c801
- (float)listVerticalOffset;	// 0x3025ba85
- (id)loadModelData;	// 0x3025bc45
- (float)menuWidthFactor;	// 0x3025ba19
- (id)primaryInfoTextControl;	// 0x3025c45d
- (void)refreshControllerForModelUpdate;	// 0x3025bc49
- (void)refreshControllerForModelUpdateToObject:(id)object;	// 0x3025bc4d
- (id)secondaryInfoTextControl;	// 0x3025c5ad
- (long)selectedItem;	// 0x3025cabd
- (id)selectedObject;	// 0x3025bc35
- (void)setHeaderWidthFactor:(float)factor;	// 0x3025ba39
- (void)setIcon:(id)icon horizontalOffset:(float)offset kerningFactor:(float)factor;	// 0x3025c2c5
- (void)setLabel:(id)label;	// 0x3025c5bd
- (void)setLabel:(id)label withAttributes:(id)attributes;	// 0x3025c5f9
- (void)setListIcon:(id)icon;	// 0x3025c841
- (void)setListIcon:(id)icon horizontalOffset:(float)offset kerningFactor:(float)factor;	// 0x3025c821
- (void)setListIconHorizontalOffset:(float)offset;	// 0x3025c8c9
- (void)setListIconKerningFactor:(float)factor;	// 0x3025c909
- (void)setListTitle:(id)title;	// 0x3025c781
- (void)setListTitle:(id)title withAttributes:(id)attributes;	// 0x3025c701
- (void)setMenuWidthFactor:(float)factor;	// 0x3025b981
- (void)setPrimaryInfoText:(id)text;	// 0x3025c31d
- (void)setPrimaryInfoText:(id)text withAttributes:(id)attributes;	// 0x3025c331
- (void)setSecondaryInfoText:(id)text;	// 0x3025c46d
- (void)setSecondaryInfoText:(id)text withAttributes:(id)attributes;	// 0x3025c481
- (void)setSelectedItem:(long)item;	// 0x3025ca9d
- (void)setSelectedObject:(id)object;	// 0x3025bbf5
- (void)setTitle:(id)title;	// 0x3025c281
- (void)setUseCenteredLayout:(BOOL)layout;	// 0x3025be05
- (BOOL)shouldRefreshForUpdateToObject:(id)object;	// 0x3025bd35
- (int)soundForSelectingItem:(long)selectingItem;	// 0x3025cb1d
- (void)wasPushed;	// 0x3025bb39
@end

@interface ATVMainMenuController: BRViewController
+ (BOOL)automaticallyNotifiesObserversOfInternetMerchants;	// 0x303db915
+ (id)mainMenu;	// 0x303db0ed
- (id)init;	// 0x303db15d
- (void)_animateContainerViewToPosition:(CGPoint)position;	// 0x303dd241
- (id)_blackBrickImage;	// 0x303df061
- (void)_cacheImageForAppliance:(id)appliance;	// 0x303df5e1
- (void)_cacheImageForMerchant:(id)merchant;	// 0x303df73d
- (void)_cleanupLayoutDocument;	// 0x303dc281
- (void)_coalescedUpdateImagesForChangedAppliances;	// 0x303dfb95
- (void)_coalescedUpdateImagesForChangedMerchants;	// 0x303dfa0d
- (id)_extraInfoForAppliance:(id)appliance;	// 0x303df309
- (void)_handleImageManagerImageUpdatedNotification:(id)notification;	// 0x303df815
- (BOOL)_handleRemoteEvent:(id)event;	// 0x303de8fd
- (BOOL)_handleTouchEvent:(id)event;	// 0x303dead1
- (void)_handleWindowMaxBoundsChanged;	// 0x303dbed9
- (id)_identifierFromImageID:(id)imageID;	// 0x303df51d
- (id)_imageBaseNameFromAppliance:(id)appliance;	// 0x303df3c1
- (id)_imageForAppliance:(id)appliance;	// 0x303df145
- (id)_imageForMerchant:(id)merchant;	// 0x303df0ad
- (id)_imageNameFromAppliance:(id)appliance;	// 0x303df415
- (id)_imageNameFromMerchant:(id)merchant;	// 0x303df2d1
- (id)_imageNameWithBaseName:(id)baseName;	// 0x303df22d
- (void)_layoutContainerView;	// 0x303dc4fd
- (void)_layoutViews;	// 0x303dc66d
- (id)_newBackgroundWithImageNamed:(id)imageNamed;	// 0x303dcc79
- (id)_newInternetContentGrid;	// 0x303dcfc5
- (id)_newMainApplicationsGrid;	// 0x303dcd2d
- (id)_prefsVersionKeyFromName:(id)name;	// 0x303df44d
- (void)_refreshTopShelfControllers;	// 0x303dcc3d
- (void)_reload;	// 0x303dbe15
- (void)_reloadTopShelf;	// 0x303ddced
- (void)_reloadTopShelfWithoutAnimating;	// 0x303ddbed
- (void)_saveVersion:(id)version forAppID:(id)appID;	// 0x303df4dd
- (void)_scrollApplicationsToVisible;	// 0x303dd785
- (void)_scrollShelfToVisible;	// 0x303dd35d
- (void)_setupTopShelfView;	// 0x303dcb05
- (void)_updateCachedApplianceImages;	// 0x303dbc41
- (void)_updateCachedMerchantImages;	// 0x303dbb95
- (id)_versionForAppID:(id)appID;	// 0x303df4a1
- (id)accessibilityLabel;	// 0x303def0d
- (id)accessibilityScreenContent;	// 0x303deebd
- (void)animationDidStop:(id)animation finished:(BOOL)finished;	// 0x303de0c1
- (id)appliances;	// 0x303def45
- (BOOL)brEventAction:(id)action withControl:(id)control;	// 0x303de3b1
- (BOOL)brKeyEvent:(id)event withControl:(id)control;	// 0x303debfd
- (BOOL)canBeRemovedFromStack;	// 0x303deeb9
- (void)controlWasActivated;	// 0x303db8ad
- (void)dealloc;	// 0x303db6f1
- (id)delegate;	// 0x303de1c5
- (void)focusApplianceWithIdentifier:(id)identifier;	// 0x303de1d5
- (id)focusedAppliance;	// 0x303de17d
- (BOOL)handleSelectionForControl:(id)control;	// 0x303deeb5
- (id)imageManager;	// 0x303def79
- (id)internetMerchants;	// 0x303def35
- (void)loadApplication:(id)application;	// 0x303dec01
- (void)observeValueForKeyPath:(id)keyPath ofObject:(id)object change:(id)change context:(void *)context;	// 0x303dc31d
- (void)setAppliances:(id)appliances;	// 0x303def55
- (void)setDelegate:(id)delegate;	// 0x303de1b5
- (void)setFocusedAppliance:(id)appliance;	// 0x303de115
- (void)setInternetMerchants:(id)merchants;	// 0x303db919
- (id)topShelfControllerForApp:(id)app;	// 0x303de2c9
- (void)updateBoundAvailableAppliances;	// 0x303dbced
- (void)updateBoundFocusedControlOfContainerView;	// 0x303dbd79
- (void)updateBoundInternetMerchants;	// 0x303dba85
- (void)updateBoundMusicStoreMerchantInfo;	// 0x303dbd69
- (id)view;	// 0x303dbf3d
@end

//my additions to attempt getting the topPanelControl working in all plugins rather than the legacy view

@protocol BRImageProxy <NSObject>
- (void)cancelImageRequestsForImageSizes:(int)imageSizes;
- (id)defaultImageForImageSize:(int)imageSize;
- (id)imageForImageSize:(int)imageSize;
@optional
- (BOOL)imageForImageSizeIsAvailable:(int)imageSizeIsAvailable;
@required
- (id)imageIDForImageSize:(int)imageSize;
- (id)object;
- (BOOL)supportsImageForImageSize:(int)imageSize;
@end


@interface BRImageControl : BRControl {
@private
	id<BRImageProxy> _imageProxy;	// 48 = 0x30
	BRImage *_image;	// 52 = 0x34
	BOOL _renderingImage;	// 56 = 0x38
	BOOL _autoDownsample;	// 57 = 0x39
	NSString *_artworkIdentifier;	// 60 = 0x3c
	BOOL _sizeIgnoresPixelBounds;	// 64 = 0x40
}
@property(assign) BOOL automaticDownsample;	// G=0x3029a85d; S=0x3029a7d5; converted property
@property(retain) BRImage *image;	// G=0x3029a769; S=0x3029a679; converted property
@property(assign) BOOL sizeIgnoresPixelBounds;	// G=0x3029a935; S=0x3029a925; converted property
- (void)_imageUpdated:(id)updated;	// 0x3029aba9
- (void)_loadImage;	// 0x3029acad
- (void)_unloadImage;	// 0x3029ac49
- (id)accessibilityLabel;	// 0x3029ab89
- (float)aspectRatio;	// 0x3029a7b5
// converted property getter: - (BOOL)automaticDownsample;	// 0x3029a85d
- (void)controlWasActivated;	// 0x3029aaf1
- (void)controlWasDeactivated;	// 0x3029ab1d
- (void)dealloc;	// 0x3029a4c5
- (void)drawInContext:(CGContextRef)context;	// 0x3029a945
// converted property getter: - (id)image;	// 0x3029a769
- (CGSize)pixelBounds;	// 0x3029a779
- (void)setArtworkIdentifier:(id)identifier;	// 0x3029a86d
// converted property setter: - (void)setAutomaticDownsample:(BOOL)downsample;	// 0x3029a7d5
// converted property setter: - (void)setImage:(id)image;	// 0x3029a679
- (void)setImageAsContents:(id)contents;	// 0x3029a6dd
- (void)setImageProxy:(id)proxy;	// 0x3029a569
- (void)setImageProxyAsContents:(id)contents;	// 0x3029a5f1
// converted property setter: - (void)setSizeIgnoresPixelBounds:(BOOL)bounds;	// 0x3029a925
// converted property getter: - (BOOL)sizeIgnoresPixelBounds;	// 0x3029a935
- (CGSize)sizeThatFits:(CGSize)fits;	// 0x3029a9f5
- (void)windowMaxBoundsChanged;	// 0x3029ab49
@end

@interface BRPanelControl : BRControl {
@private
	BRControl *_background;	// 48 = 0x30
	int _mode;	// 52 = 0x34
	float _nonAxisAlignment;	// 56 = 0x38
	float _verticalSpacing;	// 60 = 0x3c
	float _verticalMargin;	// 64 = 0x40
	float _horizontalSpacing;	// 68 = 0x44
	float _horizontalMargin;	// 72 = 0x48
}
@property(retain) id backgroundControl;	// G=0x302baa39; S=0x302ba9c5; converted property
@property(assign) float horizontalMargin;	// G=0x302bad8d; S=0x302bad51; converted property
@property(assign) float horizontalSpacing;	// G=0x302bab69; S=0x302bab2d; converted property
@property(assign) float nonAxisAlignment;	// G=0x302baa85; S=0x302baa49; converted property
@property(assign) int panelMode;	// G=0x302ba9b5; S=0x302ba989; converted property
@property(assign) float verticalMargin;	// G=0x302bab1d; S=0x302baae1; converted property
@property(assign) float verticalSpacing;	// G=0x302baad1; S=0x302baa95; converted property
- (id)init;	// 0x302ba92d
- (CGRect)_marginedFrameForFrame:(CGRect)frame screenRes:(CGSize)res;	// 0x302bbb09
- (void)_performFillRightToLeft:(id)left;	// 0x302bb759
- (void)_performFillTopToBottom:(id)bottom;	// 0x302bb92d
- (CGSize)_performFlowRightToLeft:(id)left inBounds:(CGSize)bounds setFrame:(BOOL)frame;	// 0x302bb2d9
- (CGSize)_performFlowTopToBottom:(id)bottom inBounds:(CGSize)bounds setFrame:(BOOL)frame;	// 0x302bb4e5
- (id)accessibilityLabel;	// 0x302bbbb9
// converted property getter: - (id)backgroundControl;	// 0x302baa39
// converted property getter: - (float)horizontalMargin;	// 0x302bad8d
// converted property getter: - (float)horizontalSpacing;	// 0x302bab69
- (void)layoutSubcontrols;	// 0x302bb075
// converted property getter: - (float)nonAxisAlignment;	// 0x302baa85
// converted property getter: - (int)panelMode;	// 0x302ba9b5
- (CGPoint)positionForControlAtIndex:(unsigned)index preSize:(float *)size postSize:(float *)size3;	// 0x302bad9d
// converted property setter: - (void)setBackgroundControl:(id)control;	// 0x302ba9c5
// converted property setter: - (void)setHorizontalMargin:(float)margin;	// 0x302bad51
// converted property setter: - (void)setHorizontalSpacing:(float)spacing;	// 0x302bab2d
- (void)setHorizontalSpacingForPreferredWidth:(float)preferredWidth minimumSpacing:(float)spacing;	// 0x302bab79
// converted property setter: - (void)setNonAxisAlignment:(float)alignment;	// 0x302baa49
// converted property setter: - (void)setPanelMode:(int)mode;	// 0x302ba989
// converted property setter: - (void)setVerticalMargin:(float)margin;	// 0x302baae1
// converted property setter: - (void)setVerticalSpacing:(float)spacing;	// 0x302baa95
- (CGSize)sizeThatFits:(CGSize)fits;	// 0x302bb19d
// converted property getter: - (float)verticalMargin;	// 0x302bab1d
// converted property getter: - (float)verticalSpacing;	// 0x302baad1
@end

@protocol ATVApplianceTopPanelControlDelegate <NSObject>
- (void)selectedCategoryDidChangeForApplianceTopPanelControl:(id)selectedCategory;
@end

@interface ATVApplianceTopPanelControl : BRControl {
@private
	BRPanelControl *_panel;	// 48 = 0x30
	BRControl *_bottomDivider;	// 52 = 0x34
	BRImageControl *_glow;	// 56 = 0x38
	BRControl *_leftFade;	// 60 = 0x3c
	BRControl *_rightFade;	// 64 = 0x40
	BOOL _rebuildPanel;	// 68 = 0x44
	int _selectedIndex;	// 72 = 0x48
	NSArray *_categories;	// 76 = 0x4c
	id<ATVApplianceTopPanelControlDelegate> _delegate;	// 80 = 0x50
	int _focusedIndex;	// 84 = 0x54
	NSTimer *_updateSelectedIndexTimer;	// 88 = 0x58
	BOOL _centerFocusLayout;	// 92 = 0x5c
	double _timeSinceFocusMoved;	// 96 = 0x60
}
@property(assign, nonatomic) BOOL _centerFocusLayout;	// G=0x303e71a9; S=0x303e71b9; @synthesize
@property(assign, nonatomic) int _focusedIndex;	// G=0x303e7169; S=0x303e7179; @synthesize
@property(assign, nonatomic) double _timeSinceFocusMoved;	// G=0x303e71c9; S=0x303e71e1; @synthesize
@property(assign, nonatomic, setter=_setUpdateSelectedIndexTimer:) NSTimer *_updateSelectedIndexTimer;	// G=0x303e7189; S=0x303e7199; @synthesize
@property(retain, nonatomic) NSArray *categories;	// G=0x303e7125; S=0x303e7135; @synthesize=_categories
@property(assign, nonatomic) id<ATVApplianceTopPanelControlDelegate> delegate;	// G=0x303e7159; S=0x303e6861; @synthesize=_delegate
@property(retain, nonatomic) BRApplianceCategory *selectedCategory;	// G=0x303e66b9; S=0x303e6635; @dynamic
- (id)init;	// 0x303e5f91
- (void)_accessibilityUpdateSelection;	// 0x303e71f5
// declared property getter: - (BOOL)_centerFocusLayout;	// 0x303e71a9
// declared property getter: - (int)_focusedIndex;	// 0x303e7169
- (int)_indexForCategoryWithIdentifier:(id)identifier;	// 0x303e78f1
- (void)_selectedCategoryDidChange;	// 0x303e7345
- (void)_setSelectedIndex:(int)index;	// 0x303e7321
// declared property setter: - (void)_setUpdateSelectedIndexTimer:(id)timer;	// 0x303e7199
- (void)_setUpdateSelectedIndexTimer:(NSTimer *)timer;	// 0x303e7269
// declared property getter: - (double)_timeSinceFocusMoved;	// 0x303e71c9
- (void)_updateRepositioning;	// 0x303e7385
- (void)_updateSelectedIndex;	// 0x303e72c5
// declared property getter: - (id)_updateSelectedIndexTimer;	// 0x303e7189
- (BOOL)brEventAction:(id)action;	// 0x303e6e29
// declared property getter: - (id)categories;	// 0x303e7125
- (void)controlWasFocused;	// 0x303e6d25
- (void)controlWasUnfocused;	// 0x303e6dd9
- (void)dealloc;	// 0x303e6585
// declared property getter: - (id)delegate;	// 0x303e7159
- (void)layoutSubcontrols;	// 0x303e68d9
// declared property getter: - (id)selectedCategory;	// 0x303e66b9
// declared property setter: - (void)setCategories:(id)categories;	// 0x303e7135
- (void)setCategories:(id)categories defaultCategory:(id)category;	// 0x303e6701
// declared property setter: - (void)setDelegate:(id)delegate;	// 0x303e6861
// declared property setter: - (void)setSelectedCategory:(id)category;	// 0x303e6635
// declared property setter: - (void)set_centerFocusLayout:(BOOL)layout;	// 0x303e71b9
// declared property setter: - (void)set_focusedIndex:(int)index;	// 0x303e7179
// declared property setter: - (void)set_timeSinceFocusMoved:(double)moved;	// 0x303e71e1
- (CGSize)sizeThatFits:(CGSize)fits;	// 0x303e6871
@end

@protocol ATVApplianceViewDelegate <NSObject>
@optional
- (BOOL)currentContentHasHeaderForApplianceView:(id)applianceView;
@required
- (id)topPanelCategoriesForApplianceView:(id)applianceView;
@end



@protocol ATVApplianceViewDelegate;

__attribute__((visibility("hidden")))
@interface ATVApplianceView : BRControl {
@private
	BRImageControl *_topPanelShadow;	// 48 = 0x30
	BRControl *_container;	// 52 = 0x34
	BRControl *_bottomFader;	// 56 = 0x38
	BOOL _topPanelInPopUp;	// 60 = 0x3c
	struct {
		unsigned currentContentHasHeaderSelectorBit : 1;
	} _delegateSelectorBits;	// 61 = 0x3d
	id<ATVApplianceViewDelegate> _delegate;	// 64 = 0x40
	ATVApplianceTopPanelControl *_topPanel;	// 68 = 0x44
}
@property(retain, nonatomic) BRControl *content;	// G=0x303e5105; S=0x303e5005; @dynamic
@property(assign, nonatomic) id<ATVApplianceViewDelegate> delegate;	// G=0x303e576d; S=0x303e513d; @synthesize=_delegate
@property(retain, nonatomic) ATVApplianceTopPanelControl *topPanel;	// G=0x303e577d; S=0x303e578d; @synthesize=_topPanel
- (id)init;	// 0x303e4ae1
- (id)_bottomFadeFilters;	// 0x303e57b1
- (BOOL)_canShowTopPanelInPopUp;	// 0x303e5dd5
- (BOOL)_currentContentHasHeader;	// 0x303e5a7d
- (id)_findCursor:(id)cursor;	// 0x303e5ad9
- (void)_updateCategories;	// 0x303e58c5
- (void)_updateRepositioning;	// 0x303e5bc9
- (BOOL)brEventAction:(id)action;	// 0x303e54bd
// declared property getter: - (id)content;	// 0x303e5105
- (void)controlWasActivated;	// 0x303e5219
- (void)controlWasDeactivated;	// 0x303e5299
- (void)dealloc;	// 0x303e4f7d
// declared property getter: - (id)delegate;	// 0x303e576d
- (void)layoutSubcontrols;	// 0x303e5301
- (void)observeValueForKeyPath:(id)keyPath ofObject:(id)object change:(id)change context:(void *)context;	// 0x303e5745
// declared property setter: - (void)setContent:(id)content;	// 0x303e5005
// declared property setter: - (void)setDelegate:(id)delegate;	// 0x303e513d
// declared property setter: - (void)setTopPanel:(id)panel;	// 0x303e578d
// declared property getter: - (id)topPanel;	// 0x303e577d
- (void)updateCategories;	// 0x303e5191
- (void)updateViewLayout;	// 0x303e51a1
@end

@interface ATVApplianceUIHints : NSObject {
@private
	NSArray *_categoriesWithoutHeaders;	// 4 = 0x4
}
@property(retain, nonatomic) NSArray *categoriesWithoutHeaders;	// G=0x303e4aad; S=0x303e4abd; @synthesize=_categoriesWithoutHeaders
// declared property getter: - (id)categoriesWithoutHeaders;	// 0x303e4aad
- (void)dealloc;	// 0x303e4a61
// declared property setter: - (void)setCategoriesWithoutHeaders:(id)headers;	// 0x303e4abd
@end

@protocol BRSubControllerHosting <NSObject>
@optional
- (BOOL)checkSubstitutions:(id *)substitutions;
@required
- (void)hostSubController:(id)controller;
@end


@interface ATVApplianceController : BRViewController <ATVApplianceViewDelegate, ATVApplianceTopPanelControlDelegate, BRSubControllerHosting> {
	id<BRAppliance> _appliance;	// 88 = 0x58
	ATVApplianceUIHints *_UIHints;	// 92 = 0x5c
	BRController *_hostingSubController;	// 96 = 0x60
}
@property(retain, nonatomic) ATVApplianceUIHints *UIHints;	// G=0x303e4a1d; S=0x303e4a2d; @synthesize=_UIHints
@property(readonly, assign, nonatomic) ATVApplianceView *_applianceView;	// G=0x303e477d; @dynamic
@property(retain, nonatomic, setter=_setHostingSubController:) BRController *_hostingSubController;	// G=0x303e4a51; S=0x303e434d; @synthesize
@property(retain, nonatomic) id<BRAppliance> appliance;	// G=0x303e49e9; S=0x303e49f9; @synthesize=_appliance
- (id)initWithAppliance:(id)appliance;	// 0x303e4159
// declared property getter: - (id)UIHints;	// 0x303e4a1d
- (void)_applianceCategoriesUpdated:(id)updated;	// 0x303e49c1
// declared property getter: - (id)_applianceView;	// 0x303e477d
// declared property getter: - (id)_hostingSubController;	// 0x303e4a51
// declared property setter: - (void)_setHostingSubController:(id)controller;	// 0x303e434d
// declared property getter: - (id)appliance;	// 0x303e49e9
- (BOOL)brEventAction:(id)action;	// 0x303e48f9
- (BOOL)currentContentHasHeaderForApplianceView:(id)applianceView;	// 0x303e4659
- (void)dealloc;	// 0x303e42a9
- (void)hostSubController:(id)controller;	// 0x303e4739
- (void)observeValueForKeyPath:(id)keyPath ofObject:(id)object change:(id)change context:(void *)context;	// 0x303e4435
- (void)selectedCategoryDidChangeForApplianceTopPanelControl:(id)selectedCategory;	// 0x303e478d
// declared property setter: - (void)setAppliance:(id)appliance;	// 0x303e49f9
// declared property setter: - (void)setUIHints:(id)hints;	// 0x303e4a2d
- (id)topPanelCategoriesForApplianceView:(id)applianceView;	// 0x303e45d1
- (void)wasExhumed;	// 0x303e44a5
@end


