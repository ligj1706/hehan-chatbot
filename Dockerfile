FROM maven:3.8.1-jdk-8-slim as builder

MAINTAINER hehan

# Copy local code to the container image.
WORKDIR /app
COPY pom.xml .
COPY . .

# Build a release artifact.
RUN mvn package -DskipTests

# 声明环境变量，这样容器就可以在运行时访问它们
ENV OPENAI_MODEL=gpt-3.5-turbo
ENV OPENAI_API_KEY=你的API_KEY
ENV ZSXQ_COOKIE=你的星球Cookie
ENV ZSXQ_GROUP_ID=你的星球id
# 是否只提醒提问者
ENV ZSXQ_SILENCED=true
ENV SPRING_PROFILES_ACTIVE=prod

EXPOSE 8080

# Run the web service on container startup.
ENTRYPOINT ["java","-jar","/app/start/target/start-1.0-SNAPSHOT.jar"]