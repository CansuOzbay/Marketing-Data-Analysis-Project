with aylık_toplamlar as (
						select
						date_trunc('month',ad_date)::date as ay,
						campaign_name,
						sum(reach)as aylık_erısım
						from facebook_ads_basic_daily
						left join facebook_campaign on 
						facebook_ads_basic_daily.campaign_id=facebook_campaign.campaign_id
						group by ay,campaign_name
						union all
						select
						date_trunc('month',ad_date)::date as ay,
						campaign_name,
						sum(reach)as aylık_erısım
						from google_ads_basic_daily
						group by ay,campaign_name),
	artıs_hesabı as 
					  (
					   select
					   ay,campaign_name,aylık_erısım,
					   lag(aylık_erısım)over (partition by campaign_name order by ay)as önceki_ay_erısım
					   from aylık_toplamlar)
select 
ay,
campaign_name,
aylık_erısım-önceki_ay_erısım as erısım_artısı
from artıs_hesabı
where önceki_ay_erısım is not null
order by erısım_artısı desc
limit 1;
					
						