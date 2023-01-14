#save script directory
if [[ ! -d "${SCRIPT_DIR}" ]]; then ${SCRIPT_DIR}="$PWD"; fi
configfile=${SCRIPT_DIR}/conf/default.cnf
shopt -s extglob
tr -d '\r' < $configfile > $configfile.parse
while IFS='= ' read -r lhs rhs
do
    if [[ ! $lhs =~ ^\ *# && -n $lhs ]]; then
        rhs="${rhs%%\#*}"    # Del in line right comments
        rhs="${rhs%%*( )}"   # Del trailing spaces
        rhs="${rhs%\"*}"     # Del opening string quotes 
        rhs="${rhs#\"*}"     # Del closing string quotes 
        declare $lhs="$rhs"
    fi
done < $configfile.parse
rm -rf $configfile.parse

# Automaticly load All Functions
for i in ${SCRIPT_DIR}/includes/functions/*.sh;
  do . $i
done

main()
{
    
    log_output "backup_copy started by PID: ${PID}" "report"
    check_load 120
    copy_files
}

#start script
if [[ $QUIET == 'true' && ! -f ${SCRIPT_DIR}/.lock ]]; then
  main |& log_engine &
elif [[ ! -f ${SCRIPT_DIR}/.lock ]]; then
  main |& log_engine
else
  echo "other same job is running, if it is wrong remove .lock file in ${SCRIPT_DIR}/.lock then start again"
fi
exit
