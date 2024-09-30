FROM openjdk:24-oraclelinux8
WORKDIR /app
COPY target/springboot-0.0.1-SNAPSHOT.jar /app
EXPOSE 80
CMD ["java", "-jar", "springboot-0.0.1-SNAPSHOT.jar"]
