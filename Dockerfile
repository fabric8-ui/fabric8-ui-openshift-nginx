FROM registry.centos.org/bamachrn/nginx-header:latest
MAINTAINER "Pete Muir <pmuir@bleepbleep.org.uk>"

ENV LANG=en_US.utf8

USER root
ADD root /

# Add the templater to run.sh
RUN sed -i '2s/^/\/template.sh \/usr\/share\/nginx\/html \n/' /run.sh

RUN rm /usr/share/nginx/html/*

RUN chown 997 /run.sh /template.sh
RUN chmod u+x /run.sh /template.sh
RUN chown -R 997 /usr/share/nginx/html

USER 997
