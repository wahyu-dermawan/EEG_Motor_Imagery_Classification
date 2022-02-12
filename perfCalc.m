%%%%%%%%%% perfCalc.m %%%%%%%%%%
function PERF=perfCalc(LABEL,TRLB)
K=numel(LABEL);
C=numel(unique(LABEL));
%create confusion matrix
confM=zeros(C,C);
for k=1:K
    ctr=LABEL(k);
    ces=TRLB(k);
    confM(ctr,ces)=confM(ctr,ces)+1;
end
%% calculate number of true/false positive/negatives
for c=1:C
    TP(c)=confM(c,c);
    FP(c)=sum(confM(:,c))-TP(c);
    FN(c)=sum(confM(c,:))-TP(c);
    TN(c)=K-TP(c)-FP(c)-FN(c);
end
%% calculate metrics
ACC=0;
PRE=zeros(1,C);
SENS=zeros(1,C);
SPEC=zeros(1,C);
F1SC=zeros(1,C);
for c=1:C
    ACC=ACC+(TP(c))/(TP(c)+TN(c)+FP(c)+FN(c));
    PRE(c)=(TP(c))/(TP(c)+FP(c));
    SENS(c)=(TP(c))/(TP(c)+FN(c));
    SPEC(c)=(TN(c))/(TN(c)+FP(c));
    F1SC(c)=2* PRE(c)*SENS(c)/(PRE(c)+SENS(c));
end
PERF.confM=confM;
PERF.TP=TP;
PERF.TN=TN;
PERF.FP=FP;
PERF.FN=FN;
PERF.ACC=ACC;
PERF.PRE=PRE;
PERF.SENS=SENS;
PERF.SPEC=SPEC;
PERF.F1SC=F1SC;