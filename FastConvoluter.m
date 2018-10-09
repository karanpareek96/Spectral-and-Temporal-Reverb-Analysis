%       Name: Karan Pareek
%       Student ID: kp2218
% This function performs Fast Colvolution on two signals, A & B. It does so
% by first zero padding the two signals to ensure that their lengths are
% equal, taking the FFT, engaging in element wise multiplication and
% finally taking the IFFT of the matrix to produce an output signal y_fast.
% NOTE : Only works for row matrices
%
% INPUTS : Two row arrays
% OUTPUT : Fast Convolution Matrix (Mono)

function y_fast = FastConvoluter(a,b)

%% Main Function

% First, we define the length of the result vector (or the convoluted
% vector) by the following equation:
% convLen = length(A) + length(B) - 1;

% Zero padding the given signals A and B so that they are of equal length
pad_a = zeros(1,length(b) - 1);
pad_b = zeros(1,length(a) - 1);

% Joining the the original array with the row of zeros such that:
% length(A) = length(B) = convLen
a = [a,pad_a];
b = [b,pad_b];

% Taking the FFT of the given signals
Fx_A = fft(a);
Fx_B = fft(b);

% Undertaking element wise multiplication
Fx_C = Fx_A .* Fx_B;
% i.e. Fx_A(1) * Fx_B(1), Fx_A(2) * Fx_B(2) and so on...

% Taking the inverse FFT of the given matrix to obtain the output
y_fast = ifft(Fx_C);

end