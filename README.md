# Marketing-Data-Analysis-Project
Google and Facebook ads performance analysis using SQL (PostgreSQL &amp; BigQuery).
Dijital Pazarlama Reklam Performans Analizi (SQL)

Bu proje, Google ve Facebook reklam kanallarından gelen verilerin PostgreSQL (DBeaver) ve BigQuery kullanılarak analiz edilmesini içerir. Veri analisti bakış açısıyla reklam harcamaları, dönüşüm oranları (ROMI) ve kampanya performans metrikleri hesaplanmıştır.

## 🚀 Proje Kapsamı ve Görevler

### Görev 1: Online Kampanya Detaylarının Analizi (PostgreSQL/DBeaver)
Bu bölümde Google ve Facebook reklam verileri birleştirilerek aşağıdaki analizler yapılmıştır:
- **Harcama İstatistikleri:** Günlük harcama metriklerinin ortalama, maksimum ve minimum değerlerinin hesaplanması.
- **ROMI Analizi:** Yatırım getirisinin (ROMI) hesaplanması ve en yüksek performans gösteren 5 günün belirlenmesi.
- **Kampanya Performansı:** Haftalık bazda en yüksek gelir (value) getiren kampanyaların tespiti.
- **Erişim Analizi:** Aylık bazda en büyük erişim (reach) artışı yaşayan kampanyaların belirlenmesi.

## 🛠️ Kullanılan Teknikler
- **Common Table Expressions (CTE):** Karmaşık sorguları daha okunabilir ve yönetilebilir hale getirmek için kullanıldı.
- **Joins & Union All:** Farklı veri kaynaklarından (Google & Facebook) gelen tabloları birleştirmek ve normalize etmek için uygulandı.
- **Aggregate Functions:** SUM, AVG, MAX, MIN gibi fonksiyonlarla metrikler özetlendi.
- **Window Functions:** Veriler arasında sıralama ve değişim analizi yapmak için kullanıldı.

### Görev 2 & 3: GA4 Etkinlik ve Dönüşüm Analizi (BigQuery)
- *Google Analytics 4 (GA4):* Ham etkinlik verileri (events) kullanılarak kullanıcı bazlı oturum ve dönüşüm tabloları oluşturuldu.
- *Kullanıcı Tanımlama:* Farklı kullanıcıların aynı session_id'ye sahip olma riskine karşı user_id + session_id kombinasyonu ile benzersiz oturum takibi yapıldı.
- *Dönüşüm Hunisi:* Sepete ekleme (add_to_cart), ödeme başlangıcı (begin_checkout) ve satın alma (purchase) adımları arasındaki dönüşüm oranları hesaplandı.

## 🛠️ Kullanılan Teknikler
-Aynı session_idye sahip farklı kullanıcılar olabilir, bu yüzden user_id + session_id kombinasyonu kullanıldı.
-Boş değerler COALESCE fonksiyonu ile kontrol edildi.

### Görev 4: Açılış Sayfası Dönüşüm Analizi (Landing Page Conversion)
- **Sayfa Bazlı Analiz:** 2020 yılı verileriyle, kullanıcıların ilk temas kurduğu açılış sayfalarının (landing pages) performansı ölçüldü.
- **Dönüşüm Oranı (CR):** Benzersiz oturum sayısı ile satın alma (purchase) etkinlikleri eşleştirilerek sayfa bazlı dönüşüm oranları hesaplandı.
- **Teknik Detay:** `session_start` ve `purchase` olaylarının farklı URL'lerde gerçekleşme ihtimaline karşı eşleştirme `user_id` + `session_id` üzerinden yapıldı.

### Görev 5: Kullanıcı Etkileşimi ve Satın Alma Korelasyonu (Korelasyon Analizi)
- **Etkileşim Analizi:** Her oturum için `session_engaged` durumu ve milisaniye bazında toplam etkileşim süresi hesaplandı.
- **Korelasyon:** Kullanıcıların sitede geçirdiği sürenin ve etkileşim düzeyinin satın alma kararı üzerindeki etkisi analiz edildi.
- **Veri Temizliği:** Analiz sırasında karşılaşılan boş değerler (null), veritabanı tutarlılığı için `COALESCE` fonksiyonu ile yönetildi.
- 
## 📊 Veri Seti Hakkında
Projede `ads_analysis_goit_course` veritabanındaki `facebook_ads_basic_daily` ve `google_ads_basic_daily` tabloları,bıgquery için Google Analytics 4 (GA4) veri seti kullanılmıştır.
