# Stage 1: Use Maven for building
From maven:3.8.5-openjdk-17-slim as build
WORKDIR /app
COPY . ./ems-backend
WORKDIR /app/ems-backend
RUN mvn clean package -DskipTests

# Stage 2: Use OpenJDK for running
From eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/ems-backend/target/*.jar ems-backend.jar
Expose 8080
ENTRYPOINT ["java","-jar","ems-backend.jar"]