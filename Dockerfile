ARG IMAGE=containers.intersystems.com/intersystems/iris-community:latest-cd
FROM $IMAGE

USER root
WORKDIR /opt/src
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/src
USER ${ISC_PACKAGE_MGRUSER}

# ビルド中に実行したいスクリプトがあるファイルをコンテナにコピーしています
COPY iris.script .
COPY requirements.txt .
COPY src .

# IRISを開始し、IRISにログインし、iris.scriptに記載のコマンドを実行しています
RUN iris start IRIS \
    && iris session IRIS < iris.script \
    && iris stop IRIS quietly \
    && pip install -r requirements.txt --break-system-packages