FROM nvidia/cuda:12.4.1-devel-ubuntu22.04 AS builder

RUN apt-get update && apt-get install -y git build-essential cmake

RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64/stubs:$LD_LIBRARY_PATH

RUN git clone https://github.com/TheTom/llama-cpp-turboquant.git /app
WORKDIR /app


RUN cmake -B build \
    -DGGML_CUDA=ON \
    -DGGML_FLASH_ATTN=ON \
    -DCMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs && \
    cmake --build build -j4 --target llama-server

FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y libgomp1


COPY --from=builder /app/build/bin/llama-server /app/llama-server


COPY --from=builder /app/build/bin/*.so* /app/

WORKDIR /app
ENTRYPOINT ["/app/llama-server"]
