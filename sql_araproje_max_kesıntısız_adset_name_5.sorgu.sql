with combined_data as (
						select
						ad_date,
						adset_name,
						'facebook'as source,
						impressions from facebook_ads_basic_daily
						inner join facebook_adset on
						facebook_ads_basic_daily.adset_id=facebook_adset.adset_id
						where impressions>0
						union all
						select
						ad_date,
						'google ad group'as adset_name,
						'google'as source,
						impressions from google_ads_basic_daily
						where impressions>0
						),
sequenced_data as (
						select
						adset_name,
						ad_date,
						source,
						row_number()over (partition by adset_name order by ad_date)as row_num
						from combined_data),
islands    as (        
						select
						adset_name,
						source,
						ad_date,
						ad_date-cast(row_num as int)* interval'1 day' as island_id
						from sequenced_data),
durations as  (			
						select
						source,
						adset_name,
						count(*)as kesintisiz_gun_sayisi,
						min(ad_date)as baslangic,
						max(ad_date)as bitis
						from islands
						group by adset_name,island_id,source)
select
source,
adset_name,
kesintisiz_gun_sayisi,
baslangic,
bitis 
from durations 
order by kesintisiz_gun_sayisi desc
limit 1;
