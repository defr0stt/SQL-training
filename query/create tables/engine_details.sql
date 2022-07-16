USE query_training;
CREATE TABLE engine_details(
	engine_id INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	cylinders INTEGER NOT NULL CHECK(cylinders >= 4),
	engine_volume FLOAT(24) NOT NULL CHECK(engine_volume >= 1.2),
	power_hp INTEGER NOT NULL CHECK(power_hp >= 0)
	);