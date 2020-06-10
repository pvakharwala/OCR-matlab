
% The matrix T is a 26x26 identity matrix which maps the 26 input
% vectors to the 26 classes.

[X,T] = prprob;

%%
% Here A, the first letter, is plotted as a bit map.

plotchar(X(:,1))


setdemorandstream(pi);

net1 = feedforwardnet(25);
view(net1)

%% Training the first Neural Network

net1.divideFcn = '';
net1 = train(net1,X,T,nnMATLAB);

%%

numNoise = 30;
Xn = min(max(repmat(X,1,numNoise)+randn(35,26*numNoise)*0.2,0),1);
Tn = repmat(T,1,numNoise);

%%
% Here is a noise version of A.

figure
plotchar(Xn(:,1))

%%
% Here the second network is created and trained.

net2 = feedforwardnet(25);
net2 = train(net2,Xn,Tn,nnMATLAB);


%%
numNoise = 40;
Xn = min(max(repmat(X,1,numNoise)+randn(35,26*numNoise)*0.2,0),1);
Tn = repmat(T,1,numNoise);

%%
% Here is a noise version of A.

figure
plotchar(Xn(:,1))

%%
% Here the third network is created and trained.

net3 = feedforwardnet(25);
net3 = train(net3,Xn,Tn,nnMATLAB);

%%
numNoise = 60;
Xn = min(max(repmat(X,1,numNoise)+randn(35,26*numNoise)*0.2,0),1);
Tn = repmat(T,1,numNoise);

%%
% Here is a noise version of A.

figure
plotchar(Xn(:,1))

%%
% Here the fourth network is created and trained.

net4 = feedforwardnet(25);
net4 = train(net4,Xn,Tn,nnMATLAB);
%%
numNoise = 100;
Xn = min(max(repmat(X,1,numNoise)+randn(35,26*numNoise)*0.2,0),1);
Tn = repmat(T,1,numNoise);

%%
% Here is a noise version of A.

figure
plotchar(Xn(:,1))

%%
% Here the fourth network is created and trained.

net5 = feedforwardnet(25);
net5 = train(net5,Xn,Tn,nnMATLAB);


%% Testing Both Neural Networks

noiseLevels = 0:.05:1;
numLevels = length(noiseLevels);
percError1 = zeros(1,numLevels);
percError2 = zeros(1,numLevels);
percError3 = zeros(1,numLevels);
percError4 = zeros(1,numLevels);
percError5 = zeros(1,numLevels);
for i = 1:numLevels
  Xtest = min(max(repmat(X,1,numNoise)+randn(35,26*numNoise)*noiseLevels(i),0),1);
  Y1 = net1(Xtest);
  percError1(i) = sum(sum(abs(Tn-compet(Y1))))/(26*numNoise*2);
  Y2 = net2(Xtest);
  percError2(i) = sum(sum(abs(Tn-compet(Y2))))/(26*numNoise*2);
  Y3 = net3(Xtest);
  percError3(i) = sum(sum(abs(Tn-compet(Y3))))/(26*numNoise*2);
  Y4 = net4(Xtest);
  percError4(i) = sum(sum(abs(Tn-compet(Y4))))/(26*numNoise*2);
  Y5 = net5(Xtest);
  percError5(i) = sum(sum(abs(Tn-compet(Y4))))/(26*numNoise*2);
end

figure
plot(noiseLevels,percError1*100,'--',noiseLevels,percError2*100,noiseLevels,percError3*100,'--',noiseLevels,percError4*100,'--',noiseLevels,percError5*100,'--');
title('Percentage of Recognition Errors');
xlabel('Noise Level');
ylabel('Errors');
legend('No Noise','Noise = 30','Noise = 40','Noise = 60','Noise = 100','Location','NorthWest')

