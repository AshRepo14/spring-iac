# build the application
FROM maven:3.8.4 AS build2
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# run the application
FROM openjdk:21-slim-buster
WORKDIR /app
# Copy the built JAR file from the build stage
COPY --from=build /app/target/myApp-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
