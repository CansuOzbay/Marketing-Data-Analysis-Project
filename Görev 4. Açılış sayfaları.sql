with session_landing_pages as(
select 
concat(user_pseudo_id ,cast((select value.int_value from unnest(event_params)where key='ga_session_id')as string))as unique_session_id,
regexp_extract (
  (select value.string_value from unnest(event_params)where key='page_location'),r'https?://[^/]+(/[^?#]*)'
)as page_path,
event_name
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
where _table_suffix between '20200101'and'20201231'),
session_behavior as(
select
unique_session_id,
max(if(event_name='session_start',page_path,null))as start_page,
max(if(event_name='purchase',1,0))as has_purchased
from session_landing_pages
group by unique_session_id)
select
coalesce(start_page,'(not_set)')as landing_page_path,
count(distinct unique_session_id)as total_sessions,
sum(has_purchased)as total_purchases,
safe_divide(sum(has_purchased),count(distinct unique_session_id))as conversation_rate
from
session_behavior
group by 1
order by total_sessions desc
limit 100;





