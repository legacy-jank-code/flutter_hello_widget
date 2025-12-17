import 'package:flutter/material.dart';

/// 按钮相关常量定义
class ButtonConstants {
  /// 私有构造函数，防止实例化
  ButtonConstants._();

  /// 默认按钮内边距
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );

  /// 小号按钮内边距
  static const EdgeInsetsGeometry smallPadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 8,
  );

  /// 大号按钮内边距
  static const EdgeInsetsGeometry largePadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 16,
  );

  /// 默认圆角半径
  static const double defaultBorderRadius = 8.0;

  /// 默认字体大小
  static const double defaultFontSize = 16.0;

  /// 小号字体大小
  static const double smallFontSize = 14.0;

  /// 大号字体大小
  static const double largeFontSize = 18.0;

  /// 加载指示器大小
  static const double loadingIndicatorSize = 20.0;

  /// 加载指示器线宽
  static const double loadingStrokeWidth = 2.0;

  /// 默认 SnackBar 显示时长
  static const Duration defaultSnackBarDuration = Duration(seconds: 2);

  /// 无障碍提示文本
  static const String defaultSemanticHint = '点击执行操作';
}
