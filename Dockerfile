FROM alpine/git
WORKDIR /clone
RUN git clone https://github.com/sbarraarias/spring-petclinic --single-branch -b dev-sbarra

FROM maven:alpine
WORKDIR /build
COPY --from=0 /clone/spring-petclinic .
RUN mvn install && mv target/spring-petclinic-*.jar target/spring-petclinic.jar

#from 0 for git
#from 1 for mvn
FROM openjdk:jre-alpine
WORKDIR /app
COPY --from=1 /build/target/spring-petclinic.jar .


ENTRYPOINT ["java","-jar"]
CMD ["spring-petclinic.jar"]

