#!/bin/bash
set -e

echo "🔨 Iniciando compilação do projeto ARIYAN_IOS..."

export THEOS=~/theos
cd /workspaces/AIAYB/ARIYAN_IOS

echo "📦 Limpando builds anteriores..."
make clean

echo "🔧 Compilando projeto..."
make

echo "📦 Criando pacote..."
make package

echo "✅ Compilação concluída!"
ls -lah packages/ 2>/dev/null && echo "📁 Pacote pronto em packages/"
