FROM zlim/bcc

RUN apt-get -y -qq update && apt-get -y -qq install gcc make bison flex bc libelf-dev vim

COPY start.sh /usr/local/bin/start

CMD ["start"]