% Hannes Du
% MAE 144
clear all; close all; clc;

%% Homework 1 Problem 2(a)
clear all; close all; clc;

% Defines polynomials a(s) and b(s) for plant G(s)
a = RR_poly([1 0 -46 0 369 0 -324]);
b = RR_poly([1 0 -29 0 100]);
G = RR_tf(b, a);

% Defines polynomials x(s) and y(s) for controller D(s)
x = b;
y = RR_poly([1 20 108 -344 -5626 -18144 6731 161352 337087 172044 -233649 -314928 -104652]);
D = RR_tf(y, x);
T = G*D/(1+G*D);

% Verify the controller works
f = RR_poly([1 20 154 576 1089 972 324]);
[x,y] = RR_diophantine(a,b,f);
test = trim(a*x+b*y);
residual = norm(f-test);

%% Homework 1 Problem 2(b)
T = RR_tf([1 20 154 576 1089 970 323], [1 80 2554 41816 380449 1989512 5973444 9897840 8164800 2592000]);
f2 = RR_poly([1 80 2554 41816 380449 1989512 5973444 9897840 8164800 2592000])
D2 = T/(G*(1-T))
[x,y] = RR_diophantine(a,b,f2);
test = trim(a*x+b*y)
residual = norm(f-test)