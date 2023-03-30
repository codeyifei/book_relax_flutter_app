import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// 定义app主题
class ThemeConstant {
  static SystemUiOverlayStyle get overlayStyle =>
      Get.isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
}
