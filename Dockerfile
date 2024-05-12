ARG JAVA_VERSION=21

FROM eclipse-temurin:$JAVA_VERSION-jdk AS buildtools

ENV BUILDTOOLS_URL https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

WORKDIR /workdir

RUN apt-get update \
    && apt-get install -y git curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -o BuildTools.jar $BUILDTOOLS_URL \
    && git clone https://hub.spigotmc.org/stash/scm/spigot/builddata.git BuildData \
    && git clone https://hub.spigotmc.org/stash/scm/spigot/bukkit.git Bukkit \
    && git clone https://hub.spigotmc.org/stash/scm/spigot/craftbukkit.git CraftBukkit \
    && git clone https://hub.spigotmc.org/stash/scm/spigot/spigot.git Spigot

ARG SPIGOT_VERSION=1.20.6
ARG ARGS=""

RUN java -jar BuildTools.jar --rev ${SPIGOT_VERSION} ${ARGS}

CMD [ "/bin/sh" ]
