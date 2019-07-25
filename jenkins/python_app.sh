#!/bin/sh
docker stop flaskapp
docker rm flaskapp
docker pull shariqrizvi/flaskapp
docker run -d --name flaskapp -p5000:5000 shariqrizvi/flaskapp