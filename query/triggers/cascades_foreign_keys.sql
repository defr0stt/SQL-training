USE query_training;
-- for auto delete/update foreign keys
ALTER TABLE car_details 
	ADD CONSTRAINT change_foreign_car_det FOREIGN KEY (engine_id) REFERENCES engine_details (engine_id)
	ON UPDATE CASCADE ON DELETE CASCADE
ALTER TABLE available_cars 
	ADD CONSTRAINT change_foreign_car_first FOREIGN KEY (car_id) REFERENCES car_details (car_id)
	ON UPDATE CASCADE ON DELETE CASCADE
ALTER TABLE available_cars 
	ADD CONSTRAINT change_foreign_showroom_second FOREIGN KEY (car_showroom_id) REFERENCES car_showroom (car_showroom_id)
	ON UPDATE CASCADE ON DELETE CASCADE