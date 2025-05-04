#!/bin/bash


<< task
deploy a jango app and handle the code for errors

task

code_clone(){
        echo "cloning the Django app..."
        git clone https://github.com/LondheShubham153/django-notes-app.git
}

install_requirements(){
        echo "installing dependencies"
        sudo apt update -y
        sudo apt-get install docker.io nginx -y docker-compose
}

required_restarts(){
        sudo chown $USER
        sudo systemctl enable docker
        sudo systemctl enable nginx
        sudo systemctl restart docker
}

deploy(){
        sudo docker build -t notes-app .
        #sudo docker run -d -p 8000:8000 notes-app:latest
	cd ~/django-notes-app

	sudo docker-compose up -d
}

echo "******* Deployment Started **********"
if ! code_clone; then
        echo " the code already exisits"
        cd django-notes-app
fi
if ! install_requirements; then
        echo "Installation Failled*************************"
        exit 1
fi
if ! required_restarts; then
        echo "System fault identified**********"
        exit 1
fi
deploy

echo "*********Deployment done************"


