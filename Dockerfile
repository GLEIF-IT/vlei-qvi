FROM gleif/keri:0.6.7

RUN apt-get update
RUN apt-get install -y vim

RUN useradd -ms /bin/bash qar

USER qar
WORKDIR /home/qar

COPY ./scripts scripts
