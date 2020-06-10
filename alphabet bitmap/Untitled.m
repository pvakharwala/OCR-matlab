[X,T]=imread('printable-letter-asapbold-a.jpg');
net1 = feedforwardnet(25);
view(net1);
net1.divideFcn = '';
net1 = train(net1,X,T,nnMATLAB);