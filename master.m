% BME 271 Fall 2017
% Tremor Reduction for Microsurgical Applications
% master: Master script that will allow training task and subsequent filt.
% INPUTS:
%   NONE
% OUTPUTS:
%   NONE

%% Initialize
clear, clc
trackFN = 'line';

%% Generate tracking function

switch trackFN
    case 'line'
        xpath = linspace(0,4*pi,200);
        ypath = xpath;
        ax    = [0,4*pi,0,4*pi];
    case 'butter'
        xpath = linspace(0,4*pi,200);
        ypath = sin(xpath) + cos(xpath) + sin(xpath.*3) + (cos(xpath)).^2;
        ax    = [0,4*pi,-5,5];
    case 'spiral'
        t = linspace(0,5,200);
        xpath = t.*cos(2.*t);
        ypath = t.*sin(2.*t);
        ax    = [-6,6,-6,6];
end
%% Perform tracking
human = trackTask(xpath, ypath, ax);
%human = [human(6:end,1) human(6:end,2)];

%% Show results

% figure(2)
% stem(xpath,ypath,'k-')
% hold on
% stem(human(:,1),human(:,2),'k.')

%% Calculate
discrep = size(human,1)-length(xpath);
if discrep < 0
    r     = randi(length(human(:,1))-1,[1 abs(discrep)]);
    for i = 1:length(r)
        if r(i) == 1
           r(i) = 2;
        end
        xinterp = (human(r(i)-1,1) + human(r(i) + 1,1))./2;
        yinterp = (human(r(i)-1,2) + human(r(i) + 1,2))./2;
        interp  = [xinterp yinterp];
        human   = [human(1:r(i),:); interp; human((r(i)+1):end,:)];
    end  
%     xpath = xpath(1:(end+discrep));
%     ypath = ypath(1:(end+discrep));
else
    human = [human((discrep+1):end,1) human((discrep+1):end,2)];
end

human = human';
tfx = diff(xpath);
tfy = diff(ypath);

rdfx = diff(human(1,:));
rdfy = diff(human(2,:));

rxcorr = xcorr(rdfx,rdfx,'biased');
rycorr = xcorr(rdfy,rdfy,'biased');
rxcorr = rxcorr(length(rdfx):end);
rycorr = rycorr(length(rdfx):end);

% Autocorrelation matrices (R)
Rx = toeplitz(rxcorr,conj(rxcorr));
Ry = toeplitz(rycorr,conj(rycorr));

% Cross correlation vectors (p)
px = xcorr(rdfx,tfx);
py = xcorr(rdfy,tfy);
px = px(1:length(rdfx))';
py = py(1:length(rdfx))';

% Calculate w
u = ones(length(rdfx),1);
invRx = inv(Rx);
invRy = inv(Ry);

numx = (1-(u'*invRx*px))*u;
numy = (1-(u'*invRy*py))*u;

denomx = u'*invRx*u;
denomy = u'*invRy*u;

qx = (numx./denomx) + px;
qy = (numy./denomy) + py;

wx = invRx*qx;
wy = invRy*qy;

sx = xcorr(human(1,:)',wx);
sy = xcorr(human(2,:)',wy);
sx = sx(1:length(wx));
sy = sy(1:length(wy));

figure(1)
plot(xpath,ypath,'k-')
hold on
plot(human(1,:),human(2,:),'k.')

figure(2)
plot(xpath,ypath,'k-')
hold on
plot(human(1,1:(end-1)),human(2,1:(end-1)),'k.')
plot(sx,sy,'k--')

figure(3)
subplot(1,2,1)
plot(abs(fft(wx)),'k-')
title('x filt')
subplot(1,2,2)
plot(abs(fft(wy)),'k-')
title('y filt')

% %% Filter
% ax = [-5 5 -5 5];
% humanT = filterTask(ax,length(wx));
% 
% sxT = xcorr(humanT(1,:)',wx);
% syT = xcorr(humanT(2,:)',wy);
% sxT = sxT(1:length(wx));
% syT = syT(1:length(wy));
% 
% close all;
% figure(4)
% plot(humanT(:,1),humanT(:,2),'k-')
% figure(5)
% plot(sxT,syT,'ko')