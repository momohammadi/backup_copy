log_output()
{
    if [[ ${2} == "debug" ]]; then
        echo $1
    elif [[ ${2} == "report" ]];then
        echo $1
    fi
}