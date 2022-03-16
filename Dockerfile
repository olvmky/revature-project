FROM jenkins/jenkins:2.319.3-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
    https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
    signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"

#RUN set -eux; \
#    addgroup -S -g 1000 sonarqube; \
#    adduser -S -D -u 1000 -G sonarqube sonarqube; \
#    apk add --no-cache --virtual build-dependencies gnupg unzip curl; \
#    apk add --no-cache bash su-exec ttf-dejavu openjdk11-jre; \
#    # pub   2048R/D26468DE 2015-05-25
#    #       Key fingerprint = F118 2E81 C792 9289 21DB  CAB4 CFCA 4A29 D264 68DE
#    # uid                  sonarsource_deployer (Sonarsource Deployer) <infra@sonarsource.com>
#    # sub   2048R/06855C1D 2015-05-25
#    echo "networkaddress.cache.ttl=5" >> "${JAVA_HOME}/conf/security/java.security"; \
#    sed --in-place --expression="s?securerandom.source=file:/dev/random?securerandom.source=file:/dev/urandom?g" "${JAVA_HOME}/conf/security/java.security"; \
#    for server in $(shuf -e ha.pool.sks-keyservers.net \
#                            hkp://p80.pool.sks-keyservers.net:80 \
#                            keyserver.ubuntu.com \
#                            hkp://keyserver.ubuntu.com:80 \
#                            pgp.mit.edu) ; do \
#        gpg --batch --keyserver "${server}" --recv-keys 679F1EE92B19609DE816FDE81DB198F93525EC1A && break || : ; \
#    done; \
#    mkdir --parents /opt; \
#    cd /opt; \
#    curl --fail --location --output sonarqube.zip --silent --show-error "${SONARQUBE_ZIP_URL}"; \
#    curl --fail --location --output sonarqube.zip.asc --silent --show-error "${SONARQUBE_ZIP_URL}.asc"; \
#    gpg --batch --verify sonarqube.zip.asc sonarqube.zip; \
#    unzip -q sonarqube.zip; \
#    mv "sonarqube-${SONARQUBE_VERSION}" sonarqube; \
#    rm sonarqube.zip*; \
#    rm -rf ${SONARQUBE_HOME}/bin/*; \
#    chown -R sonarqube:sonarqube ${SONARQUBE_HOME} ; \
#    # this 777 will be replaced by 700 at runtime (allows semi-arbitrary "--user" values)
#    chmod -R 777 "${SQ_DATA_DIR}" "${SQ_EXTENSIONS_DIR}" "${SQ_LOGS_DIR}" "${SQ_TEMP_DIR}" ; \
#    apk del --purge build-dependencies;
#
#COPY --chown=sonarqube:sonarqube run.sh sonar.sh ${SONARQUBE_HOME}/bin/
#
#WORKDIR ${SONARQUBE_HOME}
#EXPOSE 9000
#
#STOPSIGNAL SIGINT
#
#ENTRYPOINT ["/opt/sonarqube/bin/run.sh"]
#CMD ["/opt/sonarqube/bin/sonar.sh"]
