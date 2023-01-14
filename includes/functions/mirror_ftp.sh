mirror_ftp()
{
        log_output "ftp mirror executed" "debug"
        if [[ ! -z $EXCLUDE && ! -z $INCLUDE ]];then
                ftp_connect "lcd ${SOURCE_BACKUP_DIR}; mirror -R -P 1 --no-perms --no-umask --only-missing --continue --skip-noaccess --exclude '${EXCLUDE}' --include '${INCLUDE}' ${JUST_PRINT}"

        elif [[ ! -z $EXCLUDE ]]; then
                ftp_connect "lcd ${SOURCE_BACKUP_DIR}; mirror -R -P 1 --no-perms --no-umask --only-missing --continue --skip-noaccess --exclude '${EXCLUDE}' ${JUST_PRINT}"

        elif [[ ! -z $INCLUDE ]];then
                ftp_connect "lcd ${SOURCE_BACKUP_DIR}; mirror -R -P 1 --no-perms --no-umask --only-missing --continue --skip-noaccess --include '${INCLUDE}' ${JUST_PRINT}"
        else
                ftp_connect "lcd ${SOURCE_BACKUP_DIR}; mirror -R -P 1 --no-perms --no-umask --only-missing --continue --skip-noaccess ${JUST_PRINT}"
        fi        
} 