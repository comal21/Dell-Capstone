***Objective: Deploy a web application using Docker and Kubernetes***

**Clone the GitHub Repository using the following URL: https://github.com/comal21/Dell-Capstone.git

*** Modify Application Content:
* Navigate to the "/Dell-Capstone/www" directory
* Remove the existing image.
* Download an image of your choice using wget <ImageURL>
* Rename the image as logo.png

*** Build and Push Docker Image:
* Build the Dockerfile to get a Docker image named mywebapp:v1.
* Push the image to your Docker Hub registry.

*** Namespace
* Create a namespace called: capstone
* Verify the creation of the namespace

*** Create a Kubernetes Deployment:
* Deploy the application using the Docker image from Docker Hub.
* Ensure the deployment has the following details:
* Deployment Name: mywebapp
* Replica Count: 3
* Container Name: mycon1
* Label: app=mywebapp
* Namespace: capstone

*** Expose the Application Using a LoadBalancer Service:
* Create a LoadBalancer service to expose the deployment.
* Ensure the service has the following details:
* Service Name: mywebapp-service
* Namespace: capstone
The service should listen on port 8085.

Access the Application:
* Retrieve the external IP of the service.
* Open a browser and access the application via http://<EXTERNAL-IP>:8085.

Sample output:
![image](https://github.com/user-attachments/assets/1437a20c-fc91-4a32-8f00-cf2e7a1cea8f)
