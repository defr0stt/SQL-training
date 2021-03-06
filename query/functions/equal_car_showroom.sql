USE [query_training]
GO
/****** Object:  UserDefinedFunction [dbo].[check_brand_showroom]    Script Date: 18.07.2022 17:45:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- function to equal car brand and showroom brand
ALTER FUNCTION [dbo].[check_brand_showroom] (@car int, @showroom int)
RETURNS int
AS
BEGIN
	DECLARE @value int
    SELECT @value = CASE WHEN (SELECT car_brand FROM car_details WHERE car_id = @car) = 
		(SELECT showroom_brand FROM car_showroom WHERE car_showroom_id = @showroom) THEN 1 ELSE 0 END
  RETURN @value
END;