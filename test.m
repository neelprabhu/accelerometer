t = 0:1:100;
y = -5 + (5+5)*rand(1,length(t));
% stem(t,y)
% 
% filt = [1 1 1 1 1 1 1 1 1 1 2 3 4 4 3 2 1 1 1 1 1 1 1 1 1 1]*0.125;
% ycorr = conv(y, filt);
% 
% figure(2)
% stem(0:1:length(ycorr)-1,ycorr)

F = fft(y);
Ffilt = F(1:10);
M = abs(F);
Mfilt = abs(Ffilt);
yfilt = ifft(Ffilt);
% figure(3)
% plot(M), hold on
% plot(Mfilt)

figure(4)
stem(yfilt)
