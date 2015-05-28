function [totalerror] = CrawlPage(source, pagej,fdata,flog )
%CrawlAdvert Summary of this function goes here
%   Crawl advert crawls an advert page according to the source it comes
%   from.
%   Source: 1->Sahibinden,2->HurriyetEmlak
%TODO use regular exp in sahibinden link searching instead of stread.
MAX_ADVERT_PER_PAGE=50;
if(source==1)
    indx=strfind(pagej,'<a href="/ilan/');
    totalerror=0;
    assert((size(indx,2)<=MAX_ADVERT_PER_PAGE),'Number of adverts in a page can not be grater then 50');
    for i=1:size(indx,2)
        try
            %fprintf('Advert %d of %d\n',i,size(indx,2));
            cuthtml=pagej(indx(i):indx(i)+200);
            t2=strread(cuthtml, '%s', 'delimiter', '>');
            t3=t2{1};
            %TODO Can be shorten
            t3=strcat('http://www.sahibinden.com',t3(10:end-1));
            adata=CrawlAdvert(1,t3);
            fprintf(fdata,'%s\n',adata);
        catch
            fprintf('The advert %d in the interval failed.\n%s\n',i,t3);
            fprintf(flog,'The advert %d in the interval failed.\n%s\n',i,t3);
            totalerror=totalerror+1;
        end
    end
    return;
end


 if(source==2)
    totalerror=0;
    adverttoken='(?<=href=")[^"]+';
    indx=strfind(pagej,'lnkRedirectRealtyDetail_');
    assert((size(indx,2)<=MAX_ADVERT_PER_PAGE),'Number of adverts in a page can not be grater then 50');
    for i=1:size(indx,2)
        try
            %fprintf('Advert %d of %d\n',i,size(indx,2));
            cuthtml=pagej(indx(i):indx(i)+400);
            tempcell=regexp(cuthtml,adverttoken, 'match');
            %TODO Can be shorten
            t3=strcat('http://www.hurriyetemlak.com',tempcell{1});
            adata=CrawlAdvert(2,t3);
            fprintf(fdata,'%s\n',adata);
        catch 
            fprintf('The advert %d in the interval failed.\n%s\n',i,t3);
            fprintf(flog,'The advert %d in the interval failed.\n%s\n',i,t3);
            totalerror=totalerror+1;
        end
    end
    return;
 end
end

