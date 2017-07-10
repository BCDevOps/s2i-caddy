FROM zzrot/alpine-caddy:v0.9.5
MAINTAINER shea.phillips@cloudcompass.ca

LABEL io.openshift.s2i.scripts-url=image:///tmp/scripts

## Copy the S2I scripts into place
COPY ./.s2i/bin/ /tmp/scripts

ADD Caddyfile /etc/Caddyfile

# Create the location where we will store our content, and fiddle the permissions so we will be able to write to it.
# Also twiddle the permissions on the Caddyfile so we will be able to overwrite it with a user-provided one if desired.
RUN mkdir -p /var/www/html && chmod g+w /var/www/html && chmod g+w /etc/Caddyfile

# Expose the port for the container to Caddy's default
EXPOSE 2015

USER 1001

ENTRYPOINT ["/sbin/tini"]

CMD ["sh","/tmp/scripts/usage"]
