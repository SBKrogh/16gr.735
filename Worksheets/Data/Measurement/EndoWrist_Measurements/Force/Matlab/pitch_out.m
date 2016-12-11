clc; close all; close all;
load('pitchdata')
%%

% data = iddata(y,u,Ts)

ts = 0.02;     %Sample time
data_x = data.u{8};    % Input
data_y = data.y{8};    % Output

n = length(data_x);  
for t = 1:n
    time(t) = t*ts;
end



subplot(2,1,2)
plot(time,data.u{11},time,data.u{9},time,data.u{10})
xlabel('Time [s]')
ylabel('Current [A]')
title('Pitch - current')
axis([0 30 -1 0.5])
grid on

subplot(2,1,1)
plot(time,data.y{11}(:,2)*1000,time,data.y{9}(:,2)*1000,time,data.y{10}(:,2)*1000)
title('Pitch - downwards force')
xlabel('Time [s]')
ylabel('Force [N]')
axis([0 30 -0.5 2.2])
grid on

clear figure
