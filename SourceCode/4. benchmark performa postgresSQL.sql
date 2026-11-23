-- Tahap 12 — Benchmark performa PostgreSQL
-- 1.Pengujian tanpa index
SET enable_indexscan = OFF;
SET enable_indexonlyscan = OFF;
SET enable_bitmapscan = OFF;

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    s.stop_name,
    COUNT(*) AS jumlah_perjalanan
FROM gtfs.stop_times st
JOIN gtfs.stops s
    ON st.stop_id = s.stop_id
WHERE s.stop_id = (
    SELECT stop_id
    FROM gtfs.stops
    WHERE stop_name ILIKE '%Blok M%'
    LIMIT 1
)
GROUP BY s.stop_name;

-- 2. Pengujian dengan index
RESET enable_indexscan;
RESET enable_indexonlyscan;
RESET enable_bitmapscan;

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    s.stop_name,
    COUNT(*) AS jumlah_perjalanan
FROM gtfs.stop_times st
JOIN gtfs.stops s
    ON st.stop_id = s.stop_id
WHERE s.stop_id = (
    SELECT stop_id
    FROM gtfs.stops
    WHERE stop_name ILIKE '%Blok M%'
    LIMIT 1
)
GROUP BY s.stop_name;

-- tahap 13 - mengukur database
SELECT
    pg_size_pretty(
        pg_database_size('transjakarta')
    ) AS ukuran_database;

SELECT
    relname AS nama_tabel,
    pg_size_pretty(
        pg_total_relation_size(relid)
    ) AS ukuran_total
FROM pg_catalog.pg_statio_user_tables
WHERE schemaname = 'gtfs'
ORDER BY pg_total_relation_size(relid) DESC;

