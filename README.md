
# react-native-vpn-detect
<a href="https://www.buymeacoffee.com/kzlsn" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/yellow_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

## Getting started

`$ npm install react-native-vpn-detect --save`

### Mostly automatic installation

`$ react-native link react-native-vpn-detect`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-vpn-detect` and add `RNNativeVpnDetect.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNNativeVpnDetect.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNNativeVpnDetectPackage;` to the imports at the top of the file
  - Add `new RNNativeVpnDetectPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-vpn-detect'
  	project(':react-native-vpn-detect').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-vpn-detect/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-vpn-detect')
  	```


## Usage
```javascript
* Import Library
import Security from "react-native-vpn-detect";

* Example Usage
async function checkSecurity() {
	let detectVPN = await Security.detectVPN().then(response => { return response });
	let detectProxy = await Security.detectProxy().then(response => { return response });
}
checkSecurity();
```
