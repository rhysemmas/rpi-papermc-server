FROM eclipse-temurin:17-focal

WORKDIR /app

ENV PAPER_VERSION=1.20.1
ENV PAPER_BUILD=100

RUN curl "https://api.papermc.io/v2/projects/paper/versions/${PAPER_VERSION}/builds/${PAPER_BUILD}/downloads/paper-${PAPER_VERSION}-${PAPER_BUILD}.jar" \
    --output "paper.jar"

COPY ./config/* .
COPY ./plugins ./plugins

RUN useradd -ms /bin/bash paper && \
    chown -R paper:paper /app

USER paper

CMD java -Xms2G -Xmx2G \
         -XX:+UseG1GC \
         -XX:+ParallelRefProcEnabled \
         -XX:MaxGCPauseMillis=200 \
         -XX:+UnlockExperimentalVMOptions \
         -XX:+DisableExplicitGC \
         -XX:+AlwaysPreTouch \
         -XX:G1NewSizePercent=30 \
         -XX:G1MaxNewSizePercent=40 \
         -XX:G1HeapRegionSize=8M \
         -XX:G1ReservePercent=20 \
         -XX:G1HeapWastePercent=5 \
         -XX:G1MixedGCCountTarget=4 \
         -XX:InitiatingHeapOccupancyPercent=15 \
         -XX:G1MixedGCLiveThresholdPercent=90 \
         -XX:G1RSetUpdatingPauseTimePercent=5 \
         -XX:SurvivorRatio=32 \
         -XX:+PerfDisableSharedMem \
         -XX:MaxTenuringThreshold=1 \
         -Dusing.aikars.flags=https://mcflags.emc.gs \
         -Daikars.new.flags=true \
         -jar paper.jar --nogui

EXPOSE 25565 25575
