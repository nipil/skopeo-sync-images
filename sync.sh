#!/bin/bash

set -u -e -o pipefail

SPEC=${1:-spec.yaml}
AUTH=${2:-auth.json}
TARGET=${3:-images}

function cleanup() {
	rm -Rf "${TARGET}"
	mkdir -p "${TARGET}"
}

function main() {
	cleanup
	skopeo sync --authfile ${AUTH} --src yaml --dest dir --scoped ${SPEC} ${TARGET}
	tar zcvf ${TARGET}.tar ${TARGET}
	cleanup
}

main
