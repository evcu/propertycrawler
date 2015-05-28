function [error] = CrawlHur(fdata,flog)
%CrawlSah Summary of this function goes here
%   Detailed explanation goes here
% This function crawls hurriyet property in Sariyer district.DEMO
%TODO: Count errors at adverts and log the error percentage
    totalerror=0;
    totalA=0;
    tic;
    properStartPages=GetProperStartPagesHur(flog);
    fprintf(flog,'\t%f seconds for GetProperStartPages\n', toc); tic;
    try
         for k=1:size(properStartPages,2)
            totalA=totalA+properStartPages{2,k};
            currentpage=properStartPages{1,k};
            pagej=urlread(currentpage);
            fprintf('%dst interval has %d Adverts in %d Pages\n',k,properStartPages{2,k},properStartPages{3,k});
            for j=1:properStartPages{3,k}
                fprintf('%d/%d Page is being crawled\n',j,properStartPages{3,k});
                pageerror=CrawlPage(2,pagej,fdata,flog);
                totalerror=totalerror+pageerror;
                fprintf(flog,'%d/%d Page is crawled.%d errors occured\n',j,properStartPages{3,k},pageerror);
                if(j==properStartPages{3,k}) 
                   continue;
                end
                %TODO two pagingOffset seems unnecessary
                currentpage=sprintf('%s&page=%d',properStartPages{1,k},j+1); 
                pagej=urlread(currentpage); 
            end
            tt=toc;
            fprintf(flog,'\t%f seconds for Interval:%d. Speed: %f pages per second\n',tt,k,properStartPages{3,k}); tic;
         end
        fprintf('%d/%d Adverts in Hurriyet succesfully crawled.!!\nError rate:%f\n',totalA-totalerror,totalA,totalerror/totalA);
        fprintf(flog,'%d/%d Adverts in Hurriyet succesfully crawled.!!\nError rate:%f\n',totalA-totalerror,totalA,totalerror/totalA);
        error=0;
        return;
    catch
        fprintf('CrawlSah stopped and not crawled\n');
        fprintf(flog,'Aproblem occured at CrawlSah %d Page of %d Interval \nHtml:%s\n',j,k,currentpage);
        error=1;
        return;
    end
end



