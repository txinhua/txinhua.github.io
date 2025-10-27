# Cursor 重新配置指南

## 🚀 执行清理

### 方法一：使用清理脚本（推荐）
```bash
# 运行清理脚本
./cursor_reset.sh
```

### 方法二：手动清理
```bash
# 1. 关闭 Cursor
pkill -f cursor

# 2. 清理配置文件
rm -rf ~/.config/Cursor ~/.config/cursor
rm -rf ~/.local/share/Cursor ~/.local/share/cursor  
rm -rf ~/.cache/Cursor ~/.cache/cursor

# 3. 清理临时文件
sudo find /tmp -name "*cursor*" -o -name "*Cursor*" -exec rm -rf {} + 2>/dev/null
```

## 🔧 重新启动和配置

### 1. 启动 Cursor
- 重新打开 Cursor 应用
- 首次启动会创建新的配置文件

### 2. 基础设置
- **登录账户**：使用你的 Cursor 账户登录
- **选择主题**：Dark/Light 主题
- **设置字体**：根据偏好调整

### 3. 网络配置（重要）
如果你在企业网络或使用代理：

```json
// settings.json 中添加代理设置
{
  "http.proxy": "http://your-proxy:port",
  "http.proxyStrictSSL": false,
  "http.proxyAuthorization": null
}
```

### 4. 扩展安装
重新安装必要的扩展：
- Language packs
- Theme extensions  
- Productivity tools

### 5. 工作区恢复
- 重新打开项目文件夹
- 恢复工作区布局
- 重新配置项目设置

## 🔍 验证配置

### 网络连接测试
1. 打开 Cursor 命令面板 (`Ctrl+Shift+P`)
2. 运行 "Cursor: Network Diagnostics"
3. 检查所有服务是否正常连接

### 功能测试
- [ ] AI Chat 功能正常
- [ ] Code completion 工作
- [ ] Extension marketplace 可访问
- [ ] 项目文件正常打开

## 🆘 常见问题

### Q: 清理后仍有网络问题？
A: 检查系统代理设置，确保 Cursor 能访问 `api2.cursor.sh:443`

### Q: 扩展丢失？
A: 重新从 marketplace 安装，或从备份恢复 `~/.local/share/Cursor/extensions`

### Q: 设置丢失？
A: 从备份目录恢复 `settings.json` 文件

### Q: 项目配置丢失？
A: 项目级配置通常在 `.vscode/` 目录中，不会被清理

## 📁 重要文件位置

清理后的新配置文件位置：
```
~/.config/Cursor/
├── User/
│   ├── settings.json          # 用户设置
│   ├── keybindings.json       # 快捷键
│   └── snippets/              # 代码片段
├── logs/                      # 日志文件
└── CachedExtensions/          # 扩展缓存

~/.local/share/Cursor/
├── extensions/                # 已安装扩展
├── logs/                      # 扩展日志
└── User/                      # 用户数据
```

## 🔄 备份策略

为避免将来需要重新配置，建议：

1. **定期备份配置**
```bash
# 创建配置备份
tar -czf cursor_config_backup.tar.gz ~/.config/Cursor ~/.local/share/Cursor
```

2. **版本控制设置文件**
```bash
# 将设置文件加入 git 管理
cd ~/.config/Cursor/User
git init
git add settings.json keybindings.json
git commit -m "Initial cursor config"
```

3. **同步到云端**
- 使用 Cursor 内置的设置同步功能
- 或手动上传到云存储服务