#!/bin/bash

# Cloudflare API 配置
ZONE_NAME="example.com"       # 域名
RECORD_NAME="ddns.example.com"  # DDNS 记录
CF_API_TOKEN="your_cloudflare_api_token"  # 替换为你的 Cloudflare API 令牌

# 获取 Zone ID
ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=${ZONE_NAME}" \
    -H "Authorization: Bearer ${CF_API_TOKEN}" \
    -H "Content-Type: application/json" | jq -r '.result[0].id')

# 获取记录 ID
RECORD_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records?name=${RECORD_NAME}" \
    -H "Authorization: Bearer ${CF_API_TOKEN}" \
    -H "Content-Type: application/json" | jq -r '.result[0].id')

# 获取当前公网 IP
CURRENT_IP=$(curl -s https://ipv4.icanhazip.com)

# 更新 DNS 记录
UPDATE=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${RECORD_ID}" \
    -H "Authorization: Bearer ${CF_API_TOKEN}" \
    -H "Content-Type: application/json" \
    --data "{\"type\":\"A\",\"name\":\"${RECORD_NAME}\",\"content\":\"${CURRENT_IP}\",\"ttl\":120,\"proxied\":false}")

# 检查结果
if echo "$UPDATE" | grep -q '"success":true'; then
    echo "[$(date)] DNS 记录更新成功: ${CURRENT_IP}"
else
    echo "[$(date)] DNS 记录更新失败!"
    echo "$UPDATE"
fi
