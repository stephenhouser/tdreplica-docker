FROM stephenhouser/buddy-bbpress:latest
ENV TERM=xterm
LABEL maintainer="Stephen Houser <stephenhouser@gmail.com>" \
      version="0.1"

# Copy cached versions of plugins and themes into image.
# This is so ew (or wordpress.org) can be offline and still start
# with the versions we cached.
COPY cache /root/.wp-cli/cache