USE query_training;
CREATE TABLE engine_details(
	engine_id INTEGER PRIMARY KEY IDENTITY(1,1),
	cylinders INTEGER NOT NULL,
	engine_volume FLOAT(24) NOT NULL,
	power_hp INTEGER NOT NULL
	);