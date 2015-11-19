clc
 


Mu=input('Digite Mu: ')




%Mu = 255; % Parameter for mu-law compander
sig = -4:.1:4;
sig = exp(sig); % Exponential signal to quantize
V = max(sig);
% 1. Quantize using equal-length intervals and no compander.
[index,quants,distor] = quantiz(sig,0:floor(V),0:ceil(V));

% 2. Use same partition and codebook, but compress
% before quantizing and expand afterwards.
compsig = compand(sig,Mu,V,'mu/compressor');
[index,quants] = quantiz(compsig,0:floor(V),0:ceil(V));
newsig = compand(quants,Mu,max(quants),'mu/expander');
distor2 = sum((newsig-sig).^2)/length(sig);
[distor, distor2] % Display both mean square distortions.

plot(sig); % Plot original signal.
hold on;
plot(compsig,'r--'); % Plot companded signal.
legend('Original','Companded','Location','NorthWest')


Mu=input('Digite Mu: ')
%Mu = 255; % Parameter for mu-law compander
sig = -4:.1:4;
sig = exp(sig); % Exponential signal to quantize
V = max(sig);
% 1. Quantize using equal-length intervals and no compander.
[index,quants,distor] = quantiz(sig,0:floor(V),0:ceil(V));
% 2. Use same partition and codebook, but compress
% before quantizing and expand afterwards.
compsig = compand(sig,Mu,V,'mu/compressor');
[index,quants] = quantiz(compsig,0:floor(V),0:ceil(V));
newsig = compand(quants,Mu,max(quants),'mu/expander');
distor2 = sum((newsig-sig).^2)/length(sig);
[distor, distor2] % Display both mean square distortions.
plot(sig); % Plot original signal.
hold on;
plot(compsig,'r--'); % Plot companded signal.
legend('Original','Companded','Location','NorthWest')
% Digite Mu: 4
% Mu =
%      4
% ans =
%     0.5348    0.1254
% 7
% ans =
%      7
% Mu=input('Digite Mu: ')
% %Mu = 255; % Parameter for mu-law compander
% sig = -4:.1:4;
% sig = exp(sig); % Exponential signal to quantize
% V = max(sig);
% % 1. Quantize using equal-length intervals and no compander.
% [index,quants,distor] = quantiz(sig,0:floor(V),0:ceil(V));
% % 2. Use same partition and codebook, but compress
% % before quantizing and expand afterwards.
% compsig = compand(sig,Mu,V,'mu/compressor');
% [index,quants] = quantiz(compsig,0:floor(V),0:ceil(V));
% newsig = compand(quants,Mu,max(quants),'mu/expander');
% distor2 = sum((newsig-sig).^2)/length(sig);
% [distor, distor2] % Display both mean square distortions.
% plot(sig); % Plot original signal.
% hold on;
% plot(compsig,'r--'); % Plot companded signal.
% legend('Original','Companded','Location','NorthWest')
% Digite Mu: 7
% Mu =
%      7
% ans =
%     0.5348    0.1272
% Mu=input('Digite Mu: ')
% %Mu = 255; % Parameter for mu-law compander
% sig = -4:.1:4;
% sig = exp(sig); % Exponential signal to quantize
% V = max(sig);
% % 1. Quantize using equal-length intervals and no compander.
% [index,quants,distor] = quantiz(sig,0:floor(V),0:ceil(V));
% % 2. Use same partition and codebook, but compress
% % before quantizing and expand afterwards.
% compsig = compand(sig,Mu,V,'mu/compressor');
% [index,quants] = quantiz(compsig,0:floor(V),0:ceil(V));
% newsig = compand(quants,Mu,max(quants),'mu/expander');
% distor2 = sum((newsig-sig).^2)/length(sig);
% [distor, distor2] % Display both mean square distortions.
% plot(sig); % Plot original signal.
% hold on;
% plot(compsig,'r--'); % Plot companded signal.
% legend('Original','Companded','Location','NorthWest')
% Digite Mu: 0.1
% Mu =
%     0.1000
% ans =
%     0.5348    0.4254
% 11
% ans =
%     11
% Mu=input('Digite Mu: ')
% %Mu = 255; % Parameter for mu-law compander
% sig = -4:.1:4;
% sig = exp(sig); % Exponential signal to quantize
% V = max(sig);
% % 1. Quantize using equal-length intervals and no compander.
% [index,quants,distor] = quantiz(sig,0:floor(V),0:ceil(V));
% % 2. Use same partition and codebook, but compress
% % before quantizing and expand afterwards.
% compsig = compand(sig,Mu,V,'mu/compressor');
% [index,quants] = quantiz(compsig,0:floor(V),0:ceil(V));
% newsig = compand(quants,Mu,max(quants),'mu/expander');
% distor2 = sum((newsig-sig).^2)/length(sig);
% [distor, distor2] % Display both mean square distortions.
% plot(sig); % Plot original signal.
% hold on;
% plot(compsig,'r--'); % Plot companded signal.
% legend('Original','Companded','Location','NorthWest')
% Digite Mu: 11
% Mu =
%     11
% ans =
%     0.5348    0.0728
% Mu=input('Digite Mu: ')
% %Mu = 255; % Parameter for mu-law compander
% sig = -4:.1:4;
% sig = exp(sig); % Exponential signal to quantize
% V = max(sig);
% % 1. Quantize using equal-length intervals and no compander.
% [index,quants,distor] = quantiz(sig,0:floor(V),0:ceil(V));
% % 2. Use same partition and codebook, but compress
% % before quantizing and expand afterwards.
% compsig = compand(sig,Mu,V,'mu/compressor');
% [index,quants] = quantiz(compsig,0:floor(V),0:ceil(V));
% newsig = compand(quants,Mu,max(quants),'mu/expander');
% distor2 = sum((newsig-sig).^2)/length(sig);
% [distor, distor2] % Display both mean square distortions.
% plot(sig); % Plot original signal.
% hold on;
% plot(compsig,'r--'); % Plot companded signal.
% legend('Original','Companded','Location','NorthWest')
% Digite Mu: 111
% Mu =
%    111
% ans =
%     0.5348    0.2222
% Mu=input('Digite Mu: ')
% %Mu = 255; % Parameter for mu-law compander
% sig = -4:.1:4;
% sig = exp(sig); % Exponential signal to quantize
% V = max(sig);
% % 1. Quantize using equal-length intervals and no compander.
% [index,quants,distor] = quantiz(sig,0:floor(V),0:ceil(V));
% % 2. Use same partition and codebook, but compress
% % before quantizing and expand afterwards.
% compsig = compand(sig,Mu,V,'mu/compressor');
% [index,quants] = quantiz(compsig,0:floor(V),0:ceil(V));
% newsig = compand(quants,Mu,max(quants),'mu/expander');
% distor2 = sum((newsig-sig).^2)/length(sig);
% [distor, distor2] % Display both mean square distortions.
% plot(sig); % Plot original signal.
% hold on;
% plot(compsig,'r--'); % Plot companded signal.
% legend('Original','Companded','Location','NorthWest')
% Digite Mu: 225
% Mu =
%    225
% ans =
%     0.5348    0.0283
% Mu=input('Digite Mu: ')
% %Mu = 255; % Parameter for mu-law compander
% sig = -4:.1:4;
% sig = exp(sig); % Exponential signal to quantize
% V = max(sig);
% % 1. Quantize using equal-length intervals and no compander.
% [index,quants,distor] = quantiz(sig,0:floor(V),0:ceil(V));
% % 2. Use same partition and codebook, but compress
% % before quantizing and expand afterwards.
% compsig = compand(sig,Mu,V,'mu/compressor');
% [index,quants] = quantiz(compsig,0:floor(V),0:ceil(V));
% newsig = compand(quants,Mu,max(quants),'mu/expander');
% distor2 = sum((newsig-sig).^2)/length(sig);
% [distor, distor2] % Display both mean square distortions.
% plot(sig); % Plot original signal.
% hold on;
% plot(compsig,'r--'); % Plot companded signal.
% legend('Original','Companded','Location','NorthWest')
% Digite Mu: 255
% Mu =
%    255
% ans =
%     0.5348    0.0397
