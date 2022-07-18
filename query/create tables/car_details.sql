USE query_training;
CREATE TABLE car_details(
	car_id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	car_brand VARCHAR(50) NOT NULL,
	car_brand_model VARCHAR(100) NOT NULL,
	car_type VARCHAR(20) NOT NULL,
	production_start DATE NOT NULL,
	production_finish DATE NOT NULL,
	engine_id INTEGER NOT NULL FOREIGN KEY REFERENCES engine_details(engine_id),
	CONSTRAINT date_check CHECK(DATEDIFF(year,production_start,production_finish) > 0)
	);