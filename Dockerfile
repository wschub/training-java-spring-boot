#Etapa 1: Build con Gradle 8.14.2 y JDK 21 (compilacion)
FROM gradle:8.14.2-jdk-21 AS build
COPY --chown=gradle:gradle . /app
WORKDIR /app
RUN gradle bootJar --no-daemon

#Etapa 2: Runtime con JDK 21  (eclipse-temurin) (ejecución)
FROM eclipse-mosquitto:21-jdk
WORKDIR /app
COPY --from=build /app/build/libs/*.jar platzi_play.jar
EXPOSE 8080
ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "platzi_play.jar"]