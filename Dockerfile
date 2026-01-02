FROM mcr.microsoft.com/dotnet/runtime:latest
RUN apt-get update && apt-get install -y curl unzip bash
WORKDIR /

ADD "https://api.github.com/repos/tModLoader/tModLoader/releases/latest" /tmp/release.json
RUN ZIP_URL=$(cat /tmp/release.json | grep browser_download_url | grep "tModLoader.zip" | cut -d '"' -f 4) && \
    echo $ZIP_URL && \
    curl -L -o tModLoader.zip $ZIP_URL && \
    unzip /tModLoader.zip -d /tModLoader && \
    rm tModLoader.zip && \
    chmod +x /tModLoader/start-tModLoaderServer.sh

WORKDIR /tModLoader
EXPOSE 7777 7878

CMD ["./start-tModLoaderServer.sh", "-nosteam"]