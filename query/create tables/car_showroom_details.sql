USE query_training;
CREATE TABLE car_showroom(
	car_showroom_id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	showroom_brand VARCHAR(50) NOT NULL,
	country VARCHAR(80) NOT NULL,
	city VARCHAR(80) NOT NULL
	);