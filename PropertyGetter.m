function [ data ] = PropertyGetter(cuthtml,before,after,property )
%PropertyGetter Summary of this function goes here
%   Gets the asked property from the cutHTML
%   Source: 1->Sahibinden,2->HurriyetEmlak
   delimiter=sprintf('%s%s%s',before,property,after);
   datacell=regexp(cuthtml,delimiter, 'match');
   if(isempty(datacell)||strcmp(datacell{1},','))
      data='NaN';
   else
      data=datacell{1};
   end
end

