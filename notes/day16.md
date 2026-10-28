Day 16 - Docker Volumes with MySQL

Date: 28 Oct 2026



What I learned

A container's data is deleted when the container is removed.

A volume keeps the data outside the container, so it survives.

A new container can use the same volume and see the old data.

Commands (run on the EC2, any folder)

Make a volume: docker volume create mysql-vol



List volumes: docker volume ls



Start MySQL with the volume: docker run -d --name mysql-db -v mysql-vol:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=<password> -e MYSQL_DATABASE=testdb mysql



-d runs it in the background

--name mysql-db gives the container a name

-v mysql-vol:/var/lib/mysql links the volume to MySQL's data folder

-e sets settings (root password, first database)

Check the container and its logs: docker ps
 docker ps -a
 docker logs mysql-db



Go inside the container: docker exec -it mysql-db bash



Delete the container (the volume stays): docker rm -f mysql-db



Mistake I made

First run had no password. MySQL refused to start.

I found the reason with docker logs mysql-db.

Fix: remove the container and run again with MYSQL_ROOT_PASSWORD.

Commands inside the container

mysql -u root -p show databases; use testdb; create table students (id int, name varchar(50)); insert into students values (1, 'Amruth'); select * from students; show tables;



The test

Made a table and added rows.

Exited and deleted the container with docker rm -f mysql-db.

Started a new container with the same volume.

Went inside and checked the table. The data was still there.

Where the data lives on the host

sudo ls /var/lib/docker/volumes/mysql-vol/_data



I looked at it with vim in class.

Safer: use ls. It only looks and cannot change files.

In vim: press Esc, type :q, press Enter to leave.

Note to self

Never put real passwords in GitHub notes.








