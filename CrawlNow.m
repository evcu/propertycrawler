function [ fNameData, fNameLog,firstErrorat ] = CrawlNow()
%CrawlNow Summary of this function goes here
%   This is the main crawling func. It creates the log and data files. Then
%   it calls the crawler for different wepages with the filenumbers. If one
%   ofthe crawlers encounters with a problem then it stops and returns the
%   number of the crawler. 1->Sahibinden 2-> Hurriyet in firstErrorAt. If
%   there is no error then firstErrorAt is 0;
%TODO CrawlHur
%TODO try-catch lere Error writing eklemek lazim!
firstErrorat=0;
now=datestr(datetime('now'));
now(ismember(now,' ,.:;!')) = '-';
fNameData=sprintf('data/%s_data.txt',now);
fNameLog=sprintf('data/%s_log.txt',now);
fdata = fopen(fNameData,'w');
flog = fopen(fNameLog,'w');
fprintf(flog,'Log start recording at %s\n',now);
% % if CrawlSah(fdata,flog)
% %   fprintf(flog,'CrawlNow stop crawling Sahibinden\n');
% %   firstErrorat=1;
% if CrawlHur(fdata,flog)
%   fprintf(flog,'CrawlNow stop crawling Hurriyet\n');
%   firstErrorat=2;
% end
CrawlSah(fdata,flog)
CrawlHur(fdata,flog)

finished=datestr(datetime('now'));
finished(ismember(finished,' ,.:;!')) = '-';

fprintf(flog,'Log ended recording at %s\n',finished);
fclose(fdata);
fclose(flog);
return;
end

