import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hello_widget/src/core/utils/string_validator.dart';

/// 字符串验证器测试类
/// 测试StringValidator工具类的所有方法
void main() {
  group('StringValidator 测试', () {
    group('isNullOrEmpty 方法测试', () {
      test('应该返回true当输入为null', () {
        expect(StringValidator.isNullOrEmpty(null), isTrue);
      });

      test('应该返回true当输入为空字符串', () {
        expect(StringValidator.isNullOrEmpty(''), isTrue);
      });

      test('应该返回true当输入为空白字符串', () {
        expect(StringValidator.isNullOrEmpty('   '), isTrue);
      });

      test('应该返回false当输入为有效字符串', () {
        expect(StringValidator.isNullOrEmpty('test'), isFalse);
      });
    });

    group('isValidButtonText 方法测试', () {
      test('应该返回false当输入为null', () {
        expect(StringValidator.isValidButtonText(null), isFalse);
      });

      test('应该返回false当输入为空字符串', () {
        expect(StringValidator.isValidButtonText(''), isFalse);
      });

      test('应该返回false当输入为空白字符串', () {
        expect(StringValidator.isValidButtonText('   '), isFalse);
      });

      test('应该返回true当输入为有效字符串', () {
        expect(StringValidator.isValidButtonText('test'), isTrue);
      });

      test('应该返回false当输入超过50个字符', () {
        expect(StringValidator.isValidButtonText('a' * 51), isFalse);
      });

      test('应该返回true当输入正好50个字符', () {
        expect(StringValidator.isValidButtonText('a' * 50), isTrue);
      });
    });

    group('isValidSemanticLabel 方法测试', () {
      test('应该返回true当输入为有效字符串', () {
        expect(StringValidator.isValidSemanticLabel('test'), isTrue);
      });

      test('应该返回false当输入超过100个字符', () {
        expect(StringValidator.isValidSemanticLabel('a' * 101), isFalse);
      });

      test('应该返回true当输入正好100个字符', () {
        expect(StringValidator.isValidSemanticLabel('a' * 100), isTrue);
      });
    });

    group('safeTrim 方法测试', () {
      test('应该返回null当输入为null', () {
        expect(StringValidator.safeTrim(null), isNull);
      });

      test('应该去除字符串两端空白字符', () {
        expect(StringValidator.safeTrim('  test  '), 'test');
      });

      test('应该返回原字符串当没有空白字符', () {
        expect(StringValidator.safeTrim('test'), 'test');
      });
    });

    group('safeLength 方法测试', () {
      test('应该返回0当输入为null', () {
        expect(StringValidator.safeLength(null), 0);
      });

      test('应该返回0当输入为空字符串', () {
        expect(StringValidator.safeLength(''), 0);
      });

      test('应该返回正确的字符串长度', () {
        expect(StringValidator.safeLength('test'), 4);
        expect(StringValidator.safeLength('测试'), 2);
      });
    });
  });
}
