DROP TABLE IF EXISTS icustay_hourly; CREATE TABLE icustay_hourly AS
with all_hours as
(
select
it.stay_id

-- ceiling the intime to the nearest hour by adding 59 minutes then truncating
-- note thart we truncate by parsing as string, rather than using DATETIME_TRUNC
-- this is done to enable compatibility with psql
, PARSE_DATETIME(
'%Y-%m-%d %H:00:00',
FORMAT_DATETIME(
'%Y-%m-%d %H:00:00',
DATETIME_ADD(it.intime_hr, INTERVAL '59' MINUTE)
)) AS endtime

-- create integers for each charttime in hours from admission
-- so 0 is admission time, 1 is one hour after admission, etc, up to ICU disch
-- we allow 24 hours before ICU admission (to grab labs before admit)
, ARRAY(SELECT * FROM generate_series(-24, CEIL(DATETIME_DIFF(it.outtime_hr, it.intime_hr, 'HOUR')))) as hrs

from mimiciv_derived.icustay_times it
)
SELECT stay_id
, CAST(hr AS bigint) as hr
, DATETIME_ADD(endtime, interval '1' hour * CAST(hr AS bigint)) as endtime
FROM all_hours
CROSS JOIN UNNEST(all_hours.hrs) AS hr;