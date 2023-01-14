function send_email()        
{
        #$1= subject
        #$2= body
        log_output "email send via smtp at `date | awk '{print $4}'` ... " "report"
        log_output "notify message send to ${EMAIL_TO} from $EMAIL_SENDER via smtp server ${SMTP_SERVER}:${SMTP_PORT} from the file ${2}" "debug"
	cat $2 | mail -s "$(echo -e "${1}\nContent-Type: text/html")" -r "${FROM_NAME} <${EMAIL_SENDER}>" -S smtp="smtp://${SMTP_SERVER}:${SMTP_PORT}" \
        	-S smtp-auth=login \
                -S smtp-auth-user="$EMAIL_SENDER" \
                -S smtp-auth-password="$SMTP_PASSWORD" \
                -S sendwait "${EMAIL_TO}"
}