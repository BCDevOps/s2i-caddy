FROM zzrot/alpine-caddy:v0.9.5
MAINTAINER shea.phillips@cloudcompass.ca

LABEL io.openshift.s2i.scripts-url=image:///tmp/scripts

## Copy the S2I scripts into place
COPY ./.s2i/bin/ /tmp/scripts

# Create the location where we will store our content, and fiddle the permissions so we will be able to write to it.
RUN mkdir -p /var/www/html && chmod 777 /var/www/html

ADD Caddyfile /etc/Caddyfile

# Expose the port for the container to Caddy's default
EXPOSE 2015

ENTRYPOINT ["/sbin/tini"]

CMD ["sh","/tmp/scripts/usage"]
