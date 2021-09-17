#!/bin/sh

minikube stop
minikube delete
minikube start --vm-driver=virtualbox --cpus=4 --memory=4G --disk-size=50G

#Установка minikube и metallb
eval $(minikube docker-env)
minikube addons enable metallb
minikube addons enable metrics-server

#Установка nginx
docker build -t nginx-image srcs/nginx
kubectl apply -f ./srcs/configmap.yaml
kubectl apply -f ./srcs/nginx/nginx.yaml

#Установка mysql
docker build -t mysql-image srcs/mysql
kubectl apply -f ./srcs/mysql/mysql.yaml

#Установка phpmyadmin
docker build -t phpmyadmin-image srcs/phpmyadmin
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml

#Установка wordpress
docker build -t wp-image srcs/wordpress
kubectl apply -f ./srcs/wordpress/wordpress.yaml

#Установка ftps
docker build -t ftps-image srcs/ftps
kubectl apply -f ./srcs/ftps/ftps.yaml

#Установка influxdb
docker build -t influxdb-image srcs/influxdb
kubectl apply -f ./srcs/influxdb/influxdb.yaml

#Установка grafana
docker build -t grafana-image srcs/grafana
kubectl apply -f ./srcs/grafana/grafana.yaml

#Вызов dashboard
minikube dashboard
