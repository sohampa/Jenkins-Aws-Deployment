# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file to the container
COPY target/restapidemo-0.0.1-SNAPSHOT.jar restapidemo-0.0.1-SNAPSHOT.jar

# Expose the application port (optional, if your app runs on a specific port)
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "restapidemo-0.0.1-SNAPSHOT.jar"]
