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

STRIPPED_SUMMARY=$( echo $SUMMARY | sed -e 's|<think>.*</think>||g' -e 's/"//g' )

echo -n $STRIPPED_SUMMARY

echo -n " [Use result for commit, rerun or abort y/r/n] "
read DECISION

if [[ $DECISION == [rR] ]]; then
  exec ~/.local/bin/ai-commit
fi

if [[ $DECISION == [yY] ]]; then
  echo ""
  echo "Conventional Commit Types:"
  echo "  feat:     A new feature"
  echo "  fix:      A bug fix"
  echo "  docs:     Documentation changes"
  echo "  style:    Code style changes (formatting, etc.)"
  echo "  refactor: Code refactoring"
  echo "  perf:     Performance improvements"
  echo "  test:     Adding or updating tests"
  echo "  build:    Build system or dependencies"
  echo "  ci:       CI/CD changes"
  echo "  chore:    Other changes (maintenance, etc.)"
  echo ""
  echo -n "Enter commit type prefix (or press Enter to skip): "
  read COMMIT_PREFIX

  if [[ -n $COMMIT_PREFIX ]]; then
    FINAL_MESSAGE="${COMMIT_PREFIX}: ${STRIPPED_SUMMARY}"
  else
    FINAL_MESSAGE=$STRIPPED_SUMMARY
  fi

  git commit -m "$FINAL_MESSAGE"
fi

if [[ $DECISION == [nN] ]]; then
  echo "Bye not commiting anything"
fi

