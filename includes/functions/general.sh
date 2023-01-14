system_define()
{
    if [[ -z $os_version ]]; then
        os_version=$( cat /etc/os-release | grep -Ei "PRETTY_NAME=\"|PRETTY_NAME=" | awk -F '=' '{print $2}' | awk '{print $2}' | awk -F '.' '{print $1}' )
    fi

    if [[ -z $os_name ]]; then
        os_name=$(cat /etc/os-release |grep -Ei "PRETTY_NAME=\"|PRETTY_NAME=" | awk -F '=' '{print $2}' | awk '{print $1}' | sed 's/\"//') 
    fi
    
    if [[ -z $base_os ]]; then
        base_os=$(cat /etc/os-release |grep -Ei "ID_LIKE=\"|ID_LIKE=" | awk -F '=' '{print $2}' | awk '{print $1}' | sed 's/\"//') 
    fi
    lftp_v=$(lftp -v | grep -i Version | awk -F'|' '{print $2}' | awk '{print $2}' | head -1)
}

output_format(){
    # Reset
    NC='\033[0m'              # Text Reset

    # Regular Colors
    Black='\033[0;30m'        # Black
    Red='\033[0;31m'          # Red
    Green='\033[0;32m'        # Green
    Yellow='\033[0;33m'       # Yellow
    Blue='\033[0;34m'         # Blue
    Purple='\033[0;35m'       # Purple
    Cyan='\033[0;36m'         # Cyan
    White='\033[0;37m'        # White

    # Bold
    BBlack='\033[1;30m'       # Black
    BRed='\033[1;31m'         # Red
    BGreen='\033[1;32m'       # Green
    BYellow='\033[1;33m'      # Yellow
    BBlue='\033[1;34m'        # Blue
    BPurple='\033[1;35m'      # Purple
    BCyan='\033[1;36m'        # Cyan
    BWhite='\033[1;37m'       # White

    # Underline
    UBlack='\033[4;30m'       # Black
    URed='\033[4;31m'         # Red
    UGreen='\033[4;32m'       # Green
    UYellow='\033[4;33m'      # Yellow
    UBlue='\033[4;34m'        # Blue
    UPurple='\033[4;35m'      # Purple
    UCyan='\033[4;36m'        # Cyan
    UWhite='\033[4;37m'       # White

    # Background
    On_Black='\033[40m'       # Black
    On_Red='\033[41m'         # Red
    On_Green='\033[42m'       # Green
    On_Yellow='\033[43m'      # Yellow
    On_Blue='\033[44m'        # Blue
    On_Purple='\033[45m'      # Purple
    On_Cyan='\033[46m'        # Cyan
    On_White='\033[47m'       # White

    # High Intensity
    IBlack='\033[0;90m'       # Black
    IRed='\033[0;91m'         # Red
    IGreen='\033[0;92m'       # Green
    IYellow='\033[0;93m'      # Yellow
    IBlue='\033[0;94m'        # Blue
    IPurple='\033[0;95m'      # Purple
    ICyan='\033[0;96m'        # Cyan
    IWhite='\033[0;97m'       # White

    # Bold High Intensity
    BIBlack='\033[1;90m'      # Black
    BIRed='\033[1;91m'        # Red
    BIGreen='\033[1;92m'      # Green
    BIYellow='\033[1;93m'     # Yellow
    BIBlue='\033[1;94m'       # Blue
    BIPurple='\033[1;95m'     # Purple
    BICyan='\033[1;96m'       # Cyan
    BIWhite='\033[1;97m'      # White

    # High Intensity backgrounds
    On_IBlack='\033[0;100m'   # Black
    On_IRed='\033[0;101m'     # Red
    On_IGreen='\033[0;102m'   # Green
    On_IYellow='\033[0;103m'  # Yellow
    On_IBlue='\033[0;104m'    # Blue
    On_IPurple='\033[0;105m'  # Purple
    On_ICyan='\033[0;106m'    # Cyan
    On_IWhite='\033[0;107m'   # White
}
print_system_info()
{
    system_define
    output_format
    echo -e "${BRed}+++${NC} ${On_Blue}System Information${NC} ${BRed}+++${NC}"    
    echo -e "${BIBlue}Base OS:${NC} $base_os"
    echo -e "${BIBlue}OS:${NC} $os_name"
    echo -e "${BIBlue}Version:${NC} $os_version"
    echo -e "${BRed}+++${NC} ${On_Green}Backup copy config${NC} ${BRed}+++${NC}"    
    echo -e "${BIGreen}Log Level:${NC} $LOG_LEVEL"
    echo -e "${BIGreen}Sleep on max load(5m):${NC} $MAX_LOAD"
    echo -e "${BIGreen}Copy Type:${NC} $COPY_TYPE"
    echo -e "${BIGreen}Source Directory:${NC} $SOURCE_BACKUP_DIR"
    echo -e "${BIGreen}Notification on:${NC} $NOTIFICATION_TYPE"
    echo -e "${BIGreen}Notification type:${NC} $NOTIFICATION_CHANNEL"
}

get_date()
{    
    now_date=$(date '+%Y-%m-%d')
}

get_time()
{
    now_time=$(date '+%H:%M:%S')
}

get_datetime()
{
    now_datetime=$(date '+%Y-%m-%d %H:%M:%S')
}

get_file_path()
{
    echo $1 | sed 's:[^/]*$::'
}

get_file_name()
{
    if [[ -z $2 ]];then
        basename $1
    else
        basename $1 | cut -d"." -f1
    fi
}