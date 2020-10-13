FROM platformengineering/cf-resource-v2:stable

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]