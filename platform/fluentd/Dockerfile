FROM quay.io/assemblyline/fluentd:0.0.2
MAINTAINER Leandro Ostera <leandro@ostera.io>

RUN gem uninstall -I fluentd -v 0.14.2
COPY Gemfile /usr/local/fluent/Gemfile
RUN bundle update

# Copy the Fluentd configuration file.
COPY fluent.conf /etc/fluent/fluent.conf

# Run the Fluentd service.
ENTRYPOINT ["fluentd"]
