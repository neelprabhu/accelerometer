% BME 271 Fall 2017
% Tremor Reduction for Microsurgical Applications
% compare: Compares

load trial1.mat
load trial2.mat
load trial3.mat

% Average Megan
avgXM = (abs(fft(wxM1)) + abs(fft(wxM2)) + abs(fft(wxM3)))/3;
avgYM = (abs(fft(wyM1)) + abs(fft(wyM2)) + abs(fft(wyM3)))/3;

% Average Neel
avgXN = (abs(fft(wxN1)) + abs(fft(wxN2)) + abs(fft(wxN3)))/3;
avgYN = (abs(fft(wyN1)) + abs(fft(wyN2)) + abs(fft(wyN3)))/3;

% Average group
avgX = (avgXM + avgXN)/2;
avgY = (avgYM + avgYN)/2;

figure(1)
plot(avgXN,'b-')
hold on
plot(avgXM,'r-')

figure(2)
plot(avgYN,'b-')
hold on
plot(avgYM,'r-')

figure(3)
plot(avgX,'b-')

figure(4)
plot(avgY,'b-')