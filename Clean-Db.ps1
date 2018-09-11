
$SqlAdminPassword="Test12345" 
$SqlServer = "XC-XP1-SQL"

Write-Host "--- Validating and Tuning Database Security Model for Commerce" -ForegroundColor Cyan;
sqlcmd -i clean_db_xp1.sql -U sa -P $SqlAdminPassword -S $SqlServer
