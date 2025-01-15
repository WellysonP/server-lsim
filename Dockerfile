FROM ubuntu:latest
LABEL authors="wellyson"

# Etapa 1: Usar uma imagem Gradle para construir o JAR
FROM gradle:8.3-jdk17 AS builder

WORKDIR /app

# Copiar os arquivos do projeto
COPY . .

# Rodar o build para gerar o JAR
RUN ./gradlew bootJar

# Etapa 2: Usar uma imagem mais leve para rodar o aplicativo
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copiar o JAR da etapa de build
COPY --from=builder /app/build/libs/server-0.0.1-SNAPSHOT.jar /app.jar

EXPOSE 8761

ENTRYPOINT ["java", "-jar", "/app.jar"]

