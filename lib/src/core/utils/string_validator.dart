/// 字符串验证工具类
class StringValidator {
  /// 私有构造函数，防止实例化
  StringValidator._();

  /// 验证字符串是否为空或仅包含空白字符
  static bool isNullOrEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// 验证字符串是否为有效的按钮文本
  static bool isValidButtonText(String? text) {
    if (isNullOrEmpty(text)) return false;

    final trimmedText = text!.trim();
    return trimmedText.isNotEmpty && trimmedText.length <= 50;
  }

  /// 验证语义标签
  static bool isValidSemanticLabel(String? label) {
    if (label == null) return true; // 允许为空
    return label.length <= 100; // 最大长度限制
  }

  /// 安全地修剪字符串
  static String? safeTrim(String? value) {
    if (value == null) return null;
    return value.trim();
  }

  /// 获取字符串的长度（安全版本）
  static int safeLength(String? value) {
    return value?.length ?? 0;
  }
}
