import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../core/constants/button_constants.dart';
import '../../core/models/button_size.dart';
import '../../core/utils/string_validator.dart';

/// 可复用的 HelloButton 组件
/// 提供统一的样式和交互行为，支持自定义文本、颜色和点击事件
/// 完整支持无障碍功能，包括语义标签和屏幕阅读器
class HelloButton extends StatelessWidget {
  /// 按钮显示的文本
  final String text;

  /// 按钮点击回调
  final VoidCallback? onPressed;

  /// 按钮颜色
  final Color? color;

  /// 按钮大小
  final ButtonSize size;

  /// 是否显示加载状态
  final bool isLoading;

  /// 无障碍语义标签
  final String? semanticLabel;

  /// 构造函数
  const HelloButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    // 调试日志：记录组件构建信息
    debugPrint(
      'HelloButton building with text: $text, size: $size, isLoading: $isLoading',
    );

    // 参数验证 - 抛出异常而不是使用 assert
    if (!StringValidator.isValidButtonText(text)) {
      throw ArgumentError('按钮文本不能为空且长度不能超过50个字符');
    }
    if (!StringValidator.isValidSemanticLabel(semanticLabel)) {
      throw ArgumentError('语义标签长度不能超过100个字符');
    }

    return Semantics(
      // 添加无障碍语义支持
      label: semanticLabel ?? text, // 使用自定义语义标签或文本
      hint: ButtonConstants.defaultSemanticHint, // 操作提示
      enabled: onPressed != null && !isLoading, // 可用状态
      button: true, // 标记为按钮
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          padding: size.padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ButtonConstants.defaultBorderRadius,
            ),
          ),
        ),
        child:
            isLoading
                ? SizedBox(
                  width: ButtonConstants.loadingIndicatorSize,
                  height: ButtonConstants.loadingIndicatorSize,
                  child: CircularProgressIndicator(
                    strokeWidth: ButtonConstants.loadingStrokeWidth,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                )
                : Text(
                  text,
                  style: TextStyle(
                    fontSize: size.fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
      ),
    );
  }
}
