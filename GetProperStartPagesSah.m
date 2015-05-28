function [ startPages_cell ] = GetProperStartPagesSah(mainhtml,flog)
%GetProperStartPages Summary of this function goes here
%   Gives first pages of search results for total founded advert between
%   500<#totalperHTML<1000. Return 3*N matrix where 1.row:link
%   2.row:totalAdvert 3.row:totalpages
%TODO find proper price indeces.
  minMaxFlags=[600000 1000000 2000000 3500000];
  minMaxVals=[0 minMaxFlags intmax];
  totalhtml=size(minMaxFlags,2)+1;
  startPages_cell=cell(3,totalhtml);
    for i=1:totalhtml
        startPages_cell{1,i}=sprintf('%s&price_min=%d&price_max=%d',mainhtml,minMaxVals(i),minMaxVals(i+1)-1);
        pagej=urlread(startPages_cell{1,i});
        target=strfind(pagej,'ilan</span>');
        totalAdvert=sscanf(pagej(target-4:target),'%d%*s');
        assert((99<totalAdvert&&totalAdvert<1000),sprintf('The page you want to crawl has %d Adverts\nThe link is: %s',totalAdvert,startPages_cell{1,i}));
        startPages_cell{2,i}=totalAdvert;
        startPages_cell{3,i}=ceil(totalAdvert/50);
        fprintf(flog,'Interval %d: %s\n%d Adverts in %d Pages\n',i,  startPages_cell{1,i},startPages_cell{2,i},startPages_cell{3,i});
    end
end

