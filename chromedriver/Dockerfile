FROM yukinying/chrome-headless-browser:latest

MAINTAINER Albert Yu <yukinying@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN mkdir -p /usr/share/man/man1 \
  && apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    openjdk-17-jre-headless \
    unzip \
    wget \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#==========
# Selenium
#==========
RUN SELENIUM_REMOTEPATH=$(wget -q -O - https://api.github.com/repos/SeleniumHQ/selenium/releases/latest | grep 'browser_download_url.*selenium-server-.*jar' | cut -f4 -d\" | sort -r | head -1 ) \
  && mkdir -p /opt/selenium \
  && wget --no-verbose $SELENIUM_REMOTEPATH -O /opt/selenium/selenium-server-standalone.jar


#==================
# Chrome webdriver
#==================
RUN CHROME_DRIVER_REMOTEPATH=$(wget -q -O - https://chromedriver.storage.googleapis.com | grep -oP '(?<=Key>)[^<]*' | grep chromedriver_linux64.zip | sort -Vr | head -1 ) \
  && wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_REMOTEPATH \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

#========================
# Selenium Configuration
#========================
# As integer, maps to "maxInstances"
ENV NODE_MAX_INSTANCES 1
# As integer, maps to "maxSession"
ENV NODE_MAX_SESSION 1
# In milliseconds, maps to "registerCycle"
ENV NODE_REGISTER_CYCLE 5000
# In milliseconds, maps to "nodePolling"
ENV NODE_POLLING 5000
# In milliseconds, maps to "unregisterIfStillDownAfter"
ENV NODE_UNREGISTER_IF_STILL_DOWN_AFTER 60000
# As integer, maps to "downPollingLimit"
ENV NODE_DOWN_POLLING_LIMIT 2
# As string, maps to "applicationName"
ENV NODE_APPLICATION_NAME ""

COPY generate_config /opt/selenium/generate_config
RUN chmod +x /opt/selenium/generate_config
RUN /opt/selenium/generate_config > /opt/selenium/config.json

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

ENTRYPOINT ["/usr/bin/dumb-init","--","java","-jar","/opt/selenium/selenium-server-standalone.jar"]

EXPOSE 4444
