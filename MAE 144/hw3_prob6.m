% Hannes Du
% MAE 144
clear all; close all; clc;

%% Homework 3 Problem 6
% 6(a)
a0 = 0.1;
b0 = 0.1;
d = 6;

G = tf(b0, [1 a0 0], 'InputDelay', d);
bode(G);

Gz = c2d(G, 2);
z1 = tf([1 -1], [1 0], -1);
Gz = Gz*z1;

z = zero(Gz);
p = pole(Gz);

% 6(b)
Tz = tf([1], [1 0 0 0 0], -1)
Dz = Tz/Gz/(1-Tz)