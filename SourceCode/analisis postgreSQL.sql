-- analisis jumlah halte
SELECT COUNT(*) AS total_halte
FROM gtfs.stops;

-- analisis jumlah rute
SELECT COUNT(*) AS total_rute
FROM gtfs.routes;

-- Jumlah halte yang dilayani setiap rute
SELECT
    r.route_id,
    r.route_short_name,
    r.route_long_name,
    COUNT(DISTINCT st.stop_id) AS jumlah_halte
FROM gtfs.routes r
JOIN gtfs.trips t
    ON r.route_id = t.route_id
JOIN gtfs.stop_times st
    ON t.trip_id = st.trip_id
GROUP BY
    r.route_id,
    r.route_short_name,
    r.route_long_name
ORDER BY jumlah_halte DESC;

-- Pencarian jadwal berdasarkan halte
SELECT
    s.stop_name,
    t.trip_id,
    r.route_short_name,
    st.arrival_time,
    st.departure_time
FROM gtfs.stop_times st
JOIN gtfs.stops s
    ON st.stop_id = s.stop_id
JOIN gtfs.trips t
    ON st.trip_id = t.trip_id
JOIN gtfs.routes r
    ON t.route_id = r.route_id
WHERE s.stop_name ILIKE '%Blok M%'
ORDER BY st.arrival_time;