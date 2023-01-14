install_engine()
{
    type=$1
    action=$2
    packages=$( echo $3 | sed 's/,/ /g' )
    case $base_os in
        'Ubuntu' | 'Debian')
            INC='apk-get -y'
            if [[ $quiet == 'true' ]]; then
                INC='apt-get -qqy'
            fi
            if [[ $action == 'remove' ]]; then
                action='purge'
            elif [[ $action == 'groupremove' ]]; then
                action='purge'
            elif [[ $action == 'groupinstall' ]]; then
                action=' --fix-missing install'
            fi
            ;;
        [Rr]hel|[Cc]entos|[Ff]edora)
            if [[ $os_name == 'AlmaLinux' ]];then
                INC='dnf -y'
                if [[ $quiet == 'true' ]]; then
                    INC='dnf -qy'
                fi
            else
                if [[ $os_version == '8' || $os_version == '9' ]]; then
                    INC='dnf -y'
                    if [[ $quiet == 'true' ]]; then
                        INC='dnf -qy'
                    fi 
                elif [[ $os_version == '7' || $os_version == '6' ]]; then 
                    INC='yum -y'
                    if [[ $quiet == 'true' ]]; then
                        INC='yum -qy'
                    fi 
                fi
            fi        
            ;;
        *)
            echo -e  "Installer can not be run, Supported Distro is Ubuntu,AlmaLinux,Centos version 8,7,6 \
            \nif you are on the one of this Distro or CloudLinux add distro and os version manually in config file and try again \
            \nexample for config file : \
            \nos_name='Centos' \
            os_version='8'" 
            exit        
            ;;
    esac 

    case $type in 
        'pkg_manager')
            $INC $action $packages
    esac
}