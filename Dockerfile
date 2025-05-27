#stage1
FROM registry.access.redhat.com/ubi9/openjdk-21:latest as builder

COPY --chown=185 pom.xml pom.xml
COPY --chown=185 src src

RUN mvn clean package

#stage2
FROM registry.access.redhat.com/ubi9/openjdk-21-runtime:latest

#COPY . .
COPY --from=builder /home/default/target .
EXPOSE 8080
ENTRYPOINT ["java","-jar","/home/default/quarkus-app/quarkus-run.jar","-Djava.net.preferIPv4Stack=true"]