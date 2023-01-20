#!/bin/bash

GITHUB_CREDENTIALS="$GH_USERNAME:$GH_TOKEN"
GITHUB_API_REST="/user/repos"

GITHUB_API_HEADER_ACCEPT="Accept: application/vnd.github.v3+json"

temp=`basename $0`
# TMPFILE=`mktemp /tmp/${temp}.XXXXXX` || exit 1
TMPFILE=`mktemp tempfile.txt` || exit 1

function rest_call {
    curl -s -u $GITHUB_CREDENTIALS $1 -H "${GITHUB_API_HEADER_ACCEPT}" >> $TMPFILE
}

# single page result-s (no pagination), have no Link: section, the grep result is empty
last_page=`curl -s -I -u $GITHUB_CREDENTIALS "https://api.github.com${GITHUB_API_REST}?affiliation=owner,collaborator&per_page=200" -H "${GITHUB_API_HEADER_ACCEPT}" | grep '^link:' | sed -e 's/^link:.*page=//g' -e 's/>.*$//g'`

# does this result use pagination?
if [ -z "$last_page" ]; then
    # no - this result has only one page
    rest_call "https://api.github.com${GITHUB_API_REST}?affiliation=owner,collaborator&per_page=200"
else
    # yes - this result is on multiple pages
    for p in `seq 1 $last_page`; do
        rest_call "https://api.github.com${GITHUB_API_REST}?affiliation=owner,collaborator&per_page=200&page=$p"
    done
fi

cat $TMPFILE > ./user-repos.json
