FROM maven:3.8.4-openjdk-17-slim AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

FROM openjdk:17-slim

COPY --from=build /app/target/eureka-server-0.0.1-SNAPSHOT.war /app/
WORKDIR /app

CMD ["java", "-jar", "eureka-server-0.0.1-SNAPSHOT.war"]