#!/bin/bash
set -e  # エラーで即終了

# helper: 実行→期待結果を検証
run_test() {
  input=("$1" "$2")
  expected="$3"
  output=$(./gcd.sh "${input[@]}" 2>&1) || { echo "Test failed: ${input[*]}"; exit 1; }
  if [ "$output" != "$expected" ]; then
    echo "Test failed: args=${input[*]}, expected=$expected, got=$output"
    exit 1
  fi
}

run_error_test() {
  args=("$@")
  if ./gcd.sh "${args[@]}" >/dev/null 2>&1; then
    echo "Expected error but got success: args=${args[*]}"
    exit 1
  fi
}

# 正常系テスト
run_test 2 4 2
run_test 12 18 6
run_test 7 13 1

# 異常系テスト
run_error_test      # 引数 0 個
run_error_test 5    # 引数 1 個
run_error_test 1 2 3  # 引数 3 個
run_error_test -5 10   # 負の数
run_error_test 3.5 2   # 小数
run_error_test foo bar # 文字列

echo "All tests passed!"

