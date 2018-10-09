%       Name: Karan Pareek
%       Student ID: kp2218
% This function creates a simple lowpass filter.
%
% INPUTS : Audio signal (x), Feedforward gain (g1), Feedback gain (g2)
% OUTPUT : Filtered signal (y), Feedforward coefficients (b), Feedforward
%          coefficients (a)

function [y,b,a] = LowpassFilter(x,g1,g2)

%% Main Function

% Error checking
if g2 > 1
    error('Feedback gain cannot exceed 1');
end

% Given the amount of delay in samples and the gain factors, we can now 
% define the feedforward and feedback coefficients for the filter

b = [g1];
a = [1,-g2];

y = filter(b,a,x);
end
