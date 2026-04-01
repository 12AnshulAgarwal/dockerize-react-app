##############################
# Stage 1: Build React App
##############################

# Use official Node.js image only for building the React app
FROM node:18 AS build

# Set working directory inside the container
WORKDIR /app

# Copy package files first (optimizes Docker layer caching)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the React app (generates static files)
RUN npm run build


##############################
# Stage 2: Serve with Nginx
##############################

# Use lightweight Nginx image for production
FROM nginx:alpine

# Metadata (does not affect runtime)
LABEL maintainer="Anshul Agarwal"
LABEL project="Dockerized React Frontend"
LABEL description="React application built with Node.js and served using Nginx"

# Copy build output from previous stage to Nginx HTML directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for the container
EXPOSE 80

# Start Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
