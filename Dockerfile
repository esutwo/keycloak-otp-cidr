FROM jboss/keycloak:15.0.2 as build

ARG CI_MAVEN_VERSION=3.8.4

COPY . /build

USER 0

RUN cd /tmp && \
    curl --output maven.tar.gz https://archive.apache.org/dist/maven/maven-3/3.8.4/binaries/apache-maven-${CI_MAVEN_VERSION}-bin.tar.gz && \
    tar xvf maven.tar.gz && \
    cd /build && \
    /tmp/apache-maven-${CI_MAVEN_VERSION}/bin/mvn package -Dhttps.protocols=TLSv1.2

FROM jboss/keycloak:15.0.2

COPY --from=build /build/target/keycloak-advconditionalmfa.jar /opt/jboss/keycloak/standalone/deployments/
