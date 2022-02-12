%%%%%%%%%% test_csp.m %%%%%%%%%%
function [ftr,fts,LABELS,ZTR,ZTS]=test_csp(TSDATA,TRDATA,TRLB,WCSP,params)
Ktr=numel(TRDATA);
for k=1:Ktr
    X=TRDATA{k};
    ZTR{k}=WCSP*X;
    ftr(k,:)=[log(var(ZTR{k},0,2)'/sum(var(ZTR{k},0,2)))];
end
Kts=numel(TSDATA);
for k=1:Kts
    X=TSDATA{k};
    ZTS{k}=WCSP*X;
    fts(k,:)=[log(var(ZTS{k},0,2)'/sum(var(ZTS{k},0,2)))];
end
if(params.classifier=='LDA')
    LABELS=classify(fts, ftr, TRLB)';
elseif(params.classifier=='SVM')
    svmStruct = svmtrain(ftr,TRLB);
    LABELS = svmclassify(svmStruct,fts)';
end