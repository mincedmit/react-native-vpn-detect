# react-native-vpn-detect

A React Native wrapper to determine if the current iOS network connection is on a VPN (NetInfo supplies this for Android).

## Installation

```bash
npm i --save react-native-vpn-detect # npm syntax
yarn add react-native-vpn-detect # yarn syntax
```
then enter the `ios` directory and run `pod install` to link the pod to your React Native project.

## Usage

Import the library along with the NativeEventEmitter exported from React Native:
```
import { ..., NativeEventEmitter } from "react-native";
import RNVPNDetect from "react-native-vpn-detect";
```

## Setup:

in componentDidMount, instantiate a new NativeEventEmitter, passing in RNVPNDetect. 

```
const RNVPNDetectEmitter = new NativeEventEmitter(RNVPNDetect);

```

Then, add a listener to the EventEmitter instance, and make sure to store it somewhere globally available on the component (e.g. instance variable) so you can unsubscribe from it later.

The listener should take: ```"RNVPNDetect.vpnStateDidChange"``` as the event name to listen to, and a handler of your choosing as the second argument.

```
RootContainer._iosVpnDetectSubscribe = RNVPNDetectEmitter.addListener(
  "RNVPNDetect.vpnStateDidChange",
  this._handleVpnStateChanged
);

```

RNVPNDetect can be used in two ways: 
- Using a timer, which will check for a change in the VPN state at the provided interval, and send an event IF the state has changed 
- Manually asking for the current vpn state

## Use Timer

After following the setup steps above:

You can then initialize the timer with an interval of your choosing. It defaults to 3s (3000ms) if nothing is passed in.

```
RNVPNDetect.startTimer(5000)
```

Make sure to unsubscribe from the listener when your component unmounts.

```
componentDidUnmount {
  ...
  if (RootContainer._iosVpnDetectSubscribe) {
    RootContainer._iosVpnDetectSubscribe.remove();
    RootContainer._iosVpnDetectSubscribe = null;
    RNVPNDetect.stopTimer();
  }
}

```

## Manual

After following the steps above, you can manually query the current vpn state by calling:

```
RNVPNDetect.checkIsVpnConnected()
```

This will check the current vpn state and trigger the listener you set up in ```componentDidMount```.

You should still unsubscribe from the listener on unmount, but you can skip the ```stopTimer``` call if you never started one ;)

```
componentDidUnmount {
  ...
  if (RootContainer._iosVpnDetectSubscribe) {
    RootContainer._iosVpnDetectSubscribe.remove();
    RootContainer._iosVpnDetectSubscribe = null;
  }
}

```

