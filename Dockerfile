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

RUN chown nginx /run.sh /template.sh
RUN chmod u+x /run.sh /template.sh
RUN chown -R nginx /usr/share/nginx/html
RUN chown -R nginx /var/log/nginx

USER nginx
