#!/bin/sh
SCRIPT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
DRY_RUN=$1
PID=$BASHPID
if [[ $DRY_RUN == '--dry-run' || $DRY_RUN == 'true' ]];then
        JUST_PRINT='--just-print'
else
        JUST_PRINT=''
fi
. $SCRIPT_DIR/includes/auto_load.sh