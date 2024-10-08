# test-springboot-application
Pre-requisites: 


1. First, i have created the EKS Cluster and ALB ingress controller using terraform in separate pipeline, and also created the ECR repository in console to store the docker images.
2. From the site https://start.spring.io/ , downloaded the java with maven with below inputs.

   <img width="845" alt="image" src="https://github.com/user-attachments/assets/77661b62-3695-4a39-9db9-eb8fb501746d">

3. Created the sonar cloud account in sonarcloud.io to perform the code coverage of the code, with the project details, also created the sonar token to authenticate with github.
4. Created the secrets under repository settings for sonar token.
5. Also created the custom quality gates and set as default with the threshold value of 85% as requested, to meet the required criteria as requested. please find the screenshot below for threshold value for reference.

 <img width="1701" alt="image" src="https://github.com/user-attachments/assets/ecebaf68-c478-4e4c-ba56-8090fb613256">


Implementation:

I have ensured the below steps in sequence for the application build process and create the docker images. 

AssumeRoleandcallidentity ( to authenticate to the aws cloud without access key and secret key ) .

gitleaks ( to check if there are any hardcoded secrets or values in git repo. 

sonarscan (to perform the code coverage with expectation criteria of 85% as threshold value) .

appbuild ( to build the application and create the artifacts, create the docker image and push to ECR ).

deploy ( this would call the shell script as requested, which is placed at the root directory with name deploy-app.sh , this script has the steps to use helm and deploy the application. Here i have added the checks to avoid the release names if already present to delete and recreate, as we cannot have same release name more than once, else the pipeline will break ).

<img width="366" alt="image" src="https://github.com/user-attachments/assets/722b8edc-9302-48e7-80d9-eb5a5bc52872">


In the shell script, also i have added step to wait for 20 seconds, so that pods are completely up and we can see the output as running as expected. I have also added the ingress output to see the alb added in ADDRESS field, please find the screenshot below for reference. 

<img width="1060" alt="image" src="https://github.com/user-attachments/assets/1698b5b1-f0d1-4425-a19d-47130760d3df">

LB created as below with the tags in console : 

![image](https://github.com/user-attachments/assets/9590d086-78c7-452f-9b3b-b6316f8dd9c9)


We can then test the application using value of address in ingress output. Please find the screenshot from the ingress output above to fetch the lb details.

Below is the URL to access our springboot application, we need to append the /welcome at the end of the url. 

![image](https://github.com/user-attachments/assets/d26ac199-2dad-4563-a317-4d03e85cbe35)


