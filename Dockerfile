FROM redmine:4.0-passenger

COPY --chown=redmine:redmine ./ /usr/src/redmine


SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# hadolint ignore=SC2002
RUN apt-get update \
    && apt-get -y install --no-install-recommends cron=3.0pl1-134+deb10u1 \
    shared-mime-info=1.10-1 \
    curl=7.64.0-4+deb10u2 \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /usr/src/backups \
    && mv /usr/src/redmine/redmine.rb /usr/src/redmine/lib/ \
    && mv /usr/src/redmine/routes.rb /usr/src/redmine/config/ \
    && mv /usr/src/redmine/docker-entrypoint.sh / \
    && mv /usr/src/redmine/configuration.yml  /usr/src/redmine/config/ \
    && find /usr/src/redmine/config/locales -type f -not -name 'en*' -delete \
    && rm /usr/src/redmine/config/locales/en.yml \
    && cat /dev/null | crontab -u redmine -
    
COPY ./locales/en-GB.yml /usr/src/redmine/config/locales

ENTRYPOINT ["bash","/docker-entrypoint.sh"]

EXPOSE 4000
CMD ["passenger", "start", "-p", "4000" ]

