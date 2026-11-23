CREATE SCHEMA gtfs;

SELECT schema_name
FROM information_schema.schemata
WHERE schema_name = 'gtfs';

SELECT 'agency' AS tabel, COUNT(*) AS jumlah FROM gtfs.agency
UNION ALL
SELECT 'calendar', COUNT(*) FROM gtfs.calendar
UNION ALL
SELECT 'fare_attributes', COUNT(*) FROM gtfs.fare_attributes
UNION ALL
SELECT 'fare_rules', COUNT(*) FROM gtfs.fare_rules
UNION ALL
SELECT 'frequencies', COUNT(*) FROM gtfs.frequencies
UNION ALL
SELECT 'routes', COUNT(*) FROM gtfs.routes
UNION ALL
SELECT 'shapes', COUNT(*) FROM gtfs.shapes
UNION ALL
SELECT 'stops', COUNT(*) FROM gtfs.stops
UNION ALL
SELECT 'stop_times', COUNT(*) FROM gtfs.stop_times
UNION ALL
SELECT 'ticketing_deep_links', COUNT(*) FROM gtfs.ticketing_deep_links
UNION ALL
SELECT 'ticketing_identifiers', COUNT(*) FROM gtfs.ticketing_identifiers
UNION ALL
SELECT 'transfers', COUNT(*) FROM gtfs.transfers
UNION ALL
SELECT 'trips', COUNT(*) FROM gtfs.trips;

SELECT
    table_name,
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'gtfs'
ORDER BY table_name, ordinal_position;

-- PRIMARY KEY
ALTER TABLE gtfs.agency
ADD PRIMARY KEY (agency_id);

ALTER TABLE gtfs.calendar
ADD PRIMARY KEY (service_id);

ALTER TABLE gtfs.fare_attributes
ADD PRIMARY KEY (fare_id);

ALTER TABLE gtfs.routes
ADD PRIMARY KEY (route_id);

ALTER TABLE gtfs.shapes
ADD PRIMARY KEY (shape_id, shape_pt_sequence);

ALTER TABLE gtfs.stops
ADD PRIMARY KEY (stop_id);

ALTER TABLE gtfs.trips
ADD PRIMARY KEY (trip_id);

ALTER TABLE gtfs.stop_times
ADD PRIMARY KEY (trip_id, stop_sequence);

ALTER TABLE gtfs.frequencies
ADD PRIMARY KEY (trip_id, start_time);

ALTER TABLE gtfs.ticketing_deep_links
ADD PRIMARY KEY (ticketing_deep_link_id);

ALTER TABLE gtfs.transfers
ADD PRIMARY KEY (from_stop_id, to_stop_id);


-- FOREIGN KEY
ALTER TABLE gtfs.routes
ADD FOREIGN KEY (agency_id)
REFERENCES gtfs.agency(agency_id);

ALTER TABLE gtfs.trips
ADD FOREIGN KEY (route_id)
REFERENCES gtfs.routes(route_id);

ALTER TABLE gtfs.trips
ADD FOREIGN KEY (service_id)
REFERENCES gtfs.calendar(service_id);

ALTER TABLE gtfs.stop_times
ADD FOREIGN KEY (trip_id)
REFERENCES gtfs.trips(trip_id);

ALTER TABLE gtfs.stop_times
ADD FOREIGN KEY (stop_id)
REFERENCES gtfs.stops(stop_id);

ALTER TABLE gtfs.frequencies
ADD FOREIGN KEY (trip_id)
REFERENCES gtfs.trips(trip_id);

ALTER TABLE gtfs.fare_attributes
ADD FOREIGN KEY (agency_id)
REFERENCES gtfs.agency(agency_id);

ALTER TABLE gtfs.fare_rules
ADD FOREIGN KEY (fare_id)
REFERENCES gtfs.fare_attributes(fare_id);

ALTER TABLE gtfs.fare_rules
ADD FOREIGN KEY (route_id)
REFERENCES gtfs.routes(route_id);

ALTER TABLE gtfs.ticketing_identifiers
ADD FOREIGN KEY (stop_id)
REFERENCES gtfs.stops(stop_id);

ALTER TABLE gtfs.transfers
ADD FOREIGN KEY (from_stop_id)
REFERENCES gtfs.stops(stop_id);

ALTER TABLE gtfs.transfers
ADD FOREIGN KEY (to_stop_id)
REFERENCES gtfs.stops(stop_id);


CREATE INDEX idx_routes_agency
ON gtfs.routes(agency_id);

CREATE INDEX idx_trips_route
ON gtfs.trips(route_id);

CREATE INDEX idx_trips_service
ON gtfs.trips(service_id);

CREATE INDEX idx_stoptimes_stop
ON gtfs.stop_times(stop_id);

CREATE INDEX idx_stoptimes_trip
ON gtfs.stop_times(trip_id);

CREATE INDEX idx_stops_name
ON gtfs.stops(stop_name);

CREATE INDEX idx_stops_location
ON gtfs.stops(stop_lat, stop_lon);

CREATE INDEX idx_shapes_id
ON gtfs.shapes(shape_id);


