
<picture id="github_header">
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/zoocityboy/flutter_doki/main/assets/doki_dark.png">
  <img alt="Doki Dont kill my app!" src="https://raw.githubusercontent.com/zoocityboy/flutter_doki/main/assets/doki.png">
</picture>
<br>

Developed by 🦏 [zoocityboy][zoocityboy_link]

# Flutter Doki - Dont kill my app

[![Pub](https://img.shields.io/pub/v/flutter_doki.svg?style=flat-square)](https://pub.dev/packages/flutter_doki)
[![pub points](https://img.shields.io/pub/points/flutter_doki?style=flat-square&color=2E8B57&label=pub%20points)](https://pub.dev/packages/flutter_doki/score)
[![ci](https://github.com/zoocityboy/flutter_doki/actions/workflows/ci.yaml/badge.svg?style=flat-square)](https://github.com/zoocityboy/flutter_doki/actions/workflows/ci.yaml)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg?style=flat-square)](https://opensource.org/licenses/MIT)
![Flutter](https://img.shields.io/badge/Flutter-02569B?styleflat-square&logo=flutter&logoColor=white)


The package is designed to help developers/users understand and handle device-specific
battery optimization settings that might affect their app's background operations.
Simply open or get informations from [DontKillMyApp.com](https://dontkillmyapp.com)

### Features
* Open device-specific pages on dontkillmyapp.com
* Retrieve device information and manufacturer-specific optimization guidelines
* Fetch and parse content from the dontkillmyapp.com API
* Add Badge widgets to the app

## 🚀  Getting started

### Installation

```bash
dart pub add flutter_doki
```

### AndroidManifext.xml
Add the following permission to your AndroidManifest.xml file:

```xml
<queries>
  <!-- If your application checks for inAppBrowserView launch mode support -->
  <intent>
      <action android:name="android.support.customtabs.action.CustomTabsService" />
  </intent>
</queries>
```


## Usage

Opens an In-AppWebView displaying instructions on how to disable battery optimization for your app on the current device.

```dart
Doki().open(appName: 'My Special App');
```
> if you don't provide appName, it will use the app name from the package.


```dart
Doki().fetch()
    .then((response){ ...})
    .catchError((e){...});
```

### Widget
You can use pre-made Badge widget with informations about rating manufacturer of the device with link to more information.

```dart
DokiBadgeWidget(
    type: BadgeType.square // .square, .rectangle
)
```
#### Example app Screenshot
<a href=""><img alt="Flutter developer Zoocityboy" src="https://raw.githubusercontent.com/zoocityboy/flutter_doki/main/assets/flutter_01.png" height="300">

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

-------------------
<picture id="github_zoocityboy">
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/zoocityboy/zoo_brand/main/styles/README/zoocityboy_light.png">
  <img alt="Flutter developer Zoocityboy" src="https://raw.githubusercontent.com/zoocityboy/zoo_brand/main/styles/README/zoocityboy_dark.png">
</picture>


[logo_black]:https://raw.githubusercontent.com/zoocityboy/zoo_brand/main/styles/README/zoocityboy_dark.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/zoocityboy/zoo_brand/main/styles/README/zoocityboy_light.png#gh-dark-mode-only
[zoocityboy_link]: https://github.com/zoocityboy
[zoocityboy_link_dark]: https://github.com/zoocityboy#gh-dark-mode-only
[zoocityboy_link_light]: https://github.com/zoocityboy#gh-light-mode-only