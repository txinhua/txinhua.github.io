#!/bin/bash

# Cursor 配置清理脚本
# 用于完全重置 Cursor 配置

echo "🚀 Cursor 配置清理脚本"
echo "=========================="

# 检查 Cursor 是否正在运行
if pgrep -f "cursor" > /dev/null; then
    echo "⚠️  警告: Cursor 正在运行，请先关闭 Cursor 应用"
    echo "   使用 pkill -f cursor 强制关闭"
    read -p "   是否继续？(y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# 备份现有配置（可选）
BACKUP_DIR="$HOME/cursor_backup_$(date +%Y%m%d_%H%M%S)"
echo "📦 创建备份目录: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# 备份函数
backup_if_exists() {
    local source="$1"
    local name="$2"
    
    if [ -d "$source" ] || [ -f "$source" ]; then
        echo "   备份: $source -> $BACKUP_DIR/$name"
        cp -r "$source" "$BACKUP_DIR/$name" 2>/dev/null || true
        return 0
    fi
    return 1
}

# 执行备份
echo "📋 备份现有配置..."
backup_if_exists "$HOME/.config/Cursor" "config_Cursor"
backup_if_exists "$HOME/.config/cursor" "config_cursor" 
backup_if_exists "$HOME/.local/share/Cursor" "share_Cursor"
backup_if_exists "$HOME/.local/share/cursor" "share_cursor"
backup_if_exists "$HOME/.cache/Cursor" "cache_Cursor"
backup_if_exists "$HOME/.cache/cursor" "cache_cursor"

# 清理函数
remove_if_exists() {
    local target="$1"
    local name="$2"
    
    if [ -d "$target" ] || [ -f "$target" ]; then
        echo "   删除: $target"
        rm -rf "$target"
        return 0
    else
        echo "   跳过: $target (不存在)"
        return 1
    fi
}

# 执行清理
echo ""
echo "🧹 清理 Cursor 配置文件..."
remove_if_exists "$HOME/.config/Cursor" "主配置目录"
remove_if_exists "$HOME/.config/cursor" "备用配置目录"

echo ""
echo "🧹 清理用户数据..."
remove_if_exists "$HOME/.local/share/Cursor" "用户数据目录"
remove_if_exists "$HOME/.local/share/cursor" "备用用户数据目录"

echo ""
echo "🧹 清理缓存文件..."
remove_if_exists "$HOME/.cache/Cursor" "缓存目录"
remove_if_exists "$HOME/.cache/cursor" "备用缓存目录"

# 清理临时文件
echo ""
echo "🧹 清理临时文件..."
sudo find /tmp -name "*cursor*" -o -name "*Cursor*" 2>/dev/null | while read -r file; do
    echo "   删除临时文件: $file"
    sudo rm -rf "$file" 2>/dev/null || true
done

# 清理系统级配置（如果存在）
echo ""
echo "🧹 检查系统级配置..."
if [ -d "/etc/cursor" ]; then
    echo "   发现系统配置: /etc/cursor"
    read -p "   是否删除系统配置？(y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo rm -rf "/etc/cursor"
        echo "   已删除系统配置"
    fi
fi

echo ""
echo "✅ 清理完成！"
echo ""
echo "📋 总结:"
echo "   - 备份位置: $BACKUP_DIR"
echo "   - 配置文件已清理"
echo "   - 缓存文件已清理" 
echo "   - 临时文件已清理"
echo ""
echo "🔄 下次启动 Cursor 时将创建全新配置"
echo ""
echo "💡 如需恢复配置，可从备份目录复制文件："
echo "   cp -r $BACKUP_DIR/config_Cursor ~/.config/Cursor"