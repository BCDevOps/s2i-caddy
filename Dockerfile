FROM zzrot/alpine-caddy
MAINTAINER shea.phillips@cloudcompass.ca

#LABEL io.openshift.s2i.scripts-url=/tmp/s2i

## Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./.s2i/bin/ /tmp/scripts

# Create the location where we will store our content, and fiddle the permissions so we will be able to write to it.
RUN mkdir -p /var/www/html && chmod 777 /var/www/html

ADD Caddyfile /etc/Caddyfile

#WORKDIR /tmp/scripts

# Set the default port for applications built using this image
EXPOSE 2015

ENTRYPOINT ["/sbin/tini"]

# Set the default CMD for the image
#CMD ["ls","-laRt","/tmp"]
CMD ["sh","/tmp/scripts/usage"]
