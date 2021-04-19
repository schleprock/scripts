while((Get-Service "Jenkins").status -eq "Running")
{
    Start-Sleep -Seconds 60
} 
Send-MailMessage -From conbuild@ansys.com -To william.schilp@ansys.com -Body "Jenkins Stopped" -SmtpServer bursmarthost