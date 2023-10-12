% Hannes Du
% MAE 144
clear all; close all; clc;

%% Homework 1 Problem 3
% Test HBD_C2D_matched
syms s z z1 p1;
bs = s + z1;
as = s * (s + p1);
h = 0.1;
omega_bar = 0.5;        % Set your desired critical frequency
strictly_causal = true; % Set to true for a strictly causal D(z)

[bz_custom, az_custom] = HBD_C2D_matched(bs, as, h, omega_bar, strictly_causal);
disp("Strictly Causal with omega_bar = 0.5:");
pretty(bz_custom);
pretty(az_custom);

% Now, compare with MATLAB's 'matched' option
HBD_C2D_matched(z+1,z*(z+10), h, 0.5, true)

sys = tf([1 1], [1 10]);
sys_d = c2d(sys, h, 'matched');
disp("MATLAB's 'matched' option:");
tf(sys_d)

% Function HBD_C2D_matched
function [bz, az] = HBD_C2D_matched(bs, as, h, omega_bar, strictly_causal)
% Convert D(s) to D(z) using matched z-transform.
% Inputs:
%   bs: Coefficients of the numerator polynomial of D(s).
%   as: Coefficients of the denominator polynomial of D(s).
%   h: Time step for discretization.
%   omega_bar (optional): Critical frequency of interest (default: 0).
%   strictly_causal (optional): If true, forces a strictly causal D(z) (default: false).
% Outputs:
%   bz: Coefficients of the numerator polynomial of D(z).
%   az: Coefficients of the denominator polynomial of D(z).

if nargin < 4
    omega_bar = sym(0); % Default value for omega_bar as a symbolic variable
end

if nargin < 5
    strictly_causal = false; % Default value for strictly_causal
end

n = length(bs) - 1;
m = length(as) - 1;

bz = sym(zeros(1, n + 1));  % Initialize symbolic arrays
az = sym(zeros(1, m + 1));  % Initialize symbolic arrays
z = sym('z');  % Define z as a symbolic variable

for j = 0:n
    bz(j + 1) = bs(n - j + 1) * z^j;  % Create symbolic expressions
end

for j = 0:m
    if j == m && strictly_causal
        az(j + 1) = as(m - j + 1) * (z - 1)^j;  % Map an infinite zero to z = 1 for strictly causal
    else
        az(j + 1) = as(m - j + 1) * z^j;  % Map other poles and zeros
    end
end

% Normalize the resulting polynomials
bz = bz / az(1);
az = az / az(1);
end