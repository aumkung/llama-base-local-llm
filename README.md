# Local LLM Chat Server

A local LLM inference server running Qwen3.5 4B on NVIDIA GPU using llama-cpp-server.

## Features

- Qwen3.5 4B model inference via llama-cpp-server
- GPU acceleration with CUDA 12.4
- Optimized for Thai language support (login interface)
- Docker-based deployment with NVIDIA GPU support

## Project Structure

```

├── login.html          # Login page (Thai language)
├── Dockerfile          # Build configuration for llama-server
├── docker-compose.yml  # Docker orchestration
├── models/             # Model files directory
│   └── Qwen3.5-4B-Q4_K_M.gguf
```

## Quick Start

### Prerequisites

- Docker Desktop with NVIDIA Container Toolkit
- NVIDIA GPU (GPU drivers installed)
- 8GB+ VRAM recommended

### Build and Run

```bash
# Build and start the container
docker compose up -d

# View logs
docker compose logs -f qwen-server

# Stop the service
docker compose down
```

### Access

Open `http://localhost:8080` in your browser to access the login page.

## Configuration

### Model Selection

The server runs with these default settings:

| Parameter | Value | Description |
|-----------|-------|-------------|
| Model | Qwen3.5-4B-Q4_K_M.gguf | 4B quantized model |
| CPU Layers | 35 | Layers on CPU |
| GPU Layers | 100 | Layers on GPU |
| Port | 8080 | HTTP endpoint |
| Cache Type-K | turbo4 | KV cache type |
| Cache Type-V | turbo3 | KV cache type |
| No MMap | true | Prevent memory mapping |
| MLock | true | Lock in memory |

### Custom Configuration

Edit `docker-compose.yml` to modify:

- `--model`: Path to model file
- `--n-cpu-moe`: Number of layers on CPU
- `--n-gpu-layers`: Number of layers on GPU
- `--host`: Bind address
- `--port`: HTTP port

### Performance Tips

- Use `--mlock` to prevent swapping
- Increase `--n-gpu-layers` for better GPU utilization
- Use 8-bit or 4-bit quantization for smaller models
- Enable `--metrics` for monitoring

## Model Format

- Format: GGUF (llama.cpp)
- Quantization: Q4_K_M (4-bit)
- Model: Qwen3.5 4B

## Troubleshooting

### Out of Memory

```bash
# Reduce GPU layers
docker compose up -d --build --set --n-gpu-layers 70

# Or increase system memory limits
ulimit -l unlimited
```

### GPU Not Detected

```bash
# Verify NVIDIA drivers
nvidia-smi

# Verify Docker NVIDIA support
docker run --rm --gpus all nvidia/cuda:12.4.1-runtime ubuntu nvidia-smi
```

### Login Page Broken

- Check if port 8080 is accessible
- Verify `models/Qwen3.5-4B-Q4_K_M.gguf` exists
- Ensure correct model path in docker-compose.yml

## License

Proprietary - Qwen3.5 Model

## Notes

- Thai language support via login interface
- Login credentials not exposed (placeholder implementation)
- Model files stored in Docker volume at `./models`
