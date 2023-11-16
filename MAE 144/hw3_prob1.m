% Hannes Du
% MAE 144
clear all; close all; clc;

%% Homework 3 Problem 1
a0 = 0.1;
b0 = 0.1;
d = 6;

G = tf(b0, [1 a0], 'InputDelay', d);
bode(G);