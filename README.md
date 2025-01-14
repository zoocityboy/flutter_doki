![alt text](https://raw.githubusercontent.com/zoocityboy/flutter_doki/main/assets/doki.png "Resoure")
Developed by 🦏 [zoocityboy][zoocityboy_link]
# Melos Workspace Cleaner

[![Pub](https://img.shields.io/pub/v/flutter_doki.svg?style=flat-square)](https://pub.dev/packages/flutter_doki)
[![pub points](https://img.shields.io/pub/points/mwc?style=flat-square&color=2E8B57&label=pub%20points)](https://pub.dev/packages/flutter_doki/score)
[![ci](https://github.com/zoocityboy/flutter_doki/actions/workflows/ci.yaml/badge.svg?style=flat-square)](https://github.com/zoocityboy/flutter_doki/actions/workflows/ci.yaml)
[![coverage](https://raw.githubusercontent.com/zoocityboy/flutter_doki/main/coverage_badge.svg?style=flat-square)](https://github.com/zoocityboy/flutter_doki/actions)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg?style=flat-square)](https://opensource.org/licenses/MIT)

![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=flat-square&logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-02569B?styleflat-square&logo=flutter&logoColor=white)


Simply open or get informations from [DontKillMyApp.com](https://dontkillmyapp.com)

The package appears to include:

## Features
- [x] Widgets like `DokiBadgeWidget` for displaying device ratings
- [x] Doki class retrieve informations for users and developers 
- [x] Integration with the DontKillMyApp.com API

## 🚀  Getting started

### Installation

```bash
dart pub add flutter_doki
```

## Usage

Open informations for user in In App Webview

```dart
Doki.open(appName: 'com.example.app');
```



```dart
Doki.fetch()
    .then((response){ ...})
    .catchError((e){...});
```


## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

-------------------
[![zoocityboy][logo_white]][zoocityboy_link_dark]
[![zoocityboy][logo_black]][zoocityboy_link_light]


[logo_black]:https://raw.githubusercontent.com/zoocityboy/zoo_brand/main/styles/README/zoocityboy_dark.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/zoocityboy/zoo_brand/main/styles/README/zoocityboy_light.png#gh-dark-mode-only
[zoocityboy_link]: https://github.com/zoocityboy
[zoocityboy_link_dark]: https://github.com/zoocityboy#gh-dark-mode-only
[zoocityboy_link_light]: https://github.com/zoocityboy#gh-light-mode-only