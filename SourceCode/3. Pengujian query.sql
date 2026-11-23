-- Tahap 14 — Pengujian Query Analisis Operasional TransJakarta
-- 1.Analisis halte berdasarkan jumlah perjalanan
SELECT
    s.stop_id,
    s.stop_name,
    COUNT(st.trip_id) AS total_perjalanan
FROM gtfs.stops s
JOIN gtfs.stop_times st
    ON s.stop_id = st.stop_id
GROUP BY s.stop_id, s.stop_name
ORDER BY total_perjalanan DESC
LIMIT 20;

-- 2.Analisis rute berdasarkan jumlah perjalanan
SELECT
    r.route_id,
    r.route_short_name,
    r.route_long_name,
    COUNT(t.trip_id) AS total_perjalanan
FROM gtfs.routes r
JOIN gtfs.trips t
    ON r.route_id = t.route_id
GROUP BY
    r.route_id,
    r.route_short_name,
    r.route_long_name
ORDER BY total_perjalanan DESC;

-- 3.Analisis jadwal operasional berdasarkan waktu
SELECT
    r.route_short_name,
    COUNT(*) AS total_jadwal,
    MIN(st.departure_time) AS jadwal_awal,
    MAX(st.departure_time) AS jadwal_akhir
FROM gtfs.stop_times st
JOIN gtfs.trips t
    ON st.trip_id = t.trip_id
JOIN gtfs.routes r
    ON t.route_id = r.route_id
GROUP BY r.route_id, r.route_short_name
ORDER BY total_jadwal DESC;

-- 4.Analisis frekuensi operasional
SELECT
    r.route_short_name,
    f.start_time,
    f.end_time,
    f.headway_secs,
    ROUND(f.headway_secs / 60.0, 2) AS interval_menit
FROM gtfs.frequencies f
JOIN gtfs.trips t
    ON f.trip_id = t.trip_id
JOIN gtfs.routes r
    ON t.route_id = r.route_id
ORDER BY f.headway_secs ASC;

-- Tahap 15 — Pengujian waktu eksekusi query analisis
EXPLAIN (ANALYZE, BUFFERS)
SELECT
    s.stop_name,
    COUNT(st.trip_id)
FROM gtfs.stops s
JOIN gtfs.stop_times st
    ON s.stop_id = st.stop_id
GROUP BY s.stop_name;

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    r.route_id,
    r.route_short_name,
    r.route_long_name,
    COUNT(t.trip_id) AS total_perjalanan
FROM gtfs.routes r
JOIN gtfs.trips t
    ON r.route_id = t.route_id
GROUP BY
    r.route_id,
    r.route_short_name,
    r.route_long_name;

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    r.route_short_name,
    COUNT(*) AS total_jadwal,
    MIN(st.departure_time) AS jadwal_awal,
    MAX(st.departure_time) AS jadwal_akhir
FROM gtfs.stop_times st
JOIN gtfs.trips t
    ON st.trip_id = t.trip_id
JOIN gtfs.routes r
    ON t.route_id = r.route_id
GROUP BY r.route_id, r.route_short_name;

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    r.route_short_name,
    f.start_time,
    f.end_time,
    f.headway_secs,
    ROUND(f.headway_secs / 60.0, 2) AS interval_menit
FROM gtfs.frequencies f
JOIN gtfs.trips t
    ON f.trip_id = t.trip_id
JOIN gtfs.routes r
    ON t.route_id = r.route_id;