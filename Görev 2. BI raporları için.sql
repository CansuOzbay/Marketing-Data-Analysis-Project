SELECT 
timestamp_micros(event_timestamp)as event_timestamp,
user_pseudo_id,
(select value.int_value from unnest(event_params)where key='ga_session_id')as session_id,
event_name,
geo.country as country,
traffic_source.source as source,
traffic_source.medium as medium,
traffic_source.name as campaign
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
where
_table_suffix between '20210101' AND '20211231'and
event_name in( 'session_start', 'view_item', 'add_to_cart', 
        'begin_checkout', 'add_shipping_info', 
        'add_payment_info', 'purchase'
    )
LIMIT 100