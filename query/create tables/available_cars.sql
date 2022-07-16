USE query_training;
CREATE TABLE available_cars(
	car_id INTEGER NOT NULL FOREIGN KEY REFERENCES car_details(car_id),
	car_showroom_id INTEGER NOT NULL FOREIGN KEY REFERENCES car_showroom(car_showroom_id),
	color VARCHAR(20) NOT NULL,
	price MONEY NOT NULL DEFAULT 0 CHECK(price >= 0)
	);