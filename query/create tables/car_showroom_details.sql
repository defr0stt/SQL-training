USE query_training;
CREATE TABLE car_showroom(
	car_showroom_id INTEGER PRIMARY KEY IDENTITY(1,1),
	showroom_brand VARCHAR NOT NULL,
	country VARCHAR NOT NULL,
	city VARCHAR NOT NULL
	);