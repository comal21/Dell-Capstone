1. **Clone the GitHub Repository onto your jumpserver**:
    ```sh
    git clone https://github.com/comal21/Dell-Capstone.git
    ```

2. **Navigate to the Dell-Capstone Directory**:
    ```sh
    cd Dell-Capstone
    ```

3. **Build the Docker image using the available Dockerfile**:
    ```sh
    docker build -t mywebapp:v1 .
    ```

4. **Push the Docker image to your Docker Hub account**:
    ```sh
    docker login
    docker tag mywebapp:v1 <your-dockerhub-username>/mywebapp:v1
    docker push <your-dockerhub-username>/mywebapp:v1
    ```

5. **Create a deployment YAML file**:
    ```sh
    vi deploy.yml
    ```

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: mywebapp
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: mywebapp
      template:
        metadata:
          labels:
            app: mywebapp
        spec:
          containers:
          - name: mycon1
            image: <your-dockerhub-username>/mywebapp:v1
            ports:
            - containerPort: 80
    ```

6. **Apply the deployment**:
    ```sh
    kubectl apply -f deploy.yml
    ```

7. **Create a LoadBalancer service YAML file**:
    ```sh
    vi service.yaml
    ```

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: mywebapp-service
    spec:
      selector:
        app: mywebapp
      ports:
        - protocol: TCP
          port: 8085
          targetPort: 80
      type: LoadBalancer
    ```

8. **Apply the service**:
    ```sh
    kubectl apply -f service.yaml
    ```

9. **Retrieve the external IP of the service**:
    ```sh
    kubectl get services mywebapp-service
    ```

10. **Access the application**:
    Open a browser and navigate to `http://<EXTERNAL-IP>:8085`.

***Note: Make sure 8085 port number is open on the worker nodes security group
