# test-springboot-application


This project is to deploy the springboot application onto EKS Cluster.

**For storing the state file, i have used s3 bucket, please refer the terraform block for the s3 bucket details in backend section.**

Please find the below steps followed to build this project. 

1. First, Create the infrastructure using terraform , please find the source code in this git repository under eks directory.
2. In the next stage, we are building the application generated from the website https://start.spring.io/ with the below details.
    <img width="1514" alt="image" src="https://github.com/user-attachments/assets/794de233-f2ea-4f07-92c9-68f09078e2b0">

3. download the zip file and extract it.
4. We will have the pom.xml file to build our application.

   Issues faced - i have faced ** White label error page here ** initially while i was testing with image i built using single docker container, i was unable to access webpage. i have modified the file src/main/java/com/docker/springboot/SpringbootApplication.java to have /welcome as the mapping to provide as url to access my webpage. ** 
   
6. Once the application is built, with the help of sonar scanner ( please create a project from url  https://sonarcloud.io/ to scan for code coverage, i have added the organization and project usecase in main.yml file )

Please find the screenshot of the report in sonarcloud scanner. 

<img width="1728" alt="image" src="https://github.com/user-attachments/assets/7db71b49-a365-49e4-85b0-6feb73dc4b3e">

   
7. We need to dockerize the application using dockerfile present in this repository, with the help of docker, i have created the image and tagged the image so that we can push the image to ECR.

8. For storing the images, this project uses ECR in AWS cloud. Once the docker images are created in pipeline, images would be pushed to ECR.
9. We have also scanned the docker images using apache trivy to look for vulnerabilities.

    **Here i am getting the vulnerability with the packages for glibc,glibc-minimal-langpack,glibc-common,libgcc,libgcrypt,libnghttp2,libstdc++ and openssl-libs for the patches , i have tried to pickup the latest image from dockerhub which is updated 2 days back, mentioning it has 0 vulnerabilities, today i could see these with lower version compared to one's updated in CVE database of trivy. we may need to see it after few days if it gets updated with the new one's** 

 Reference image used for testing, with the below image, vulnerability is reduced to count as 1.
 
 <img width="1395" alt="image" src="https://github.com/user-attachments/assets/87eba19e-af15-4379-9894-0585dabbd328">


reference from scan report :

  <img width="1395" alt="image" src="https://github.com/user-attachments/assets/44048293-81af-4110-ad60-926004762ccb">


   **for testing i have mentioned severity as LOW (reference line number 175 in yml file)** 
    
   
11. once  the Images are scanned , we can then proceed to the next step to deploy the image on to the EKS cluster, we have a directory called manifests.
    
 **I have used the helm to deploy the application, using the shell script, please modify the variable values in the shell script accordingly.** 

 I have added the command in the pipeline main.yml file to execute the shell script to deploy application using helm charts.


To Verify the application in the browser, copy the LB DNS Name and append /welcome at the end, to test the application. please find the screenshot below for reference.

<img width="1488" alt="image" src="https://github.com/user-attachments/assets/524b4b2e-d5ff-4ff9-94e0-d55b7240ec7e">









