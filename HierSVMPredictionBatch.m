function [accuracyMean, accuracyStd, F_LCAMean, FHMean, TIEmean, TestTime,accuracy_l,accuracy_mon,FHStd,TIEStd,accuracy_monStd,FH,TIE] = HierSVMPredictionBatch(data_array, tree, feature,randIndex,i)
[m, numFeature] = size(data_array);
numFeature = numFeature - 1; 
numFolds  = 10;
if strcmp(i,'DD') |strcmp(i,'F194')
    j=1;
else
    j=2;
end
    numSeleted = round(numFeature * j * 0.1);
    rand('seed', 1);
    indices = crossvalind('Kfold', m, numFolds);
    tic;
    [accuracyMean, accuracyStd, F_LCAMean, FHMean, TIEmean,accuracy_l,accuracy_mon,FHStd,TIEStd,accuracy_monStd,FH,TIE] = FS_Kflod_TopDownSVMClassifier1(data_array, numFolds, tree, feature, numSeleted, indices,randIndex);
    TestTime= toc;

end

