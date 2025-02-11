#!/usr/bin/env bash
PROGRAM_NAME="$1"
ROOT_DIR="$(cd "$(dirname "$0")"; pwd)"
#set -e
PROGRAM_DIR=$ROOT_DIR/$PROGRAM_NAME
cd $PROGRAM_DIR/atama
cargo build-sbf
PROGRAM_NAME="atama_${PROGRAM_NAME//-/_}" SBF_OUT_DIR="$ROOT_DIR/target/deploy" cargo test --manifest-path "$PROGRAM_DIR/Cargo.toml"
