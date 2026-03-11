# Docker Flask Web App

This project demonstrates containerizing a Flask application using Docker.

## Technologies
- Python
- Flask
- Docker

## Build Image
docker build -t docker-web-app .

## Run Container
docker run -d -p 5000:5000 docker-web-app

## Test
curl http://localhost:5000
