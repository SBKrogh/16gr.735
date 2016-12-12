clc; clear all; close all;
%%
% The given force is in Ncm 
% 1 V

mes1 = ([114 117 127 137 152 163 190 202 332 431]-97)*10^-3;   % Volt
cur1 = [63 97 125 160 208 241 300 380 730 1020]*10^(-3);             % Ampere
force1 = mes1 * 20;                                            % Ncm

mes2 = ([130 131 140 172 195 216 239 258 295 344 395 470]-95)*10^-3;   % Volt
cur2 = [60 120 175 240 300 370 420 489 568 730 876 1120]*10^(-3);      % Ampere
force2 = mes2 * 20;                                                    % Ncm
mes3 = ([95 133 194 246 305 355 417 457]-93)*10^-3;   % Volt
cur3 = [30 60 276 420 568 730 877 1020]*10^(-3);      % Ampere
force3 = mes3 * 20;                                   % Ncm

mes4 = ([151 160 197 234 283 332 376 444 496]-91)*10^-3   % Volt
cur4 = [64 160 275 389 510 631 780 940 1120]*10^(-3)      % Ampere
force4 = mes4 * 20;                                       % Ncm

plot(cur1,force1,'*',cur2,force2,'*',cur3,force3,'*',cur4,force4,'*')
title('Relation between roll force and ampere')
xlabel('Curremt [A]')
ylabel('Torque [Ncm]')
grid on