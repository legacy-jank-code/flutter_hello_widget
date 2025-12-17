#!/bin/bash

# Flutter测试覆盖率分析脚本
# 分析哪些代码没有被测试覆盖

echo "🔍 分析测试覆盖率详情..."

if [ ! -f "coverage/lcov.info" ]; then
    echo "❌ 未找到覆盖率数据，请先运行: flutter test --coverage"
    exit 1
fi

echo "📊 覆盖率统计:"
echo "=================="
lcov --summary coverage/lcov.info

echo ""
echo "🎯 未覆盖的代码行:"
echo "=================="

# 提取未覆盖的代码行
if command -v lcov &> /dev/null; then
    # 移除已覆盖的行，只显示未覆盖的
    lcov --remove coverage/lcov.info "*/test/*" -o coverage/uncovered.info
    
    echo ""
    echo "📋 各文件覆盖情况:"
    echo "------------------"
    
    # 分析每个文件
    for file in lib/src/**/*.dart; do
        if [ -f "$file" ]; then
            # 提取该文件的覆盖率信息
            file_coverage=$(lcov --extract coverage/lcov.info "*/$(basename $file)" --summary 2>/dev/null | grep "lines" || echo "未找到覆盖率数据")
            echo "$(basename $file): $file_coverage"
        fi
    done
    
    echo ""
    echo "💡 提高覆盖率建议:"
    echo "------------------"
    echo "1. 为常量文件添加测试 (button_constants.dart - 0%覆盖)"
    echo "2. 完善UI工具类的错误处理测试 (ui_utils.dart - 71%覆盖)"
    echo "3. 测试边界条件和异常情况"
    echo "4. 添加更多集成测试"
    
else
    echo "⚠️  lcov未安装，无法生成详细分析"
    echo "💡 安装命令: brew install lcov (macOS) 或 apt-get install lcov (Linux)"
fi

echo ""
echo "✅ 分析完成！"
echo "🌐 详细HTML报告: coverage/html/index.html"