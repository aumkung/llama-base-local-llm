# LLM Chat Server

llama-cpp-server และ Qwen3.5 4B โมเดลสำหรับรันบน GPU ของ NVIDIA

## สิ่งที่โปรแกรมมี

- รองรับ GPU ของ NVIDIA ผ่าน CUDA 12.4
- โมเดล Qwen3.5 4B (4-bit quantized)
- รองรับภาษาไทย (หน้า login)
- ใช้ Docker รันบน GPU

## ดาวน์โหลดโมเดล

ดาวน์โหลดโมเดลจาก Hugging Face:
```
https://huggingface.co/unsloth/Qwen3.5-4B-GGUF
```

ดาวน์โหลดไฟล์ `.gguf` มาแล้ว放在了 `models/` โฟลเดอร์

## ติดตั้งและรัน

### ที่ต้องเตรียม

- Docker Desktop (มี NVIDIA Container Toolkit)
- การ์ดจอ NVIDIA

### ขั้นตอน

```bash
# สร้างและรัน container
docker compose up -d

# ดู log
docker compose logs -f qwen-server

# ปิด service
docker compose down
```

## เข้าใช้งาน

เปิด `http://localhost:8080` ใน browser

## ตั้งค่าเพิ่มเติม

แก้ไข `docker-compose.yml` เพื่อปรับ:

- `--model`: path ของโมเดล
- `--n-gpu-layers`: จำนวน layer ที่ใช้ GPU (เพิ่ม = เร็วขึ้น)
- `--port`: พอร์ตที่เข้าถึง

## troubleshoot

### Out of Memory

ลด `--n-gpu-layers` ใน docker-compose.yml

### GPU ไม่พบ

```bash
nvidia-smi
docker run --rm --gpus all nvidia/cuda:12.4.1-runtime ubuntu nvidia-smi
```

## โครงสร้างไฟล์

```
llama/
├── README.md
├── Dockerfile          # Build config
├── docker-compose.yml  # รันบน GPU
└── models/             # ที่เก็บโมเดล
    └── Qwen3.5-4B-Q4_K_M.gguf
```
