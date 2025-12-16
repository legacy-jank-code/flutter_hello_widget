import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hello_widget/src/core/models/button_size.dart';

/// 按钮尺寸扩展测试类
/// 测试ButtonSize枚举的所有属性和方法
void main() {
  group('ButtonSizeExtension 测试', () {
    group('ButtonSize.small 属性测试', () {
      test('应该返回正确的内边距', () {
        expect(ButtonSize.small.padding, isA<EdgeInsetsGeometry>());
      });

      test('应该返回正确的字体大小', () {
        expect(ButtonSize.small.fontSize, 14.0);
      });

      test('应该返回正确的语义标签前缀', () {
        expect(ButtonSize.small.semanticLabelPrefix, '小号按钮');
      });
    });

    group('ButtonSize.medium 属性测试', () {
      test('应该返回正确的内边距', () {
        expect(ButtonSize.medium.padding, isA<EdgeInsetsGeometry>());
      });

      test('应该返回正确的字体大小', () {
        expect(ButtonSize.medium.fontSize, 16.0);
      });

      test('应该返回正确的语义标签前缀', () {
        expect(ButtonSize.medium.semanticLabelPrefix, '标准按钮');
      });
    });

    group('ButtonSize.large 属性测试', () {
      test('应该返回正确的内边距', () {
        expect(ButtonSize.large.padding, isA<EdgeInsetsGeometry>());
      });

      test('应该返回正确的字体大小', () {
        expect(ButtonSize.large.fontSize, 18.0);
      });

      test('应该返回正确的语义标签前缀', () {
        expect(ButtonSize.large.semanticLabelPrefix, '大号按钮');
      });
    });

    group('ButtonSizeExtension.fromString 方法测试', () {
      test('应该正确转换small字符串', () {
        expect(ButtonSizeExtension.fromString('small'), ButtonSize.small);
      });

      test('应该正确转换medium字符串', () {
        expect(ButtonSizeExtension.fromString('medium'), ButtonSize.medium);
      });

      test('应该正确转换large字符串', () {
        expect(ButtonSizeExtension.fromString('large'), ButtonSize.large);
      });

      test('应该返回默认medium当输入无效字符串', () {
        expect(ButtonSizeExtension.fromString('invalid'), ButtonSize.medium);
      });

      test('应该返回null当输入为null', () {
        expect(ButtonSizeExtension.fromString(null), isNull);
      });

      test('应该忽略大小写转换', () {
        expect(ButtonSizeExtension.fromString('SMALL'), ButtonSize.small);
        expect(ButtonSizeExtension.fromString('Medium'), ButtonSize.medium);
        expect(ButtonSizeExtension.fromString('LARGE'), ButtonSize.large);
      });
    });
  });
}
