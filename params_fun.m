function  [sys]=params_fun(K, b)

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
% 
% %Gains:
% PwrAmpl = 50;

%PI controller parametrs
s = roots([Ta/k1/k2/ce, 1/k1/k2/ce, 1]);
T1 = -1/s(1);
T2 = -1/s(2);
k_pa = 1; %power amplifier in velocity control loop
k_vfb = 0.45; % velocity feedback in velocity control loop
kp = T2*ce/(2*T1*k_pa*k_vfb);
ki = kp/T2;

assignin('base', 'Pn', Pn);
assignin('base', 'wn', wn);
assignin('base', 'Un', Un);
assignin('base', 'In', In);
assignin('base', 'Mn', Mn);
assignin('base', 'Jm', Jm);
assignin('base', 'R', R);
assignin('base', 'L', L);
assignin('base', 'Ta', Ta);
assignin('base', 'ce', ce);
assignin('base', 'cm', cm);
assignin('base', 'Tm', Tm);
assignin('base', 'k1', k1);
assignin('base', 'k2', k2);
assignin('base', 'Ang_FB', Ang_FB);

assignin('base', 's', s);
assignin('base', 'T1', T1);
assignin('base', 'T2', T2);
assignin('base', 'k_pa', k_pa);
assignin('base', 'k_vfb', k_vfb);
assignin('base', 'kp', kp);
assignin('base', 'ki', ki);


[A,B,C,D] = linmod('start_mdl_dc_motor2');
sys = ss(A,B,C,D);
