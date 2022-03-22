function [treecor] = get_treecor(tree)
%根据树结构计算节点间的相似度
[r,~]=size(tree);
for i=1:r
    n=i;
    while(n~=0)
        label(i,n)=1;
        n=tree(n,1);
    end  
end
for i=1:r
    for j=1:r
        treecor(i,j)=corr(label(i,:)',label(j,:)','type','pearson');
    end
end
end

