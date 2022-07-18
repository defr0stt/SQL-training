USE query_training;
GO
CREATE TRIGGER available_cars_insert 
	ON available_cars AFTER INSERT AS
	SELECT * FROM available_cars