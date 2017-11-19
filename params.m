%lab 3 (LTI)
% motor paramretrs CL 321
Pn = 8; % W
wn = 315; %rad/s
Un = 110; %V
In = 0.58; %A
Mn = 0.123;% H*m
Jm = 0.59*10^(-4); %kg*m^2 * 10^(-4)
R  = 25.8; %Om
L  = 130*10^(-3); %mHn

%formules
Ta = L/R; %s   armature time constant
ce = (Un - In*R)/wn;
cm = Mn/In;
Tm = (R*Jm)/(ce*cm);% electromechanic time constant
k1 = 1/R;
k2 = cm/Jm;

%%%%%
%Feedback:
Ang_FB = 1;

%Gains:
PwrAmpl = 50;

%PI controller parametrs
s = roots([Ta/k1/k2/ce, 1/k1/k2/ce, 1]);
T1 = -1/s(1);
T2 = -1/s(2);
k_pa = 1; %power amplifier in velocity control loop
k_vfb = 0.45; % velocity feedback in velocity control loop
kp = T2*ce/(2*T1*k_pa*k_vfb);
ki = kp/T2;


% Flux = 1;
% Mf = 0.05*Mn;
% r_sh = 0.01*R;
% k_tg = 0.45; %V/(rad/s)
% 
% % Matrices A,B,C,D
% 
% A = [-1/Ta, -ce*Flux; cm*Flux/Jm, 0];
% B = [1/L, 0; 0, -1/Jm];
% C = [r_sh,0;0,k_tg];
% D = [0,0;0,0];
% %
% Ts1 = 0.02; % sampling period 1
% Ts2 = 0.002; % sampling period 2
% 
% % state spase model
% SSsys = ss(A,B,C,D);
% %Continious time model:
% [Num1 Den1] = ss2tf(A,B,C,D,1);
% [Num2 Den2] = ss2tf(A,B,C,D,2);
%  W11 = tf(Num1(1,:),Den1); %TF from first input to output
%  W12 = tf(Num1(2,:),Den1); %TF from second input to output
%  W21 = tf(Num2(1,:),Den2); %TF from first input to output
%  W22 = tf(Num2(2,:),Den2);
%  %Descret time model
%  Wz = zpk(SSsys);
%  ZPKsys1 = c2d(Wz,Ts1);
%  ZPKsys2 = c2d(Wz,Ts2);
%  % system set parametrs
%  SSsys.inputName{1,1}='U';
%  SSsys.inputName{2,1}='M';
%  SSsys.OutputName{1,1}='I';
%  SSsys.OutputName{2,1}='w';
%  SSsys.UserData='lab4';
%  SSsys.Notes='control system toolbox';


