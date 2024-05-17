CC := gcc
EMCC := emcc
CFLAGS := -std=c11
EMFLAGS := -s WASM=1 -s EXPORTED_FUNCTIONS='["_main"]' -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' --preload-file data -lm -s INITIAL_MEMORY=67108864

# Native build target
project: 
	$(CC) $(CFLAGS) -o mnist mnist.c mnist_file.c neural_network.c -lm

# WebAssembly build target
project_wasm:
	$(EMCC) $(CFLAGS) mnist.c mnist_file.c neural_network.c -o mnist.html $(EMFLAGS)

# Serve the project on a local web server
serve:
	python3 -m http.server 8000

# Default target
all: project project_wasm
