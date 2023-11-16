% Hannes Du
% MAE 144
clear all; close all; clc;

%% Homework 3 Problem 4
% 4(a)
a0 = 0.1;
b0 = 0.1;
d = 6;
G = tf(b0, [1 a0], 'InputDelay', d);

alpha = 0.6;
beta = 0.5;
gamma = 0.125;
Ku = 3.2;
omega = 0.3;
Tu = 1/omega;
Kp = 0.6*Ku;
TI = beta*Tu;
TD = gamma*Tu;
D_PID = Kp*TD*tf([1 1/TD 1/TD/TI], [1 0]);

bode(G*D_PID);

omega_I = 1/TI;
omega_D = 1/TD;

% 4(b)
figure();
% Define time points
t = 0:0.01:6;  % Time from 0 to 6 hours with 0.01-hour intervals

% Initialize the temperature profile with the bath temperature at 20°C
T_profile = 20 * ones(size(t));

% Set the temperature profile as described
T_profile(t >= 1 & t < 2) = 35;  % 35°C for 1 hour
T_profile(t >= 2 & t < 5) = 45;  % 45°C for 3 hours
T_profile(t >= 5 & t < 6) = 20;  % 20°C for 1 hour

% Adjust for the limitation of the hot water source at 42°C
T_hot_source = 42;  % Cooler hot water source temperature
T_profile = min(T_profile, T_hot_source);

% Plot the temperature profile with the 42°C hot water source limitation
plot(t, T_profile, 'b', 'LineWidth', 1);
xlabel('Time (hours)');
ylabel('Temperature (°C)');
title('Temperature Profile with 42°C Hot Water Source Limitation');
grid on;