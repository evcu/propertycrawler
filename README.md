# propertycrawler
Property Advert Crawler 

This repo contains code written for the web-page crawler for property price estimation project PROPER. 

###Which has bascially following layers in the structure:

#####CrawlNow(.*)
#####|
#####{CrawlHur(.*),CrawlSah(.*)}
#####|
#####{GetProperStartPages.+(.*),CrawlPage(.*)}
#####|
#####CrawlAdvert(.*)
#####|
#####PropertyGetter(.*)
*Data fields are like the following.
1. d1=Ilan No
2. d2=Fiyat
3. d3=Konum_Latitude
4. d4=Konum_Longitude
5. d5=Sehir
6. d6=Ilce
7. d7=Mah/Koy
8. d8=Ilan Tarihi
9. d9=m2
10. d10=Oda Sayisi
11. d11=Banyo Sayisi
12. d12=Bina Yasi
13. d13=Kat Sayisi
14. d14=Bulundugu Kat
15. d15=Isitma
16. d16=KullanimDurumu
17. d17=SiteIcerisinde
18. d18=Krediye Uygun?
19. d19=Kimden
20. d20=html

###After crawling data into csv-like structure. I do preprocess the data to use it with the UFLDL-Codes that I completed with following

#####PrepareData(.*)
#####|
#####preProcessor(.*)

####I also used GetStatistics(.*) method to get the unique instances of the fields. 

##TODO's
-Improve PrepareData, such that it may ask the user how to represent and remember after! Which would be easy. 
-Improve Crawling such that no manual entries in GetProperStartPages exists.
-Improve data respresentation. Binary feature data for a lot of things needed. 

 
