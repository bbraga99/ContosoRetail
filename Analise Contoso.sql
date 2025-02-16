USE ContosoRetailDW;

SELECT * FROM FactSales;
SELECT * FROM DimProduct;
SELECT * FROM DimProductCategory;
SELECT * FROM DimProductSubCategory;

--Top 10 produtos com maior receita total
SELECT TOP 10
	FS.ProductKey,
	D.ProductName,
	SUM(SalesAmount) AS RECEITA
FROM FactSales FS
INNER JOIN DimProduct D ON D.ProductKey = FS.ProductKey
GROUP BY FS.ProductKey, D.ProductName
ORDER BY SUM(SalesAmount) DESC;

--TOP 10 produtos com maior lucro
SELECT TOP 10
	FS.ProductKey,
	D.ProductName,
	FS.UnitPrice - FS.UnitCost AS Lucro
FROM FactSales FS
INNER JOIN DimProduct D ON D.ProductKey = FS.ProductKey
ORDER BY LUCRO DESC

--Categoria com maior receita
SELECT DISTINCT TOP 1
	PC.ProductCategoryName,
	SUM(FS.SalesAmount) AS TOTAL_RECEITA
FROM FactSales FS
INNER JOIN DimProduct D ON D.ProductKey = FS.Productkey
INNER JOIN DimProductSubcategory PS ON PS.ProductSubcategoryKey = D.ProductSubcategoryKey
INNER JOIN DimProductCategory PC ON PC.ProductCategoryKey = PS.ProductCategoryKey
GROUP BY PC.ProductCategoryName
ORDER BY SUM(FS.SalesAmount) DESC

--Qual categoria de produto gera mais lucro
SELECT DISTINCT TOP 1
	PC.ProductCategoryName,
	SUM(FS.UnitPrice - FS.UnitCost) AS LUCRO
FROM FactSales FS
INNER JOIN DimProduct D ON D.ProductKey = FS.Productkey
INNER JOIN DimProductSubcategory PS ON PS.ProductSubcategoryKey = D.ProductSubcategoryKey
INNER JOIN DimProductCategory PC ON PC.ProductCategoryKey = PS.ProductCategoryKey
GROUP BY PC.ProductCategoryName
ORDER BY SUM(FS.UnitPrice - FS.UnitCost) DESC

