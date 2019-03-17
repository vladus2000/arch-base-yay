if [[ -z "${PUID}" ]]; then
	$*
else
	/runuser.sh evil $*
fi
