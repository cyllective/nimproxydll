FROM nimlang/nim:1.6.18-ubuntu

RUN apt update 
RUN apt install gcc-mingw-w64 -y --no-install-recommends
RUN apt install python3-pefile python3-future -y --no-install-recommends

COPY app /app
WORKDIR /app

ARG USERID=1000
RUN useradd -m -s /bin/sh -u ${USERID} nim
RUN chown -R nim /app

USER nim
RUN nimble install winim -y

ENTRYPOINT ["/bin/sh" ,"/app/run.sh"]