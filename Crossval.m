%Accuracy Crossval

% %Crossval
% TRLB=TRLB';
% A=EPOCHS.EPDT';
% k=4;
% cv = cvpartition(length(A),'kfold',k);
% for i=1:k
% trainIdxs{i} = find(training(cv,i));
% testIdxs{i}  = find(test(cv,i));
% trainingdata{i} = A(trainIdxs{i},:);
% testingdata{i}  = A(testIdxs{i},:);
% TrLabel{i} = TRLB(trainIdxs{i},:);
% TsLabel{i} = TRLB(testIdxs{i},:);
% end

% % Trial 1 CV 1
% TRDATA = trainingdata{1,1};
% TRLB = TrLabel{1,1};
% TSDATA = testingdata{1,1};
% TSLB = TsLabel{1,1};

% Trial 1 CV 2
TRDATA = trainingdata{1,2};
TRLB = TrLabel{1,2};
TSDATA = testingdata{1,2};
TSLB = TsLabel{1,2};

% % Trial 1 CV 3
% TRDATA = trainingdata{1,3};
% TRLB = TrLabel{1,3};
% TSDATA = testingdata{1,3};
% TSLB = TsLabel{1,3};

% % Trial 1 CV 4
% TRDATA = trainingdata{1,4};
% TRLB = TrLabel{1,4};
% TSDATA = testingdata{1,4};
% TSLB = TsLabel{1,4};


%Call Function
[WCSP,L]=train_csp(TRDATA,TRLB,trainParams); %Fungsi Train CSP
[ftr,fts,LABELS,ZTR,ZTS]=test_csp(TSDATA,TRDATA,TRLB,WCSP,params)
FBCSSP=train_fbcssp(TRDATA,TRLB,params);% Fungsi Train FBCSSP
[ftr,fts,ZTR,ZTS]=test_fbcssp(FBCSSP,TRDATA,TRLB,TSDATA,params); %Nilai ekstraksi fitur
ldatrain = fitcdiscr(ftr,TRLB); % Fungsi LDA Train
ldatest = fitcdiscr (fts,TSLB); % Fungsi LDA Test
LABEL = resubPredict(ldatrain) % Label LDA Train
LABELS = resubPredict(ldatest) % Label LDA Test
PERF=perfCalc(LABEL,TRLB) % Menghitung Performa Train
PERFS=perfCalc(LABELS,TSLB) %Menghitung Performa Test


