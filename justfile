set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

default:
    @just --list

check-all:
    cargo check --workspace --tests
    cd portal; just check-web

build-wasm:
    cd portal/wasm-crate; wasm-pack build --target web --out-dir ../src/wasm

wt-add repo branch path:
    git -C {{repo}} worktree add -b {{branch}} {{path}}

submodules-sync:
    git submodule update --init --recursive
