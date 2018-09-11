# SQL Instance Install

Download and install SQL Express 2016 with SP1 or Enterprise
If using SQL Express use the default instance and not SQLEXPRESS instance

SQL Server 2016 Express with SP1
From: C:\Deploy\Dependencies\SQLServer2016-SSEI-Expr.exe
	Original: https://www.microsoft.com/en-us/download/confirmation.aspx?id=54284
Select Custom and specify default SQL instance instead of SQLExpress to eliminate need to change connection strings
 

Select Windows and Database authentication and use password for SA:
Test12345
If you want to use a different password, open up the c:\resourcefiles directory in VS Code and search and replace for new password.

SQL Server Management Tool:
https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-2017

(requires restart)

----------------------------------------------------------
Enable contained databases
In order to enable contained databases on SQL Server, run this SQL script through SQL Server Management Studio:

```sql
sp_configure 'contained database authentication', 1;
GO
RECONFIGURE;
GO
```

Open up port 1433 on firewall

In Order to remotely install using msdeploy from the various roles, SQL Server must have TCP/IP enabled.
This is done in the SQL Server Management Tools
SQL Server must be restarted after enabling.


Register ScriptDom (hack!)
"C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\gacutil" /i "C:\Program Files (x86)\Microsoft Visual Studio\2017\SQL\Common7\IDE\Extensions\Microsoft\SQLDB\DAC\140\Microsoft.SqlServer.TransactSql.ScriptDom.dll"

Go into File Explorer/Network and ensure that File sharing is turned on and the VM is connected to the network to allow other VMs to find it.
