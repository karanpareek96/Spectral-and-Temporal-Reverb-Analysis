%       Name: Karan Pareek
%       Student ID: kp2218
% This function plots an input signal using frequency domain plots.
% 1. Signal
% 2. Power
% 3. Pseudospectrum
% 4. Spectrogram

% INPUTS: Name of Input File (x), Type of Plot
% OUTPUT: Plotted Signal

function SignalPlotter(a,plotSig)

%% Initialization

% Stereo to Mono conversion
if size(a,2) > 1
    a = mean(a,2);
end

% Assuming a sampling rate of 44100 for simplicity in plotting
fs = 44100; 

%% Types of Plots

if strcmp(plotSig,'Signal')
    % Defining the time array
    t = 0:1/fs:1/fs*(length(a)-1);
    % Plotting the signal
    plot(t,a);
    xlim([0,length(a)/fs]);
    ylim([-1,1]);
    title('Time Domain Plot');
    xlabel('Time (secs)');
    ylabel('Amplitude');
    
elseif strcmp(plotSig,'Phase')
    % Taking the FFT of the audio
    a = fft(a);
    % Extracting the angle information from the signal
    aPhase = angle(a);
    aPhase = unwrap(aPhase);
    aPhaseNorm = aPhase(end/2:end);
    % Defining the frequency resolution
    aFR = 0:fs/length(a):fs/2;
    % Plotting the signal
    plot(aFR, aPhaseNorm);
    title('Phase Relation Plot');
    xlabel('Frequency (Hz)');
    ylabel('Phase (rad)');
    xlim([0,fs/2]);

elseif strcmp(plotSig,'Frequency Spectrum')
    % Taking the FFT of the audio
    a = fft(a);
    % Length of the signal
    len = length(a);
    % Defining the frequency resolution
    aFR = 0:fs/len:fs/2;
    % Normalizing the audio and taking the first half of the FFT
    a = abs(a);
    a = a/len;
    aNorm = a(1:len/2+1)*2;
    % Plotting the signal
    plot(aFR, aNorm);
    title('FFT Plot');
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    axis tight;
    xlim([0,2500]);
    
elseif strcmp(plotSig,'Power Spectrum')
    periodogram(a,hamming(length(a)),'power');
    axis tight;
    xlim([0,0.25]);
    
elseif strcmp(plotSig,'Spectrogram')
    spectrogram(a,kaiser(256,5),220,512,fs,'yaxis');
    title('Spectrogram Plot');
    axis tight;
    ylim([0,10]);
    
end
    
end