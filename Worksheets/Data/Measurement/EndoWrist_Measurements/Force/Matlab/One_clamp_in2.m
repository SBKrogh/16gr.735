clc; close all; close all;
load('data_for_simon')
%%

% data = iddata(y,u,Ts)

ts = 0.02;     %Sample time
data_x = data_2.u{15};    % Input
data_y = data_2.y{13};    % Output

n = length(data_x);  
for t = 1:n
    time(t) = t*ts;
end

subplot(2,1,2)
plot(time,data_2.u{14},time,data_2.u{16},time,data_2.u{13})
xlabel('Time [s]')
ylabel('Current [A]')
title('Clamp two - current')
axis([0 30 -2 0.5])
grid on

subplot(2,1,1)
plot(time,data_2.y{14}*1000,time,data_2.y{16}*1000,time,data_2.y{13}*1000)
title('Clamp two - inwards force')
xlabel('Time [s]')
ylabel('Force [N]')
axis([0 30 -0.5 2])
grid on

clear figure
