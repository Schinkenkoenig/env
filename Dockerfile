FROM ubuntu:focal as base
WORKDIR /root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common sudo wget curl git build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base as nilsse
ARG TAGS
RUN addgroup --gid 1000 nilsse 
RUN adduser nilsse --uid 1000 --gid 1000 
RUN echo "nilsse:vokuhila" | chpasswd
RUN echo "nilsse ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/nilsse

USER nilsse 
WORKDIR /home/nilsse 

FROM nilsse
COPY --chown=nilsse:nilsse . .


CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]















