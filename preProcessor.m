function [ data ] = preProcessor(file,preproclog)
%GETUNIQUE Summary of this function goes here
%   Prepares the data as a double matrix.
    % d2=Fiyat
    % d9=m2
    % d10=Oda Sayisi
    % d11=Banyo Sayisi
    % d12=Bina Yasi
    % d13=Kat Sayisi
    % d14=Bulundugu Kat
    % d15=Isitma
	%%TODO need to be better representation of the data which includes multiple sources...
    dolar=2.59;
    euro=2.89;
    count=1;
fid = fopen(file);
c = textscan(fid,'%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n','delimiter',',');
data=zeros(size(c{1,1},1),9);

for i=1:size(c{1,1},1)
    try
        temp=strsplit(c{1,2}{i,1});
        if strcmp(temp{1},'$')
           tprice=str2double(strrep(temp{2},'.',''))*dolar;
        elseif strcmp(temp{1},'€')
           tprice=str2double(strrep(temp{2},'.',''))*euro;
        elseif strcmp(temp{2}, 'USD')
           tprice=str2double(strrep(temp{1},'.',''))*dolar;
        elseif strcmp(temp{2}, 'EUR')
           tprice=str2double(strrep(temp{1},'.',''))*euro;
        elseif strcmp(temp{2}, 'TL')
           tprice=str2double(strrep(temp{1},'.',''));
        else
           fprintf(preproclog,'INVALID:%dth line:%s failed.Due to Price\n%s\n',i,c{1,2}{i,1},c{1,20}{i,1});
           continue; 
        end
    catch 
        fprintf(preproclog,'ERROR:%dth line failed.Due to Price\n',i);
        continue;
    end %d2
    try
    temp=strsplit(c{1,9}{i,1});
    tm2=str2double(strrep(temp{1},'.',''));
        if(tm2>1000) 
            fprintf(preproclog,'INVALID:%dth line:%s failed.Due to m2\n%s\n',i,c{1,9}{i,1},c{1,20}{i,1});
            continue;
        end
    catch
        fprintf(preproclog,'ERROR:%dth line:%s failed.Due to m2\n%s\n',i,c{1,9}{i,1},c{1,20}{i,1});
        continue; 
    end %d9
    try %d10
        if strcmp(c{1,10}{i,1},'Stüdyo (1+0)')
            toda=1;
            tsalon=0;
        else
        temp=strsplit(c{1,10}{i,1},'+');
        assert((size(temp,2)==2),'Oda sayisi x+y konseptinde degil');
        toda=str2double(temp{1});
        tsalon=str2double(temp{2}); 
        end   
    catch
        fprintf(preproclog,'ERROR:%dth line:%s failed.Due to Oda Sayisi\n%s\n',i,c{1,10}{i,1},c{1,20}{i,1});
        continue; 
    end
    try %d11
        tbanyo=str2double(c{1,11}{i,1});
        assert(~isnan(tbanyo),'Banyo sayisi rakam degil');  
    catch
        fprintf(preproclog,'ERROR:%dth line:%s failed.Due to Banyo Sayisi\n%s\n',i,c{1,11}{i,1},c{1,20}{i,1});
        continue; 
    end
    try %d12
        temp=strsplit(c{1,12}{i,1});
        temp=strsplit(temp{1},'-');
        tbinayas=str2double(temp{1});
        assert(~isnan(tbinayas),'Bina yasi belirtilmemis');  
    catch
        fprintf(preproclog,'ERROR:%dth line:%s failed.Due to Bina Yasi\n%s\n',i,c{1,12}{i,1},c{1,20}{i,1});
        continue; 
    end
    try %d13
        temp=strsplit(c{1,13}{i,1});
        tkats=str2double(temp{1});
        assert(~isnan(tkats),'Kat sayisi belirtilmemis');  
    catch
        fprintf(preproclog,'ERROR:%dth line:%s failed.Due to Kat Sayisi\n%s\n',i,c{1,13}{i,1},c{1,20}{i,1});
        continue; 
    end
    %TODO bahce kat-cati kati-giris kati ozellikleri ekle
    try %d14
        temp=c{1,14}{i,1};
        if strcmp(temp,'Çatý Katý')
        tbulkat=tkats;
        elseif strcmp(temp,'Giriþ Katý')||strcmp(temp,'Bahçe Katý')||strcmp(temp,'Yüksek Giriþ')
        tbulkat=1;
        else
        tbulkat=str2double(temp);
        assert(~isnan(tbulkat),'Bulundugu Kat belirtilmemis');  
        end
    catch
        fprintf(preproclog,'ERROR:%dth line:%s failed.Due to Bulundugu Kat\n%s\n',i,c{1,14}{i,1},c{1,20}{i,1});
        continue; 
    end
    %TODO isi pay olceri koy
    try %d15
        temp=c{1,15}{i,1};
        if strfind(temp,'Doðalgaz') 
        tisit=2;
        elseif strfind(temp,'Merkezi')
        tisit=1;  
        else
        error('Merkezi veya Dogalgaz degil');  
        end
    catch
        fprintf(preproclog,'ERROR:%dth line:%s failed.Due to Isitma\n%s\n',i,c{1,15}{i,1},c{1,20}{i,1});
        continue; 
    end
    
    data(i,:)=[tprice/20000 tm2/20 toda tsalon tbanyo tbinayas tkats tbulkat tisit];
end

    
    fclose(fid);

end

