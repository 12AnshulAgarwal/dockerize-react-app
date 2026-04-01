# Dockerizing a React Application on AWS EC2

This repository demonstrates how to **build, containerize, and run a React frontend application using Docker on an AWS EC2 instance**.

The focus of this project is to understand:

*   How a React app works normally
*   How it is built for production
*   How Docker packages and runs it
*   How the app is accessed using an EC2 public IP

***

## ✅ Prerequisites

Before starting, make sure you have:

*   An **AWS EC2 instance** running (Amazon Linux)
*   **Docker installed and running** on EC2
*   SSH access to the EC2 instance

***

## 🏁 Goal of This Project

Run a **React application inside a Docker container on AWS EC2** and access it from a browser using:

    http://<EC2_PUBLIC_IP>:3000

***

## 🔹 Step 0: Verify Docker Installation

Check whether Docker is installed and working.

```bash
docker --version
```

✅ If you see a Docker version, you’re good to continue.

***

## 🔹 Step 1: Create Project Workspace

Create a directory for the React project and move into it.

```bash
mkdir react-docker-app
cd react-docker-app
```

**What this does:**

*   Creates a clean workspace for the React project
*   Keeps application files organized

***

## 🔹 Step 2: Install Node.js (Build Purpose Only)

Node.js is required **only to build the React app**, not to run it in production.

```bash
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs
```

Verify installation:

```bash
node -v
npm -v
```

✅ You should see Node and npm versions.

***

## 🔹 Step 3: Create React Application

Create a React app in the current directory.

```bash
npx create-react-app .
```

**Why the dot (`.`) matters:**

*   It creates the app inside the current folder instead of a nested directory

***

## 🔹 Step 4: Test React App (Before Docker)

Run the app in development mode to verify it works.

```bash
npm start
```

✅ You should see:

    Compiled successfully!

Stop the server after verification:

```bash
Ctrl + C
```

**Why this step is important:**

*   Confirms the app works before containerizing
*   Avoids confusing React issues with Docker issues later

***

## 🔹 Step 5: Create the Dockerfile

Create a Dockerfile:

```bash
nano Dockerfile
```

Paste the following:

```dockerfile
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
```

**What this Dockerfile does:**

*   Uses Node.js only to build the React app
*   Generates static files using `npm run build`
*   Uses Nginx to serve those static files
*   Final image does NOT contain Node.js

***

## 🔹 Step 6: Create `.dockerignore`

Create a `.dockerignore` file:

```bash
nano .dockerignore
```

Add:

    node_modules
    .git
    npm-debug.log
    Dockerfile
    README.md

**Why this is important:**

*   Reduces image size
*   Speeds up Docker builds
*   Avoids copying unnecessary files

***

## 🔹 Step 7: Build the Docker Image

Build the Docker image from the Dockerfile.

```bash
docker build -t react-docker-app .
```

✅ You should see:

    Successfully built ...

Verify the image:

```bash
docker images
```

***

## 🔹 Step 8: Run the Docker Container

Start the React app inside a Docker container.

```bash
docker run -d -p 3000:80 react-docker-app
```

**What this does:**

*   Maps EC2 port `3000` → container port `80`
*   Runs the container in detached mode (`-d`)
*   Starts Nginx to serve the React build

Check running containers:

```bash
docker ps
```

✅ You should see `react-docker-app` running.

***

## 🔹 Step 9: Configure AWS Security Group

In the AWS Console:

*   Go to **EC2 → Security Groups**
*   Edit **Inbound Rules**
*   Add rule:

| Type       | Port | Source    |
| ---------- | ---- | --------- |
| Custom TCP | 3000 | 0.0.0.0/0 |

✅ This allows browser access to the app.

***

## 🔹 Step 10: Access the App from Browser

Open your browser and visit:

    http://<EC2_PUBLIC_IP>:3000

✅ You should see the React welcome page  
✅ The app is running **inside Docker on AWS EC2**

***

## 🧠 What This Project Teaches

*   Difference between development and production React
*   How Docker images and containers work
*   Multi‑stage Docker builds
*   How frontend apps are served using Nginx
*   Basic cloud deployment using AWS EC2

***

## 🎤 Interview Explanation (Simple & Honest)

> “I built a React frontend, containerized it using Docker, and deployed it on AWS EC2. I used a multi‑stage Docker build where Node.js was used only to build the app, and Nginx served the production files. The app was accessed via the EC2 public IP.”

***

## ✅ Summary

✅ React frontend only  
✅ Node.js used only for build  
✅ Nginx used for serving static files  
✅ Dockerized and deployed on AWS EC2

***
