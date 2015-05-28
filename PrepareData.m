function [train,test] = PrepareData(datatxt)
%PrepareData Summary of this function goes here
%   This is the script to call preProcessing calls and prepare the learning
%   set
now=datestr(datetime('now'));
now(ismember(now,' ,.:;!')) = '-';
fNameLog=sprintf('PreProcess/%s_log.txt',now);
flog = fopen(fNameLog,'w');
fprintf(flog,'Log start recording at %s\n',now);
% % if CrawlSah(fdata,flog)
% %   fprintf(flog,'CrawlNow stop crawling Sahibinden\n');
% %   firstErrorat=1;
% if CrawlHur(fdata,flog)
%   fprintf(flog,'CrawlNow stop crawling Hurriyet\n');
%   firstErrorat=2;
% end
data=preProcessor(datatxt,flog);
data = data(any(data,2),:);
data=data';

data = [  data;ones(1,size(data,2)) ];
% Shuffle examples.
data = data(:, randperm(size(data,2)));
% Split into train and test sets
% The last row of 'data' is the median home price.
%%TODO need to be not fixed sizes, I used this for for the first trial.
train.X = data(2:end,1:2000);
train.y = data(1,1:2000);

test.X = data(2:end,2001:end);
test.y = data(1,2001:end);

finished=datestr(datetime('now'));
finished(ismember(finished,' ,.:;!')) = '-';

fprintf(flog,'Log ended recording at %s\n',finished);
fclose(flog);
return;
end

