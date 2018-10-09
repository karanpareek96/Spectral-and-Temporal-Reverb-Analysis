%       Name: Karan Pareek
%       Student ID: kp2218
% This function recreates the Freeverb reverberation algorithm. In addition
% to the basic parameters such as gain, size and spread of the reverb, the
% user can choose from an additive and convoluted reverb that produces 
% different sounds.
%
% INPUTS: Name of Input File, Name of Output File, Type of Reverberation
%         (Additive/Convolution), Reverb Gain, Reverb Size
% OUTPUT: JCRev Output (y)

function y = JCRev(inputFilename,revType,revGain,revSize)

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

% Left Channel
roomsize = 0.7;
if strcmp(revSize,'Small')
    roomsize = 0.3;
elseif strcmp(revSize,'Medium')
    roomsize = 0.55;
elseif strcmp(revSize,'Large')
    roomsize = 0.8;
end

%% Allpass Filters

% The audio signal first goes through 3 Allpass filters placed in a series.
% Depending on the type of reverb method selected by the user, the module 
% either inputs the input signal (x) or the impulse response (IR) through 
% the filters

if strcmp(revType,'Additive')
    y1 = AllpassFilter(x,0.7,1051);
    y2 = AllpassFilter(y1,0.7,337);
    AllpassOut = AllpassFilter(y2,0.7,113);
elseif strcmp(revType,'Convolution')
    y1 = AllpassFilter(IR,0.7,1051);
    y2 = AllpassFilter(y1,0.7,337);
    AllpassOut = AllpassFilter(y2,0.7,113);
end

%% Feedforward Comb Filters

% The resultant signal enters the feedforward module where 4 parallel comb
% filters process the signal before adding a delay ramp
y3 = FeedforwardCombFilter(AllpassOut,roomsize,4799);
y4 = FeedforwardCombFilter(AllpassOut,roomsize,4999);
y5 = FeedbackCombFilter(AllpassOut,roomsize,5399);
y6 = FeedbackCombFilter(AllpassOut,roomsize,5801);

CombOut = y3+y4+y5+y6;

%% Output Section

dryGain = 1 - revGain; % Total of Dry and Wet should be 1

RevOut = revGain*CombOut;
input = dryGain*x;

if strcmp(revType,'Additive')
    yOut = (input+RevOut);
elseif strcmp(revType,'Convolution')
    yOut = FastConvoluter(input,RevOut);
end

yOut = yOut/max(abs(yOut));

%% Channel Delay

% After the signal exits the reverb module, the audio can be split into
% multiple channels. Each channel is delayed by a factor of the sample rate
% and finalized as the reverberated output

% delaying the left channel by 0.046*fs samples
leftPad = zeros(1,round(0.046*fs));
leftChannel = [leftPad,yOut,zeros(1,485)];

% delaying the right channel by 0.057*fs samples
rightPad = zeros(1,round(0.057*fs));
rightChannel = [rightPad,yOut];
% Concatnating the channels to obtain a stereo output
y = [leftChannel;rightChannel];
y = y';

end