copy_files()
{
    system_define
    if [[ -z $1 ]];then
        log_output "start copy of ${SOURCE_BACKUP_DIR} at `date | awk '{print $4}'` ... " "report"
        destination_type "mirror"
        compare_source_destination
    else 
        #$1=file name
        log_output "start retry to copy of ${1} at `date | awk '{print $4}'` ..." "report"
        #$2=destination path
        #$3=local file
        destination_type "upload" ${2} ${3}
        log_output "send to check again for ${1}(${3}) at `date | awk '{print $4}'` ..." "report"
        #compare size/availability of source file by uploaded file and try for unmatched files
        compare_source_destination ${3}
    fi      
    
    if [[ -z $1 ]];then
        log_output "end of copy ${SOURCE_BACKUP_DIR} at `date | awk '{print $4}'` ... " "report"
        send_notification
    else
        log_output "end of retry copy for ${1} at `date | awk '{print $4}'` ..." "report"
    fi
}