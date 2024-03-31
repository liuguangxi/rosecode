clc;    clear;

[y, fs, nbits] = wavread('radio_signal.wav');
y = y';
len = length(y);

fc = 4000;
xcar = exp(1j*2*pi*(0:len-1)*fc/fs);
ymix = y .* xcar;

fs = 16000;  % sampling frequency
fpass = 1500;             % passband frequency
fstop = 1600;             % stopband frequency
dpass = 0.0028782234183;  % passband ripple
dstop = 0.001;            % stopband attenuation
dens  = 20;               % density factor
[n, fo, ao, w] = firpmord([fpass, fstop]/(fs/2), [1 0], [dpass, dstop]);
b  = firpm(n, fo, ao, w, {dens});

ylpf = filter(b, 1, ymix);
yy = real(ylpf);
yy = yy / max(abs(yy)) * 0.95;
sound(yy, fs);    % keyword 'economy'
wavwrite(yy, fs, 'keyword.wav');
