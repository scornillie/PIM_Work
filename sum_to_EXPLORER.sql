SELECT Vehicle, DealerCode, (SELECT COUNT(distinct VIN)) CountStock
	  FROM FordAutomationData.dbo.VIN_Detail
      WHERE (Status = 'Stock') and (CreatedDateTime > getdate() -7) and DealerCode = 27039
      GROUP By Vehicle, DealerCode
UNION
SELECT 'EXPLORER' as Vehicle, DealerCode, ((SELECT COUNT(distinct VIN) FROM FordAutomationData.dbo.VIN_Detail WHERE Vehicle = 'EXPLORER (2011-2018)' and (Status = 'Stock') and (CreatedDateTime > getdate() -7) and DealerCode = 27039) + (SELECT COUNT(distinct VIN) FROM FordAutomationData.dbo.VIN_Detail WHERE Vehicle = 'EXPLORER (2011-2019)' and (Status = 'Stock') and (CreatedDateTime > getdate() -7) and DealerCode = 27039)) CountStock
	  FROM FordAutomationData.dbo.VIN_Detail
      WHERE (Status = 'Stock') and (CreatedDateTime > getdate() -7) and DealerCode = 27039
      GROUP By Vehicle, DealerCode
EXCEPT
SELECT Vehicle, DealerCode, (SELECT COUNT(distinct VIN)) CountStock
	  FROM FordAutomationData.dbo.VIN_Detail
      WHERE (Status = 'Stock') and (CreatedDateTime > getdate() -7) and DealerCode = 27039 and (Vehicle = 'EXPLORER (2011-2018)' or Vehicle = 'EXPLORER (2011-2019)')
	  GROUP BY Vehicle, DealerCode
