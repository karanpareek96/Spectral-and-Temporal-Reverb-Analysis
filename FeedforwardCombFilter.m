%       Name: Karan Pareek
%       Student ID: kp2218
% This function creates feedforward comb filter.
%
% INPUTS : Audio signal (x), Feedfoward gain (g), Delay length (d)
% OUTPUT : Filtered signal (y), Feedforward coefficients (b), Feedforward
%          coefficients (a)

function [y,b,a] = FeedforwardCombFilter(x,g,d)

%% Main Function

% Given the amount of delay in samples and the gain factor, we can now 
% define the feedforward and feedback coefficients for the filter

b = [1,zeros(1,d-1),g];
a = [1];

y = filter(b,a,x);

end
