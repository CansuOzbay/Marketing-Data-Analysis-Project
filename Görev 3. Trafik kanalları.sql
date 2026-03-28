with base_events as (
  select
  extract(date from timestamp_micros(event_timestamp))as event_date,
  concat(user_pseudo_id,cast((select value.int_value from unnest(event_params)where key='ga_session_id')as string))as unique_session_id,
  traffic_source.source as source,
  traffic_source.medium as medium,
  traffic_source.name as campaign,
  event_name
  from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  where
  _table_suffix between '20200101'and'2021231')
  select
  event_date,source,medium,campaign,
  count(distinct if(event_name='session_start',unique_session_id,null))as user_sessions_count,
  count(distinct if(event_name='add_to_cart',unique_session_id,null))as visit_to_cart,
  count(distinct if(event_name='begin_checkout',unique_session_id,null))as visit_to_checkout,
  count(distinct if (event_name='purchase',unique_session_id,null))as visit_to_purchase
  from
  base_events
  group by 1,2,3,4
  order by event_date desc
  limit 100;
  
