save_notification()
{
    #$1=type
    #$2=body
    if [[ ! -f ${SCRIPT_DIR}/logs/.notify.txt ]];then
        log_output "notify file created" "debug"
        touch ${SCRIPT_DIR}/logs/.notify.txt
        touch ${SCRIPT_DIR}/logs/.success_notify.txt
        touch ${SCRIPT_DIR}/logs/.failed_notify.txt
        touch ${SCRIPT_DIR}/logs/.complete_notify.txt
        echo "<p><strong style='font-weight:bolder;'>Backup Copy report from `hostname` ${JOB_NAME} </strong></p><hr>" > ${SCRIPT_DIR}/logs/.notify.txt
        echo "<p style="'font-size:1.2em;font-weight:normal'">backup copy jobs has been completed at <strong>`date`<strong></p>" >> ${SCRIPT_DIR}/logs/.notify.txt
        echo "<hr>" >> ${SCRIPT_DIR}/logs/.notify.txt
        echo '<strong style="color:green;font-weight:900;font-size:1.5em">Successfuly:</strong><br>' > ${SCRIPT_DIR}/logs/.success_notify.txt
        echo '<strong style="color:red;font-weight:900;font-size:1.5em">Failed:</strong><br>' > ${SCRIPT_DIR}/logs/.failed_notify.txt
    fi

    if [[ ${1} == 'success' ]];then
        log_output "save success notify" "debug"
        echo "<p style="'text-align:left;padding:8px;background-color:black;color:white;font-weight:500;font-size:1em'">${2}</p>" >> ${SCRIPT_DIR}/logs/.success_notify.txt
    elif [[ ${1} == 'failed' ]];then
        log_output "save failed notify" "debug"
        echo "<p style="'text-align:left;padding:8px;background-color:black;color:white;font-weight:500;font-size:1em'">${2}</p>" >> ${SCRIPT_DIR}/logs/.failed_notify.txt
    fi
}