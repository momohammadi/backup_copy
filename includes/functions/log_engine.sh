log_engine()
{
    get_datetime
    output_format
    logname=$(echo "${now_datetime}-backup" | sed 's/ /_/' | awk -F "_" '{print $1}')
    LOGFILE="${SCRIPT_DIR}/logs/backup-${logname}.log"     
    if [[ ! -f  $LOGFILE ]]; then
        touch $LOGFILE
    fi

    case $LOG_LEVEL in
        debug|report)
            if [[ $QUIET == 'true' ]]; then
                awk '{ print strftime("%F %H:%M:%S"), $0; fflush(); }' >> $LOGFILE
            else
                awk '{ print strftime("%F %H:%M:%S"), $0; fflush(); }' | tee -a $LOGFILE
            fi
            ;;
        'none')
            awk '{ print strftime("%F %H:%M:%S"), $0; fflush(); }' >> /dev/null
            ;;
        \?)
            echo "Debug level is invalid valid option = none | debug"
    esac
}