% Hannes Du
% MAE 144
clear all; close all; clc;

%% Homework 3 Extra Credit
% (a)
syms y(t) t s Y(s)

D1y = diff(y);
G = D1y + 0.1*y == 0.1*heaviside(t-6)
T = laplace(G)
LEqn = subs(T, {laplace(y(t),t,s), y(0)}, {Y(s), 20})
A = Y(s) == (exp(-6*s)/(10*s)+20)/(s+10)
B = ilaplace(A)
subs(B, {ilaplace(Y(s), s, t)}, {35})
solve(B, t)
ilaplace(LEqn)