# Build stage
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

# Package stage
FROM openjdk:11-jre
COPY --from=build /home/app/target/spring-petclinic-2.5.0-SNAPSHOT.jar /usr/local/lib/spring-petclinic.jar

ADD https://files.trendmicro.com/products/CloudOne/ApplicationSecurity/1.0.2/agent-java/trend_app_protect-4.3.5.jar trend_app_protect.jar
ADD trend_app_protect.properties trend_app_protect.properties

EXPOSE 8080
ENTRYPOINT ["java","-javaagent:trend_app_protect.jar","-Dcom.trend.app_protect.config.file=trend_app_protect.properties","-jar","/usr/local/lib/spring-petclinic.jar"]
