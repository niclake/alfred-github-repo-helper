#!/usr/bin/env bash

cat ./user-repos.json | $(brew --prefix)/bin/jq -s 'map(.[]|{ arg: [.html_url, .name], uid: .id, title: .name, subtitle: (if .description then .description else .url end) }) | { items: . }' > ./alfred-user-repos.json
