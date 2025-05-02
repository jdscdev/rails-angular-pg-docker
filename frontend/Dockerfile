# Stage 1: Build the Angular app
FROM node:23-alpine AS build

WORKDIR /app

# Copy and install deps
COPY package*.json ./
RUN npm install

# Add app source
COPY . .

EXPOSE 4200
CMD ["npm", "start"]