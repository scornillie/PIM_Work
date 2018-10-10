SELECT A.Vehicle, A.DealerCode,
       ISNULL(F.CountSold, 0) as CountSold,
	   ISNULL(G.CountStock, 0) as CountStock,
	   ISNULL((CAST(CountSold as FLOAT)/CAST(CountStock as FLOAT)), 0) as Ratio
FROM (SELECT distinct Vehicle, DealerCode FROM FordAutomationData.dbo.VIN_Detail) as A
FULL OUTER JOIN
     (SELECT Vehicle, DealerCode, (SELECT COUNT(distinct VIN)) CountSold 
      FROM FordAutomationData.dbo.VIN_Detail
      WHERE (Status = 'Sold') and (SoldDate > getdate() -90) and (CreatedDateTime > getdate() -7)
      GROUP By Vehicle, DealerCode) as F
ON A.Vehicle = F.Vehicle and A.DealerCode = F.DealerCode
FULL OUTER JOIN
	 (SELECT Vehicle, DealerCode, (SELECT COUNT(distinct VIN)) CountStock
	  FROM FordAutomationData.dbo.VIN_Detail
      WHERE (Status = 'Stock') and (CreatedDateTime > getdate() -7)
      GROUP By Vehicle, DealerCode) as G
ON A.Vehicle = G.Vehicle and A.DealerCode = G.DealerCode
ORDER BY A.DealerCode, A.Vehicle
