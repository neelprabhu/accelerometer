% BME 271 Fall 2017
% Tremor Reduction for Microsurgical Applications
% lowpassFiltDes: Creates low pass filter with cutoff from Wiener.

function [xfilt, yfilt] = lowPassFiltDes(x,y,hpf)

d = designfilt('lowpassiir','FilterOrder',3, ...
        'HalfPowerFrequency',hpf,'DesignMethod','butter');
    
xfilt = filtfilt(d,x); yfilt = filtfilt(d,y);
end