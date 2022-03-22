function [ output_args ] = myconversionY01( Y, numCol,children_set)
%节点序号从小到大
output_args=zeros(length(Y),numCol);
for i = 1:length(Y)
    indx=find(children_set==Y(i));
    output_args(i,indx)=1;
end
end

