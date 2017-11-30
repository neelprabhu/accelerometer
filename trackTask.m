% BME 271 Fall 2017
% Tremor Reduction for Microsurgical Applications
% trackTask: Master script to track motion and make tremor reducing filter.

function trackTask

figure('WindowButtonMotionFcn', @trackPoint)
ah = axes('SortMethod','childorder');
global track; global k; k = 1;

axis([0,4*pi,-1,1])
x = linspace(0,4*pi,500);
y = sin(x);
h = animatedline;
for i = 1:length(x)
    addpoints(h,x(i),y(i));
    drawnow
end

function trackPoint(src,callbackdata)

    loc = ah.CurrentPoint;
    track(k,1:2) = [loc(1,1:2)];
    k = k + 1;
    disp(loc(1,1:2))
end
% 
% figure(2)
% plot(pos(:,1),pos(:,2),'k-')
end