with CTE as (
    select
    TO_TIMESTAMP(STARTED_AT) as STARTED_AT, DATE(TO_TIMESTAMP(STARTED_AT)) as DATE_STARTED_AT,
    hour(TO_TIMESTAMP(STARTED_AT)) as HOUR_STARTED_AT,
    CASE
        WHEN DAYNAME(TO_TIMESTAMP(STARTED_AT)) in ('Sat', 'Sun')
        THEN 'WEEKEND'
        ELSE 'BUSINESSDAY'
        END as DAY_TYPE,
    case 
        when month(TO_TIMESTAMP(STARTED_AT)) in (12,1,2) then 'WINTER'
        when month(TO_TIMESTAMP(STARTED_AT)) in (3,4,5) then 'SPRING'
        when month(TO_TIMESTAMP(STARTED_AT)) in (6,7,8) then 'SUMMER'
        ELSE 'AUTUMN'
        end as station_of_year
        

    from {{ source('demo', 'bike') }} 
    where STARTED_AT != 'started_at'
)

select * from CTE