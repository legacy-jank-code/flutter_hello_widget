#!/bin/bash

# Flutter测试覆盖率报告生成脚本
# 使用方法: ./scripts/coverage_report.sh

echo "🧪 运行Flutter测试并生成覆盖率报告..."

# 清理旧的覆盖率数据
if [ -d "coverage" ]; then
    rm -rf coverage
fi

# 运行测试并生成覆盖率
flutter test --coverage

# 检查lcov是否安装
if ! command -v lcov &> /dev/null; then
    echo "⚠️  lcov未安装，跳过HTML报告生成"
    echo "📊 覆盖率摘要:"
    if [ -f "coverage/lcov.info" ]; then
        echo "✅ 覆盖率数据已生成: coverage/lcov.info"
        echo "💡 安装lcov后运行: genhtml coverage/lcov.info -o coverage/html"
    else
        echo "❌ 覆盖率数据生成失败"
        exit 1
    fi
    exit 0
fi

# 生成HTML报告
echo "📈 生成HTML覆盖率报告..."
genhtml coverage/lcov.info -o coverage/html

# 显示覆盖率摘要
echo "📊 覆盖率摘要:"
echo "=================="
lcov --summary coverage/lcov.info

# 打开报告（macOS）
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🌐 在浏览器中打开覆盖率报告..."
    open coverage/html/index.html
fi

echo "✅ 覆盖率报告生成完成！"
echo "📁 报告位置: coverage/html/index.html"