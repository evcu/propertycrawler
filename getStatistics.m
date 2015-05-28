function [ output ] = getStatistics(file)
%GETUNIQUE Summary of this function goes here
%   Gets the element set for the spec at the column of the property
fid = fopen(file);
c = textscan(fid,'%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n','delimiter',',');
output=cell(size(c));

  
 for i=1:size(output,2)
   output{1,i} = unique(c{1,i}); 
 end
 
 if(size(output{1,1})~=size(c{1,1}))
    error 'Yo need to remove duplicates'; 
 end
 
 
fclose(fid);

end

