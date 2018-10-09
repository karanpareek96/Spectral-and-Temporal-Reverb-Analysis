%       Name: Karan Pareek
%       Student ID: kp2218
% This function creates feedback comb filter.
%
% INPUTS : Audio signal (x), Feedback gain (g), Delay length (d)
% OUTPUT : Filtered signal (y), Feedforward coefficients (b), Feedforward
%          coefficients (a)

function [y,b,a] = FeedbackCombFilter(x,g,d)

%% Main Function

% Error checking
if g > 1
    error ('Filter gain cannot exceed 1');
end

% Given the amount of delay in samples and the gain factor, we can now 
% define the feedforward and feedback coefficients for the filter

b = [0,zeros(1,d-1),1];
a = [1,zeros(1,d-1),-g];

y = filter(b,a,x);

end
