FROM openjdk:21-jdk-slim
COPY my-app-artifact/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]