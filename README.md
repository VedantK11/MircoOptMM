# Matrix Multiplication Optimization with Microarchitectural Techniques

## Overview

This project implements and benchmarks various microarchitectural optimization techniques for matrix multiplication, including blocking, SIMD vectorization, and software prefetching. The implementation demonstrates significant performance improvements over naive matrix multiplication through careful exploitation of cache locality and CPU vector processing capabilities.


## Optimization Techniques Implemented

### 1. Blocking Matrix Multiplication
- **Technique**: Divides matrices into smaller blocks (BxB) to improve cache locality
- **Block Size**: 25 (calculated based on L1 cache size of 32KB)
- **Features**: 
 - Loop unrolling to reduce overhead
 - Ensures 3 B×B blocks fit in L1 cache
- **Performance Improvement**: 1.34x to 1.71x speedup

### 2. SIMD Vectorization
- **Technique**: Uses AVX2 instructions for parallel processing
- **Key Instructions**:
 - `_mm256_loadu_pd`: Load unaligned double-precision values
 - `_mm256_fmadd_pd`: Fused multiply-add operations
 - `_mm256_setzero_pd`: Initialize vectors to zero
 - `_mm256_storeu_pd`: Store results to memory
- **Optimization**: Column-major reordering of matrix B for better cache usage
- **Parallelism**: Processes 4 double-precision values simultaneously

### 3. Software Prefetching
- **Technique**: Uses `__builtin_prefetch` to load data into cache ahead of time
- **Configuration**: 
 - Prefetch distance: 4 elements ahead
 - Read operations (parameter: 0)
 - High temporal locality hint (parameter: 3)
- **Limitation**: Hardware prefetcher often outperforms software prefetching

### 4. Combined Optimizations
- **Blocking + SIMD**: Combines cache-friendly blocking with vectorized operations
- **SIMD + Prefetching**: Vectorization with predictive data loading
- **Blocking + SIMD + Prefetching**: Triple optimization approach

## System Requirements

### Hardware Requirements
- **CPU**: x86-64 processor with AVX2 support
- **Cache**: L1 cache size of at least 32KB (for optimal blocking)
- **Architecture**: Intel or AMD processors supporting `_mm256_*` instructions

### Software Requirements
- **Compiler**: GCC with AVX2 support
- **Build System**: Make
- **OS**: Linux/Unix-based system

## Installation and Setup

### Prerequisites Check
Before running, verify your system supports AVX2:
```bash
# Check for AVX2 support
grep -o avx2 /proc/cpuinfo | head -1
```

### Building the Project
```bash
# Make the run script executable
chmod +x run.sh
bash run.sh
```
Above script performs the following operations:
- make all - Compiles all optimization variants
- Runs benchmarks for matrix sizes 100×100, 200×200, and 800×800
- Outputs results to out.txt