FROM openjdk:8

LABEL maintainer="sanskarram992@gmail.com" version="1.0" description="This is a sample Docker image"

WORKDIR /home/ubuntu/app

ENV MAVEN_VERSION=3.8.3
ENV MAVEN_HOME=/opt/maven
ENV PATH=$MAVEN_HOME/bin:$PATH

# Install dependencies and Maven
RUN apt-get update
RUN apt-get install -y wget unzip
RUN wget https://archive.apache.org/dist/maven/maven-3/3.8.3/binaries/apache-maven-3.8.3-bin.zip
RUN unzip apache-maven-3.8.3-bin.zip -d /opt
RUN rm apache-maven-3.8.3-bin.zip
RUN mv /opt/apache-maven-3.8.3 $MAVEN_HOME

RUN mvn -version

COPY ./pom.xml /home/ubuntu/app/pom.xml
COPY ./src /home/ubuntu/app/src



RUN mvn clean install


EXPOSE 8080

RUN mv /home/ubuntu/app/target/demo-0.0.1-SNAPSHOT.jar /home/ubuntu/app/target/demo.jar

CMD ["java", "-jar", "target/demo.jar"]