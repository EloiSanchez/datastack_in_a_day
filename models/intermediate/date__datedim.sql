with

date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2000-01-01' as date)",
        end_date=dbt_date.today("Europe/Brussels")
    )
    }}
),

date_dim as (
    select
        date_day,
        day(date_day) as day,
        week(date_day) as week,
        month(date_day) as month,
        quarter(date_day) as quarter,
        year(date_day) as year
    from date_spine
)

select * from date_dim