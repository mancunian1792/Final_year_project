function [theta,yhat,yhat1,yhat2,output22]=blaine(data)
input1=data(:,1);
[input11,scale1]=scaling1(input1,150);
input2=data(:,2);
[input22,scale2]=scaling1(input2,100);
output1=data(:,3);
[output11,scale3]=scaling1(output1,100);
output2(1)=data(1,9);
for i=2:size(data(:,9),1)
    if (data(i-1,9)~=data(i,9))
        output2(i)=data(i,9);
    else
        output2(i)=NaN;
    end
end
[output22,scale4]=scaling1(output2',5000);
        
[blainest,scaled]=scaling1(data(:,7),5000);


appended=output22;
test3=inpaint_nans(appended,3);


%op=[output1 output2];
%[theta,yhat]=batchols1(xarray,op)
xarray=[input11 input22];
yarray=[output11 test3];
[theta,yhat]=batchols(xarray,yarray,5);
yhat1=descaling1(yhat(:,1),scale3);

yhat2=descaling1(yhat(:,2),scale4);
t=1:size(yarray,1);
figure(1);
%plot(t,yhat(:,1),'b',t,output11,'r')
plot(yhat2(1:10000),'linewidth',2)
hold on
plot(data(1:10000,7),'r','linewidth',2,'linestyle','--');
set(gca,'fontname','times','fontsize',16)
xlabel('time instants');
ylabel('Predicted vs lab measured blaine');
title('Comparison of blaine measurements');
legend('predicted blaine','lab measured blaine');
print('-depsc','comparison_of_blaine.eps')
rmse(data(1:10000,7),yhat2(1:10000))
figure(2)
%plot(t,yhat(:,2),'b',t,test33,'r')
plot(yhat1(1:10000),'linewidth',2)
hold on
plot(data(1:10000,3),'r','linewidth',2,'linestyle','--');
set(gca,'fontname','times','fontsize',16)
xlabel('time instants');
ylabel('Predicted vs measured folaphone');
title('Comparison of folaphone measurements');
legend('predicted folaphone','measured folaphone');
print('-depsc','comparison_of_folaphone.eps')
rmse(data(1:10000,3),yhat1(1:10000))


%[theta1,uhat,phi22,W2,A2,newy2]=batchols1(yarray,xarray,20);
%uhat1=descaling1(uhat(:,1),scale1);
%uhat2=descaling1(uhat(:,2),scale2);

%t=1:size(xarray,1);
%figure(3);
%plot(t,uhat1,'b',t,data(:,1),'r')
%figure(4);
%plot(t,uhat2,'b',t,data(:,2),'r')


end