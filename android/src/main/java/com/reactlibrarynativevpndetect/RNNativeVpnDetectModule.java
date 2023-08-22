
package com.reactlibrarynativevpndetect;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;

public class RNNativeVpnDetectModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public RNNativeVpnDetectModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "RNNativeVpnDetect";
  }

  @ReactMethod
  public void detectVPN(Promise promise){
    ConnectivityManager cm = (ConnectivityManager)reactContext.getSystemService(Context.CONNECTIVITY_SERVICE);
    Network[] networks = cm.getAllNetworks();

    boolean isRunningVPN = false;
    for (Network value : networks) {
      NetworkCapabilities caps = cm.getNetworkCapabilities(value);
      if (caps != null && (caps.hasTransport(NetworkCapabilities.TRANSPORT_VPN) || !caps.hasCapability(NetworkCapabilities.NET_CAPABILITY_NOT_VPN))) {
        isRunningVPN = true;
        break;
      }
    }
    promise.resolve(isRunningVPN);
  }

  @ReactMethod
  public void detectProxy(Promise promise){
    promise.resolve(System.getProperty("http.proxyPort") != null);
  }
}
