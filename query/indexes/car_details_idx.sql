USE query_training;
CREATE INDEX cars_details_idx_not_full
ON car_details(car_brand, car_brand_model, car_type, production_start, production_finish);
CREATE INDEX cars_details_idx_full
ON car_details(car_id, car_brand, car_brand_model, car_type, production_start, production_finish, engine_id);