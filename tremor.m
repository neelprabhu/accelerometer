% BME 271 Fall 2017
% Tremor Reduction for Microsurgical Applications
% tremor: Master script that will allow the user to input line
% INPUTS:
%   NONE
% OUTPUTS:
%   NONE
%hi
R = round(rand(200));
Z = zeros(size(R,1));
origin = [round((size(Z,2)-1)/2+1) round((size(Z,1)-1)/2+1)]; % "center" of the matrix
rad = size(R,1)./10;
[x,y] = meshgrid((1:size(Z,2))-origin(1),(1:size(Z,1))-origin(2)); % grid
Z(sqrt(x.^2 + y.^2) >= rad) = 1; % set points inside the radius equal to one

F     = fft2(R);
M     = abs(F);
ML    = log(M);
Fsh   = fftshift(F);
FshM  = abs(Fsh);
FshML = log(FshM);

filt    = Z.*Fsh;
filtM   = abs(filt);
filtsh  = fftshift(filt);
filtshM = abs(filtsh);

ift     = ifft2(filtsh);
magift  = abs(ift);
filtlog = log(filt);

figure(2)
subplot(2,2,1)
imshow(Z,[]), title('Low pass filter')
subplot(2,2,2)
imshow(log(filtM),[]), title('Filter .* |FFT|')
subplot(2,2,3)
imshow(ift,[]), title('Inverse FFT of Filter .* |FFT|')
subplot(2,2,4)
imshow(magift,[]), title('|Inverse FFT| of Filter .* |FFT|')