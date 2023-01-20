#!/usr/bin/env bash

raw_query="$*"
read -ra arr <<<"$raw_query"
query=""
for word in "${arr[@]}"; do
  query+=".*$word"
done

query="$query.*"

/opt/homebrew/bin/jq --arg query "$query" '{ items: map(.[]|select(.title|test($query)))}' ./alfred-user-repos.json
