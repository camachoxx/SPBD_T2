This is the 2nd lab work for the course SPBD (Systems for Big Data Processing)

# HIVE
This lab consist mainly on the usage of Hive.

# Running scripts (for evaluation)

Before running anything please download the dataset with the name 'txis.csv' into the root directory of the project

Then, please first run the script **create_taxis_table.sql** to load the dataset.

Only then try the scripts from the exercises.


## Docker

The container to run this lab is **prasanthj/docker-hive-on-tez**

You can download it using:

```
docker pull prasanthj/docker-hive-on-tez
```

Also you have to run the following command (**just once**) to execute the image on a shared folder with your computer. Don't forget to change <path_to_local_folder> with the path to the folder of your computer:

```
docker run -v <path_to_local_folder>:/root/work --name docker-hive-on-tez -it -P prasanthj/docker-hive-on-tez /etc/hive-bootstrap.sh -bash
```

Finally, to run the container in the future on the share folder you can use the following bash command:

```
docker run -v  <path_to_local_folder>:/root/work prasanthj/docker-hive-on-tez
```

### docker work directory

```
root/work
```

### Run Hive Scripts
```
hive -f <file>
```
