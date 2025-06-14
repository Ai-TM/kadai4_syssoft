#!/bin/bash

set -eu  # -e: エラーで停止、-u: 未定義変数で停止

# 引数チェック
if [ "$#" -ne 2 ]; then
  echo "使い方: $0 自然数1 自然数2" >&2
  exit 1
fi

a="$1"; b="$2"

# 数値かどうか
if ! [[ "$a" =~ ^[0-9]+$ ]] || ! [[ "$b" =~ ^[0-9]+$ ]]; then
  echo "エラー: 両方の引数を自然数にしてください。" >&2
  exit 1
fi

# 0 は扱わない
if [ "$a" -le 0 ] || [ "$b" -le 0 ]; then
  echo "エラー: 引数は0以外の自然数を指定してください。" >&2
  exit 1
fi

# ユークリッドの互除法
while [ "$b" -ne 0 ]; do
  r=$(( a % b ))
  a=$b
  b=$r
done

echo "$a"

