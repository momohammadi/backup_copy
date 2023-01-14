#!/bin/bash
SCRIPT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_DIR}/includes/functions/general.sh
source ${SCRIPT_DIR}/includes/functions/install_engine.sh
print_system_info
chmod +x ${SCRIPT_DIR}/backup_copy.sh
mkdir -p ${SCRIPT_DIR}/logs
install_engine 'pkg_manager' 'install' 'lftp mailx mailutils bc'
echo "install dependency completed."
csf_enabled=$(ps -aux | grep csf | head -1)
if [[ ! -z $csf_enabled ]]; then
    echo "find csf on this server"
    echo "backup copy added to csf pignore"
    echo "exe:${SCRIPT_DIR}/backup_copy.sh" >> /etc/csf/csf.pignore
fi
echo -e "some help:\n"
echo -e "run .${SCRIPT_DIR}/backup_copy.sh --dry-run to see the result without copy anything"
echo -e "run bellow command to start backup_copy script after the WHM backup finished \n"
echo "/usr/local/cpanel/bin/manage_hooks add script ${SCRIPT_DIR}/backup_copy.sh --manual --category System --event Backup --stage=post"
