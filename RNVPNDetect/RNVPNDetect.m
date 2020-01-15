#import "RNVPNDetect.h"

@implementation RNVPNDetect
{
  bool hasListeners;
}

-(void)startObserving {
    hasListeners = YES;
}

-(void)stopObserving {
    hasListeners = NO;
}

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"RNVPNDetect.vpnStateDidChange"];
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(isVPNConnected)
{
    CFDictionaryRef cfDict = CFNetworkCopySystemProxySettings();
    NSDictionary *nsDict = (__bridge NSDictionary*)cfDict;
    NSDictionary *keys = [nsDict valueForKey:@"__SCOPED__"];
    __block BOOL isVpnConnected = nil;

    for (id key in keys) {
        if ([@"tap" isEqual: key] || [@"tun" isEqual: key] || [@"ppp" isEqual: key] || [@"ipsec" isEqual: key] || [@"ipsec0" isEqual: key] || [key containsString: @"utun"] ) {
            isVpnConnected = YES;
        } else {
          isVpnConnected = NO;
        }
    }

    if (hasListeners) {
        [self sendEventWithName:@"RNVPNDetect.vpnStateDidChange" body:@(isVpnConnected)];
    }
}
@end

