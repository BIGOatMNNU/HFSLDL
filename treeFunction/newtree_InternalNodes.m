function [ middleNode ] = newtree_InternalNodes( tree )
%���ϵ��·����м�ڵ�
%���ö���˼��
root = tree_Root( tree );
middleNode=[];
middle = get_children_set(tree, root);
leafNode = tree_LeafNode( tree );
while ~isempty(middle)
    if ~ismember(middle(1),leafNode)
        middleNode=[middleNode;middle(1)];
        temp = get_children_set(tree, middle(1));
        middle=[middle;temp];
    end
    middle(1)=[];
end
end

