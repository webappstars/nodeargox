FROM node:20.19.2
EXPOSE 3000
WORKDIR /app


# 修改這裡：確保直接複製內容到當前工作目錄
COPY files/ .

RUN apt-get update && \
    apt-get install -y iproute2 wget && \
    npm install && \
    npm install -g pm2 && \
    wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb && \
    rm -f cloudflared.deb && \
    chmod -R 777 /app && chmod -v 775 web.js entrypoint.sh

# 使用相對路徑啟動
ENTRYPOINT [ "node", "server.js" ]
