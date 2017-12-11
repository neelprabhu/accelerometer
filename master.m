% BME 271 Fall 2017
% Tremor Reduction for Microsurgical Applications
% master: Master script that will allow training task and subsequent filt.

%% Initialize, choose tracking function
clear, clc
trackFN  = 'line'; % Shape for PTT
allGraph = false; % Filter graphs post PTT
filter   = true; % Filter task post PTT

%% Generate tracking function
switch trackFN
    case 'line'
        xpath = linspace(0,4*pi,100);
        ypath = xpath;
        ax    = [0,4*pi,0,4*pi];
    case 'randomWave'
        xpath = linspace(0,4*pi,300);
        ypath = sin(xpath) + (sin(4.*xpath)).^2 + cos(xpath) + sin(xpath.*3) + (cos(xpath)).^2;
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

%% Calculate Wiener filter
human = interpolator(human,xpath);
[wx,wy,sx,sy] = wFind(human,xpath,ypath);

%% Correlation with healthy baseline
load healthy.mat
wxF = abs(fft(wx));
wyF = abs(fft(wy));
xC  = xcorr(wxF,avgX);
yC  = xcorr(wyF,avgY);
xCM = max(xC)
yCM = max(yC)

%% Plot
figure(1)
plot(xpath,ypath,'k-')
hold on
plot(human(:,1),human(:,2),'k.')
xlabel('X'),ylabel('Y')
title('Pursuit Tracking Task')
set(gca,'FontSize',20)

% figure(2)
% plot(xpath,ypath,'k-')
% hold on
% plot(human(1,1:(end-1)),human(2,1:(end-1)),'k.')
% plot(sx,sy,'k--')

% figure(3)
% plot([abs(fft(human(:,1))) abs(fft(human(:,2)))])

if allGraph % If you want filters
    figure(3)
    subplot(1,2,1)
    plot(wxF(1:round(end/2)),'k-')
    xlabel('Frequency'), ylabel('Magnitude')
    title('X Filter')
    axis([0 100 0 300])
    set(gca,'FontSize',20)
    subplot(1,2,2)
    plot(wyF(1:round(end/2)),'k-')
    xlabel('Frequency'), ylabel('Magnitude')
    title('Y Filter')
    axis([0 100 0 300])
    set(gca,'FontSize',20)
    
    avgX = abs(fft(wx))';
    avgXshift = [avgX(100:199) avgX(2:99)];
    avgY = abs(fft(wy))';
    avgYshift = [avgY(100:199) avgY(2:99)];
    
%     figure(4)
%     plot(avgXshift,'k-')
%     xlabel('Frequency')
%     ylabel('Magnitude')
%     title('Post-Exercise X Filter')
%     set(gca,'FontSize',20)
%     
%     figure(5)
%     plot(avgYshift,'k-')
%     xlabel('Frequency')
%     ylabel('Magnitude')
%     title('Post-Exercise Y Filter')
%     set(gca,'FontSize',20)
%     set(gca,'YLim',[0 300])
end

%% Filter task to apply low pass filter with cutoff from Wiener
if filter
    pause(2)
    close all
    ax = [-5 5 -5 5];
    humanT = filterTask(ax,1000);
    cut = 25;
    
    [hpf,loc] = max(abs(fft(human(cut:100,1))));
    
    hpf = (cut + loc).*0.003; % optimal hpf

    [xfilt,yfilt] = lowPassFiltDes(humanT(:,1),humanT(:,2),hpf);
    
    X = fft(humanT(:,1)); Y = fft(humanT(:,2));
    
    figure(1)
    subplot(2,1,1)
    plot(humanT(:,1),humanT(:,2),'k-')
    hold on
    plot(xfilt,yfilt,'r-')
    subplot(2,1,2)
    plot(xfilt,yfilt,'r-')
%     figure(2)
%     subplot(2,1,1)
%     plot(abs(X),'r-')
%     hold on
%     plot(abs(fft(xfilt)),'b-')
%     subplot(2,1,2)
%     plot(abs(Y),'r-')
%     hold on
%     plot(abs(fft(yfilt)),'b-')
end