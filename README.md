# rpi-papermc-server

Note: RCON port exposed by container with no password - don't forward to internet

Built with buildx:

`docker buildx build --push  --platform=linux/arm/v7 --tag rhysemmas/papermc:arm32v7 .`
