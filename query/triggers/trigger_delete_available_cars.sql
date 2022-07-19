USE query_training;
GO
CREATE TRIGGER delete_cars
	ON car_details AFTER DELETE AS
	SELECT * FROM available_cars