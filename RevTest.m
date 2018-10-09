[a,fs] = audioread('Output(Freeverb).wav');
a = mean(a,2);
a = a';
    % Taking the FFT of the audio
    a = fft(a);
    % Length of the signal
    len = length(a);
    % TIme resolution
    aTR = 0:1/fs:1/fs*(length(a)-1);
    % Defining the frequency resolution
    aFR = 0:fs/len:fs/2;
    % Normalizing the audio and taking the first half of the FFT
    a = abs(a);
    a = a/len;
    aNorm = a(1:len/2+1)*2;
    % Plotting the signal
    mesh(aFR,aTR,aNorm);