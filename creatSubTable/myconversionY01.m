function [ output_args ] = myconversionY01( Y, numCol,children_set)
%�ڵ���Ŵ�С����
output_args=zeros(length(Y),numCol);
for i = 1:length(Y)
    indx=find(children_set==Y(i));
    output_args(i,indx)=1;
end
end

