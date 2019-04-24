# flutter_app

flutter初始项目

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

flutter run

Release模式只能在真机上运行，不能在模拟器上运行：会关闭所有断言和debugging信息，关闭所有debugger工具。
优化了快速启动、快速执行和减小包体积。禁用所有的debugging aids和服务扩展。这个模式是为了部署给最终的用户使用。
flutter run --release

flutter run --profile
Profile模式只能在真机上运行，不能在模拟器上运行：基本和Release模式一致，除了启用了服务扩展和tracing，
 以及一些为了最低限度支持tracing运行的东西（比如可以连接observatory到进程）。

headless test模式只能在桌面上运行：基本和Debug模式一致，
  除了是headless的而且你能在桌面运行。命令flutter test就是以这种模式运行的
