function [unctr, K, b,sys] = Modal_control (A,B,tgel,sigma,both)

C = eye(3);
D = 0;

K = [0, 0, 0];
b = 0;
sys = 0;
% �������������� ������ �������� ������� � ������������ ���������
n = length(A)  %������� ������� ������� ��������� �

B(:, 2:size(B)) = []; % ������� ������ ������� ������� B

%�������� ������������� ������ �,�
Co = ctrb(A,B);
unctr = length(A)-rank(Co) ; %����� ������������� ���

if unctr==0
   disp ( '������� ��������� ����������' )
else 
   T = '����� ������������� ��� ���������';
   disp ([T unctr])
   return
end

%������ �������� ������ ������ �� ������� ������� � ������� �����������
%��������


if sigma == 1
    [z,p,k] = buttap(n);
    [b,a] = zp2tf(z,p,k);
    SYS = tf(b,a);
    [Y,T] = step(SYS,0:0.01:30);
    j = length(Y);

    while (Y(j) < 1.05)&&(Y(j) > 0.95) 
        j = j-1;
    end
    
    tau = T(j); %������������� �������� ������� ����������� ��������
    w0 = tau/tgel; %�������� ��������������������� �����
    
    for i = 1:n %������ ������������� ��������� ��������
        a(i+1) = a(i+1).*w0^(i);	
    end
    
    b = a(n+1); %������ ��������������� ������������ � ������ ����
    SYS = tf(b,a);
    [z,p,k] = zpkdata(SYS,'v'); %������� �����, ������� � �����������          

end

if sigma == 2

    
    p(1:n) = -1;
    a = poly(p);
    SYS = tf(1,a);

    [Y,T] = step(SYS,0:0.01:30);
    j = length(Y);
    
    while (Y(j) < 1.05)&&(Y(j) > 0.95) 
        j = j-1;
    end
    
    tau = T(j); %������������� �������� ������� ����������� ��������
    w0 = tau/tgel; %�������� ��������������������� �����

    for i = 1:n %������ ������������� ��������� ��������
        a(i+1) = a(i+1).*w0^(i);	
    end
    
    b = a(n+1) %������ ��������������� ������������ � ������ ����
    SYS = tf(b,a);
    [z,p,k] = zpkdata(SYS,'v') %������� �����, ������� � �����������          

end

%������ ������������ ���������� ����������
K = place(A,B,p)

assignin('base','K', K);
assignin('base','b', b);

sys = params_fun(K, b);

cla reset

step(sys), grid on %���������� �������������� �������
if sigma == 1
else if sigma == 2
    end
end

if both == 1
    if sigma == 1
        p(1:n) = -1;
        a = poly(p);
        SYS = tf(1,a);

        [Y,T] = step(SYS,0:0.01:30);
        j = length(Y);
    
        while (Y(j) < 1.05)&&(Y(j) > 0.95) 
            j = j-1;
        end
    
        tau = T(j); %������������� �������� ������� ����������� ��������
        w0 = tau/tgel; %�������� ��������������������� �����

        for i = 1:n %������ ������������� ��������� ��������
            a(i+1) = a(i+1).*w0^(i);	
        end
    
        b = a(n+1) %������ ��������������� ������������ � ������ ����
        SYS = tf(b,a);
       [z,p,k] = zpkdata(SYS,'v') %������� �����, ������� � �����������    
   
    else if sigma ==2
            [z,p,k] = buttap(n);
            [b,a] = zp2tf(z,p,k);
            SYS = tf(b,a);
            [Y,T] = step(SYS,0:0.01:30);
            j = length(Y);

            while (Y(j) < 1.05)&&(Y(j) > 0.95) 
                j = j-1;
            end
    
            tau = T(j); %������������� �������� ������� ����������� ��������
            w0 = tau/tgel; %�������� ��������������������� �����
    
            for i = 1:n %������ ������������� ��������� ��������
                a(i+1) = a(i+1).*w0^(i);	
            end
    
            b = a(n+1); %������ ��������������� ������������ � ������ ����
            SYS = tf(b,a);
            [z,p,k] = zpkdata(SYS,'v'); %������� �����, ������� � �����������          
   
        end
    end
    K = place(A,B,p)
    assignin('base','K', K);
    assignin('base','b', b);
    sys = params_fun(K, b);
    hold on;
    step(sys, 'r--'), grid on %���������� �������������� �������
    if sigma == 1
        legend('Batterwort','Niewton');       
    else if sigma == 2
             legend('Niewton','Batterwort');
         end
    end
    
end
