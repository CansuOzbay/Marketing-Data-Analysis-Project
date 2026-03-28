with session_metrics as (
select
concat(user_pseudo_id,cast((select value.int_value from unnest(event_params)where key='ga_session_id')as string))as unique_session_id,
max(cast(coalesce((select value.string_value from unnest(event_params)where key='session_engaged'),'0')as int64))as is_engaged,
sum(coalesce((select value.int_value from unnest(event_params)where key='engagement_timemsec'),0))as total_engagement_time,
max(if(event_name='purchase',1,0))as has_purchased
from
`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
group by unique_session_id
)
select
corr(is_engaged,has_purchased)as  engagement_presence_correlation,
corr(total_engagement_time,has_purchased)as engagement_time_correlation
from session_metrics
limit 100;