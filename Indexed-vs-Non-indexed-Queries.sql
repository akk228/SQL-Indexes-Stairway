use AdventureWorks2019;
go

if DB_NAME() <> 'AdventureWorks2019' raiserror('DB AdventureWorks2019 not found',22,-1) with log;
go

/***
	Basic performance info enabling
***/

set statistics io on
set statistics time on
go


/***
	Query that uses non-clustered index
***/

select EmailAddress from Person.EmailAddress where EmailAddress = 'chloe29@adventure-works.com'
go

/***
	Summary: 
		SQL Server parse and compile time: 
		CPU time = 0 ms, elapsed time = 0 ms.

		SQL Server Execution Times:
			CPU time = 0 ms,  elapsed time = 0 ms.
		SQL Server parse and compile time: 
			CPU time = 0 ms, elapsed time = 13 ms.
		SQL Server parse and compile time: 
			CPU time = 0 ms, elapsed time = 0 ms.

		(1 row affected)
		Table 'EmailAddress'. Scan count 1, logical reads 5, physical reads 4, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

		(1 row affected)

		SQL Server Execution Times:
			CPU time = 0 ms,  elapsed time = 34 ms.
		SQL Server parse and compile time: 
			CPU time = 0 ms, elapsed time = 0 ms.

		SQL Server Execution Times:
			CPU time = 0 ms,  elapsed time = 0 ms.

		Completion time: 2023-04-04T16:22:38.6238923+02:00
***/

/***
	Same query with no index
***/

USE [AdventureWorks2019]
GO

/****** Object:  Index [IX_EmailAddress_EmailAddress]    Script Date: 04/04/2023 16:34:52 ******/
DROP INDEX [IX_EmailAddress_EmailAddress] ON [Person].[EmailAddress]
GO


/***
	Execute query in the table without index
***/

select * from Person.EmailAddress where EmailAddress = 'chloe29@adventure-works.com'
go

/*
	Summary:
		SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.
SQL Server parse and compile time: 
   CPU time = 47 ms, elapsed time = 108 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

(1 row affected)
Table 'EmailAddress'. Scan count 1, logical reads 251, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

(1 row affected)

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 9 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

Completion time: 2023-04-04T16:37:25.4684344+02:00

*/

/***
	Restore index
***/

USE [AdventureWorks2019]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_EmailAddress_EmailAddress]    Script Date: 04/04/2023 16:35:19 ******/
CREATE NONCLUSTERED INDEX [IX_EmailAddress_EmailAddress] ON [Person].[EmailAddress]
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'EmailAddress', @level2type=N'INDEX',@level2name=N'IX_EmailAddress_EmailAddress'
GO


/***
	Basic performance info disabling
***/

set statistics io off
set statistics time off
go
