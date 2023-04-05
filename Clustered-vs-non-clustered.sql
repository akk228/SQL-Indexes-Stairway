use AdventureWorks2019;
go


if DB_NAME() <> 'AdventureWorks2019' raiserror('DB AdventureWorks2019 not found',22,-1) with log;
go


set statistics io on
set statistics time on
go


select * from Person.CountryRegion where CountryRegionCode = 'TN'
/***
	Summary: 
		Table 'CountryRegion'. Scan count 0, logical reads 2, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

***/

/***
	No clustered index
***/

select * 
into CountryReg
from Person.CountryRegion

select * from CountryReg where CountryRegionCode = 'ZW'
/***
	Summary:
		Table 'CountryReg'. Scan count 1, logical reads 2, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

***/

drop table CountryReg
go

set statistics io off
set statistics time off
go