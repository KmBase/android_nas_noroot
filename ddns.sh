#!/bin/bash

# Cloudflare API 配置
ZONE_NAME="example.com"       # 域名
RECORD_NAME="ddns.example.com"  # DDNS 记录
CF_API_TOKEN="your_cloudflare_api_token"  # 替换为你的 Cloudflare API 令牌
Global_API_Key="your_cloudflare_global_api_key"  # 替换为你的Global API Key令牌
# 获取 Zone ID
ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=${ZONE_NAME}" \
    -H "Authorization: Bearer ${CF_API_TOKEN}" \
    -H "Content-Type: application/json" | jq -r '.result[0].id')

# 获取记录 ID
RECORD_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records?name=${RECORD_NAME}" \
    -H "Authorization: Bearer ${CF_API_TOKEN}" \
    -H "Content-Type: application/json" | jq -r '.result[0].id')

# 获取当前公网 IPV6
CURRENT_IP=$(curl -s https://ipv6.icanhazip.com)

# 更新 DNS 记录
UPDATE=$(curl https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${RECORD_ID} \
    -X PATCH \
    -H 'Content-Type: application/json' \
    -H "X-Auth-Email: ${CLOUDFLARE_EMAIL}" \
    -H "X-Auth-Key: ${Global_API_Key}" \
    --data "{\"type\":\"AAAA\",\"name\":\"${RECORD_NAME}\",\"content\":\"${CURRENT_IP}\",\"ttl\":120,\"proxied\":false}")

# 检查结果
if echo "$UPDATE" | grep -q '"success":true'; then
    echo "[$(date)] DNS 记录更新成功: ${CURRENT_IP}"
else
    echo "[$(date)] DNS 记录更新失败!"
    echo "$UPDATE"
fi
