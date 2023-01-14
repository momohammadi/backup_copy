ftp_connect()
{
    lftp -c "open $FTP_USER:$FTP_PASSWORD@$FTP_IP; $1"
}