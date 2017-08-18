FROM registry.centos.org/kbsingh/openshift-nginx:1.10.2
LABEL maintainer "Devtools <devtools@redhat.com>"

ENV LANG=en_US.utf8

USER root

RUN yum -y install gettext && yum clean all

ADD root /

# Clear out the default config
RUN rm -rf /etc/nginx/conf.d/default.conf

RUN rm /usr/share/nginx/html/*

## Added to stop the cache
RUN mkdir /var/cache/nginx

ENV FABRIC8_USER_NAME=fabric8
RUN useradd --no-create-home -s /bin/bash ${FABRIC8_USER_NAME}

RUN chmod +rx /run.sh /template.sh
RUN chmod -R +r /usr/share/nginx/html
RUN chmod -R +rw /var/log/nginx
RUN chmod -R a+rw /etc/nginx
RUN chmod -R a+rw /var/cache/nginx

# Add the templater to run.sh
RUN sed -i "2s/^/\/template.sh \/usr\/share\/nginx\/html\nVARS='\$PROXY_PASS_URL' \/template.sh \/etc\/nginx\/nginx.conf  \n/" /run.sh

VOLUME /var/cache/nginx

USER ${FABRIC8_USER_NAME}
