FROM registry.centos.org/bamachrn/nginx-header:latest
MAINTAINER "Pete Muir <pmuir@bleepbleep.org.uk>"

ENV LANG=en_US.utf8

USER root
ADD root /

# Clear out the default config
RUN rm -rf /etc/nginx/conf.d/default.conf

# Add the templater to run.sh
RUN sed -i '2s/^/\/template.sh \/usr\/share\/nginx\/html \n/' /run.sh

RUN rm /usr/share/nginx/html/*

ENV FABRIC8_USER_NAME=fabric8
RUN useradd --no-create-home -s /bin/bash ${FABRIC8_USER_NAME}

RUN chmod +rx /run.sh /template.sh
RUN chmod -R +r /usr/share/nginx/html
RUN chmod -R +rw /var/log/nginx

USER ${FABRIC8_USER_NAME}
