FROM python:3.7-stretch
LABEL MAINTAINER "amaya <mail@sapphire.in.net>"

COPY . /opt/k8s-debugkit
WORKDIR /opt/k8s-debugkit
ADD root/.bashrc /root/.bashrc
ADD root/.vimrc /root/.vimrc
ENV HOME /root

# Set timezone
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN set -eux && \
    pip install -r requirements.txt && \
    wget https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
      -O /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    apt update && \
    apt install -y nano vim emacs build-essential software-properties-common \
                   pwgen python3-pip python mlocate awscli apt-transport-https \
                   ca-certificates gnupg tig ncdu oathtool mtr pigz gpa tree vim net-tools sudo \
                   iputils-ping telnet netcat tcpdump nmap \ 
                   dnsutils traceroute curl git htop man unzip vim wget && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["./run.sh"]
