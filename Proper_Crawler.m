function [ out ] = Proper_Crawler( fullURL )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
str = urlread(fullURL);
idx = strfind(str, 'pageTrackData');
s2=str(idx:end);
A = strread(s2, '%s', 'delimiter', sprintf('\n'));
s3=A{1};
Latindex = strfind(str, 'data-lat');
if(isempty(Latindex))
  out=sprintf('0,0\n%s',s3);  
   return;
end
idx2 = strfind(str(Latindex:end), '"');
Lat=str(idx2(1)+Latindex:idx2(2)+Latindex-2);
Long=str(idx2(3)+Latindex:idx2(4)+Latindex-2);
out=sprintf('%s,%s\n%s',Lat,Long,s3);
end

