# Use Debian-based image to avoid musl / native binding issues
FROM node:18-bullseye

WORKDIR /src

# Install deps cleanly inside Docker only
COPY package*.json ./
RUN npm ci

COPY . .

EXPOSE 4200
CMD ["npm", "start"]
