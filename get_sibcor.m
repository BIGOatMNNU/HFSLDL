function [sibcor] = get_sibcor(hiercor,Y,tree)
%根据样本特征间的相似度计算兄弟节点间的相似度,不是兄弟用0表示
internalNodes = tree_InternalNodes(tree);
internalNodes(find(internalNodes==-1))=[];
sibcor=zeros(length(Y),length(Y));
for i=1:length(internalNodes)
    if isempty(Y{internalNodes(i)})
        continue
    end
    cur_sib = tree_Sibling(tree,internalNodes(i));
    cur_par=tree(internalNodes(i),1);
    cur_index=find(Y{cur_par}==internalNodes(i));
    cur_cor=hiercor{cur_par}(cur_index,:);
    for j=1:length(cur_sib)
        sib_index=find(Y{cur_par}==cur_sib(j));
        if isempty(sib_index)
            continue
        end
        cur_sib_cor=cur_cor(:,sib_index);
        sibcor(internalNodes(i),cur_sib(j))=mean(mean(cur_sib_cor,2));
    end
end
temp=sibcor;
temp_index=find(temp==0);
temp(temp_index)=[];
if length(temp)>0
sibcor=(sibcor-min(temp))./(max(temp)-min(temp));
end
sibcor(temp_index)=0;
end

