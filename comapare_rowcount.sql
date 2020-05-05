
Declare @RowCount Table(
	DBName varchar(50),
	TableName varchar(200),
	Rowcnt int
)




Insert into @RowCount(DBName,TableName,Rowcnt)
EXECUTE sys.sp_MSforeachdb 'USE [?]; SELECT ''?'',
     ''[?].''+QUOTENAME(SCHEMA_NAME(sOBJ.schema_id)) + ''.'' + QUOTENAME(sOBJ.name) AS [TableName]
      , SUM(sdmvPTNS.row_count) AS [RowCount]
FROM
      sys.objects AS sOBJ
      INNER JOIN sys.dm_db_partition_stats AS sdmvPTNS
            ON sOBJ.object_id = sdmvPTNS.object_id
WHERE 
      sOBJ.type = ''U''
      AND sOBJ.is_ms_shipped = 0x0
      AND sdmvPTNS.index_id < 2
GROUP BY
      sOBJ.schema_id
      , sOBJ.name
	  '

Select * from @rowcount
where dbname in (
'AnalyticsReporting'
,'Configuration'
,'EconomicData'
,'FreddieMacLLD'
,'GlobalMIPortfolio'
,'GSEData'
,'InForce'
,'InForceDublin'
,'MIDM'
,'MiPdfParser'
,'MortgageAnalytics'
,'MortgageClients'
,'MortgageData'
,'MultiFamily'
,'PowerBIReporting'
,'Reporting_QBR'
,'SourceControl'
,'StacrModel'
,'StructuredPortfolios'
,'StructuredPortfoliosCompare'
,'StructuredPortfoliosDev1'
,'StructuredPortfoliosReporting'
,'StructuredPortfoliosUW'
,'UW'
,'Westpac'
,'zz_Archive'
)
ORDER BY 1,2
--SELECT
--      QUOTENAME(SCHEMA_NAME(sOBJ.schema_id)) + '.' + QUOTENAME(sOBJ.name) AS [TableName]
--      , SUM(sdmvPTNS.row_count) AS [RowCount]
--FROM
--      sys.objects AS sOBJ
--      INNER JOIN sys.dm_db_partition_stats AS sdmvPTNS
--            ON sOBJ.object_id = sdmvPTNS.object_id
--WHERE 
--      sOBJ.type = 'U'
--      AND sOBJ.is_ms_shipped = 0x0
--      AND sdmvPTNS.index_id < 2
--GROUP BY
--      sOBJ.schema_id
--      , sOBJ.name
--ORDER BY [TableName]
--GO

--select * from sys.dm_db_partition_stats AS sOBJ


--select * from sys.databases

