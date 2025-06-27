FROM node:20-alpine
WORKDIR /app
COPY pnpm-lock.yaml package.json ./
RUN corepack enable && pnpm i --prod
COPY . .
CMD ["node","dist/main.js"]
