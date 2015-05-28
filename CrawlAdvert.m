function [advertdata] = CrawlAdvert(source, url )
%CrawlAdvert Summary of this function goes here
%   Crawl advert crawls an advert page according to the source it comes
%   from.
%   Source: 1->Sahibinden,2->HurriyetEmlak
%Geting data
    % d1=Ilan No
    % d2=Fiyat
    % d3=Konum_Latitude
    % d4=Konum_Longitude
    % d5=Sehir
    % d6=Ilce
    % d7=Mah/Koy
    % d8=Ilan Tarihi
    % d9=m2
    % d10=Oda Sayisi
    % d11=Banyo Sayisi
    % d12=Bina Yasi
    % d13=Kat Sayisi
    % d14=Bulundugu Kat
    % d15=Isitma
    % d16=KullanimDurumu
    % d17=SiteIcerisinde
    % d18=Krediye Uygun?
    % d19=Kimden
    % d20=html
 if(source==1)
    %Delimiters
    Del1='(?<=ifiedId">)\d+';
    Del2='(?<=h3>\s*)\S[^<]+';
    Del34='(?<=data-l\w\w=")(\d+\.\d+)';
    Del567='(?<=href\S+\s+)\w[^<]+';
    Del8='(?<=Ýlan Tarihi</strong>&nbsp;\s+<span>\s+)\S[^<]*';
    html = urlread(url);
    databegn = strfind(html, 'classifiedInfo ');
    dataend = strfind(html, 'classifiedIdBox');
    cuthtml=html(databegn:dataend);

    d1cell=regexp(cuthtml,Del1, 'match');
    d1=d1cell{1};
    d2cell=regexp(cuthtml,Del2, 'match');
    d2=d2cell{1};
    coorCell=regexp(html,Del34, 'match');
    if(isempty(coorCell))
        d3='NaN';
        d4='NaN';
    else
    d3=coorCell{1};
    d4=coorCell{2};
    end
    locCel=regexp(cuthtml,Del567, 'match');
    d5=locCel{1};
    d6=locCel{2};
    d7=locCel{3};
    d8cell=regexp(cuthtml,Del8, 'match');
    d8=d8cell{1};
    
    bef='(?<=';
    aft='</strong>&nbsp;\s+<span class="">\s+)\S[^<]*';
    d9=PropertyGetter(cuthtml,bef,aft,'m²');
    d10=PropertyGetter(cuthtml,bef,aft,'Oda Sayýsý');
    d11=PropertyGetter(cuthtml,bef,aft,'Banyo Sayýsý');
    d12=PropertyGetter(cuthtml,bef,aft,'Bina Yaþý');
    d13=PropertyGetter(cuthtml,bef,aft,'Kat Sayýsý');
    d14=PropertyGetter(cuthtml,bef,aft,'Bulunduðu Kat');
    d15=PropertyGetter(cuthtml,bef,aft,'Isýtma');
    d16=PropertyGetter(cuthtml,bef,aft,'Kullaným Durumu');
    d17=PropertyGetter(cuthtml,bef,aft,'Site Ýçerisinde');
    d18=PropertyGetter(cuthtml,bef,aft,'Krediye Uygun');
    d19=PropertyGetter(cuthtml,bef,aft,'Kimden');
    advertdata=sprintf('%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s',d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,url);
 end
 
  if(source==2)
    %Delimiters
    Del1='(?<=<span class=''red''>)[^<]+';
    Del2='(?<=class="fz22 ff-m700">)[^<]+';
    Del34='(?<=e" content=")[^"]+';
    Del567='(?<=&amp;new=1">)[^<]+';
    Del19='(?<=listing_ownertype: ")[^"]+';
    html = urlread(url);
    databegn = strfind(html, '<!-- Yan Detay Paneli -->');
    dataend = strfind(html, '  <!-- Kredi Banner -->');
    cuthtml=html(databegn:dataend);

    d1cell=regexp(cuthtml,Del1, 'match');
    d1=d1cell{1};
    d2cell=regexp(cuthtml,Del2, 'match');
    d2=d2cell{1};
    coorCell=regexp(cuthtml,Del34, 'match');
    if(isempty(coorCell))
        d3='NaN';
        d4='NaN';
    else
    d3=strrep(coorCell{1},',','.');
    d4=strrep(coorCell{2},',','.');
    end
    locCel=regexp(cuthtml,Del567, 'match');
    d5=locCel{1};
    d6=locCel{2};
    d7=locCel{3};
    
    bef='(?<=<span><b>';
    aft='</b>)[^<]+';
    d10=PropertyGetter(cuthtml,bef,aft,'Oda [+] Salon');
    d9=PropertyGetter(cuthtml,bef,aft,'Metrekare');
    d9=d9(1:end-3); % To remove the " m2" part
    d12=PropertyGetter(cuthtml,bef,aft,'Bina Yaþý');
    d15=PropertyGetter(cuthtml,bef,aft,'Isýnma Tipi');
    
    d19cell=regexp(html,Del19, 'match');
    if(isempty(d19cell))
        d19='NaN';
    else
        d19=d19cell{1};
    end
    
    bef='(?<=<li><span>';
    aft='</span><span>)[^<]*';
    d8=PropertyGetter(cuthtml,bef,aft,'Ýlan Tarihi');
    d11=PropertyGetter(cuthtml,bef,aft,'Banyo Sayýsý');
    d13=PropertyGetter(cuthtml,bef,aft,'Kat Sayýsý');
    d14=PropertyGetter(cuthtml,bef,aft,'Bulunduðu Kat');
    d16=PropertyGetter(cuthtml,bef,aft,'Kullaným Durumu');
    d17=PropertyGetter(cuthtml,bef,aft,'Site Ýçerisinde');
    d18=PropertyGetter(cuthtml,bef,aft,'Krediye Uygunluk');
    advertdata=sprintf('%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s',d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,url);
 end
 
 
end

