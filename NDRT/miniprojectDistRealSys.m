%Miniproject in real times systems. 
%!!!only runs in matlab 9.1 or newer aka 2016b!!!
%A car ethernet based car network. The car has the following elements,
%which has the following priorites. All time is in ms
% Flow | Min/Mean Cycle time [ms]| Size [B] | Priority | D/P
%-------------------------------------------------------------
% W1   | 2                       | 20       | 1        | D
% W2   | 2                       | 20       | 1        | D
% W3   | 2                       | 20       | 1        | D
% W4   | 2                       | 20       | 1        | D
% ESC  | 20                      | 8        | 1        | D
%      |    Mean                 |          |          |
% RC   | 2                       | 1400     | 2        | P
% MM   | 2.5                     | 1400     | 3        | P

%The moduels are connected to two 10MbpS switchs the following way
%witchs 1 = W1 + W2 + ESC+ EC + HUD. EC is engien contorl and HUB is the display which only recives
%switch 2 = W3+ W4 + RC + MM
%The data is transmitted the follwoing way 
%W{1,2,3,4} -> ESC
% ESC -> EC
% Multimedia -> HUD
% RC -> HUD
% RTC dokumentaion http://www.mpa.ethz.ch/static/Tutorial.html
clear all;
%Assignment 1A
%% Determanistic part
Wheel_packet_size = (20*8);%packet size for wheels
ESC_packet_size = (8*8);%%packet size for ESC

%the determanistic task are modeled as periodic task with jitter
%rtcpjd(period, jitter, minimum interarrival time)
W1 = rtcpjd(2,0,0);%Wheel 1 with period of 2ms and a jitter of 0ms
W2 = rtcpjd(2,0,0);%Wheel 2 with period of 2ms and a jitter of 0ms
W3 = rtcpjd(2,0,0);%Wheel 3 with period of 2ms and a jitter of 0ms
W4 = rtcpjd(2,0,0);%Wheel 4 with period of 2ms and a jitter of 0ms
ESC = rtcpjd(20,0,0);%ESC with period of 20ms and a jitter of 0ms

switch_1 = rtcfs(10000);%service curve with 10Mbit bandwidth = 10.000bit/ms
switch_2 = rtcfs(10000);

W1_in = rtctimes(W1,Wheel_packet_size);%scale curve with packet size
W2_in = rtctimes(W2,Wheel_packet_size);
W3_in = rtctimes(W3,Wheel_packet_size);
W4_in = rtctimes(W4,Wheel_packet_size);
ESC_in = rtctimes(ESC,ESC_packet_size);

%this models all the determanistic trafic to model the poisson trafic,
%there is used a token bucket filter in order to make the trafic
%determanistic

%% poisson traffic
%Token bucket filet 
% filter for RC 
RC_mean = 2;
Sercive_time_RC_filter = 2;
token_amount_RC = 5;
queue_lenght_RC = 10;
[RC_packet_loss, RC_wait_time] = token_bucket(1/RC_mean, Sercive_time_RC_filter, token_amount_RC, queue_lenght_RC);
disp(['RC packt loss from filter = ', num2str(RC_packet_loss*100),'%']);
disp(['RC mean wait time in filter = ', num2str(RC_wait_time),'ms']);

%filter for Multi media 
MM_mean = 2.5;
Sercive_time_MM_filter = 3;
token_amount_MM = 5;
queue_lenght_MM = 10;
[MM_packet_loss, MM_wait_time] = token_bucket(1/MM_mean, Sercive_time_MM_filter, token_amount_MM, queue_lenght_MM);
disp(['MM packt loss from filter = ', num2str(MM_packet_loss*100),'%']);
disp(['MM mean wait time in filter = ', num2str(MM_wait_time),'ms']);

%determanist assumptions for poisson processes
RC_packet_size = (1400*8);
MM_packet_size = (1400*8);
RC = rtcpjd(Sercive_time_RC_filter,0,0);%RC with period of 2ms and a jitter of 0ms
MM = rtcpjd(Sercive_time_MM_filter,0,0);%MM with period of 2.5ms and a jitter of 0ms
RC_in = rtctimes(RC,RC_packet_size);%scale curve with packet size
MM_in = rtctimes(MM,MM_packet_size);

%% Joined GPC model

%switch 1
[W1_out, switch_1_left, del1, buf1] = rtcgpc(W3_in, switch_1);
[W2_out, switch_1_left, del2, buf2] = rtcgpc(W4_in, switch_1_left);
[ESC_out, switch_1_left, del3, buf3] = rtcgpc(ESC_in, switch_1_left);

%switch 2
[W3_out, switch_2_left, del4, buf4] = rtcgpc(W1_in, switch_2);
[W4_out, switch_2_left, del5, buf5] = rtcgpc(W2_in, switch_2_left);
[RC_out, switch_2_left, del6, buf6] = rtcgpc(RC_in, switch_2_left);
[MM_out, switch_2_left, del7, buf7] = rtcgpc(MM_in, switch_2_left);

%joining all trafic from switch 2 there goes for switch 1
[switch_2_out, ecc1, ecc2] =  rtcjoin(W3_out, W4_out, RC_out, MM_out);

%trafic from switch 2 into 1
%[from_switch_2, switch_1_left, del8, buf8] = rtcgpc(switch_2_out, switch_1_left);

%% print of results 
disp(['Wheel 1: delay = ',num2str(del1), 'ms ;  buffer size = ',num2str(buf1)]);
disp(['Wheel 2: delay = ',num2str(del2), 'ms ;  buffer size = ',num2str(buf2)]);
disp(['Wheel 3: delay = ',num2str(del4), 'ms ;  buffer size = ',num2str(buf4)]);
disp(['Wheel 3: delay = ',num2str(del5), 'ms ;  buffer size = ',num2str(buf5)]);
disp(['ESC: Delay = ',num2str(del3), 'ms ;  buffer size = ',num2str(buf3)]);
disp(['RC filter: Delay = ',num2str(del6), 'ms ;  buffer size = ',num2str(buf6)]);
disp(['MM filter: Delay = ',num2str(del7), 'ms ;  buffer size = ',num2str(buf7)]);
%disp(['data from switch 1: delay = ',num2str(del8), 'ms ;  buffer size = ',num2str(buf8)]);

%% Token bucket function
function [packet_loss, mean_wait_time] = token_bucket(lambda, service_rate, token_size, queue_lenght)
    %calculate arrival probalilitys 
    A = zeros(1,queue_lenght+token_size);
    for j = 1:queue_lenght+token_size
        i = j-1; %make count start in 0
        A(j) = (lambda*service_rate)^i*exp(-lambda*service_rate)/factorial(i);
    end
    
    %calculat transison matrix for Periodic Transfer
    H = zeros(queue_lenght+token_size,queue_lenght+token_size);
    for i=1:queue_lenght+token_size
        if(i==1) %first run
            for j=1:queue_lenght+token_size-1
                if(j==1)
                    H(i,j) = A(1)+A(2); %spcieal start when Periodic Transfer istead of M/G/1
                else
                    H(i,j) = A(j+1);
                end
            end
        else %for subsecuent rows
            for j=i-1:queue_lenght+token_size-1 %from i-1 until matrix end
                H(i,j) = A(j+2-i);
            end
        end
    end
    
    %calculate propability that a packet is lost in a state
    sum_H = H*ones(queue_lenght+token_size,1); %sum H matrix by the use of matrix mutplication 
    H(:,end) = 1-sum_H; %append the propability to H

    %calculating for stationary probability
    pie_matrix = H^1000;

    %packloss calculation
    packet_loss = pie_matrix(1,queue_lenght+token_size);
    
    %Calculate average queue lenght 
    Q = 0;
    for i = token_size:queue_lenght+token_size-1
        Q = Q + pie_matrix(1,i)*(i-token_size+1);
    end
    
    %calculate mean wait time
    lamdba_prime = (1-packet_loss)*lambda;
    mean_wait_time = Q/lamdba_prime;
end