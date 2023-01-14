send_notification()
{
    #$1=success counter
    #$2=failed counter
    log_output "send notification execcuted" "debug"
    FAILED_LEN=${#FAILED_COUNTERT[@]}
    SUCCESS_LEN=${#SUCCESS_COUNTERT[@]} 
    log_output "SUCCESS_LEN is ${SUCCESS_LEN}" "debug" 
    log_output "FAILED_LEN is ${FAILED_LEN}" "debug"        
    log_output "${SUCCESS_COUNTERT[@]} - ${FAILED_COUNTERT[@]}" "debug"
    
    case ${NOTIFICATION_CHANNEL} in
    'mail')
        log_output "notification channel set to mail" "debug"
        cat ${SCRIPT_DIR}/logs/.notify.txt > ${SCRIPT_DIR}/logs/.complete_notify.txt
        
        if [[ -z $JOB_NAME ]];then
            notify_subject=" backup_copy on `hostname` "
        else
            notify_subject=" backup_copy on `hostname` for  $JOB_NAME "
        fi

        if [[ ${NOTIFICATION_TYPE} ==  'success' ]];then
            log_output "build filnal notify for success message" "debug"
            if [[ ${SUCCESS_LEN} > 1 ]];then
                log_output "SUCCESS_LEN is ${SUCCESS_LEN}" "debug"                
                cat ${SCRIPT_DIR}/logs/.success_notify.txt >> ${SCRIPT_DIR}/logs/.complete_notify.txt
                send_email "${NOTIFICATION_TYPE} ${notify_subject}" "${SCRIPT_DIR}/logs/.complete_notify.txt"
            fi            
        elif [[ ${NOTIFICATION_TYPE} == 'failed' ]];then
            log_output "build filnal notify for failed message" "debug"
            if [[ ${FAILED_LEN} > 1 ]];then
                log_output "FAILED_LEN is ${FAILED_LEN}" "debug"
                cat ${SCRIPT_DIR}/logs/.failed_notify.txt >> ${SCRIPT_DIR}/logs/.complete_notify.txt
                send_email "${NOTIFICATION_TYPE} ${notify_subject}" "${SCRIPT_DIR}/logs/.complete_notify.txt"
            fi                
        elif [[ ${NOTIFICATION_TYPE} ==  'both' ]];then
            log_output "build filnal notify for both failed and success message" "debug"
            cat ${SCRIPT_DIR}/logs/.failed_notify.txt >> ${SCRIPT_DIR}/logs/.complete_notify.txt
            cat ${SCRIPT_DIR}/logs/.success_notify.txt >> ${SCRIPT_DIR}/logs/.complete_notify.txt
            NOTIFICATION_TYPE="failed and success"
            send_email "${NOTIFICATION_TYPE} ${notify_subject}" "${SCRIPT_DIR}/logs/.complete_notify.txt"
        else
            log_output "invalid notification type, check config file" "report"
        fi
    ;;
    *)
        log_output "try send notification failed, notification channel did not detect, check config file" "report"
    ;;
    esac
    rm -rf ${SCRIPT_DIR}/logs/*notify*.txt
}