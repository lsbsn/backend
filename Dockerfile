############  build stage  ############
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json pnpm-lock.yaml ./
RUN corepack enable && pnpm install
COPY . .
RUN pnpm run build           # <-- создаёт dist/

############  runtime stage ############
FROM node:20-alpine
WORKDIR /app
COPY package*.json pnpm-lock.yaml ./
RUN corepack enable && pnpm install --prod
COPY --from=builder /app/dist ./dist
CMD ["node","dist/main.js"]