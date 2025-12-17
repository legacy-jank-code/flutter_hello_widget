import 'package:flutter/material.dart';
import 'package:flutter_hello_widget/flutter_hello_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hello Widget Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Hello Widget 演示'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;
  int _clickCount = 0;

  void _handleButtonClick() {
    // 调试日志：记录按钮点击
    debugPrint('HelloButton 被点击，当前计数: $_clickCount');

    setState(() {
      _clickCount++;
      _isLoading = true;
    });

    // 模拟异步操作
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // 显示成功消息
        HelloUiUtils.showSuccess(context, '操作完成！总计点击次数: $_clickCount');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 调试日志：记录页面构建
    debugPrint('MyHomePage 正在构建，点击次数: $_clickCount');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: <Widget>[
            const Text(
              'Flutter Hello Widget 组件演示',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            Text(
              '点击次数: $_clickCount',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            // 标准尺寸按钮
            HelloButton(
              text: '点击我',
              onPressed: _handleButtonClick,
              isLoading: _isLoading,
            ),

            // 小尺寸按钮
            HelloButton(
              text: '小按钮',
              size: ButtonSize.small,
              color: Colors.green,
              onPressed: () {
                HelloUiUtils.showSuccess(context, '你点击了小按钮！');
              },
            ),

            // 大尺寸按钮
            HelloButton(
              text: '大按钮',
              size: ButtonSize.large,
              color: Colors.orange,
              onPressed: () {
                HelloUiUtils.showSuccess(context, '你点击了大按钮！');
              },
            ),

            // 显示屏幕尺寸信息
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      '屏幕宽度: ${HelloUiUtils.getScreenSize(context).width.toStringAsFixed(0)} px',
                    ),
                    Text(
                      '屏幕高度: ${HelloUiUtils.getScreenSize(context).height.toStringAsFixed(0)} px',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
