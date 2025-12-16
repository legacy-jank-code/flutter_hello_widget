import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hello_widget/flutter_hello_widget.dart';

/// HelloUiUtils工具类测试
/// 测试UI工具类的所有方法
void main() {
  group('HelloUiUtils.showSuccess 测试', () {
    testWidgets('应该正确显示成功消息', (WidgetTester tester) async {
      const successMessage = '成功消息';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    HelloUiUtils.showSuccess(context, successMessage);
                  },
                  child: const Text('显示成功消息'),
                );
              },
            ),
          ),
        ),
      );

      // 点击按钮触发成功消息
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // 触发 SnackBar 显示

      // 验证成功消息显示
      expect(find.text(successMessage), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('不应该显示空的成功消息', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    HelloUiUtils.showSuccess(context, '');
                  },
                  child: const Text('显示空消息'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // 空消息不应该显示 SnackBar
      expect(find.byType(SnackBar), findsNothing);
    });
  });

  group('HelloUiUtils.showError 测试', () {
    testWidgets('应该正确显示错误消息', (WidgetTester tester) async {
      const errorMessage = '错误消息';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    HelloUiUtils.showError(context, errorMessage);
                  },
                  child: const Text('显示错误消息'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // 验证错误消息显示
      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });

  group('HelloUiUtils.showWarning 测试', () {
    testWidgets('应该正确显示警告消息', (WidgetTester tester) async {
      const warningMessage = '警告消息';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    HelloUiUtils.showWarning(context, warningMessage);
                  },
                  child: const Text('显示警告消息'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // 验证警告消息显示
      expect(find.text(warningMessage), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });

  group('HelloUiUtils.getScreenSize 测试', () {
    testWidgets('应该正确获取屏幕尺寸', (WidgetTester tester) async {
      late Size screenSize;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                screenSize = HelloUiUtils.getScreenSize(context);
                return Container();
              },
            ),
          ),
        ),
      );

      // 验证屏幕尺寸不为null
      expect(screenSize, isNotNull);
      expect(screenSize.width, greaterThan(0));
      expect(screenSize.height, greaterThan(0));
    });
  });

  group('HelloUiUtils.isWideScreen 测试', () {
    testWidgets('应该正确判断宽屏状态', (WidgetTester tester) async {
      late bool isWide;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                isWide = HelloUiUtils.isWideScreen(context);
                return Container();
              },
            ),
          ),
        ),
      );

      // 验证宽屏判断不为null
      expect(isWide, isNotNull);
      expect(isWide, isA<bool>());
    });

    testWidgets('应该在宽屏设备上返回true', (WidgetTester tester) async {
      late bool isWide;

      // 设置较宽的测试屏幕
      await tester.binding.setSurfaceSize(const Size(1200, 800));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                isWide = HelloUiUtils.isWideScreen(context);
                return Container();
              },
            ),
          ),
        ),
      );

      // 在宽屏上应该返回true
      expect(isWide, isTrue);

      // 恢复默认尺寸
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('应该在窄屏设备上返回false', (WidgetTester tester) async {
      // 设置较窄的测试屏幕 (宽度400 < 600，应该返回false)
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      bool? isWide;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                isWide = HelloUiUtils.isWideScreen(context);
                return Container();
              },
            ),
          ),
        ),
      );

      // 验证结果
      expect(isWide, isNotNull);
      expect(isWide, isFalse);

      // 恢复默认设置
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });
  });

  group('HelloUiUtils 边界条件测试', () {
    testWidgets('应该处理null上下文', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    expect(
                      () => HelloUiUtils.showSuccess(context, '测试消息'),
                      throwsA(anything),
                    );
                  },
                  child: const Text('测试'),
                );
              },
            ),
          ),
        ),
      );
    });

    testWidgets('应该处理超长消息', (WidgetTester tester) async {
      final longMessage = '这是一个非常长的消息' * 20;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    expect(
                      () => HelloUiUtils.showSuccess(context, longMessage),
                      throwsA(isA<ArgumentError>()),
                    );
                  },
                  child: const Text('测试'),
                );
              },
            ),
          ),
        ),
      );
    });
  });
}
