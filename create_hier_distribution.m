function [Yd] = create_hier_distribution(Y,tree,cor,alpha,beta)
%建立层次标记分布
internalNodes = newtree_InternalNodes(tree);
internalNodes(find(internalNodes==-1))=[];
indexRoot = tree_Root(tree);% The root of the tree
noLeafNode =[internalNodes;indexRoot];
for i = 1:length(noLeafNode)
    m(noLeafNode(i)) = length(find(tree(:,1)==noLeafNode(i)));
end
maxm=max(m);
for i = 1:length(noLeafNode)
    children_set = get_children_set(tree, noLeafNode(i));
    Y{noLeafNode(i)}=myconversionY01(Y{noLeafNode(i)},length(children_set),children_set);%extend 2 to [1 0]
end


for i=1:length(noLeafNode)
    if isempty(Y{noLeafNode(i)})
        continue
    end
    path=tree(noLeafNode(i),2);
    for j=1:size(Y{noLeafNode(i)},1)
        y1=Y{noLeafNode(i)}(j,:);
        y2=Y{noLeafNode(i)}(j,:)+path;
        y2=y2/sum(y2);
        %         cor_sum=sum(cor{noLeafNode(i)}(j,:))-1;
        y3=Y{noLeafNode(i)};
        y3_temp=[];
        cor_temp=cor{noLeafNode(i)}(j,:);
        y3(j,:)=[];%去掉自己
        cor_temp(j)=[];%去掉自己
        if length(cor_temp)>1
            cor_temp=(cor_temp-min(cor_temp))./(max(cor_temp)-min(cor_temp));%归一化，拉大差距
        end
        [~,col]=size(y3);
        y3_temp=y3.* repmat(cor_temp',[1,col]);
        
        y3=sum(y3,1);
        y3_temp=sum(y3_temp,1);
        y3=y3_temp./y3;%除以每个类别的个数，防止多样本的类别有更大的影响
        y3(find(isnan(y3)==1))=0;
        y3=y3/sum(y3);
        Yd{noLeafNode(i)}(j,:)=(1-alpha-beta)*y1+alpha*y2+beta*y3;
    end
end

