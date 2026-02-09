#!/bin/bash

echo "=============================="
echo "🚀 Frontend Deployment Started"
echo "=============================="

FRONTEND_DIR="/home/tanmay/projects/frontend"
APACHE_ROOT="/home/viteapp/public_html"

cd $FRONTEND_DIR || {
  echo "❌ Frontend directory not found"
  exit 1
}

echo "➡️ Pulling latest frontend code"
git pull --rebase origin main || exit 1

echo "➡️ Installing dependencies"
npm install || exit 1

echo "➡️ Building frontend"
npm run build || exit 1

echo "➡️ Deploying build to Apache"
sudo rm -rf $APACHE_ROOT/*
sudo cp -r dist/* $APACHE_ROOT/
sudo chown -R viteapp:viteapp $APACHE_ROOT
sudo chmod -R 755 $APACHE_ROOT

echo "➡️ Reloading Apache"
sudo systemctl reload apache2 || exit 1

echo "=============================="
echo "✅ Frontend Deployment Done"
echo "=============================="
