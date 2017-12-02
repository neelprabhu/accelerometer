% BME 271 Fall 2017
% Tremor Reduction for Microsurgical Applications
% filterTask: Master script to track motion and make tremor reducing filter.

function track = filterTask(ax,wxlen)

clear global

figure('WindowButtonMotionFcn', @trackPoint)
ah = axes('SortMethod','childorder');
global track; global k; k = 1;

axis(ax)
hold on

pause(10)
close all;

function tracked = trackPoint(src,callbackdata)
    loc = ah.CurrentPoint;
    track(k,1:2) = [loc(1,1:2)];
    k = k + 1;
    disp(loc(1,1:2))
    if mod(k,5) == 0
        plot(loc(1,1),loc(1,2),'k.')
    end
    if k == wxlen
        close all;
    end
end

end