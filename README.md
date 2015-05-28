# propertycrawler
Property Advert Crawler 

This repo contains code written for the web-page crawler for property price estimation project PROPER. 

###Which has bascially following layers in the structure:

CrawlNow(.*)->{CrawlHur(.*),CrawlSah(.*)}\n
**|**\n
{GetProperStartPages.+(.*),CrawlPage(.*)}\n
**|**\
CrawlAdvert(.*)
**|**
PropertyGetter(.*)

*Data fields are like the following.
    * d1=Ilan No
    * d2=Fiyat
    * d3=Konum_Latitude
    * d4=Konum_Longitude
    * d5=Sehir
    * d6=Ilce
    * d7=Mah/Koy
    * d8=Ilan Tarihi
    * d9=m2
    * d10=Oda Sayisi
    * d11=Banyo Sayisi
    * d12=Bina Yasi
    * d13=Kat Sayisi
    * d14=Bulundugu Kat
    * d15=Isitma
    * d16=KullanimDurumu
    * d17=SiteIcerisinde
    * d18=Krediye Uygun?
    * d19=Kimden
    * d20=html

###After crawling data into csv-like structure. I do preprocess the data to use it with the UFLDL-Codes that I completed with following

PrepareData(.*)
**|**
preProcessor(.*)

####I also used GetStatistics(.*) method to get the unique instances of the fields. 

##TODO's
-Improve PrepareData, such that it may ask the user how to represent and remember after! Which would be easy. 
-Improve Crawling such that no manual entries in GetProperStartPages exists.
-Improve data respresentation. Binary feature data for a lot of things needed. 

 
