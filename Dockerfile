FROM scaleway/cli:v2.19.0 as upstream

FROM alpine:3.18

COPY --from=upstream /scw /scw

RUN apk add --no-cache curl

LABEL "name"="action-scw"
LABEL "version"="2.19.0"
LABEL "maintainer"="Jawher Moussa"
LABEL "repository"="https://github.com/jawher/action-scw"
LABEL "homepage"="https://github.com/jawher/action-scw"

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "help" ]
