compare_source_destination()
{
        log_output "start compare source files by destination file at ... " "report"
        SUCCESS_COUNTER=(" defined ")
        FAILED_COUNTER=(" defined ")
        if [[ -z $1 ]];then                
                SOURCE_FILES+=$(find_copy_item)
        else
                SOURCE_FILES=$(find ${1} -type f -print0 | xargs -0 ls -l | awk '{print $9}')
        fi
        check_load 30       
        for FILE in ${SOURCE_FILES}
        do
                SOURCE_BACKUP_PATH=$(echo ${SOURCE_BACKUP_DIR} | sed 's,/*[^/]\+/*$,,' )
                SOURCE_FILE_ADDRESS=$FILE
                SOURCE_FILE_SIZE=$(find $FILE -type f -print0 | xargs -0 ls -l | awk '{print $5}')
                FILE_NAME=$(get_file_name ${SOURCE_FILE_ADDRESS})
                destination_files_info $FILE
                DESTINATION_FILE_PATH=$(get_file_path ${DESTINATION_FILE_ADDRESS})

                log_output "checking  ${FILE_NAME} ... " "report"

                if [[ -z $DESTINATION_FILE_SIZE || $DESTINATION_FILE_SIZE != $SOURCE_FILE_SIZE ]];then
                        if [[ ! -f ${SCRIPT_DIR}/copy_${FILE_NAME}.lock ]];then
                                log_output "failed: send retry signal for copy of ${SOURCE_FILE_ADDRESS} to ${DESTINATION_FILE_ADDRESS}" "report"

                                touch ${SCRIPT_DIR}/copy_${FILE_NAME}.lock

                                copy_files ${FILE_NAME} ${DESTINATION_FILE_PATH} ${SOURCE_FILE_ADDRESS}

                        elif [[ -f ${SCRIPT_DIR}/copy_${FILE_NAME}.lock ]];then
                                log_output "failed: failed to retry copy of ${SOURCE_FILE_ADDRESS}, Remote size : ${DESTINATION_FILE_SIZE} - Source Size: ${SOURCE_FILE_SIZE}" "report"
                                save_notification "failed" "copy ${SOURCE_FILE_ADDRESS} <br> to ${DESTINATION_FILE_PATH} <br> source size: ${SOURCE_FILE_SIZE} <br> destination size: ${DESTINATION_FILE_SIZE}"
                                FAILED_COUNTER=(${FAILED_COUNTER[@]} ${FILE_NAME})                        
                                rm -rf ${SCRIPT_DIR}/copy_${FILE_NAME}.lock                        
                        fi
                elif [[ -f ${SCRIPT_DIR}/copy_${FILE_NAME}.lock ]];then
                        log_output "successfull: end retry copy of ${SOURCE_FILE_ADDRESS}, Remote size : ${DESTINATION_FILE_SIZE} - Source Size: ${SOURCE_FILE_SIZE}" "report"

                        save_notification "success" "successfully to retry copy of ${SOURCE_FILE_ADDRESS} to ${DESTINATION_FILE_PATH} <br> source size: ${SOURCE_FILE_SIZE} <br> destination size: ${DESTINATION_FILE_SIZE}"

                        rm -rf ${SCRIPT_DIR}/copy_${FILE_NAME}.lock
                elif [[ ! -z $DESTINATION_FILE_SIZE || $DESTINATION_FILE_SIZE == $SOURCE_FILE_SIZE ]];then
                        log_output "successfull: file ${SOURCE_FILE_ADDRESS} successfully copied to ${DESTINATION_FILE_PATH} Remote size : ${DESTINATION_FILE_SIZE} - Source Size: ${SOURCE_FILE_SIZE}" "report"
                        save_notification "success" "file ${SOURCE_FILE_ADDRESS} successfully copied <br> to ${DESTINATION_FILE_PATH} <br> source size: ${SOURCE_FILE_SIZE} <br> destination size: ${DESTINATION_FILE_SIZE}"
                        SUCCESS_COUNTER=(${SUCCESS_COUNTER[@]} ${FILE_NAME})                        
                else
                        log_output "Unknown: could not compare source file(${SOURCE_FILE_ADDRESS}) by destination file(${DESTINATION_FILE_PATH}), check connection or config file" "report"
                fi
        done
} 