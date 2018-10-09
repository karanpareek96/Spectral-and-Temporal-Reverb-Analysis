%       Name: Karan Pareek
%       Student ID: kp2218
% This function recreates the Freeverb reverberation algorithm. In addition
% to the basic parameters such as gain, size and spread of the reverb, the
% user can choose from an additive and convoluted reverb that produces 
% different sounds.
%
% INPUTS: Name of Input File, Name of Output File, Type of Reverberation
%         (Additive/Convolution), Reverb Gain, Reverb Size, Reverb Spread
% OUTPUT: Schroeder Output (y)

function y = Schroeder(inputFilename,revType,revGain,revSize,revSpread)

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
    roomsize = 0.2;
elseif strcmp(revSize,'Medium')
    roomsize = 0.8;
elseif strcmp(revSize,'Large')
    roomsize = 0.9;
end

%% Feedback Comb Filters

% The audio file first goes through 4 parallel feedback comb filters.
% Depending on the type of reverb method selected by the user, the module 
% either inputs the input signal (x) or the impulse response (IR) through 
% the filters

if strcmp(revType,'Additive')
    y1 = FeedbackCombFilter(x,roomsize,2000);
    y2 = FeedbackCombFilter(x,roomsize,2200);
    y3 = FeedbackCombFilter(x,roomsize,1800);
    y4 = FeedbackCombFilter(x,roomsize,2100);
elseif strcmp(revType,'Convolution')
    y1 = FeedbackCombFilter(IR,roomsize,2000);
    y2 = FeedbackCombFilter(IR,roomsize,2200);
    y3 = FeedbackCombFilter(IR,roomsize,1800);
    y4 = FeedbackCombFilter(IR,roomsize,2100);
end

CombOut = y1 + y2 + y3 + y4; % Taking sum of parallel filters

%% Allpass Filters

% The output of the comb filters is now processed using Allpass filters
y5 = AllpassFilter(CombOut,0.7,1600);
AllpassOut = AllpassFilter(y5,0.8,1800);

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