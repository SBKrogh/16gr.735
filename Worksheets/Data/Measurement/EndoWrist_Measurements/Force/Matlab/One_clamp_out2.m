clc; close all; close all;
load('data_for_simon')
%%

% data = iddata(y,u,Ts)

ts = 0.02;     %Sample time
data_x = data_2.u{1};    % Input
data_y = data_2.y{1};    % Output

n = length(data_x);  
for t = 1:n
    time(t) = t*ts;
end

subplot(2,1,2)
plot(time,data_2.u{2},time,data_2.u{3},time,data_2.u{4})
xlabel('Time [s]')
ylabel('Current [A]')
title('Clamp two - current')
axis([0 14 -0.5 2])
grid on

subplot(2,1,1)
plot(time,data_2.y{2}*1000,time,data_2.y{3}*1000,time,data_2.y{4}*1000)
title('Clamp two - outwards force')
xlabel('Time [s]')
ylabel('Force [N]')
axis([0 14 -2.2 0.5])
grid on

clear figure
