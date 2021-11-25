import 'package:flutter_demo/injection/main_module.dart';

import 'injector.dart';

class DependencyManager {
  static Future<void> inject() async {
    await MainModule.inject();
  }

  static Future<void> reset() async {
    await injector.reset();
  }
}
