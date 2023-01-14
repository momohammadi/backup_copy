upload_ftp()
{   
    #$1=destination path
    #$2=local file
    log_output "ftp upload executed" "debug"
    if [[ $DRY_RUN == '--dry-run' || $DRY_RUN == 'true' ]];then
        log_output "try upload to ftp on dry-run mode" "report"
    else
        log_output "upload file ${2} via ftp to destination ${1}" "debug"
        ftp_connect "mkdir -p  ${1} || cd ${1}; mput ${2}"
    fi
}