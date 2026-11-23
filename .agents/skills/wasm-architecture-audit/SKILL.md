---
name: wasm-architecture-audit
description: >-
  Audits Rust/WebAssembly, Web Worker, browser storage, and client-side OCR architectures in web applications.
  Use when diagnosing bundle bloat, duplicate WASM instantiation, main-thread vs worker state splitting,
  parallelism options (SharedArrayBuffer, Atomics, wasm-bindgen-rayon), serialization bottlenecks, or client-side OCR feasibility.
---

# WASM Architecture & Client-Side Pipeline Audit

Perform a deep, codebase-grounded technical analysis and design concrete architectural solutions without guessing unverified symbols or capabilities.

## Procedure

1. **Inspect the Actual Codebase First**:
   - Read the Rust crate manifest, WASM exports, worker bridge, storage layer, and frontend build/server headers before proposing changes.
   - Cite only verified file paths, crate versions, symbol names, and config settings observed in the repository.

2. **Analyze Core Architectural Axes**:
   - **Bundle Size & Lazy Loading**: Inspect embedded assets (`include_str!`, dictionaries, fonts), crate dependencies, `wasm-opt` flags, and split strategies (external compressed dictionaries cached in OPFS/IndexedDB, feature gating, streaming instantiation).
   - **Single-Instance Worker Ownership & State**: Trace where WASM is initialized (main thread vs Web Worker), identify duplicate instantiation or `thread_local!` state split, and design a unified Worker-owned RPC/Comlink boundary.
   - **Browser Parallelism & Concurrency**: Evaluate `SharedArrayBuffer`, `Atomics`, `wasm-bindgen-rayon`, Web Worker pools, and their mandatory HTTP security header implications (`Cross-Origin-Opener-Policy: same-origin` and `Cross-Origin-Embedder-Policy: require-corp` / `credentialless`), including conflicts with external embeds, CDNs, fonts, or `pdfjs-dist` workers.
   - **Serialization & Memory Pressure**: Identify Base64/JSON bloat, redundant copies across `postMessage`, and streaming/Transferable/`Uint8Array` or ZIP/binary container alternatives.
   - **Client-Side OCR Feasibility**: Evaluate browser-viable OCR stacks (e.g., Tesseract.js / WASM, ONNX Runtime Web / WebGPU, PaddleOCR/Surya-class models, hybrid PDF page detection for image-only vs text-layer PDFs), memory/download trade-offs, accuracy on stylized/novel typography, and UX patterns (progressive/on-demand worker download).
   - **HTML/DOM Parsing, Testing & Token Hygiene**: Replace fragile regex HTML transforms with structured DOM/HTML parsers, make parity tests portable without hardcoded machine paths, and enforce semantic design tokens.

3. **Deliver Actionable Architectural Proposals**:
   - For each issue, provide: root cause in the current code, recommended solution, concrete tooling/crates/APIs, trade-offs/risks (especially browser compatibility and COOP/COEP constraints), and phased implementation order.
   - Do not modify source files when operating in advisory/audit mode unless explicitly instructed to implement.
