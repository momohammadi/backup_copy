destination_files_info()
{
    #$1 = file path
    FILE_PATH=$1
    case $COPY_TYPE in 
        'ftp')
                if [[ $DRY_RUN == '--dry-run' || $DRY_RUN == 'true' ]];then
                        DESTINATION_FILE_ADDRESS=$FILE_PATH
                        DESTINATION_FILE_SIZE=$(find $FILE_PATH -type f -print0 | xargs -0 ls -l | awk '{print $5}')
                        log_output "compare ran on dry-run mode, in this mode compare is not affected so just shows the positive state" "report"
                else
                        lftp_version=$(version_compare $lftp_v 4.4.11)
                        if [[ $lftp_version == 1 ]]; then
                                column_size=1 
                        else
                                column_size=5
                        fi
                        DESTINATION_FILE_ADDRESS=$(echo ${FILE_PATH#$SOURCE_BACKUP_DIR})                
                        DESTINATION_FILE_SIZE=$(ftp_connect "cls -l --filesize --size ${DESTINATION_FILE_ADDRESS}" | awk '{print $column_size}' column_size=$column_size)
                        
                        log_output "get information of $FILE_NAME from destination, DESTINATION_FILE_ADDRESS: $DESTINATION_FILE_ADDRESS DESTINATION_FILE_SIZE: $DESTINATION_FILE_SIZE " "debug"
                fi
        ;;
    esac
}