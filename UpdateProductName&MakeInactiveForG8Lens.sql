/*SQL Query Updates Product Name to start with @namePreFix and to be inactive for the products that contain G8 in the name 

NOTE: Did any G8 lenses exist before the Lens Loader update in July 2019? 
If so, I can add the select statements to use: WHERE prd_new_since > '2019-07-01 00:00:00.000'
*/

DECLARE @namePreFix nvarchar(max);
SET @namePreFix = 'zz123 ';
DECLARE @currentProdName nvarchar(max);
DECLARE @newProdName nvarchar(max);
DECLARE @prodNum nvarchar(max);


WHILE (SELECT COUNT(*) FROM product WHERE prd_style_name LIKE '[a-Z]%G8%' AND prd_style_name NOT LIKE 'zz123%') > 0
BEGIN

	SELECT @currentProdName = prd_style_name FROM product WHERE prd_style_name LIKE '[a-Z]%G8%' AND prd_style_name NOT LIKE 'zz123%';
	SELECT @prodNum = prd_no FROM product WHERE prd_style_name LIKE '[a-Z]%G8%' AND prd_style_name NOT LIKE 'zz123%';
	SET @newprodName = @namePreFix + @currentProdName;

	print N'Current Product Num  = ' + @prodNum;
	print N'Current Product Name = ' + @currentProdName;
	print N'New Product Name     = ' + @newProdName;
	print '';

	UPDATE product
	SET prd_style_name = @newProdName
	WHERE prd_no = @prodNum;

	UPDATE product_details
	SET product_details.Prddtl_Status=3
	WHERE prd_no = @prodNum;

END

