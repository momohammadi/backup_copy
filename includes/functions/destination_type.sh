destination_type(){
    log_output "setup destination" "debug"
    case ${COPY_TYPE} in
        'ftp')
            log_output "destination set to ftp" "debug"
            if [[ $1 == 'upload' ]];then
                log_output "destination(ftp) set to upload" "debug"
                #$2=rempte path
                #$3=local file
                upload_ftp $2 $3
            elif [[ $1 == 'mirror' ]];then
                log_output "destination(ftp) set to mirror" "debug"
                mirror_ftp
            fi
        ;;        
        *)
        log_output "copy_way not selected, check config file" "report"
        exit
        ;;
    esac
}