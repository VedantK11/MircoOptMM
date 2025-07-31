BUILD=build
CC=g++

blocking: build
	g++ matrix.c -D OPTIMIZE_BLOCKING -o $(BUILD)/$@

prefetch: build
	g++ matrix.c -D OPTIMIZE_PREFETCH -o $(BUILD)/$@

simd: build
	g++ matrix.c -mavx -march=native -D OPTIMIZE_SIMD -o $(BUILD)/$@

blocking-prefetch: build
	g++ matrix.c -D OPTIMIZE_BLOCKING_PREFETCH -o $(BUILD)/$@

blocking-simd: build
	g++ matrix.c -mavx -march=native -D OPTIMIZE_BLOCKING_SIMD -o $(BUILD)/$@

simd-prefetch: build
	g++ matrix.c -mavx -march=native -D OPTIMIZE_SIMD_PREFETCH -o $(BUILD)/$@

blocking-simd-prefetch: build
	g++ matrix.c -mavx -march=native -D OPTIMIZE_BLOCKING_SIMD_PREFETCH -o $(BUILD)/$@


all: blocking prefetch simd blocking-prefetch blocking-simd simd-prefetch blocking-simd-prefetch


clean:
	@rm -rf $(BUILD)
	@rm -f out.txt

build:
	@mkdir -p $(BUILD)
