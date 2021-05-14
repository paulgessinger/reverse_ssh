FROM debian:10

RUN apt-get update \
    && apt-get install -y openssh-client autossh \
	&& apt-get clean

COPY run.sh /run.sh


RUN echo "$SSH_HOST:${SSH_PORT}"

RUN mkdir ~/.ssh && ssh-keyscan -H -p $SSH_PORT $SSH_HOST >> ~/.ssh/known_hosts

CMD ["/run.sh"]
