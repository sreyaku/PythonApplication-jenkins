#!/bin/bash
# This script was adapted from:
# https://about.gitlab.com/2017/09/05/how-to-automatically-create-a-new-mr-on-gitlab-with-gitlab-ci/

# TODO determine URL from git repository URL
[[ $HOST =~ ^https?://[^/]+ ]] && HOST="${BASH_REMATCH[0]}/api/v4/projects/"

# The branch which we wish to merge into
TARGET_BRANCH="master";
PRIVATE_TOKEN="glpat-v8K3z-ohHUf3LFbz6wwv"

# The description of our new MR, we want to remove the branch after the MR has
# been closed
BODY="{
\"project_id\": ${CI_PROJECT_ID},
\"source_branch\": \"${CI_COMMIT_REF_NAME}\",
\"target_branch\": \"${TARGET_BRANCH}\",
\"remove_source_branch\": false,
\"force_remove_source_branch\": false,
\"allow_collaboration\": true,
\"subscribed\" : true,
\"title\": \"${GITLAB_USER_NAME} merge request for: ${CI_COMMIT_REF_SLUG}\"
}";

# Require a list of all the merge request and take a look if there is already
# one with the same source branch
 LISTMR=`curl --silent "${HOST}${CI_PROJECT_ID}/merge_requests?state=opened" --header "PRIVATE-TOKEN:${PRIVATE_TOKEN}"`;
 COUNTBRANCHES=`echo ${LISTMR} | grep -o "\"source_branch\":\"${CI_COMMIT_REF_NAME}\"" | wc -l`;

# No MR found, let's create a new one
if [ ${COUNTBRANCHES} -eq "0" ]; then
    curl -X POST "${HOST}${CI_PROJECT_ID}/merge_requests" \
    --header "PRIVATE-TOKEN:${PRIVATE_TOKEN}" \
    --header "Content-Type: application/json" \
    --data "${BODY}";

    echo "Opened a new merge request: WIP: ${CI_COMMIT_REF_SLUG} for user ${GITLAB_USER_LOGIN}";
    exit;
fi
    echo "No new merge request opened"
