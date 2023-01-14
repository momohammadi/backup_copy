find_copy_item()
{
    if [[ ! -z $EXCLUDE && ! -z $INCLUDE ]];then
        find $SOURCE_BACKUP_DIR -type f -print0 | xargs -0 ls -l | grep -Ev "$EXCLUDE" | grep -E "$INCLUDE" | awk '{print $9}'
    elif [[ ! -z $EXCLUDE ]]; then
        find $SOURCE_BACKUP_DIR -type f -print0 | xargs -0 ls -l | grep -Ev "$EXCLUDE" | awk '{print $9}'
    elif [[ ! -z $INCLUDE ]];then
        find $SOURCE_BACKUP_DIR -type f -print0 | xargs -0 ls -l | grep -E "$INCLUDE" | awk '{print $9}'
    else
        find $SOURCE_BACKUP_DIR -type f -print0 | xargs -0 ls -l | awk '{print $9}'
    fi
} 