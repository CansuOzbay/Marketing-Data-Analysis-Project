select 
'facebook' as source,
max(spend)as maksimum_harcama,
min(spend)as minimum_harcama,
Round(avg(spend)::int )as ortalama_harcama
from facebook_ads_basic_daily
union all
select 
'google'as source,
max(spend)as maksimum_harcama,
min(spend)as minimum_harcama,
round(avg(spend)::integer)as ortalama_harcama
from google_ads_basic_daily;