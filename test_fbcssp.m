%%%%%%%%%% test_fbcssp.m %%%%%%%%%%

function [ftr,fts,ZTR,ZTS]=test_fbcssp(FBCSSP,TRDATA,TRLB,TSDATA,params)

W1=FBCSSP.W1;
W2=FBCSSP.W2;
H=FBCSSP.H;

F=numel(H);
KTR=numel(TRDATA);
KTS=numel(TSDATA);
C=numel(unique(TRLB));

for s=1:F
    h=H{s};
    for k=1:KTR
        x=TRDATA{k};
        xf=filter(h,1,x')';
        XF{s}{k}=xf;
    end
end

for s=1:F
    for k=1:KTR
        X=XF{s}{k};
        OUT{k}=W1{s}*X;
    end
    Y1S{s}=OUT;
end

m=size(W1{1},1)/C;
for k=1:KTR
    rown=1;
    for s=1:F
        Y1{k}(rown:rown+C*m-1,:) = Y1S{s}{k};
        rown=rown+C*m;
    end
    ZTR{k}=W2*Y1{k};
    ftr(k,:)=[log(var(ZTR{k}')/sum(var(ZTR{k}')))];
end

%% test data
for s=1:F
    h=H{s};
    for k=1:KTS
        x=TSDATA{k};
        xf=filter(h,1,x')';
        XFT{s}{k}=xf;
    end
end
for s=1:F
    for k=1:KTS
        X=XFT{s}{k};
        OUTT{k}=W1{s}*X;
    end
    Y1ST{s}=OUTT;
end
m=size(W1{1},1)/C;
for k=1:KTS
    rown=1;
    for s=1:F
        Y1T{k}(rown:rown+C*m-1,:) = Y1ST{s}{k};
        rown=rown+C*m;
    end
    ZTS{k}=W2*Y1T{k};
    fts(k,:)=[log(var(ZTS{k}')/sum(var(ZTS{k}')))];
end
% if(params.classifier=='fitcdicsr')
%     ldatrain = fitcdiscr(ftr,TRLB);
%     ldatest = fitcdiscr (fts,TSLB);
%     LABEL = resubPredict(ldatrain)
%     LABELS = resubPredict(ldatest)
% 
%     %LABELS=classify(fts, ftr, TRLB)';
% elseif(params.classifier=='SVM')
%     svmStruct = svmtrain(ftr,TRLB);
%     LABELS = svmclassify(svmStruct,fts)';
% end
