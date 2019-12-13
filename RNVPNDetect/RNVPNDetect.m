#import "RNVPNDetect.h"

@implementation RNVPNDetect

- (instancetype)init
{
    self = [super init];
    return self;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(isVPN:(NSDictionary *)options callback: (RCTResponseSenderBlock)callback)
{
    CFDictionaryRef cfDict = CFNetworkCopySystemProxySettings();
    NSDictionary *nsDict = (__bridge NSDictionary*)cfDict;
    NSDictionary *keys = [nsDict valueForKey:@"__SCOPED__"];
    for (id key in keys) {
        if ([@"tap" isEqual: key] || [@"tun" isEqual: key] || [@"ppp" isEqual: key] || [@"ipsec" isEqual: key] || [@"ipsec0" isEqual: key] || [key containsString: @"utun"] ) {
            callback(@[@YES]);
        }
    }
    callback(@[@NO]);
}

@end
