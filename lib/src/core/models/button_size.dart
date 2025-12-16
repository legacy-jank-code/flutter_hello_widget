import 'package:flutter/material.dart';

/// 按钮尺寸枚举
/// 定义了三种标准按钮尺寸：小、中、大
enum ButtonSize {
  /// 小号按钮
  small,

  /// 中号按钮（默认）
  medium,

  /// 大号按钮
  large,
}

/// 按钮尺寸扩展
extension ButtonSizeExtension on ButtonSize {
  /// 获取按钮对应的内边距
  EdgeInsetsGeometry get padding {
    switch (this) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
      case ButtonSize.medium:
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    }
  }

  /// 获取按钮对应的字体大小
  double get fontSize {
    switch (this) {
      case ButtonSize.small:
        return 14.0;
      case ButtonSize.large:
        return 18.0;
      case ButtonSize.medium:
      return 16.0;
    }
  }

  /// 获取按钮对应的语义标签前缀
  String get semanticLabelPrefix {
    switch (this) {
      case ButtonSize.small:
        return '小号按钮';
      case ButtonSize.large:
        return '大号按钮';
      case ButtonSize.medium:
      return '标准按钮';
    }
  }

  /// 从字符串转换 ButtonSize
  static ButtonSize? fromString(String? value) {
    if (value == null) return null;
    
    try {
      return ButtonSize.values.firstWhere(
        (e) => e.name.toLowerCase() == value.toLowerCase(),
        orElse: () => ButtonSize.medium,
      );
    } catch (e) {
      debugPrint('ButtonSize 转换失败: $value, 使用默认值: medium');
      return ButtonSize.medium;
    }
  }
}