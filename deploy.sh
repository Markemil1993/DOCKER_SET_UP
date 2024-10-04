#!/bin/bash
# Using ubuntu OS
sudo lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv 2>/dev/null
sudo resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv 2>/dev/null

# Docker Build up
docker compose up --build -d 


