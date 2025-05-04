# Use Debian-based image to avoid musl / native binding issues
FROM node:23-bullseye

WORKDIR /src

# Install deps cleanly inside Docker only
COPY package*.json ./
RUN npm ci

COPY . .

EXPOSE 4200
# Create a non-root user and switch to it
RUN useradd -m appuser
USER appuser

CMD ["npm", "start"]
