import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// 测试辅助工具类
/// 提供常用的测试辅助方法和工具函数
class TestHelpers {
  /// 创建一个基础的MaterialApp包装器
  /// 用于简化组件测试的包装
  static Widget createTestableWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  /// 创建一个带Scaffold的测试环境
  /// 适用于需要Scaffold上下文的组件测试
  static Widget createScaffoldTest({
    required Widget child,
    PreferredSizeWidget? appBar,
    Widget? drawer,
    Widget? bottomNavigationBar,
  }) {
    return MaterialApp(
      home: Scaffold(
        appBar: appBar,
        drawer: drawer,
        bottomNavigationBar: bottomNavigationBar,
        body: child,
      ),
    );
  }

  /// 创建一个带Navigator的测试环境
  /// 适用于需要导航功能的测试
  static Widget createNavigatorTest({
    required Widget child,
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: child,
    );
  }

  /// 创建一个带主题的测试环境
  /// 可以自定义主题数据进行测试
  static Widget createThemedTest({
    required Widget child,
    ThemeData? theme,
    ThemeData? darkTheme,
  }) {
    return MaterialApp(
      theme: theme ?? ThemeData.light(),
      darkTheme: darkTheme,
      home: Scaffold(
        body: child,
      ),
    );
  }

  /// 创建一个带MediaQuery的测试环境
  /// 用于测试响应式布局
  static Widget createMediaQueryTest({
    required Widget child,
    Size screenSize = const Size(800, 600),
    double textScaleFactor = 1.0,
  }) {
    return MediaQuery(
      data: MediaQueryData(
        size: screenSize,
        textScaleFactor: textScaleFactor,
      ),
      child: MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  /// 创建一个带本地化的测试环境
  /// 用于测试国际化功能
  static Widget createLocalizedTest({
    required Widget child,
    Locale locale = const Locale('zh', 'CN'),
    Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  }) {
    return MaterialApp(
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      home: Scaffold(
        body: child,
      ),
    );
  }

  /// 创建一个异步测试环境
  /// 用于测试异步操作
  static Future<void> runAsyncTest(
    Future<void> Function() testFunction, {
    Duration timeout = const Duration(seconds: 10),
  }) async {
    await Future.any([
      testFunction(),
      Future.delayed(timeout, () {
        throw TimeoutException('测试超时', timeout);
      }),
    ]);
  }

  /// 等待特定的条件满足
  /// 用于等待异步状态更新
  static Future<void> waitForCondition(
    bool Function() condition, {
    Duration timeout = const Duration(seconds: 5),
    Duration checkInterval = const Duration(milliseconds: 100),
  }) async {
    final endTime = DateTime.now().add(timeout);
    
    while (!condition()) {
      if (DateTime.now().isAfter(endTime)) {
        throw TimeoutException('等待条件超时', timeout);
      }
      await Future.delayed(checkInterval);
    }
  }

  /// 创建一个模拟的异步延迟
  /// 用于测试加载状态
  static Future<void> mockAsyncDelay({
    Duration duration = const Duration(milliseconds: 100),
  }) async {
    await Future.delayed(duration);
  }

  /// 生成测试用的长字符串
  /// 用于边界条件测试
  static String generateLongString(int length) {
    return '测试字符' * (length ~/ 4) + 'a' * (length % 4);
  }

  /// 生成测试用的特殊字符字符串
  /// 用于特殊字符处理测试
  static String generateSpecialCharacters() {
    return '!@#\$%^&*()_+-=[]{}|;:,.<>?';
  }

  /// 创建一个可滚动的测试环境
  /// 用于测试滚动相关功能
  static Widget createScrollableTest({
    required List<Widget> children,
    Axis scrollDirection = Axis.vertical,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: scrollDirection,
          child: scrollDirection == Axis.vertical
              ? Column(children: children)
              : Row(children: children),
        ),
      ),
    );
  }

  /// 创建一个带底部弹窗的测试环境
  /// 用于测试BottomSheet相关功能
  static Widget createBottomSheetTest({
    required Widget child,
    required VoidCallback onShowBottomSheet,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                child,
                ElevatedButton(
                  onPressed: onShowBottomSheet,
                  child: const Text('显示底部弹窗'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// 创建一个带弹窗的测试环境
  /// 用于测试Dialog相关功能
  static Widget createDialogTest({
    required Widget child,
    required VoidCallback onShowDialog,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                child,
                ElevatedButton(
                  onPressed: onShowDialog,
                  child: const Text('显示弹窗'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// 组件测试工具类
/// 提供Widget测试相关的辅助方法
class WidgetTestUtils {
  /// 查找指定类型的Widget
  static Finder findWidgetByType(Type widgetType) {
    return find.byType(widgetType);
  }

  /// 查找指定Key的Widget
  static Finder findWidgetByKey(Key key) {
    return find.byKey(key);
  }

  /// 查找包含指定文本的Widget
  static Finder findWidgetByText(String text) {
    return find.text(text);
  }

  /// 验证Widget是否存在
  static void expectWidgetExists(Finder finder, {bool exists = true}) {
    if (exists) {
      expect(finder, findsOneWidget);
    } else {
      expect(finder, findsNothing);
    }
  }

  /// 验证Widget是否存在多个
  static void expectWidgetsExist(Finder finder, int count) {
    expect(finder, findsNWidgets(count));
  }

  /// 获取Widget的属性值
  static T getWidgetProperty<T>(Widget widget, T Function() propertyGetter) {
    return propertyGetter();
  }

  /// 模拟用户点击
  static Future<void> simulateTap(WidgetTester tester, Finder finder) async {
    await tester.tap(finder);
    await tester.pump();
  }

  /// 模拟用户输入
  static Future<void> simulateInput(
    WidgetTester tester,
    Finder finder,
    String text,
  ) async {
    await tester.enterText(finder, text);
    await tester.pump();
  }

  /// 模拟滚动操作
  static Future<void> simulateScroll(
    WidgetTester tester,
    Finder finder,
    Offset offset,
  ) async {
    await tester.fling(finder, offset, 1000);
    await tester.pump();
  }

  /// 等待Widget出现
  static Future<void> waitForWidget(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    final endTime = DateTime.now().add(timeout);
    
    while (finder.evaluate().isEmpty) {
      if (DateTime.now().isAfter(endTime)) {
        throw TimeoutException('等待Widget出现超时', timeout);
      }
      await tester.pump();
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  /// 验证Widget的样式属性
  static void expectWidgetStyle<T>(
    Widget widget,
    T expectedStyle,
    T Function() styleGetter,
  ) {
    final actualStyle = styleGetter();
    expect(actualStyle, expectedStyle);
  }

  /// 创建一个测试用的GlobalKey
  static GlobalKey createTestKey([String? debugLabel]) {
    return GlobalKey(debugLabel: debugLabel);
  }

  /// 创建一个测试用的UniqueKey
  static UniqueKey createUniqueTestKey() {
    return UniqueKey();
  }

  /// 验证Widget的语义属性
  static void expectSemantics(
    Widget widget, {
    String? label,
    bool? isButton,
    bool? isEnabled,
  }) {
    // 这里可以添加语义相关的验证逻辑
    // 具体实现取决于项目的语义需求
  }
}