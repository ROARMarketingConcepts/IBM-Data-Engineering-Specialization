-- Week 2:  MongoDB Commands

wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu1804-x86_64-100.5.2.tgz

tar -zxvf mongodb-database-tools-ubuntu1804-x86_64-100.5.2.tgz

export PATH="/home/project/mongodb-database-tools-ubuntu1804-x86_64-100.5.2/bin:$PATH"

-- The issue with start_mongo command, might occur if your mongo is already running in the background. So, terminate the running mongo and try again.
-- If you want to start a new mongo server, you have to delete the containers created and run the start_mongo command.  Follow the below steps to delete the containers and restart the mongo server: 

-- View the running containers using this command and use the container id for the following command: 

docker container ps -a  

-- Delete the running container using this command: 

docker container rm <container id> <container id >  

-- And finally, use start_mongo again.  