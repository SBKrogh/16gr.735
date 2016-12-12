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
plot(time,data.u{2},time,data.u{4},time,data.u{5})
xlabel('Time [s]')
ylabel('Current [A]')
title('Pitch - current')
axis([0 30 -0.5 1])
grid on

subplot(2,1,1)
plot(time,data.y{2}(:,2)*1000,time,data.y{4}(:,2)*1000,time,data.y{5}(:,2)*1000)
title('Pitch - upwards force')
xlabel('Time [s]')
ylabel('Force [N]')
axis([0 30 -3 0.5])
grid on

clear figure
