FROM ubuntu:latest
LABEL authors="wellyson"

FROM gradle:8.3-jdk17 AS builder

WORKDIR /app

COPY . .

RUN ./gradlew bootJar

FROM eclipse-temurin

WORKDIR /app

EXPOSE 8761

COPY --from=builder /app/build/libs/server-0.0.1-SNAPSHOT.jar /app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]