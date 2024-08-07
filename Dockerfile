FROM openjdk:8-jdk-alpine

LABEL maintainer="sanskarram992@gmail.com" version="1.0" description="This is a sample Docker image"

WORKDIR home/ubuntu/app
RUN sudo apt-get update && \
    sudo apt-get install -y wget unzip && \
    wget https://downloads.apache.org/maven/maven-3/3.8.3/binaries/apache-maven-3.8.3-bin.zip && \
    unzip apache-maven-3.8.3-bin.zip && \
    mv apache-maven-3.8.3 /usr/local/maven && \
    ln -s /usr/local/maven/bin/mvn /usr/bin/mvn

RUN mvn -version

COPY ./pom.xml home/ubuntu/app
COPY ./src home/ubuntu/app/src

RUN mvn clean install
EXPOSE 8080

RUN mv /home/ubuntu/app/target/demo-0.0.1-SNAPSHOT.jar /home/ubuntu/app/target/demo.jar

CMD ["java", "-jar", "target/demo.jar"]