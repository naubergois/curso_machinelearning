## About

This repository contains assigments completed for the Udacity Deep Learning Machine Learning Class.  All assignments are done using TensorFlow on Docker on Windows. I'll eventually add the steps to do this as it was quite detailed.

## Docker tips 

**Getting docker setup on Windows:**

----

Step 1: Dowload the docker toolbox from: https://www.docker.com/products/docker-toolbox

Step 2: Open the Docker Quickstart Terminal and the default docker machine will start

Step 3: Stop this machine by running this command ``` docker-machine stop default ```

Step 4: You'll need to create a new docker machine with more memory for class. Use the command below.


``` docker-machine create -d virtualbox --virtualbox-memory 8196 <docker-name> ```


Make sure to provide a name of your choosing for the last arguement above.  I named mine tensorflow like below. 


``` docker-machine create -d virtualbox --virtualbox-memory 8196 tensorflow ```


Step 5: Start the docker-machine by the following command ``` docker-machine start <docker-name> ```



**To have docker save the files after you close and restart the machine, this was the best solution I found:**

----

After you've created you docker machine above get your docker machine ip

``` docker-machine ip ```


The first time you run/pull the docker file from the google repo give it a name

``` docker run -p 8888:8888 -d --name tfudacity b.gcr.io/tensorflow-udacity/assignments ```


You can then start this docker by name everytime after by simply running this command in the Quickstart Terminal:

``` docker start tfudacity ```

It will look like it's not doing anything but if you visit


``` <docker_ip>:8888 ```


in your browser the jupyter tree will be there with your files. 


To stop the docker: 

``` docker stop tfudacity ```

