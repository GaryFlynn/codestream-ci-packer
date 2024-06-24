FROM sammcgeown/codestream-ci:latest
LABEL maintainer="contact@garyflynn.com"

ENV PACKER_VER=1.11.0
ENV WINUPDATE_VER=0.10.1

# Install jq
RUN     yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
        yum install jq -y

RUN     wget -q https://releases.hashicorp.com/packer/${PACKER_VER}/packer_${PACKER_VER}_linux_amd64.zip && \
        unzip packer_${PACKER_VER}_linux_amd64.zip && \
        mv -f packer /usr/local/bin/

RUN     wget -q https://github.com/rgl/packer-provisioner-windows-update/releases/download/v${WINUPDATE_VER}/packer-provisioner-windows-update_${WINUPDATE_VER}_linux_amd64.tar.gz && \
        tar xf packer-provisioner-windows-update_${WINUPDATE_VER}_linux_amd64.tar.gz && \
        mv -f packer-provisioner-windows-update /usr/local/bin/

ADD     https://github.com/rgl/packer-provisioner-windows-update/releases/download/v${WINUPDATE_VER}/packer-provisioner-windows-update_${WINUPDATE_VER}_linux_amd64.tar.gz /tmp/packer-provisioner-windows-update-linux.tar.gz

RUN     /bin/bash -c 'tar -xf /tmp/packer-provisioner-windows-update-linux.tar.gz -C /usr/local/bin/ && chmod 755 /usr/local/bin/packer-provisioner-windows-update'

RUN     /bin/bash -c 'cd /usr/local/bin/; ls -la; chmod +x /usr/local/bin/packer-provisioner-windows-update; ls -la'