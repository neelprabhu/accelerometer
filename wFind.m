% BME 271 Fall 2017
% Tremor Reduction for Microsurgical Applications
% wFind: Finds w coefficients from Weiner Filter using optimization.
% INPUTS:
%   NONE
% OUTPUTS:
%   w

function [wx,wy,sx,sy] = wFind(human,xpath,ypath)

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
end