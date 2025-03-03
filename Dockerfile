# Usa Java 17 si tu proyecto lo necesita
FROM openjdk:17-jdk-slim AS build
WORKDIR /app

# Copia los archivos del proyecto
COPY . .

# Compila el proyecto con Maven
RUN apt-get update && apt-get install -y maven && mvn clean package -DskipTests

# Imagen final
FROM openjdk:17-jre-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Exponer el puerto Eureka (8761)
EXPOSE 8761
ENTRYPOINT ["java", "-jar", "/app.jar"]
