

reg=[data(:,1) data(:,3) data(:,5) data(:,7) data(:,9)];
X=reg;%%taking 29 columns of regressors(delayed feed with dynamics,instantaneous sep speed,delayed fola,mmload,elev power with dynamics data(:,1:4)
x6=data(:,10);%%blaine
reg1=[test(:,1) test(:,3) test(:,5) test(:,7) test(:,9)];
X_test=reg1;%test(:,1:4)
x6_test=test(:,10);%%blaine

 X_Trainiii=X(1:200,:);
 X_Trainii=X(201:306,:);
 X_Traini=[X_Trainiii;X_Trainii];
 AStd=std(X_Traini);%mean  of training regressors
 AMean=mean(X_Traini);%std of training regressors
 X_Train=zscore(X_Traini);
 
 
 %Training Data-Blaine
 X1_Trainiiii=x6(1:200,:);
 X1_Trainiii=x6(201:306,:);
 X1_Trainii=[X1_Trainiiii;X1_Trainiii];
 AAStd=std(X1_Trainii);%standard deviation of training blaine
 AAMean=mean(X1_Trainii);%mean of training blaine
 X1_Traini=zscore(X1_Trainii);
 X1_Train=X1_Traini';

% Test Data-Regressors
 X_Testii=(X_test(1:250,:));
 X_Testi=bsxfun(@minus,X_Testii,AMean);% removing mean of training data from test data
 X_Test= bsxfun(@rdivide, X_Testi, AStd);%removinhg std of training data from test data
 
 % Test Data-Blaine
 X1_Testiii=x6_test(1:250,:);
 AAAMean=mean(X1_Testiii);
 X1_Testii=bsxfun(@minus,X1_Testiii,AAMean);
 X1_Testi= bsxfun(@rdivide, X1_Testii, AAStd); 
 X1_Test= X1_Testi'; 
 
 [COEFF,SCORE,LATENT] = princomp(X_Train);
 
 param=SCORE(:,1:5)\X1_Traini;
 
 pred=param(1)*X_Test(:,1)+param(2)*X_Test(:,2)+param(3)*X_Test(:,3)+param(4)*X_Test(:,4)+param(5)*X_Test(:,5)%+param(6)*X_Test(:,6)+param(7)*X_Test(:,7)+param(8)*X_Test(:,8)+param(9)*X_Test(:,9);
%param(10)*X_Test(:,10)+param(11)*X_Test(:,11)+param(12)*X_Test(:,12)+param(13)*X_Test(:,13)+param(14)*X_Test(:,14)+param(15)*X_Test(:,15)+param(16)*X_Test(:,16)+param(17)*X_Test(:,17)+param(18)*X_Test(:,18)+param(19)*X_Test(:,19)+param(20)*X_Test(:,20)+param(21)*X_Test(:,21)+param(22)*X_Test(:,22)+param(23)*X_Test(:,23)+param(24)*X_Test(:,24)+param(25)*X_Test(:,25)+param(26)*X_Test(:,26)+param(27)*X_Test(:,27)+param(28)*X_Test(:,28)+param(29)*X_Test(:,29)
  figure(1)
  
    plot(LATENT(1:5),'--rs','LineWidth',2,'MarkerEdgeColor','k', 'MarkerFaceColor','g','MarkerSize',10) ;
    hold on
    set(gca,'fontname','times','fontsize',16);
    xlabel('Principal Components');
    ylabel('Eigen Values');
    title('Eigen Value Plot');
  
  
    f=(cumsum(LATENT)/sum(LATENT))*100;  %Cumulative variance
  
    figure(2)
  
    plot(f(1:5),'--rs','LineWidth',2,'MarkerEdgeColor','k', 'MarkerFaceColor','g','MarkerSize',10) ;
    set(gca,'fontname','times','fontsize',16)
    xlabel('Principal Components');
    ylabel('Cumulative Variance');
    title('Cumulative Variance Plot');
   print('-depsc','CumulativeVariance_PCAExample.eps') 
 
  figure(3)
   plot(X1_Testi,pred,'p','MarkerEdgeColor','k', 'MarkerFaceColor','g','MarkerSize',10) ;
   set(gca,'fontname','times','fontsize',16)
   xlabel('True Blaine [cm^2/gm]');
   ylabel('Predicted Blaine [cm^2/gm]');
   title('True vs. Predicted Blaine');
   print('-depsc','True_Vs_Predicted Blaine.eps')

    figure(4)
   plot(X1_Testi,'linewidth',2)
   hold on
   plot(pred,'r','linewidth',2,'linestyle','--') ;
   set(gca,'fontname','times','fontsize',16)
   xlabel('Samples');
   ylabel('True and Predicted Blaine [cm^2/gm]');
   title('True and Predicted Blaine');
   legend('True Blaine','Predicted Blaine');
   print('-depsc','True_Predicted.eps')
   
