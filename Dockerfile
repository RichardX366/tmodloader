FROM mcr.microsoft.com/dotnet/runtime:latest
RUN apt-get update && apt-get install -y curl unzip bash
WORKDIR /

RUN RELEASE_URL="https://api.github.com/repos/tModLoader/tModLoader/releases/latest" && \
    ZIP_URL=$(curl -s $RELEASE_URL | grep browser_download_url | grep "tModLoader.zip" | cut -d '"' -f 4) && \
    curl -L -o tModLoader.zip $ZIP_URL && \
    unzip /tModLoader.zip -d /tModLoader && \
    rm tModLoader.zip && \
    chmod +x /tModLoader/start-tModLoaderServer.sh

WORKDIR /tModLoader
EXPOSE 7777 7878

CMD ["./start-tModLoaderServer.sh"]