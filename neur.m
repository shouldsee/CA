gen
postgen

%%
mat1=m1;
mat2=m2;

%%
mat1=m1(:);
mat2=m2(:);

%%

% tst=linspace(-10,10,21);
tst=-10:0.25:30;
tstout=net(tst);
plot(tst,tstout)
%%
% Solve an Input-Output Fitting problem with a Neural Network
% Script generated by Neural Fitting app
% Created 01-Nov-2016 14:05:05
%
% This script assumes these variables are defined:
% %
% %   mat1 - input data.
% %   mat2 - target data.
% 
% x = mat1';
% t = mat2';
% 
% % Choose a Training Function
% % For a list of all training functions type: help nntrain
% % 'trainlm' is usually fastest.
% % 'trainbr' takes longer but may be better for challenging problems.
% % 'trainscg' uses less memory. Suitable in low memory situations.
% trainFcn = 'traingda';  % Scaled conjugate gradient backpropagation.
% 
% % Create a Fitting Network
% hiddenLayerSize = 256;
% net = fitnet(hiddenLayerSize,trainFcn);
% % net.performFcn='crossentropy';
% net.performFcn='crossentropy';
% net.performParam.regularization = 0.1;
% net.performParam.normalization = 'none';
% % Setup Division of Data for Training, Validation, Testing
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;


%%
% Solve a Pattern Recognition Problem with a Neural Network
% Script generated by Neural Pattern Recognition app
% Created 01-Nov-2016 15:36:57
%
% This script assumes these variables are defined:
%
%   mat1 - input data.
%   mat2 - target data.

x = mat1';
t = mat2';

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
% trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.
% trainFcn = 'traingda';
neto.trainFcn='trainscg';
neto.trainParam.showWindow=false;
% Create a Pattern Recognition Network
hiddenLayerSize = 6;
net = patternnet(hiddenLayerSize);
[net,tr] = train(net,x,t);


% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
%%
imax=100;
po=linspace(0.5,0,imax);
for i=i0:imax
    
 p=po(i);
net=configure(neto,x,t);
net.IW{1,1}=neto.IW{1,1}.*(rand(size(neto.IW{1,1}))>p);
net.b{1,1}=neto.b{1,1}.*(rand(size(neto.b{1,1}))>p);
net.LW{2,1}=neto.LW{2,1}.*(rand(size(neto.LW{2,1}))>p);
net.b{2,1}=neto.b{2,1}.*(rand(size(neto.b{2,1}))>p);
net.trainParam.max_fail=6;
net.initFcn='';
% Train the Network
[net,tr] = train(net,x,t);
neto=net;

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y);
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

% View the Network
% view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotconfusion(t,y)
%figure, plotroc(t,y)
fprintf('p=%.2f, step %d out of %d\n,perf=%.5f',p,i,imax,performance)
% disp(num2str(performance))
pf(i)=performance;

% performance
end
%%
figure(10)
W=neto.IW{1,1};
fts=reshape(W,size(W,1),n,n);
l=5;
for i=1:l^2;
    wt=squeeze(fts(i,:,:));
    subplot(l,l,i);
    imagesc(wt);
end

%%

Pmat2=sim(neto,mat1')';
Pmat2=net(mat1')';
xx=xx+1
figure(xx)
% histogram(Pmat2(:)-mat2(:))
histogram(Pmat2(:))
title(sprintf('p=%.2f',p))
MIN=min(Pmat2(:));
MAX=max(Pmat2(:));
crossentropy(mat2,Pmat2)
% figure(6)
% imagesc(reshape(mean(mat2,1),n,n));

%%

%%
pm2=net(m1')';
figure(3)
l=6;
id=randsample(1:soupmax,l^2);
for i=1:l^2
    subplot(l,l,i)
    imagesc(reshape(m2(id(i),:),n,n));
end
figure(4)
for i=1:l^2
    subplot(l,l,i)
    imagesc(reshape(pm2(id(i),:),n,n),[MIN MAX]*1);
end
figure(5)
for i=1:l^2
    subplot(l,l,i)
    imagesc(reshape(m1(id(i),:),n,n));
end
