# Stage1: Build Stage
FROM eclipse-temurin:21-jdk-jammy AS builder
WORKDIR /workspace/app

COPY app/gradlew gradlew
COPY app/gradle gradle
COPY app/build.gradle app/settings.gradle ./
COPY app/src src

RUN chmod +x ./gradlew
RUN ./gradlew build --no-daemon

# Stage2: Run Stage
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app

COPY --from=builder /workspace/app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "app.jar" ]
