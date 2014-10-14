#!/bin/sh

show_help() {
  echo "Usage: ${0##*/} URL"
}

while true; do
  case $1 in
    -h|-\?|--help)
      show_help
      exit
      ;;
    *)
      break
  esac
  shift
done

URL=$@

if [ -z "$URL" ]; then
  show_help
  exit 1
fi

while true; do
  CODE=`curl -o /dev/null --silent --head --write-out '%{http_code}' $1`
  CODE_FIRST_LETTER=`echo $CODE | head -c 1`
  COLOR=1

  if [ "$CODE_FIRST_LETTER" -eq "2" ]; then
    COLOR=2

  elif [ "$CODE_FIRST_LETTER" -eq "3" ]; then
    COLOR=3
  fi

  echo "$(tput setaf $COLOR)`date`: $CODE"

  sleep 1
done 
