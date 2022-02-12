%%%%%%%%%% train_fbcssp.m %%%%%%%%%%
function FBCSSP=train_fbcssp(TRDATA,TRLB,params)
bands=params.bands;
F=size(bands,1);
P=params.P;
C=numel(unique(TRLB)); %number of classes
KTR=numel(TRDATA);
%% filter bank
for s=1:F
    H{s}=fir1(P,[bands(s,1)*2/params.fs,...
    bands(s,2)*2/params.fs]);
    for k=1:KTR
        x=TRDATA{k};
        xf=filter(H{s},1,x')';
        XF{s}{k}=xf;
    end
end
%% first stage CSP1
m= params.m;
cspparams.m=m;
for s=1:F
    W1{s}=train_csp(XF{s},TRLB,cspparams);
    for k=1:KTR
        X=XF{s}{k};
        OUT{k}=W1{s}*X;
    end
    Y1S{s}=OUT;
end
fprintf('input size:%dx%dx%dx%d\n',...
    F,numel(XF{1}),size(XF{1}{1},1),size(XF{1}{1},2));

for k=1:KTR
    rown=1;
    for s=1:F
        Y1{k}(rown:rown+C*m-1,:) = Y1S{s}{k};
        rown=rown+C*m;
    end
end

%% 2. stage
cspparams.m= params.r;
W2=train_csp(Y1,TRLB,cspparams);

FBCSSP.W1=W1;
FBCSSP.W2=W2;
FBCSSP.H=H;


    