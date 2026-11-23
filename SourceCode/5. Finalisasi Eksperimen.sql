--Memperbarui statistik database
VACUUM ANALYZE;

-- Memeriksa seluruh index
SELECT
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'gtfs'
ORDER BY tablename, indexname;

--Mengukur ukuran penyimpanan setiap tabel
SELECT
    relname AS nama_tabel,
    pg_size_pretty(
        pg_relation_size(relid)
    ) AS ukuran_data,
    pg_size_pretty(
        pg_indexes_size(relid)
    ) AS ukuran_index,
    pg_size_pretty(
        pg_total_relation_size(relid)
    ) AS ukuran_total
FROM pg_catalog.pg_statio_user_tables
WHERE schemaname = 'gtfs'
ORDER BY pg_total_relation_size(relid) DESC;

-- Menyimpan hasil pengujian
CREATE TABLE gtfs.benchmark_results (
    id SERIAL PRIMARY KEY,
    nama_pengujian VARCHAR(100),
    kondisi_index VARCHAR(30),
    execution_time_ms NUMERIC(12,3),
    planning_time_ms NUMERIC(12,3),
    tanggal_pengujian TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT
    relname AS nama_tabel,
    pg_size_pretty(pg_relation_size(relid)) AS ukuran_data,
    pg_size_pretty(pg_indexes_size(relid)) AS ukuran_index,
    pg_size_pretty(pg_total_relation_size(relid)) AS ukuran_total
FROM pg_catalog.pg_statio_user_tables
WHERE schemaname = 'gtfs'
ORDER BY pg_total_relation_size(relid) DESC;

