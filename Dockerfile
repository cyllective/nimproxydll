FROM nimlang/nim:1.6.14-ubuntu

RUN apt update 
RUN apt install build-essential gcc-mingw-w64 -y --no-install-recommends
RUN apt install python3-pefile python3-future -y --no-install-recommends

RUN mkdir /app
COPY dllproxy.nim /app
COPY gen_def.py /app/
COPY entrypoint.sh /app/

ARG USERID=1000
RUN useradd -m -s /bin/sh -u ${USERID} nim
RUN chown -R nim /app

USER nim
RUN nimble install winim -y

WORKDIR /app

ENTRYPOINT ["sh", "/app/entrypoint.sh"]