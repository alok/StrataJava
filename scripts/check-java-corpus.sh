#!/usr/bin/env bash
set -eu

out_dir="build/classes/cs61b-java"
rm -rf "$out_dir"
mkdir -p "$out_dir"

javac -d "$out_dir" corpus/cs61b-java/src/*.java

echo "Compiled Java corpus into $out_dir"
