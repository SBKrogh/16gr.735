clc; clear all; close all;

d0 = load('MotorLog top up.csv');
d1 = load('MotorLog top up2.csv');
d2 = load('MotorLog top up3.csv');
d3 = load('MotorLog top up4.csv');
d4 = load('MotorLog top up5.csv');
d5 = load('MotorLog top up6.csv');
d6 = load('MotorLog top up7.csv');
d7 = load('MotorLog top up8.csv');
d8 = load('MotorLog top up9.csv');
d9 = load('MotorLog top up10.csv');


fd0 = d0(:,3)*1000;
fd1 = d1(:,3)*1000;
fd2 = d2(:,3)*1000;
fd3 = d3(:,3)*1000;
fd4 = d4(:,3)*1000;
fd5 = d5(:,3)*1000;
fd6 = d6(:,3)*1000;
fd7 = d7(:,3)*1000;
fd8 = d8(:,3)*1000;
fd9 = d9(:,3)*1000;

cd0 = d0(:,6);
cd1 = d1(:,6);
cd2 = d2(:,6);
cd3 = d3(:,6);
cd4 = d4(:,6);
cd5 = d5(:,6);
cd6 = d6(:,6);
cd7 = d7(:,6);
cd8 = d8(:,6);
cd9 = d9(:,6);

plot(cd0,fd0,cd1,fd1,cd2,fd2,cd3,fd3,cd4,fd4,cd5,fd5,cd6,fd6,cd7,fd7,cd8,fd8,cd9,fd9)
