function [overshoot,settle_time]=analisys_step_resp(tout,yout)

overshoot = (max(yout(:,3))-(yout(length(yout),3)))/yout(length(yout),3)
for i=length(yout):-1:1
    if (yout(i,3)>1.05*yout(length(yout),3))||(yout(i,3)<0.95*yout(length(yout),3))
        settle_time = tout(i)  
        break;
    end
      
end
