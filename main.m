clc; clear;
str1={'DD';'F194';'CLEF'};
% str1={'DD';'F194';'CLEF';'VOC';'ILSVRC65';'Sun';'Cifar100';};
a=[0.05,0.5,0.2];
b=[0.05,0.15,0.15];
m = length(str1);
rng('default');
for i =1:m
    indx=[];
    filename = [str1{i} 'Train']    
    %     filename1 = [str1{i} 'cor1']
    load (filename);
    %     load (filename1);
    %Pearson similarity
    cor=corr(data_array(:,1:end-1)',data_array(:,1:end-1)','type','pearson');
    [X,Y,~,cor]=create_SubTable(data_array, tree,cor);
    tic;
    TDTime(i)= toc;
    [Yd] = create_hier_distribution(Y,tree,cor,a(i),b(i));
    [treecor] = get_treecor(tree);
    [sibcor] = get_sibcor(cor,Y,tree);
    %Feature selection
    tic;
    [feature_slct,W] = HFSLDL(X, Yd, tree, 10, treecor,sibcor,0.1,0.1,0);
    FSTime(i) =toc;
    count_num=tabulate(data_array(:,end));
    max_num=max(count_num(:,2));
    mon_num=max_num*0.2;
    mon_index{i}=find(count_num(:,2)<=mon_num);
    %Test feature batch
    testFile = [str1{i}, 'Test.mat']
    load (testFile);
    [accuracyMean(i), accuracyStd(i), F_LCAMean(i), FHMean(i), TIEmean(i), TestTime(i),accuracy_l{i},accuracy_mon(i),FHStd(i), TIEStd(i),accuracy_monStd(i),FH{i},TIE{i}] = HierSVMPredictionBatch(data_array, tree, feature_slct,mon_index{i},str1{i});        %
    [t_r,~]=size(data_array);
    tiemean(i)=TIEmean(i)/t_r;
    tieStd(i)=TIEStd(i)./t_r;
    tie{i}=TIE{i}./t_r;
end
