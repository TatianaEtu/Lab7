
subplot(3,1,1);
plot(tout,yout(:,1),'r','LineWidth',1.5);
xlabel('t, c'); ylabel('I, A');
title('DC motor step response'); 
grid on;

% hold on;
subplot(3,1,2); 
plot(tout,yout(:,2),'b','LineWidth',1.5);
grid on;
xlabel('t, c'); ylabel('w, rps');

subplot(3,1,3); 
plot(tout,yout(:,3),'k','LineWidth',1.5);
grid on;
xlabel('t, c'); ylabel('angle, rad');