% BME 271 Fall 2017
% Tremor Reduction for Microsurgical Applications
% correlate: Generates correlation plots.

load T3.mat
load T7.mat
load healthy.mat

% Correlations
wxF3 = abs(fft(T3X));
wyF3 = abs(fft(T3Y));
wxF7 = abs(fft(T7X));
wyF7 = abs(fft(T7Y));
xC3  = xcorr(wxF3,avgX);
yC3  = xcorr(wyF3,avgY);
xC7  = xcorr(wxF7,avgX);
yC7  = xcorr(wyF7,avgY);

figure(1)
plot(linspace(-200,200,397),xC3,'b-')
hold on
plot(linspace(-200,200,397),xC7,'r-')
% plot(linspace(-100,100,198),avgXshift2,'r-')
title('Pre/Post Exercise X Filter Correlations')
legend('Pre','Post')
set(gca,'FontSize',20)

figure(2)
plot(linspace(-200,200,397),yC3,'b-')
hold on
plot(linspace(-200,200,397),yC7,'r-')
% plot(linspace(-100,100,198),avgXshift2,'r-')
title('Pre/Post Exercise Y Filter Correlations')
legend('Pre','Post')
set(gca,'FontSize',20)








%avgX = abs(fft(T3X))';
avgX = avgX';
avgXshift = [avgX(100:199) avgX(2:99)];
%avgY = abs(fft(T3Y))';
avgY = avgY';
avgYshift = [avgY(100:199) avgY(2:99)];

avgX2 = abs(fft(T7X))';
avgXshift2 = [avgX2(100:199) avgX2(2:99)];
avgY2 = abs(fft(T7Y))';
avgYshift2 = [avgY2(100:199) avgY2(2:99)];

% figure(1)
% plot(linspace(-100,100,198),avgXshift,'k-')
% % hold on
% % plot(linspace(-100,100,198),avgXshift2,'r-')
% xlabel('Frequency')
% ylabel('Magnitude')
% title('Healthy Baseline X Filter')
% set(gca,'FontSize',20)
% 
% figure(2)
% plot(linspace(-100,100,198),avgYshift,'k-')
% % hold on
% % plot(linspace(-100,100,198),avgYshift2,'r-')
% xlabel('Frequency')
% ylabel('Magnitude')
% title('Healthy Baseline Y Filter')
% set(gca,'FontSize',20)
% set(gca,'YLim',[0 300])