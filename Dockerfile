FROM jboss/keycloak:15.0.2 as build

COPY . /build

USER 0

RUN cd /tmp && \
    curl --output maven.tar.gz https://dlcdn.apache.org/maven/maven-3/3.8.2/binaries/apache-maven-3.8.2-bin.tar.gz && \
    tar xvf maven.tar.gz && \
    cd /build && \
    /tmp/apache-maven-3.8.2/bin/mvn package -Dhttps.protocols=TLSv1.2

FROM jboss/keycloak:15.0.2

COPY --from=build /build/target/keycloak-advconditionalmfa.jar /opt/jboss/keycloak/standalone/deployments/
