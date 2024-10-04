This Docker Set-up is for linux user, 

Docker Installation
```bash
# Update the package list
sudo apt update

# Install necessary packages
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Add Docker's GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository (automatically detect your Ubuntu version)
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update the package list again to include Docker's repository
sudo apt update

# Verify the Docker version available
sudo apt-cache policy docker-ce

# Install Docker
sudo apt install docker-ce -y

```

Before building the Docker file, first install Docker on your OS. After installation, clone the repositories for the CI-3 and Laravel projects and place them in the "/var/www/" path. You should also get a dump file for your local database. Then, clone this repository:  
```bash
cd /home
```
```bash
git clone https://github.com/Markemil1993/DOCKER_SET_UP.git
```

Once cloned, try to build.

Command: 
New version docker
```bash
docker compose up --build -d    
```
or 
Old version docker
```bash
docker-composer up --build -d 
```

to build import db this Variables are need to check:
**mysq_import_process.sh**
```bash
SQL_FILE="viptutor_live_2024-09-13_00-00-01.sql" # if your dump file is not same on this value just change 
DOCKER_CONTAINER="mysql-8-0" # name of mysql container
DB_NAME="viptutors_db" # name of db
MYSQL_USER="root"
MYSQL_PASS="vG7n4AP9NSCmXNLg"
```
Then run the script
```bash
cd /home/DOCKER_SET_UP
```
```bash
bash mysq_import_process.sh
```
Wait until the import finishes. Importing can take a long time, around 2 hours or more, because the database file is almost 8GB or larger. Once the database import is done, just change the configuration for each project.

There are command in need to be remind. 
if you are using docker need to use this command
```bash 
docker ps

# Output
CONTAINER ID   IMAGE                  COMMAND                  CREATED      STATUS       PORTS                                                  NAMES
d2e6b1d352f7   docker_set_up-php8-2   "docker-php-entrypoi…"   3 days ago   Up 3 hours   9000/tcp                                               php8-2
6b1fc7b84dca   nginx                  "/docker-entrypoint.…"   4 days ago   Up 3 hours   0.0.0.0:80-81->80-81/tcp, :::80-81->80-81/tcp          nginx
4c391e1c91ca   docker_set_up-php7-2   "docker-php-entrypoi…"   4 days ago   Up 3 hours   9000/tcp                                               php7-2
a90e4fec6a83   mysql:8.0              "docker-entrypoint.s…"   4 days ago   Up 3 hours   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql-8-0
```
```bash
docker exec -it php8-2 composer update
```
```bash
docker exec -it php8-2 php artisan make:controller SampleController
```

```bash
docker exec -it php8-2 bash
```

host:
```bash
hostname -I | awk '{print $1}'

# Output
192.168.254.120
```
http://192.168.254.120  -> laravel
http://192.168.254.120:81  -> CI - 3 Legacy
