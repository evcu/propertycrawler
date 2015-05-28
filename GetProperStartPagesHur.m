function [ startPages_cell ] = GetProperStartPagesHur(flog)
%GetProperStartPages Summary of this function goes here
%   Gives the search links for Hurriyetç Hürriyet shows maximum of 2000
%   adverts per search, so one need to create different searches.
%   2.row:totalAdvert 3.row:totalpages
%TODO get search htmls automatically.
%TODO I am getting 850 from the #totaladvert 1.850. Delimiter needed to be
%changed for safety.
  delimiter='(?<="mr5 fl">\d\.)\d{3}';
  totalhtml=4;
  tempcell=cell(1);
  startPages_cell=cell(3,totalhtml);
  startPages_cell{1,1}='http://www.hurriyetemlak.com/konut-satilik/istanbul-sariyer/listeleme?rsc=eRNA3xMId--o6NjOxkWPUd6fVSvxs6C2TXgoDqLsx2rDb8kSSV4XgBrx%2eoZMXw2chajgGFoQ6nCgDCPkDLsQA7VDFi-mgp0S&pageSize=50&new=1';
  startPages_cell{1,2}='http://www.hurriyetemlak.com/konut-satilik/istanbul-sariyer/listeleme?rsc=eRNA3xMId--o6NjOxkWPUd6fVSvxs6C2TXgoDqLsx2rDb8kSSV4XgBrx%2eoZMXw2cQQ5N2lU7lI-wEgDq4BpdIenJsPsTbOizCkMtLQ%2e0sY6Vtq1cGaOjkQ==&pageSize=50&new=1';  
  startPages_cell{1,3}='http://www.hurriyetemlak.com/konut-satilik/istanbul-sariyer/listeleme?rsc=eRNA3xMId--o6NjOxkWPUd6fVSvxs6C2TXgoDqLsx2rDb8kSSV4XgBrx%2eoZMXw2c9wq6cNuMP2UQup70pt0sntv-iOf1xebmQyKkZYlfnemZY0TL-Lq4tw==&pageSize=50&new=1';
  startPages_cell{1,4}='http://www.hurriyetemlak.com/konut-satilik/istanbul-sariyer/listeleme?rsc=eRNA3xMId--o6NjOxkWPUd6fVSvxs6C2TXgoDqLsx2rDb8kSSV4XgBrx%2eoZMXw2c9xuKwvMz6-NFAljuBvIuDlYrLpOlpRip&pageSize=50&new=1';
  for i=1:totalhtml
        pagej=urlread(startPages_cell{1,i});
        tempcell=regexp(pagej,delimiter, 'match');
        totalAdvert=1000+str2double(tempcell{1});
        assert((1000<totalAdvert&&totalAdvert<2000),sprintf('The page you want to crawl has %d Adverts\nThe link is: %s',totalAdvert,startPages_cell{1,i}));
        startPages_cell{2,i}=totalAdvert;
        startPages_cell{3,i}=ceil(totalAdvert/50);
        fprintf(flog,'Interval %d: %s\n%d Adverts in %d Pages\n',i,  startPages_cell{1,i},startPages_cell{2,i},startPages_cell{3,i});
  end
end

