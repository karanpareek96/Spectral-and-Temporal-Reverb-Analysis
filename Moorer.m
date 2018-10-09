 %       Name: Karan Pareek
%       Student ID: kp2218
% This function recreates the Freeverb reverberation algorithm. In addition
% to the basic parameters such as gain, size and spread of the reverb, the
% user can choose from an additive and convoluted reverb that produces 
% different sounds.
%
% INPUTS: Name of Input File, Name of Output File, Type of Reverberation
%         (Additive/Convolution), Reverb Gain, Reverb Size, Reverb Spread
% OUTPUT: Moorer Output (y)

function y = Moorer(inputFilename,revType,revGain,revSize,revSpread)

%% Initialization

% Using audioread to read the input file
[x,fs] = audioread(inputFilename);

% Stereo to Mono conversion
if size(x,2) > 1
    x = mean(x,2);
end

% Transposing the audio file into rows and extending its length to
% incorporate the reverberated tail
x = x';
x = [x,zeros(1,fs)];

% Since the GUI allows the user to switch between Additive and Convolution
% reverb type, the function creates an IR by default by creating a rwo of
% zeros with length 'fs' and placing IR(1) as 1
IR = zeros(1,fs);
IR(1) = 1;

%% Room Size

% Before processing the audio file/IR through the reverb module, we must
% define certain parameters for the size of the acoustic space. 

roomsize = 0.7;
if strcmp(revSize,'Small')
    roomsize = 0.4;
elseif strcmp(revSize,'Medium')
    roomsize = 0.7;
elseif strcmp(revSize,'Large')
    roomsize = 0.9;
end

%% Delay line

% Depending on the type of reverb method selected by the user, the module
% either inputs the input signal (x) or the impulse response (IR) through
% the filters

if strcmp(revType,'Additive')
    [xDelay] = PreDelay(x,18,6000);
elseif strcmp(revType,'Convolution')
    [xDelay] = PreDelay(IR,18,6000);
end

%% Lowpass Comb Filters

% Output from the pre-delay line enters the parallel comb filters
Comb1 = LowpassCombFilter(xDelay,0.4,roomsize,1579);
Comb2 = LowpassCombFilter(xDelay,0.4,roomsize,1949);
Comb3 = LowpassCombFilter(xDelay,0.4,roomsize,2113);
Comb4 = LowpassCombFilter(xDelay,0.4,roomsize,2293);
Comb5 = LowpassCombFilter(xDelay,0.4,roomsize,2467);
Comb6 = LowpassCombFilter(xDelay,0.4,roomsize,2647);

% Summing the output of the parallel comb filters
CombOut = Comb1+Comb2+Comb3+Comb4+Comb5+Comb6;

%% Allpass Filters

% The signal now goes through an Allpass filter and added to the delayed
% signal
AllpassOut = AllpassFilter(CombOut,0.8,307);
AllpassOut = AllpassOut + xDelay;

%% Output Section

dryGain = 1 - revGain; % Total of Dry and Wet should be 1

RevOut = revGain*AllpassOut;
input = dryGain*x;

if strcmp(revType,'Additive')
    y = (input+RevOut);
elseif strcmp(revType,'Convolution')
    y = FastConvoluter(input,RevOut);
end

y = y/max(abs(y));

% Adding Stereo Spread to the output using a simple delay filter
yLeft = [y,zeros(1,round(revSpread*1000))];
yRight = [zeros(1,round(revSpread*1000)),y];
y = [yLeft;yRight];
y = y';

end