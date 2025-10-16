#!/usr/bin/env zsh

DIFF=$(git diff --cached $1)

SUMMARY=$(
  ollama run llama3.2:3b <<EOF
Generate a raw text commit message for the following diff.
Keep commit message concise and to the point.
Make the first line the title (100 characters max) and the rest the body:
Do not show raw output of Diff in the message
Do not add meta data such as characters
$DIFF
EOF
)

STRIPPED_SUMMARY=$( echo $SUMMARY | sed -e 's|<think>.*</think>||g' )

echo -n $STRIPPED_SUMMARY

echo -n " [Use result for commit, rerun or abort y/r/n] "
read DECISION

if [[ $DECISION == [rR] ]]; then
  exec ~/bin/ai-commit.sh
fi

if [[ $DECISION == [yY] ]]; then
  git commit -m "$STRIPPED_SUMMARY"
fi

if [[ $DECISION == [nN] ]]; then
  echo "Bye not commiting anything"
fi

