USE [master]
GO


If Exists (select name from master.sys.server_principals where name = 'collectionuser')
BEGIN
DROP LOGIN [collectionuser]
END
GO

DROP DATABASE [xp902_MarketingAutomation]
GO

DROP DATABASE [xp902_Messaging]
GO

DROP DATABASE [xp902_Processing.Pools]
GO

DROP DATABASE [xp902_Xdb.Collection.Shard0]
GO

DROP DATABASE [xp902_Xdb.Collection.Shard1]
GO

DROP DATABASE [xp902_Xdb.Collection.ShardMapManager]
GO
