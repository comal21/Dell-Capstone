### Objective: Deploy a Web Application Using Docker and Kubernetes

1. **Clone the GitHub Repository**:
    - Retrieve the repository from the following URL: https://github.com/comal21/Dell-Capstone.git

2. **Modify Application Content**:
    - Navigate to the `/Dell-Capstone/www` directory.
    - Remove the existing image.
    - Download an image of your choice using `wget <ImageURL>`.
    - Rename the image as `logo.png`.

3. **Build and Push Docker Image**:
    - Build the Dockerfile to get a Docker image named `mywebapp:v1`.
    - Push the image to your Docker Hub registry.

4. **Create a Namespace**:
    - Create a namespace called `capstone`.
    - Verify the creation of the namespace.

5. **Create a Kubernetes Deployment**:
    - Deploy the application using the Docker image from Docker Hub.
    - Ensure the deployment has the following details:
        - **Deployment Name**: `mywebapp`
        - **Replica Count**: 3
        - **Container Name**: `mycon1`
        - **Label**: `app=mywebapp`
        - **Namespace**: `capstone`

6. **Expose the Application Using a LoadBalancer Service**:
    - Create a LoadBalancer service to expose the deployment.
    - Ensure the service has the following details:
        - **Service Name**: `mywebapp-service`
        - **Namespace**: `capstone`
        - The service should listen on port `8085`.

7. **Access the Application**:
    - Retrieve the external IP of the service.
    - Open a browser and access the application via `http://<EXTERNAL-IP>:8085`.

#### Sample Output:
![image](https://github.com/user-attachments/assets/2367dd63-0584-4400-a8cb-3dbc2936974c)
