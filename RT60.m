%       Name: Karan Pareek
%       Student ID: kp2218
% This function calculates the RT60 for an input signal using the slope of
% the Energy Decay Curve (EDC), as proposed by Schroeder.
% (https://www.mathworks.com/matlabcentral/fileexchange/35740-blind-reverberation-time-estimation)
%
% INPUT : Dry signal (x), Reverberated signal (y)
% OUTPUT : Reverberation Time (RT60)

function reverbTime = RT60(x,y)

%% Initialization

% Stereo to Mono Conversion
x = mean(x,2);
x = x';

y = mean(y,2);
y = y';

% Assuming the sample rate to be 44.1 kHz for simplicity
fs = 44100; 

%% Energy Decay Curve

% The energy decay curve of an audio signal is calculated by taking the
% integeral of the backward cumulative squared sum of the signal. Here, 
% the signal is first squared, then flipped backwards before a cumulative
% sum of the array is calculated and flipped back to give us the curve.

y_sq = y.^2;                % Square the array
y_sq = fliplr(y_sq);        % Flip it
EDC = cumsum(y_sq);         % Take the cumulative sum
EDC = fliplr(EDC);          % Flip it back
EDC = EDC./max(EDC);        % Normalize the array
EDC_log = 20*log10(EDC);    % Converting to dB scale

%{
t = 0:1/fs:1/fs*(length(y)-1);
plot(t,EDC_log);
axis tight;
ylabel('Energy (dB)');
xlabel('Time (secs)');
legend('Energy Curve');
%}

%% Reverberation Time Calculation

% In order to determine the reverberation time of the signal, we need to
% evaluate the amount of time it takes for the signal to decay by 60 dB.
% Rather than calculating the energy of the reverberated signal and
% measuring the decay, we'll start measuring our decay from the point where
% the input audio file ends. The sample number is used to denote the point
% in the reverberated file from which the decay will be measured.

thresh = EDC_log(length(x)-fs);       % Point where input audio ends
a = find(EDC_log <= thresh, 1);       % First threshold point
b = find(EDC_log <= (thresh-60), 1);  % Second threshold point

len = b-a; 
% This gives us the number of samples it takes for the energy to decay. 
% Dividing it by the sample rate will give us the RT60 in secs.
reverbTime = len/fs;

end