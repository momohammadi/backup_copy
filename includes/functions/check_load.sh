check_load(){
    while true; do
        current_load=$(cat /proc/loadavg |awk {'print $2'}|cut -d "." -f1)
        if [[ $current_load < $MAX_LOAD ]]; then
            log_output "load average $current_load, backup_copy will be started" "report"
            break;
        else
            log_output "load average(${current_load}) greater than ${MAX_LOAD} waiting..." "report"
            sleep $1
            log_output "load average checking..." "report"
        fi
    done
}