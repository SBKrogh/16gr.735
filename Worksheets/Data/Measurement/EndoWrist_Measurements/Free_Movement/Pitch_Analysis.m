close all; clear all; clc;

% M= csvread('MotorLog.csv');
% avg=20;
% Filter_curr = M(1:avg,1);
% 
% for i=1+avg:size(M,1)-avg
%     Filter_curr(i)=mean(M(i+1:i+avg,1));
%     
% end

M = csvread('MotorLog (10).csv');

subplot(2,1,1);
plot(M(:,1),M(:,2));
subplot(2,1,2)
plot(M(:,1),M(:,3));

%0.1569;0.1537;0.1659;0.1662;0.1857;0.1889;0.1828;0.162;0.154;0.1956;

mean([0.1569,0.1537,0.1659,0.1662,0.1857,0.1889,0.1828,0.162,0.154,0.1956])