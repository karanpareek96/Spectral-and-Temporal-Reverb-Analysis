%       Name: Karan Pareek
%       Student ID: kp2218
% This function recreates the Freeverb reverberation algorithm. In addition
% to the basic parameters such as gain, size and spread of the reverb, the
% user can choose from an additive and convoluted reverb that produces 
% different sounds.
%
% INPUTS: Name of Input File, Name of Output File, Type of Reverberation
%         (Additive/Convolution), Reverb Gain, Reverb Size
% OUTPUT: Stereo Output (y)

function y = StereoReverb(inputFilename,revType,revGain,revSize)

%% Initialization

% Using audioread to read the input file
[x,fs] = audioread(inputFilename);

% Mono to Stereo conversion
if size(x,2) < 2
    x = [x,x];
end

% Transposing the audio file into rows and extending its length to
% incorporate the reverberated tail
x = x';
x = [x,zeros(2,1.5*fs)];
xLeft = x(1,:);
xRight = x(2,:);

% Since the GUI allows the user to switch between Additive and Convolution
% reverb type, the function creates an IR by default by creating a row of
% zeros with length 'fs' and placing IR(1st column) as 1
IR = zeros(2,fs);
IR(1,1) = 1;
IR(2,1) = 1;
irLeft = IR(1,:);
irRight = IR(2,:);

%% Room Size

% Before processing the audio file/IR through the reverb module, we must
% define certain parameters for the size of the acoustic space.

% Left Channel
roomsize = 0.7;
if strcmp(revSize,'Small')
    roomsize = 0.3;
elseif strcmp(revSize,'Medium')
    roomsize = 0.8;
elseif strcmp(revSize,'Large')
    roomsize = 0.9;
end

%% Left In

% The audio file first goes through 2 Allpass filters in a series.
% Depending on the type of reverb method selected by the user, the module 
% either inputs the input signal (x) or the impulse response (IR) through 
% the filters

if strcmp(revType,'Additive')
    y1 = AllpassFilter(xLeft,0.8,500);
    y2 = AllpassFilter(y1,0.8,500);
elseif strcmp(revType,'Convolution')
    y1 = AllpassFilter(irLeft,0.8,500);
    y2 = AllpassFilter(y1,0.8,500);
end

% Now the filtered output goes through 4 parallel Comb filters
y3 = LowpassCombFilter(y2,0.8,roomsize,2000);
y4 = LowpassCombFilter(y2,0.8,roomsize,5000);
y5 = LowpassCombFilter(y2,0.8,roomsize,1000);
y6 = LowpassCombFilter(y2,0.8,roomsize,500);

% Now, each output is multiplied with a gain ratio of 0.7
C1 = 0.7*y3;
C2 = 0.7*y4;
C3 = 0.7*y5;
C4 = 0.7*y6;

%% Right In

% The audio file first goes through 2 Allpass filters in a series.
% Depending on the type of reverb method selected by the user, the module 
% either inputs the input signal (x) or the impulse response (IR) through 
% the filters

if strcmp(revType,'Additive')
    y7 = AllpassFilter(xRight,0.8,500);
    y8 = AllpassFilter(y7,0.8,500);
elseif strcmp(revType,'Convolution')
    y7 = AllpassFilter(irRight,0.8,500);
    y8 = AllpassFilter(y7,0.8,500);
end

% Now the filtered output goes through 4 parallel Comb filters
y9 = FeedbackCombFilter(y8,roomsize,1000);
y10 = FeedbackCombFilter(y8,roomsize,6000);
y11 = FeedbackCombFilter(y8,roomsize,2000);
y12 = FeedbackCombFilter(y8,roomsize,1000);

% Now, each output is multiplied with a gain ratio of 0.7
C5 = 0.7*y9;
C6 = -0.7*y10;
C7 = 0.7*y11;
C8 = -0.7*y12;

%% Matrix Multiplication

% In order to get  stereo output, the comb filter outputs are multiplied by
% a mixing orthogonal matrix
% M = [1,1,1,1;1,-1,1,-1];

left1 = (C1+C5);
left2 = (C2+C6);
left3 = (C3+C7);
left4 = (C4+C8);
leftOut = left1+left2+left3+left4;

right1 = (C1+C5);
right2 = (C2+C6);
right3 = (C3+C7);
right4 = (C4+C8);
rightOut = right1-right2+right3-right4;


%% Output Section

dryGain = 1 - revGain; % Total of Dry and Wet should be 1

leftOut = revGain*leftOut;
rightOut = revGain*rightOut;
RevOut = [leftOut;rightOut];

leftIn = dryGain*xLeft;
rightIn = dryGain*xRight;
input = [leftIn;rightIn];

if strcmp(revType,'Additive')
    y = input+RevOut;
elseif strcmp(revType,'Convolution')
    yLeft = FastConvoluter(input(1,:),RevOut(1,:));
    yRight = FastConvoluter(input(2,:),RevOut(2,:));
    y = [yLeft;yRight];
end

yLeft = y(1,:)/max(abs(y(1,:)));
yRight = y(2,:)/max(abs(y(2,:)));
y = [yLeft;yRight];
y = y';

end