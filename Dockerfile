FROM eclipse-temurin:17-jdk as build
WORKDIR /app
COPY . .
RUN ./gradlew build -x test
# For Maven, use: RUN mvn package -DskipTests

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
# For Maven, use: COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]