#!/usr/bin/env bash
set -e

echo "=============================="
echo " Ubuntu Node.js & npm Installer"
echo "=============================="

# 1. 检查 root
if [ "$EUID" -ne 0 ]; then
  echo "[ERROR] 请使用 root 运行该脚本"
  exit 1
fi

# 2. 检查是否已安装
if command -v node >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
  echo "[INFO] Node.js 已安装"
  node -v
  npm -v
  exit 0
fi

# 3. 安装依赖
echo "[STEP 1] 安装基础依赖..."
apt update -y
apt install -y curl ca-certificates gnupg

# 4. 添加 NodeSource LTS 源
echo "[STEP 2] 添加 Node.js LTS 源..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -

# 5. 安装 Node.js（自带 npm）
echo "[STEP 3] 安装 Node.js & npm..."
apt install -y nodejs

# 6. 验证安装
echo "[STEP 4] 验证版本..."
echo "Node version:"
node -v
echo "npm version:"
npm -v

echo "=============================="
echo " ✅ Node.js & npm 安装完成"
echo "=============================="
