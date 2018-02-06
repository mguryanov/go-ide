#!/bin/bash

set -e

CWD=${1:-$PWD}
PROJECT=""
VOLUME_ROOT=""
PROJECT_ROOT=""
PROJECT_FILE_RELATIVE_PATH=""

OIFS=$IFS
IFS=$'\n'

declare -a ITEMS=(${CWD////$'\n'})

ROOT_CHECK=""

pos=0
for item in "${ITEMS[@]}"; do
	[[  -e "${ROOT_CHECK}/${item}/vendor" &&
		-d "${ROOT_CHECK}/${item}/vendor" ]]	\
		&& PROJECT_ROOT=${ROOT_CHECK}			\
	   	&& PROJECT=${item}						\
		&& echo "MATCH"							\
	   	&& break
	ROOT_CHECK+="/$item"
	((++pos))
done

IFS=$OIFS

PROJECT_FILE_RELATIVE_PATH=$(IFS=/ ; echo "${ITEMS[*]:$pos}")

if [[ -d $CWD ]]; then
	[[ ${#PROJECT_FILE_RELATIVE_PATH} > 0 ]] &&
		PROJECT_FILE_RELATIVE_PATH+="/"
	pushd .
	cd $CWD
	for f in $(ls main.go); do
		[[ -f $f ]] &&
		PROJECT_FILE_RELATIVE_PATH+=$f && break
	done
	popd
fi

echo "PROJECT: $PROJECT"
echo "PROJECT_FILE_RELATIVE_PATH: $PROJECT_FILE_RELATIVE_PATH"

#:<<dg
sudo docker run -it --rm \
		--name go-ide-${PROJECT} \
		--net=host \
		-e PROJECT_FILE_PATH=${PROJECT_FILE_RELATIVE_PATH} \
		-v ${PROJECT_ROOT}:/go/src \
		-p 7172:7172 \
		-w="/go/src/${PROJECT}" \
go-ide:latest
#dg
