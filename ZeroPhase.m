fs = 100;
% fs is Sampling frequency in hz
% Time vector - use colon operator to generate integer vector of sample
% numbers
t = 1:.01:7.01; %7 seconds of sampling
f1 = 6; %6 Hz freq
f2 = 40; %40 Hz freq
f3 = 45; %45 Hz freq
signal = 3*cos(2*pi*f1*t + 2) + 1*cos(2*pi*f2*t + 1) + 1*cos(2*pi*f3*t + 3);
fs=100; % sample frequency
fc1=2; %cutoff frequency low
fc2=15; %cutoff frequency high
[B,A]=butter(3,[fc1/(fs/2) fc2/(fs/2)] ,'bandpass'); 
filtered_signal=filtfilt(B,A,signal);
plot(signal)
hold on
plot(filtered_signal, 'r')
figure
X = fft(signal);
Z = fft(filtered_signal);
n=length(X);
X_mag = abs(X);
X_phase = angle(X);
w = fs/(length(t)-1);
binHzConv = ((fs)/(n) +.000001);
freq = 0:binHzConv:100;
p = unwrap(angle(X)); 
g = unwrap(angle(Z));