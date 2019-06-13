% clc
% clear
% fid = fopen('train.csv');
% out = textscan(fid,'%f%s','delimiter',',');
% fclose(fid);
% 
% col1 = out{1};
% col2 = out{2};



%train.csv

id = train{:,1};
class = train{:,2};


%class(id == 71)