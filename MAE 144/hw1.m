% Hannes Du
% MAE 144 Homework 1

%% Problem 2(a)
clear all; close all; clc;

% Defines polynomials a(s) and b(s) for plant G(s)
a = RR_poly([1 0 -46 0 369 0 -324]);
b = RR_poly([1 0 -29 0 100]);
G = RR_tf(b, a);

% Defines polynomials x(s) and y(s) for controller D(s)
x = b;
x = RR_poly([1 180 14371 666780 19742500 383730000 4792800000 34454400000 76512000000 784000000000 6144000000000 10240000000000 23040000000000 51200000000000])
y = RR_poly([1 20 108 -344 -5626 -18144 6731 161352 337087 172044 -233649 -314928 -104652]);
D = RR_tf(y, x)
T = G*D/(1+G*D)

% Verify the controller works
f = RR_poly([1 20 154 576 1089 972 324]);
[x,y] = RR_diophantine(a,b,f);
test = trim(a*x+b*y);
residual = norm(f-test);

f = RR_poly([1 200 18154 988296 35922369 918379392 16947568884 228050823120 2234759289600 15771794048000 78516586240000 267095628800000 592349184000000 796446720000000 572313600000000 165888000000000]);
[x,y] = RR_diophantine(a,b,f);
test = trim(a*x+b*y);
residual = norm(f-test);

%% Problem 3
syms s z1 p1;
bs = s + z1;
as = s * (s + p1);
h = 0.1;
omega_bar = 0.5; % Set your desired critical frequency
strictly_causal = true; % Set to true for a strictly causal D(z)

[bz, az] = XYZ_C2D_matched(bs, as, h, omega_bar, strictly_causal)

function [bz, az] = XYZ_C2D_matched(bs, as, h, omega_bar, strictly_causal)
% function [bz, az] = XYZ_C2D_matched(bs, as, h, omega_bar, strictly_causal)
% Convert D(s) to D(z) using matched z-transform.
% Inputs:
%   bs: Coefficients of the numerator polynomial of D(s).
%   as: Coefficients of the denominator polynomial of D(s).
%   h: Time step for discretization.
%   omega_bar (optional): Critical frequency of interest.
%   strictly_causal (optional): If true, forces a strictly causal D(z).
% Outputs:
%   bz: Coefficients of the numerator polynomial of D(z).
%   az: Coefficients of the denominator polynomial of D(z).

if nargin < 4
    omega_bar = 0; % Default value for omega_bar
end

if nargin < 5
    strictly_causal = false; % Default value for strictly_causal
end

n = length(bs) - 1;
m = length(as) - 1;

bz = zeros(1, n + 1);
az = zeros(1, m + 1);

for j = 0:n
    z = exp(1i * omega_bar * h);
    bz(j + 1) = bs(n - j + 1) * z^j;
end

for j = 0:m
    z = -1; % Mapping infinite zeros to z = -1
    if strictly_causal && j == m 
        z = 1; % If strictly causal, map an infinite zero to z = 1
    az(j + 1) = as(m - j + 1) * z^j;
end

% Normalize the resulting polynomials
bz = bz / az(1);
az = az / az(1);

end
end