select 
ad_date,
sum(spend)as toplam_harcama,
sum(value)as toplam_deger,
case
	when sum(spend)>0 then sum (value)/sum(spend)
	else
	0
end as Romi
from (select ad_date,value,spend from facebook_ads_basic_daily
union all
select ad_date,value,spend from google_ads_basic_daily)as combined_ads
group by ad_date
order by romi desc,ad_date desc
limit 5;


