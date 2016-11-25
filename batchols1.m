function [theta,yhat] = batchols1( xarray,yarray,n0 )


%n0=20;%No of centers created for RBF network.This network is large and unneccessary as it was later found out.The centers can be reduced also .
c=zeros(n0,size(xarray,2));

for no=1:1:n0
    for val=1:size(xarray,2)
        c(no,val)=rand(1,1);  % The values of the centers are randomly selected between 0 to 1 from normal distribution
    end
end


phi=zeros(size(yarray,1),n0); % The size of RBF centers output is pre-allocated.
d=zeros(n0,1);

for t=1:size(yarray,1)
    for val=1:n0
            d(val)=norm(xarray(t,:)-c(val,:));
            phi(t,val)=(d(val)^2)*log(d(val));   % The values of phi are computed by thin plate spline method.
    end
end

[W,A]=gramsch(phi);% decompose phi (QR) using gran schmidth orthogonalization
newy=W'*yarray;   
theta=A\newy;% find the theta which is multiplied to the output of the RBF network to compute the predicted yhat.
%theta=newy\A;


yhat=phi*theta;
%yhat=theta*phi';
% error=yarray-yhat;


%norm(error);
%errorpercent=sqrt(sum((batchy-yhat).^2)/750) % calculating RMSE 