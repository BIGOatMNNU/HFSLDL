%% 10-fold Hierarchical SVM
%% Written by Hong Zhao
%% Modified by Haoyang Liu.
function [accuracyMean,accuracyStd,F_LCAMean,FHMean,TIEmean,accuracy_l,accuracy_mon,FHStd,TIEStd,accuracy_monStd,FH,TIE] = FS_Kflod_TopDownSVMClassifier1(data, numFolds, tree, feature, numberSel,indices,randIndex)
[M,N]=size(data);
accuracy_k = zeros(1,numFolds);
[ leafNode ] = tree_LeafNode( tree );
l_rig=zeros(1,length(leafNode));
l_num=zeros(1,length(leafNode));

for k = 1:numFolds
    testID = (indices == k);%//获得test集元素在数据集中对应的单元编号
    trainID = ~testID;%//train集元素的编号为非test元素的编号
    test_data = data(testID,1:N-1);
    test_label = data(testID,N);
    train_data = data(trainID,:);
    mon_rig=0;
    mon_num=0;
    %% Creat sub table
    [trainDataMod, trainLabelMod] = creatSubTablezh(train_data, tree);
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Train classifiers of all internal nodes
    numNodes = length(tree(:,1));%ZH: The total of all nodes.
    for i = 1:numNodes
        if (~ismember(i, tree_LeafNode(tree)))
            trainLabel = trainLabelMod{i};
            trainData = trainDataMod{i};
            %             trainLabel = sparse(trainLabelMod{i});
            %             trainData = sparse(trainDataMod{i});
            selFeature = feature{i}(1:numberSel);
            [modelSVM{i}]  = svmtrain(trainLabel, trainData(:,selFeature), '-c 1 -t 0 -q');
            %             [model{i}]  = train(double(trainLabel), sparse(trainData(:,selFeature(1:numberSel))), '-c 2 -s 0 -B 1 -q');
        end
    end
    
    %%           Prediction       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [predict_label] = FS_topDownSVMPrediction(test_data, modelSVM, tree,feature,numberSel) ;
    
    %%          Envaluation       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [PH(k), RH(k), FH(k)] = EvaHier_HierarchicalPrecisionAndRecall(test_label,predict_label',tree);
    [P_LCA(k),R_LCA(k),F_LCA(k)] = EvaHier_HierarchicalLCAPrecisionAndRecall(test_label,predict_label',tree);
    TIE(k) = EvaHier_TreeInducedError(test_label,predict_label',tree);
    accuracy_k(k) = EvaHier_HierarchicalAccuracy(test_label,predict_label', tree);%王煜
    for j=1:length(leafNode)
        [index,l_num1]=find(test_label==leafNode(j));
        if ~isempty(l_num1)
            l_rig1=predict_label(index)==leafNode(j);
        else
            l_num1=0;
            l_rig1=0;
        end
        l_rig(j)=l_rig(j)+sum(l_rig1);
        l_num(j)=l_num(j)+sum(l_num1);
    end
    if(~isempty(randIndex))
        for j=1:length(randIndex)
            [index2,l_num2]=find(test_label==randIndex(j));
            if ~isempty(l_num2)
                mon_rig1=predict_label(index2)==randIndex(j);
            else
                mon_rig1=0;
                l_num2=0;
            end
            mon_rig=mon_rig+sum(mon_rig1);
            mon_num=mon_num+sum(l_num2);
        end
    end
    acc_m(k)=mon_rig./mon_num;
end
accuracy_l(1,:)=leafNode;
accuracy_l(2,:)=l_rig./l_num;
accuracy_mon=mean(acc_m);
accuracy_monStd=std(acc_m);
accuracyMean = mean(accuracy_k);
accuracyStd = std(accuracy_k);
F_LCAMean=mean(F_LCA);
FHStd=std(FH);
FHMean=mean(FH);
TIEmean=mean(TIE);
TIEStd=std(TIE);
end