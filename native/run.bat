@echo off
title Running Qwen 35B MoE Server

set MODEL_PATH=%~dp0models\Qwen3.5-9B-Q8_0.gguf

llama-server.exe ^
    --model "%MODEL_PATH%" ^
    --n-cpu-moe 30 ^
    --n-gpu-layers 100 ^
    --cache-type-k q4_0 ^
    --cache-type-v q4_0 ^
    --host 0.0.0.0 ^
    --port 8080 ^
    --metrics

pause
