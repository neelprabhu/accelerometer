% BME 271 Fall 2017
% Tremor Reduction for Microsurgical Applications
% master: Master script that will allow training task and subsequent filt.

%% Initialize, choose tracking function
clear, clc
trackFN = 'spiral';

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
    case 'sine'
        xpath = linspace(0,4*pi,200);
        ypath = sin(xpath);
        ax    = [0,4*pi,-1.5,1.5];
    case 'spiral'
        t = linspace(0,5,200);
        xpath = t.*cos(2.*t);
        ypath = t.*sin(2.*t);
        ax    = [-6,6,-6,6];
end

%% Perform tracking
human = trackTask(xpath, ypath, ax);

%% Calculate
human = interpolator(human,xpath);
[wx,wy,sx,sy] = wFind(human,xpath,ypath);

% figure(1)
% plot(abs(fft(wxN)),'b-')
% hold on
% plot(abs(fft(wxM)),'r-')
% title('x')
% 
% figure(2)
% plot(abs(fft(wyN)),'b-')
% hold on
% plot(abs(fft(wyM)),'r-')
% title('y')

%% Plot
figure(1)
plot(xpath,ypath,'k-')
hold on
plot(human(:,1),human(:,2),'k.')

figure(2)
plot(xpath,ypath,'k-')
hold on
plot(human(1,1:(end-1)),human(2,1:(end-1)),'k.')
plot(sx,sy,'k--')

wxF = abs(fft(wx));
wyF = abs(fft(wy));

figure(3)
subplot(1,2,1)
plot(wxF(1:round(end/2)),'k-')
title('x filt')
subplot(1,2,2)
plot(wyF(1:round(end/2)),'k-')
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