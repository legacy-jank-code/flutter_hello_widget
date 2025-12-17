# Flutter Hello Widget

A feature-rich Flutter component library providing customizable Hello series UI components with focus on accessibility and semantic labeling support.

## ✨ Features

- 🎯 **HelloButton** - Accessible button supporting multiple sizes, colors, and loading states
- ♿ **Full Accessibility Support** - Built-in semantic labels and screen reader support
- 📱 **Responsive Design** - Adapts to different screen sizes and devices
- 🎨 **Highly Customizable** - Flexible color, size, and style configuration
- 🧪 **Comprehensive Test Coverage** - Includes unit tests and integration tests
- 📝 **Detailed Documentation** - All public APIs include detailed documentation

## 📦 Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_hello_widget: ^0.1.2
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### Basic Usage

```dart
import 'package:flutter_hello_widget/flutter_hello_widget.dart';

// Create a basic button
HelloButton(
  text: 'Click Me',
  onPressed: () {
    print('Button clicked!');
  },
)
```

### Different Button Sizes

```dart
Column(
  children: [
    // Small size button
    HelloButton(
      text: 'Small Button',
      size: ButtonSize.small,
      color: Colors.green,
      onPressed: () {},
    ),
    
    // Medium size button (default)
    HelloButton(
      text: 'Medium Button',
      size: ButtonSize.medium,
      onPressed: () {},
    ),
    
    // Large size button
    HelloButton(
      text: 'Large Button',
      size: ButtonSize.large,
      color: Colors.orange,
      onPressed: () {},
    ),
  ],
)
```

### Button with Loading State

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _isLoading = false;

  Future<void> _handlePress() async {
    setState(() => _isLoading = true);
    
    // Simulate async operation
    await Future.delayed(Duration(seconds: 2));
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return HelloButton(
      text: 'Submit',
      isLoading: _isLoading,
      onPressed: _isLoading ? null : _handlePress,
    );
  }
}
```

### Accessibility Support

```dart
HelloButton(
  text: 'Purchase',
  semanticLabel: 'Purchase item button',
  onPressed: () {
    // Handle purchase logic
  },
)
```

## 📋 API Reference

### HelloButton

| Parameter | Type | Default | Description |
|----------|------|---------|-------------|
| `text` | `String` | Required | Button display text |
| `onPressed` | `VoidCallback?` | `null` | Click callback function |
| `color` | `Color?` | `null` | Button background color |
| `size` | `ButtonSize` | `ButtonSize.medium` | Button size |
| `isLoading` | `bool` | `false` | Whether to show loading state |
| `semanticLabel` | `String?` | `null` | Accessibility semantic label |

### ButtonSize Enum

- `ButtonSize.small` - Small size, font size 14px
- `ButtonSize.medium` - Medium size, font size 16px (default)
- `ButtonSize.large` - Large size, font size 18px

### UI Utility Class

```dart
// Show success message
HelloUiUtils.showSuccess(context, 'Operation successful!');

// Show warning message
HelloUiUtils.showWarning(context, 'Please check your input');

// Get screen size
final screenSize = HelloUiUtils.getScreenSize(context);

// Check if wide screen
final isWideScreen = HelloUiUtils.isWideScreen(context);
```

## 🧪 Testing

This package includes complete test cases. You can run tests with:

```bash
# Run all tests
flutter test

# Run specific test files
flutter test test/presentation/hello_button_test.dart
flutter test test/presentation/hello_ui_utils_test.dart
```

## 🔧 Development Environment

- Flutter: ^3.7.0
- Dart: ^3.7.0
- Supports Android, iOS, Web, macOS, Windows, Linux

## 📱 Example App

Check the `example` directory for a complete example app demonstrating all features:

```bash
cd example
flutter run
```

## 🤝 Contributing

Issues and Pull Requests are welcome! Before contributing, please:

1. Read our coding standards
2. Ensure all tests pass
3. Add necessary comments and documentation

## 📄 License

This project uses MIT License - see [LICENSE](LICENSE) file for details.

## 🆘 Support

If you encounter issues, please:

1. Check documentation and example code
2. Search for similar issues in [GitHub Issues](https://github.com/your-username/flutter_hello_widget/issues)
3. Create a new Issue describing your problem

---

## 📖 中文文档

For Chinese documentation, please see [README_CN.md](README_CN.md) (中文文档)