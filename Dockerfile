# ---------- Stage 1: Build the WAR file using Maven ----------
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory inside the container
WORKDIR /app

# Copy all files into the container
COPY . .

# Build the WAR file and skip tests
RUN mvn clean package -DskipTests


# ---------- Stage 2: Deploy the WAR file to Tomcat ----------
FROM tomcat:9.0.107-jdk17-temurin

# Remove the default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the WAR file from the build stage and rename it to ROOT.war
COPY --from=build /app/target/Food-Hub.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 for access
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
