function EPOCHSOUT=cropEpochs(EPOCHS,cparams)
if(~isfield(cparams,'t0') || ~isfield(cparams,'t1'))
    fprintf('params.t0 & params.t1 are required');
return;
end
n0=(cparams.t0+EPOCHS.trigtime)*EPOCHS.fs;
n1=(cparams.t1+EPOCHS.trigtime)*EPOCHS.fs;
%number of epochs in training set
K=numel(EPOCHS.EPDT);
EPOCHSOUT=EPOCHS;
for k=1:K
    X=EPOCHS.EPDT{k};
    EPOCHSOUT.EPDT{k}=X(:,n0:n1);
end