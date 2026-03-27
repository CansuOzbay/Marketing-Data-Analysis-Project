with campaign_data as 
					(select
					fabd.ad_date,
					fc.campaign_name,
					fabd.value 
					from facebook_ads_basic_daily fabd
					left join facebook_campaign fc on 
					fabd.campaign_id=fc.campaign_id
					union all
					select
					ad_date,campaign_name,value
					from google_ads_basic_daily),
weekly_total as (select
					date_trunc('week',ad_date)::date as hafta,
					campaign_name,
					sum(coalesce(value,0))as haftalık_toplam_deger
					from campaign_data 
					group by hafta,campaign_name)
select 
hafta as rekor_haftası,
campaign_name as rekor_kampanya,
max(haftalık_toplam_deger) as rekor_deger
from weekly_total
group by hafta,campaign_name
order by rekor_deger desc
limit 1;

