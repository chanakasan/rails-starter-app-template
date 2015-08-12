#!/usr/bin/env bash

set -e

setup() {
  if [ -x myapptest ]; then
    rm -rf myapptest
  fi

  rails new myapptest -m "$PWD/starter.rb"
  cd myapptest
}

fail_test() {
  echo FAIL: "$*"
  exit 1
}

run_unit_tests() {
  (
    [ "`git log -1 | grep 'commit ' | wc -l`" == "1" ] || fail_test "incorrect commits"

    echo Unit tests OK!
  )
}

run_karma_js_tests() {
  echo Running js tests with karma..
  karma start --single-run
}

run_brower_test() {
  echo Running browser test..
  echo "Let's look at a page to see everything is working" visit http://localhost:3000/home/index
  echo "Press Ctrl-C to finish this test."
  rails g controller home index
  rails s
}

main() {
  setup
  run_unit_tests
  run_brower_test
  run_karma_js_tests
  echo All tests finished!
}

main
