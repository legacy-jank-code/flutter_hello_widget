import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hello_widget/flutter_hello_widget.dart';

/// HelloButton组件测试类
/// 测试HelloButton的所有功能和交互
void main() {
  group('HelloButton 基础功能测试', () {
    testWidgets('应该正常显示按钮文本', (WidgetTester tester) async {
      // 定义测试数据
      const testText = '测试按钮';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: HelloButton(text: testText, onPressed: () {})),
        ),
      );

      // 验证按钮文本正确显示
      expect(find.text(testText), findsOneWidget);
    });

    testWidgets('应该正确处理点击事件', (WidgetTester tester) async {
      // 跟踪点击状态
      var clicked = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HelloButton(
              text: '点击测试',
              onPressed: () {
                clicked = true;
              },
            ),
          ),
        ),
      );

      // 执行点击操作
      await tester.tap(find.byType(HelloButton));
      await tester.pump();

      // 验证点击事件被触发
      expect(clicked, isTrue);
    });

    testWidgets('应该正确处理带加载状态的异步点击事件', (WidgetTester tester) async {
      // 使用StatefulBuilder来管理加载状态
      var isLoading = false;
      var clickCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return HelloButton(
                  text: '异步操作',
                  isLoading: isLoading,
                  onPressed: () {
                    // 模拟异步操作的开始和结束
                    setState(() {
                      isLoading = true;
                      clickCount++;
                    });

                    // 模拟异步操作完成
                    Future.delayed(const Duration(milliseconds: 100), () {
                      if (context.mounted) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      // 初始状态验证
      expect(find.text('异步操作'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(clickCount, 0);

      // 执行点击
      await tester.tap(find.byType(HelloButton));
      await tester.pump();

      // 验证点击后立即进入加载状态
      expect(clickCount, 1);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('异步操作'), findsNothing);

      // 等待异步操作完成
      await tester.pump(const Duration(milliseconds: 150));

      // 验证加载状态结束
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('异步操作'), findsOneWidget);
    });
  });

  group('HelloButton 加载状态测试', () {
    testWidgets('应该正确显示加载指示器', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HelloButton(text: '加载中', isLoading: true, onPressed: () {}),
          ),
        ),
      );

      // 验证加载指示器存在
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // 验证按钮文本不存在（被加载指示器替代）
      expect(find.text('加载中'), findsNothing);
    });

    testWidgets('应该禁用点击当处于加载状态', (WidgetTester tester) async {
      var clicked = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HelloButton(
              text: '加载中按钮',
              isLoading: true,
              onPressed: () {
                clicked = true;
              },
            ),
          ),
        ),
      );

      // 尝试点击加载中的按钮
      await tester.tap(find.byType(HelloButton));
      await tester.pump();

      // 验证点击事件未被触发
      expect(clicked, isFalse);
    });

    testWidgets('应该正确处理加载状态切换', (WidgetTester tester) async {
      // 测试按钮从正常状态到加载状态的切换
      var isLoading = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return HelloButton(
                  text: '提交',
                  isLoading: isLoading,
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      // 初始状态：正常按钮
      expect(find.text('提交'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // 点击按钮，切换到加载状态
      await tester.tap(find.byType(HelloButton));
      await tester.pump();

      // 验证状态切换后的UI变化
      expect(find.text('提交'), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('HelloButton 尺寸测试', () {
    testWidgets('应该正确显示小尺寸按钮', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HelloButton(
              text: '小按钮',
              size: ButtonSize.small,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('小按钮'), findsOneWidget);

      // 验证小尺寸按钮的字体大小
      final buttonWidget = tester.widget<HelloButton>(find.byType(HelloButton));
      expect(buttonWidget.size.fontSize, 14.0);
    });

    testWidgets('应该正确显示中尺寸按钮', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HelloButton(
              text: '中按钮',
              size: ButtonSize.medium,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('中按钮'), findsOneWidget);

      // 验证中尺寸按钮的字体大小
      final buttonWidget = tester.widget<HelloButton>(find.byType(HelloButton));
      expect(buttonWidget.size.fontSize, 16.0);
    });

    testWidgets('应该正确显示大尺寸按钮', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HelloButton(
              text: '大按钮',
              size: ButtonSize.large,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('大按钮'), findsOneWidget);

      // 验证大尺寸按钮的字体大小
      final buttonWidget = tester.widget<HelloButton>(find.byType(HelloButton));
      expect(buttonWidget.size.fontSize, 18.0);
    });

    testWidgets('应该验证不同尺寸的字体大小', (WidgetTester tester) async {
      // 验证三种尺寸的字体大小设置正确
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                HelloButton(
                  text: '小',
                  size: ButtonSize.small,
                  onPressed: () {},
                ),
                HelloButton(
                  text: '中',
                  size: ButtonSize.medium,
                  onPressed: () {},
                ),
                HelloButton(
                  text: '大',
                  size: ButtonSize.large,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      // 获取所有按钮并验证字体大小
      final buttons =
          tester.widgetList<HelloButton>(find.byType(HelloButton)).toList();
      expect(buttons.length, 3);
      expect(buttons[0].size.fontSize, 14.0); // 小尺寸
      expect(buttons[1].size.fontSize, 16.0); // 中尺寸
      expect(buttons[2].size.fontSize, 18.0); // 大尺寸
    });
  });

  group('HelloButton 无障碍功能测试', () {
    testWidgets('应该正确设置语义标签', (WidgetTester tester) async {
      const semanticLabel = '这是一个测试按钮';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HelloButton(
              text: '无障碍按钮',
              semanticLabel: semanticLabel,
              onPressed: () {},
            ),
          ),
        ),
      );

      // 验证按钮文本存在
      expect(find.text('无障碍按钮'), findsOneWidget);

      // 验证按钮是可点击的
      final buttonFinder = find.byType(HelloButton);
      expect(buttonFinder, findsOneWidget);

      // 验证按钮的语义标签
      final buttonWidget = tester.widget<HelloButton>(buttonFinder);
      expect(buttonWidget.semanticLabel, semanticLabel);
    });
  });

  group('HelloButton 错误处理测试', () {
    testWidgets('应该抛出异常当文本为空字符串', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: HelloButton(text: '', onPressed: () {})),
        ),
      );

      // 捕获构建时抛出的异常
      final dynamic exception = tester.takeException();
      expect(exception, isA<ArgumentError>());
      expect(exception.toString(), contains('按钮文本不能为空且长度不能超过50个字符'));
    });

    testWidgets('应该抛出异常当文本超过50字符', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HelloButton(
              text: 'a' * 51, // 51个字符，超过限制
              onPressed: () {},
            ),
          ),
        ),
      );

      // 捕获构建时抛出的异常
      final dynamic exception = tester.takeException();
      expect(exception, isA<ArgumentError>());
      expect(exception.toString(), contains('按钮文本不能为空且长度不能超过50个字符'));
    });

    testWidgets('应该正常处理边界值50字符', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HelloButton(
              text: 'a' * 50, // 正好50个字符，边界值
              onPressed: () {},
            ),
          ),
        ),
      );

      // 验证没有异常抛出
      expect(tester.takeException(), isNull);
      expect(find.text('a' * 50), findsOneWidget);
    });
  });
}
