FROM monostream/nodejs-gulp-bower

# Make ssh dir
RUN mkdir /root/.ssh/

# Copy over private key, and set permissions
ADD .ssh/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Create known_hosts
RUN touch /root/.ssh/known_hosts

# Add bitbuckets key
RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts

# Set default volume for image
# This would be overrided by docker-compose for updatable source code between development
COPY . /data
WORKDIR /data

# Fixes user permissions for Mac OS [https://github.com/boot2docker/boot2docker/issues/581]
RUN usermod -u 1000 www-data