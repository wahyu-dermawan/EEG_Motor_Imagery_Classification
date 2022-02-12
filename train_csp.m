%%%%%%%%%% train_csp.m %%%%%%%%%%
function [WCSP,L]=train_csp(TRDATA,TRLB,trainParams)
%number of classes
C=numel(unique(TRLB));
%number of channels
N=size(TRDATA{1},1);
%number of epochs in training set
K=numel(TRDATA);
%number of epochs in test set
%KTS=numel(TSDATA);
RA=zeros(N,N);
RB=zeros(N,N);
na=0;
nb=0;
for c=1:C
    R{c}=zeros(N,N);
    n(c)=0;
end
%% calculate average covariance matrices
for k=1:K
    X=TRDATA{k};
    r=X*X'/trace(X*X');
    c=TRLB(k);
    R{c}=R{c}+r;
    n(c)=n(c)+1;
end
for c=1:C
    R{c}=R{c}/n(c);
end
%% calculate spatial filters for each class
WCSP=[]; % csp matrix
for c=1:C
    %calculate num & den
    RA=R{c};
    RB=zeros(N,N);
    for ci=1:C
        if ci~=c
            RB=RB+R{ci};
        end
    end
    
    %calculate CSP matrix
    Q=inv(RB)*RA;
    [W A]=eig(Q);
    %sort eigenvalues in descending order
    [A order] = sort(diag(A),'descend');
    % sort eigen vectors
    % W=inv(W)';
    W = W(:,order);
    WCSP=[WCSP;W(:,1:trainParams.m)'];
    L{c}=A(1:trainParams.m);
end
