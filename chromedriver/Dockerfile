FROM yukinying/chrome-headless-browser:latest

MAINTAINER Albert Yu <yukinying@gmail.com>

USER root

RUN mkdir -p /usr/share/man/man1 \
  # && echo "deb https://deb.debian.org/debian jessie-backports main" >> /etc/apt/sources.list.d/jessie-backports.list \
  && echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list.d/jessie-backports.list \
  && apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    -t jessie-backports openjdk-8-jre-headless \
    unzip \
    wget \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#==========
# Selenium
#==========

RUN  mkdir -p /opt/selenium \
  && wget --no-verbose https://selenium-release.storage.googleapis.com/3.3/selenium-server-standalone-3.3.1.jar -O /opt/selenium/selenium-server-standalone.jar


#==================
# Chrome webdriver
#==================
ARG CHROME_DRIVER_VERSION=2.29
RUN wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

# DISABLED Selenium Configuration as it is for Node setup
# #========================
# # Selenium Configuration
# #========================
# ENV NODE_MAX_INSTANCES 1
# ENV NODE_MAX_SESSION 1
# ENV NODE_REGISTER_CYCLE 5000
# COPY generate_config /opt/selenium/generate_config
# RUN chmod +x /opt/selenium/generate_config
# RUN /opt/selenium/generate_config > /opt/selenium/config.json

#=================================
# Chrome Launch Script Modication
#=================================
COPY chrome_launcher.sh /opt/google/chrome/google-chrome
RUN chmod +x /opt/google/chrome/google-chrome

RUN chown -R headless:headless /opt/selenium

USER headless
# Following line fixes
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

ENTRYPOINT java -jar /opt/selenium/selenium-server-standalone.jar

EXPOSE 4444
