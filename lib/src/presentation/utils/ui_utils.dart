import 'package:flutter/material.dart';
import '../../core/constants/button_constants.dart';

/// UI 工具类
/// 提供通用的 UI 辅助方法，包括 SnackBar 显示、屏幕尺寸获取等
class HelloUiUtils {
  /// 私有构造函数，防止实例化
  HelloUiUtils._();

  /// 显示成功提示
  ///
  /// [context] - BuildContext
  /// [message] - 成功消息
  /// [duration] - 显示时长，默认2秒
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    debugPrint('显示成功提示: $message');

    if (message.trim().isEmpty) {
      debugPrint('警告：尝试显示空的成功消息');
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: duration ?? ButtonConstants.defaultSnackBarDuration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  /// 显示错误提示
  ///
  /// [context] - BuildContext
  /// [message] - 错误消息
  /// [duration] - 显示时长，默认2秒
  static void showError(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    debugPrint('显示错误提示: $message');

    if (message.trim().isEmpty) {
      debugPrint('警告：尝试显示空的错误消息');
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: duration ?? ButtonConstants.defaultSnackBarDuration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  /// 显示警告提示
  ///
  /// [context] - BuildContext
  /// [message] - 警告消息
  /// [duration] - 显示时长，默认2秒
  static void showWarning(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    debugPrint('显示警告提示: $message');

    if (message.trim().isEmpty) {
      debugPrint('警告：尝试显示空的警告消息');
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        duration: duration ?? ButtonConstants.defaultSnackBarDuration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  /// 获取屏幕尺寸
  ///
  /// [context] - BuildContext
  /// 返回 Size 对象，如果获取失败则返回默认 Size(360, 640)
  static Size getScreenSize(BuildContext context) {
    try {
      final size = MediaQuery.of(context).size;
      debugPrint('屏幕尺寸获取成功: ${size.width}x${size.height}');
      return size;
    } catch (e) {
      debugPrint('获取屏幕尺寸失败: $e');
      return const Size(360, 640); // 返回默认尺寸
    }
  }

  /// 获取屏幕宽度
  ///
  /// [context] - BuildContext
  /// 返回屏幕宽度，如果获取失败则返回默认宽度 360
  static double getScreenWidth(BuildContext context) {
    try {
      return MediaQuery.of(context).size.width;
    } catch (e) {
      debugPrint('获取屏幕宽度失败: $e');
      return 360.0; // 返回默认宽度
    }
  }

  /// 获取屏幕高度
  ///
  /// [context] - BuildContext
  /// 返回屏幕高度，如果获取失败则返回默认高度 640
  static double getScreenHeight(BuildContext context) {
    try {
      return MediaQuery.of(context).size.height;
    } catch (e) {
      debugPrint('获取屏幕高度失败: $e');
      return 640.0; // 返回默认高度
    }
  }

  /// 检查是否为宽屏设备
  ///
  /// [context] - BuildContext
  /// 返回 true 如果屏幕宽度大于 600dp
  static bool isWideScreen(BuildContext context) {
    try {
      return MediaQuery.of(context).size.width > 600;
    } catch (e) {
      debugPrint('检查宽屏设备失败: $e');
      return false;
    }
  }
}
