#!/bin/bash

set -u -e -o pipefail

# defaults
AUTH=auth.json
TARGET=images
MULTI=false

function err() {
	echo "${1}" >&2
	exit 1
}

while getopts ":a:d:m" option
do
case $option in
		a)
			AUTH="$OPTARG"
			;;
		d)
			TARGET="$OPTARG"
			;;
		m)
			MULTI=true
			;;
		:)
			err "L'option -$OPTARG requiert un argument"
			;;
		\?)
			err "-$OPTARG : option invalide"
			;;
	esac
done
shift $((OPTIND-1))
if [ $# == 0 ]
then
	err "Fichiers de spécification manquant"
fi

if [ "${MULTI}" = true ] ; then
	MULTI_OPT='--all'
else
	MULTI_OPT=''
fi

for SPEC_FILE in "${@}"
do
	skopeo sync ${MULTI_OPT} --authfile "${AUTH}" --src yaml --dest dir --scoped "${SPEC_FILE}" "${TARGET}"
done
