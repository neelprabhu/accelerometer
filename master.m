% BME 271 Fall 2017
% Tremor Reduction for Microsurgical Applications
% master: Master script that will allow training task and subsequent filt.
% INPUTS:
%   NONE
% OUTPUTS:
%   NONE

%% Initialize
clear, clc

%% Generate tracking function
xpath = linspace(0,4*pi,200);
ypath = sin(xpath);

%% Perform tracking
[xtrack,ytrack,human] = trackTask(xpath,ypath);
%human = [human(6:end,1) human(6:end,2)];

%% Show results
figure(1)
plot(xtrack,ytrack,'k-')
hold on
plot(human(:,1),human(:,2),'k.')

figure(2)
stem(xtrack,ytrack,'k-')
hold on
stem(human(:,1),human(:,2),'k.')