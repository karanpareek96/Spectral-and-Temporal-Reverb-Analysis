%       Name: Karan Pareek
%       Student ID: kp2218
% This function recreates the Freeverb reverberation algorithm. In addition
% to the basic parameters such as gain, size and spread of the reverb, the
% user can choose from an additive and convoluted reverb that produces 
% different sounds.
%
% INPUTS: Name of Input File, Name of Output File, Type of Reverberation
%         (Additive/Convolution), Reverb Gain, Reverb Size, Reverb Spread
% OUTPUT: Freeverb Output (y)

function y = Freeverb(inputFilename,revType,revGain,revSize,revSpread)

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
    roomsize = 0.64;
elseif strcmp(revSize,'Medium')
    roomsize = 0.74;
elseif strcmp(revSize,'Large')
    roomsize = 0.84;
end

%% Lowpass Comb Filters

% The audio file first goes through 8 parallel lowpass comb filters
% and that then added in groups of 4 to give a filtered output. Depending 
% on the type of reverb method selected by the user, the module either 
% inputs the input signal (x) or the impulse response (IR) through 
% the filters

if strcmp(revType,'Additive')
    % First group
    Comb1 = LowpassCombFilter(x,0.2,roomsize,1557);
    Comb2 = LowpassCombFilter(x,0.2,roomsize,1617);
    Comb3 = LowpassCombFilter(x,0.2,roomsize,1491);
    Comb4 = LowpassCombFilter(x,0.2,roomsize,1422);
    CombGroup1 = Comb1+Comb2+Comb3+Comb4;
    % Second group
    Comb5 = LowpassCombFilter(x,0.2,roomsize,1277);
    Comb6 = LowpassCombFilter(x,0.2,roomsize,1356);
    Comb7 = LowpassCombFilter(x,0.2,roomsize,1188);
    Comb8 = LowpassCombFilter(x,0.2,roomsize,1116);
    CombGroup2 = Comb5+Comb6+Comb7+Comb8;
    
elseif strcmp(revType,'Convolution')
    % First group
    Comb1 = LowpassCombFilter(IR,0.2,roomsize,1557);
    Comb2 = LowpassCombFilter(IR,0.2,roomsize,1617);
    Comb3 = LowpassCombFilter(IR,0.2,roomsize,1491);
    Comb4 = LowpassCombFilter(IR,0.2,roomsize,1422);
    CombGroup1 = Comb1+Comb2+Comb3+Comb4;
    % Second group
    Comb5 = LowpassCombFilter(IR,0.2,roomsize,1277);
    Comb6 = LowpassCombFilter(IR,0.2,roomsize,1356);
    Comb7 = LowpassCombFilter(IR,0.2,roomsize,1188);
    Comb8 = LowpassCombFilter(IR,0.2,roomsize,1116);
    CombGroup2 = Comb5+Comb6+Comb7+Comb8;
end

% Filtered Out
CombOut = CombGroup1+CombGroup2;

%% Allpass Filters

% The signal now goes through a series of 4 Allpass filters
AP1 = AllpassFilter(CombOut,0.5,225);
AP2 = AllpassFilter(AP1,0.5,556);
AP3 = AllpassFilter(AP2,0.5,441);
AllpassOut = AllpassFilter(AP3,0.5,341);

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