import 'package:body_buddies/internal/application/di/app_depends.dart';
import 'package:flutter/widgets.dart';

class AppDependsProvider extends InheritedWidget {
  final AppDepends appDepends;

  const AppDependsProvider(
      {super.key, required super.child, required this.appDepends});

  static AppDepends of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<AppDependsProvider>();
    return provider!.appDepends;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
