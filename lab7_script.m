function [unctr, K, b,sys] = Modal_control (A,B,tgel,sigma,bat,niewt)

C=eye(3);
D=0;
%lab 7
% �������������� ������ �������� ������� � ������������ ���������


%�������� ������������� ������ �,�
Co = ctrb(A,B);
unctr = length(A)-rank(Co) ; %����� ������������� ���
if unctr==0
   disp ( '������� ��������� ����������' )
else 
   T = '����� ������������� ��� ���������';
   disp ([T unctr])	
end

%������ �������� ������ ������ �� ������� ������� � ������� �����������
%��������

% n= input('������� ������� ������� n = ');
% tgel= input('������� �������� ����� ����������� �������� tgel = ');
% sigma= input('����������������� ���������? - �� -1, ��� -0 = ');

if sigma == 1

[z,p,k]=buttap(n);
[b,a]=zp2tf(z,p,k);
SYS=tf(b,a);
[Y,T]=step(SYS,0:0.01:30);
j=length(Y);
while (Y(j) < 1.05)&&(Y(j) > 0.95) 
j=j-1;
end 
tau=T(j); %������������� �������� ������� ����������� ��������
w0=tau/tgel; %�������� ��������������������� �����
for i=1:n %������ ������������� ��������� ��������
  a(i+1)=a(i+1).*w0^(i);	
end
b=a(n+1); %������ ��������������� ������������ � ������ ����
SYS=tf(b,a);
[z,p,k]=zpkdata(SYS,'v'); %������� �����, ������� � �����������          
%�������� �������� �������                      
step(SYS), grid %���������� �������������� �������
disp('������ �������� �������')
p
disp('����������� �������� � ������ ����')
b
end

if sigma == 0


    p(1:n)=-1;
    a=poly(p);
    SYS=tf(1,a);

[Y,T]=step(SYS,0:0.01:30);
j=length(Y);
while (Y(j) < 1.05)&&(Y(j) > 0.95) 
j=j-1;
end 
tau=T(j); %������������� �������� ������� ����������� ��������
w0=tau/tgel; %�������� ��������������������� �����
for i=1:n %������ ������������� ��������� ��������
  a(i+1)=a(i+1).*w0^(i);	
end
b=a(n+1); %������ ��������������� ������������ � ������ ����
SYS=tf(b,a);
[z,p,k]=zpkdata(SYS,'v'); %������� �����, ������� � �����������          
%�������� �������� �������                      
step(SYS), grid %���������� �������������� �������
disp('������ �������� �������')
p
disp('����������� �������� � ������ ����')
b

end

%������ ������������ ���������� ����������
K = place(A,B,p)

[A,B,C,D]=linmod('start_mdl_dc_motor');
sys = ss(A,B,C,D);
