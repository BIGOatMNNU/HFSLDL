%²»Æ½ºâ»¯
 
[ leafNode ] = tree_LeafNode( tree );
rand_num=round(length(leafNode)*0.1);
for i=1:10
    randIndex{i} = randperm(length(leafNode));
    randIndex{i} =randIndex{i} (1:rand_num);
    dele_indx{i}=[];
    dele_indx2{i}=[];
    
    for j=1:rand_num
        cur_node=leafNode(randIndex{i} (j));
        cur_idx=find(data_array(:,end)==cur_node);
        cur_num=length(cur_idx);
        rand_num1=round(cur_num*0.9);
        rand_num2=round(cur_num*0.99);
        
        randIndex1= randperm(cur_num);
        randIndex2= randperm(cur_num);
        
        
        randIndex1=randIndex1(1:rand_num1);
        randIndex2=randIndex2(1:rand_num2);
        
        idx=cur_idx(randIndex1);
        idx2=cur_idx(randIndex2);
        
        dele_indx{i}=[dele_indx{i};idx];
        dele_indx2{i}=[dele_indx2{i};idx2];
        
    end
end