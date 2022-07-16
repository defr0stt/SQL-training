USE query_training;
CREATE TABLE car_details(
	car_id INTEGER PRIMARY KEY IDENTITY(1,1),
	car_brand VARCHAR NOT NULL,
	car_brand_model VARCHAR NOT NULL,
	car_type VARCHAR NOT NULL,
	production_start DATE NOT NULL,
	production_finish DATE NOT NULL,
	engine_id INTEGER FOREIGN KEY REFERENCES engine_details(engine_id)
	);