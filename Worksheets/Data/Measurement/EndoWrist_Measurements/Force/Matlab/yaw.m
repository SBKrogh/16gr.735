clc; close all; close all;
load('currentyaw')
%%

% data = iddata(y,u,Ts)

ts = 0.02;     %Sample time
data_x = data.u{7};    % Input
data_y = data.y{7};    % Output

n = length(data_x);  
for t = 1:n
    time(t) = t*ts;
end

fdata = idfilt(data,[0 15]);

h1=subplot(3,1,1)
plot(time,data.y{7})
line([15 15],get(h1,'YLim'),'Color',[1 0 0]);
line([18.7 18.7],get(h1,'YLim'),'Color',[1 0 0]);%%%%
line([17.7 17.7],get(h1,'YLim'),'Color',[0 1 0]);%%%%
%line([16.88 16.88],get(h1,'YLim'),'Color',[0 1 0]);%%%%
title('Clamp force')
%xlabel('Time [s]')
ylabel('Force [N]')
axis([0 30 -0.2 4])
grid on



h2=subplot(3,1,2)
plot(time,data.u{7}(:,1))
line([15 15],get(h2,'YLim'),'Color',[1 0 0]);
line([18.7 18.7],get(h2,'YLim'),'Color',[1 0 0]);%%%%
line([17.7 17.7],get(h2,'YLim'),'Color',[0 1 0]);%%%%
%line([16.88 16.88],get(h2,'YLim'),'Color',[0 1 0]);%%%%
%xlabel('Time [s]')
ylabel('Current [A]')
title('Clamp current')
axis([0 30 -1 0.4])
grid on



h3=subplot(3,1,3)
plot(time,fdata.u{7}(:,2))
line([15 15],get(h3,'YLim'),'Color',[1 0 0]);
line([18.7 18.7],get(h3,'YLim'),'Color',[1 0 0]);%%%%
line([17.7 17.7],get(h3,'YLim'),'Color',[0 1 0]);%%%%
%line([16.88 16.88],get(h3,'YLim'),'Color',[0 1 0]);%%%%
xlabel('Time [s]')
ylabel('Velocity [rad/s]')
title('Clamp velocity')
axis([0 30 -0.8 0.7])
grid on






clear figure
