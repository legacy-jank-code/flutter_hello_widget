# Flutter Hello Widget

一个功能丰富的Flutter组件库，提供可定制的Hello系列UI组件，专注于无障碍访问和语义化标签支持。

## ✨ 特性

- 🎯 **HelloButton** - 支持多种尺寸、颜色和加载状态的可访问按钮
- ♿ **完整无障碍支持** - 内置语义标签和屏幕阅读器支持
- 📱 **响应式设计** - 适配不同屏幕尺寸和设备
- 🎨 **高度可定制** - 灵活的颜色、尺寸和样式配置
- 🧪 **完善的测试覆盖** - 包含单元测试和集成测试
- 📝 **中文注释** - 所有公共API都包含详细的中文注释

## 📦 安装

在您的 `pubspec.yaml` 文件中添加以下依赖：

```yaml
dependencies:
  flutter_hello_widget: ^0.1.0
```

然后运行：

```bash
flutter pub get
```

## 🚀 快速开始

### 基础使用

```dart
import 'package:flutter_hello_widget/flutter_hello_widget.dart';

// 创建一个基础按钮
HelloButton(
  text: '点击我',
  onPressed: () {
    print('按钮被点击了！');
  },
)
```

### 不同尺寸的按钮

```dart
Column(
  children: [
    // 小尺寸按钮
    HelloButton(
      text: '小按钮',
      size: ButtonSize.small,
      color: Colors.green,
      onPressed: () {},
    ),
    
    // 中等尺寸按钮（默认）
    HelloButton(
      text: '中等按钮',
      size: ButtonSize.medium,
      onPressed: () {},
    ),
    
    // 大尺寸按钮
    HelloButton(
      text: '大按钮',
      size: ButtonSize.large,
      color: Colors.orange,
      onPressed: () {},
    ),
  ],
)
```

### 带加载状态的按钮

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _isLoading = false;

  Future<void> _handlePress() async {
    setState(() => _isLoading = true);
    
    // 模拟异步操作
    await Future.delayed(Duration(seconds: 2));
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return HelloButton(
      text: '提交',
      isLoading: _isLoading,
      onPressed: _isLoading ? null : _handlePress,
    );
  }
}
```

### 无障碍支持

```dart
HelloButton(
  text: '购买',
  semanticLabel: '购买商品按钮',
  onPressed: () {
    // 处理购买逻辑
  },
)
```

## 📋 API 参考

### HelloButton

| 参数 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `text` | `String` | 必填 | 按钮显示的文本 |
| `onPressed` | `VoidCallback?` | `null` | 点击回调函数 |
| `color` | `Color?` | `null` | 按钮背景色 |
| `size` | `ButtonSize` | `ButtonSize.medium` | 按钮尺寸 |
| `isLoading` | `bool` | `false` | 是否显示加载状态 |
| `semanticLabel` | `String?` | `null` | 无障碍语义标签 |

### ButtonSize 枚举

- `ButtonSize.small` - 小尺寸，字体大小 14px
- `ButtonSize.medium` - 中等尺寸，字体大小 16px（默认）
- `ButtonSize.large` - 大尺寸，字体大小 18px

### UI 工具类

```dart
// 显示成功消息
HelloUiUtils.showSuccess(context, '操作成功！');

// 显示警告消息
HelloUiUtils.showWarning(context, '请注意检查输入');

// 获取屏幕尺寸
final screenSize = HelloUiUtils.getScreenSize(context);

// 判断是否为宽屏
final isWideScreen = HelloUiUtils.isWideScreen(context);
```

## 🧪 测试

本包包含完整的测试用例，您可以通过以下命令运行测试：

```bash
# 运行所有测试
flutter test

# 运行特定测试文件
flutter test test/presentation/hello_button_test.dart
flutter test test/presentation/hello_ui_utils_test.dart
```

## 🔧 开发环境

- Flutter: ^3.7.0
- Dart: ^3.7.0
- 支持 Android、iOS、Web、macOS、Windows、Linux

## 📱 示例应用

查看 `example` 目录中的完整示例应用，了解所有功能的使用方法：

```bash
cd example/example_app
flutter run
```

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！在贡献之前，请：

1. 阅读我们的代码规范
2. 确保所有测试通过
3. 添加必要的注释和文档

## 📄 许可证

本项目使用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🆘 支持

如果您在使用过程中遇到问题，请：

1. 查看文档和示例代码
2. 在 [GitHub Issues](https://github.com/your-username/flutter_hello_widget/issues) 中搜索类似问题
3. 创建新的 Issue 描述您的问题

---

⭐ 如果这个项目对您有帮助，请给我们一个星标！