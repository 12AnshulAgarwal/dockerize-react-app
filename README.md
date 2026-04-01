# Dockerized React Application

This repository contains a basic React application that has been **containerized using Docker**.  
The purpose of this project is to understand how a frontend application is built, packaged, and run in a **production‑like environment using Docker**, instead of relying on local setups.

This project is part of my hands-on learning journey with **Docker and Cloud fundamentals**.

---

## 📌 What This Project Demonstrates

- How a React application works normally in development
- How a React app is built for production
- How Docker packages the application into an image
- How the app runs consistently using a Docker container
- How frontend applications are served using Nginx in production

---

## 🧱 Tech Stack Used

- **React** – Frontend framework
- **Node.js** – Used only for building the React app
- **Docker** – Containerization
- **Nginx** – Serving production build
- **AWS EC2** – (Used during implementation, not required to run locally)

---

## 📂 Project Structure
dockerize-react-app/
├── Dockerfile
├── .dockerignore
├── package.json
├── package-lock.json
├── public/
└── src/

---

## 🐳 Docker Approach (Important)

This project uses a **multi‑stage Docker build**, which is the industry‑recommended way for frontend applications.

### Stage 1 – Build
- Uses a Node.js image
- Installs dependencies
- Builds the React app into static files

### Stage 2 – Serve
- Uses a lightweight Nginx image
- Serves the production build
- No Node.js in the final image (smaller and faster)

---

## ✅ Prerequisites

Before running this project, make sure you have:

- Docker installed  
  👉 https://docs.docker.com/get-docker/

No need to install Node.js locally if you only want to run the Docker container.

---

## 🚀 How to Run This Project (Docker Way)

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/12AnshulAgarwal/dockerize-react-app.git
cd dockerize-react-app
