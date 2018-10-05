SELECT A.Vehicle,
       ISNULL(F.CountSold, 0) as CountSold,
	   ISNULL(G.CountStock, 0) as CountStock,
	   ISNULL((CAST(CountSold as FLOAT)/CAST(CountStock as FLOAT)), 0) as Ratio
FROM (SELECT distinct Vehicle
	  FROM FordAutomationData.dbo.VIN_Detail) as A
FULL OUTER JOIN
     (SELECT Vehicle, COUNT(*) CountSold 
      FROM FordAutomationData.dbo.VIN_Detail
      WHERE (DealerCode = 27039) and (Status = 'Sold') and (SoldDate > getdate() -90) and (CreatedDateTime > getdate() -7)
      GROUP By Vehicle) as F
ON A.Vehicle = F.Vehicle
FULL OUTER JOIN
	 (SELECT Vehicle, COUNT(*) CountStock
	  FROM FordAutomationData.dbo.VIN_Detail
      WHERE (DealerCode = 27039) and (Status = 'Stock') and (CreatedDateTime > getdate() -7)
      GROUP By Vehicle) as G
ON F.Vehicle = G.Vehicle
ORDER BY Vehicle
