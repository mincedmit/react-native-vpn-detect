#import "RNVPNDetect.h"

@implementation RNVPNDetect
{
  BOOL hasListeners;
  BOOL isVpnConnected;
  NSTimer *timer;
}

RCT_EXPORT_MODULE();

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

- (void)sendIsVpnConnected:(NSTimer *)timer {
    BOOL nextIsVpnConnected = [self isVpnConnected];
    
    if ((isVpnConnected && nextIsVpnConnected) || (!isVpnConnected && !nextIsVpnConnected)) {
        return;
    }
    
    isVpnConnected = nextIsVpnConnected;
    if (hasListeners) {
        if ([self bridge] != nil) {
            [self sendEventWithName:@"RNVPNDetect.vpnStateDidChange" body:@(isVpnConnected)];
        }
    }
}

- (BOOL)isVpnConnected {
    CFDictionaryRef cfDict = CFNetworkCopySystemProxySettings();
    NSDictionary *nsDict = (__bridge NSDictionary*)cfDict;
    NSDictionary *keys = [nsDict valueForKey:@"__SCOPED__"];
    BOOL isConnected = NO;
    
    for (id key in keys) {
        if ([@"tap" isEqual: key] || [@"tun" isEqual: key] || [@"ppp" isEqual: key] || [@"ipsec" isEqual: key] || [@"ipsec0" isEqual: key] || [key containsString: @"utun"]) {
            isConnected = YES;
        } else {
            isConnected = NO;
        }
    }
    
    return isConnected;
}

RCT_EXPORT_METHOD(startTimer:(NSTimeInterval)timerInterval)
{
    NSLog(@"%@", [NSDecimalNumber numberWithDouble:timerInterval]);
    
    NSTimeInterval interval;
    if (timerInterval) {
        interval = timerInterval;
    } else {
        interval = 3000;
    }
    
    timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(sendIsVpnConnected:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

RCT_EXPORT_METHOD(stopTimer)
{
    if (timer) {
        [timer invalidate];
    }
    timer = nil;
}


RCT_EXPORT_METHOD(checkIsVpnConnected)
{
    isVpnConnected = [self isVpnConnected];
    
    if (hasListeners) {
        if ([self bridge] != nil) {
            [self sendEventWithName:@"RNVPNDetect.vpnStateDidChange" body:@(isVpnConnected)];
        }
    }
}
@end


