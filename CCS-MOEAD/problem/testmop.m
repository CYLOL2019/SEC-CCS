function mop = testmop( testname, dimension)

%Get test multi-objective problems from a given name. 
%   The method get testing or benchmark problems for Multi-Objective
%   Optimization. The test problem will be encapsulated in a structure,
%   which can be obtained by function get_structure('testmop'). 
%   User get the corresponding test problem, which is an instance of class
%   mop, by passing the problem name and optional dimension parameters.

    mop=get_structure('testmop');
    
    switch lower(testname)
        case 'kno1'
            mop=kno1(mop);
        case 'zdt1'
            mop=zdt1(mop, dimension);
        case 'tec09_f1'
            mop=tec09_f1(mop, dimension);
        case 'tec09_f2'
            mop=tec09_f2(mop, dimension);
        case 'tec09_f3'
            mop=tec09_f3(mop, dimension);
        case 'tec09_f4'
            mop=tec09_f4(mop, dimension);
        case 'tec09_f5'
            mop=tec09_f5(mop, dimension);     
        case 'tec09_f6'
            mop=tec09_f6(mop, dimension); 
        case 'tec09_f7'
            mop=tec09_f7(mop, dimension); 
        case 'tec09_f8'
            mop=tec09_f8(mop, dimension); 
        case 'tec09_f9'
            mop=tec09_f9(mop, dimension);             
        case 'zzj_f1'
            mop=zzj_f1(mop, dimension);
        case 'zzj_f2'
            mop=zzj_f2(mop, dimension);
        case 'zzj_f3'
            mop=zzj_f3(mop, dimension);
        case 'zzj_f4'
            mop=zzj_f4(mop, dimension);
        case 'zzj_f5'
            mop=zzj_f5(mop, dimension);     
        case 'zzj_f6'
            mop=zzj_f6(mop, dimension); 
        case 'zzj_f7'
            mop=zzj_f7(mop, dimension); 
        case 'zzj_f8'
            mop=zzj_f8(mop, dimension); 
        case 'zzj_f9'
            mop=zzj_f9(mop, dimension); 
        case 'zzj_f10'
            mop=zzj_f10(mop, dimension);             
        case {'uf1', 'uf2','uf3','uf4','uf5','uf6','uf7'}
            mop=cecproblems(mop, testname, dimension);
            mop.od=2;
        case {'uf8','uf9','uf10'}
            mop=cecproblems(mop, testname, dimension);
            mop.od=3;
        case {'r2_dtlz2_m5', 'r3_dtlz3_m5', 'wfg1_m5'}
            mop=cecproblems2(mop, testname, dimension);
        case 'dtlz4'
            mop=dtlz4(mop, dimension);
        case 'dtlz5'
            mop=dtlz5(mop, dimension);
        case {'port1','port2','port3','port4','port5','port6','port7','port8','port9','port10'}
            mop=port(mop, dimension,testname);
        otherwise 
            error('Undefined test problem name');                
    end 
end
%Port1 function generator
function p=port(p,dim,testname)
global u cov variance Covariance;
p.name=testname;

 p.od = 2;      % dimension of objectives
 p.pd = dim;      % dimension of x
 p.domain= [zeros(p.pd,1) ones(p.pd,1)];   % search domain
 p.func = @evaluate;
 
    %KNO1 evaluation function.
    function y = evaluate(x)
      y=zeros(2,1);
      if Covariance==0
      y(1) = sum(sum(x*x'.*(variance*variance'.*cov)));
      else
%            size(Covariance)
%            size(x)
      y(1) = sum(sum(x*x'.*Covariance));
      
     
      end
      y(2) = -x'*u;

    end
end
%KNO1 function generator
function p=kno1(p)
 p.name='KNO1';
 p.od = 2;      % dimension of objectives
 p.pd = 2;      % dimension of x
 p.domain= [0 3;0 3];   % search domain
 p.func = @evaluate;
 
    %KNO1 evaluation function.
    function y = evaluate(x)
      y=zeros(2,1);
	  c = x(1)+x(2);
	  %f = 9-(3*sin(2.5*c^0.5) + 3*sin(4*c) + 5 *sin(2*c+2));
      f = 9-(3*sin(2.5*c^2) + 3*sin(4*c) + 5 *sin(2*c+2));
	  g = (pi/2.0)*(x(1)-x(2)+3.0)/6.0;
	  y(1)= 20-(f*cos(g));
	  y(2)= 20-(f*sin(g)); 
    end
end

%ZDT1 function generator
function p=zdt1(p,dim)
 p.name='ZDT1';
 p.pd=dim;
 p.od=2;
 p.domain=[zeros(dim,1) ones(dim,1)];
 p.func=@evaluate;
 
    %KNO1 evaluation function.
    function y=evaluate(x)
        y=zeros(2,1);
        y(1) = x(1);
    	su = sum(x)-x(1);    
		g = 1 + 9 * su / (dim - 1);
		y(2) =g*(1 - sqrt(x(1) / g));
    end
end

%%
function p = zzj_f1(p,dim)
 p.name     = 'ZZJ_F1';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [zeros(dim,1) ones(dim,1)];
 p.func     = @evaluate;
 
function F = evaluate(X)
    F   = zeros(2,1);
    N   = size(X,1);
    X1  = X(2:N,:);
    G   = 1.0 + 9.0*(X1 - X(1))'*(X1 - X(1))/(N-1.0);

    F(1)= X(1);
    F(2)= G*(1.0-sqrt(F(1)/G));
end
end

%%
function p = zzj_f2(p,dim)
 p.name     = 'ZZJ_F2';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [zeros(dim,1) ones(dim,1)];
 p.func     = @evaluate;
 
function F = evaluate(X)
    F   = zeros(2,1);
    N   = size(X,1);
    X1  = X(2:N,:);
    G   = 1.0 + 9.0*(X1 - X(1))'*(X1 - X(1))/(N-1.0);

    F(1)= X(1);
    F(2)= G*(1.0-(F(1)/G)^2.0);
end
end

%%
function p = zzj_f3(p,dim)
 p.name     = 'ZZJ_F3';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [zeros(dim,1) ones(dim,1)];
 p.func     = @evaluate;
 
function F = evaluate(X)
    F   = zeros(2,1);
    N   = size(X,1);
    X1  = X(2:N,:);
    G   = 1.0 + 9.0*((X1 - X(1))'*(X1 - X(1))/9.0)^0.25;

    F(1)= 1.0-exp(-4.0*X(1))*sin(6.0*pi*X(1)).^6.0;
    F(2)= G*(1.0-(F(1)/G)^2.0);
end
end

%%
function p = zzj_f4(p,dim)
 p.name     = 'ZZJ_F4';
 p.pd       = dim;
 p.od       = 3;
 p.domain   = [zeros(dim,1) ones(dim,1)];
 p.func     = @evaluate;
 
function F = evaluate(X)
    F   = zeros(3,1);
    N   = size(X,1);
    X1  = X(3:N,:);
    G   = (X1 - X(1))'*(X1 - X(1));
    
    F(1) = cos(0.5*pi*X(1))*cos(0.5*pi*X(2))*(1.0+G);
    F(2) = cos(0.5*pi*X(1))*sin(0.5*pi*X(2))*(1.0+G);    
    F(3) = sin(0.5*pi*X(1))*(1.0+G);
end
end

%%
function p = zzj_f5(p,dim)
 p.name     = 'ZZJ_F5';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [zeros(dim,1) ones(dim,1)];
 p.func     = @evaluate;
 
function F = evaluate(X)
    F   = zeros(2,1);
    N   = size(X,1);
    X1  = X(2:N,:).^2.0;
    G   = 1.0 + 9.0*(X1 - X(1))'*(X1 - X(1))/(N-1.0);

    F(1)= X(1);
    F(2)= G*(1.0-sqrt(F(1)/G));
end
end

%%
function p = zzj_f6(p,dim)
 p.name     = 'ZZJ_F6';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [zeros(dim,1) ones(dim,1)];
 p.func     = @evaluate;
 
function F = evaluate(X)
    F   = zeros(2,1);
    N   = size(X,1);
    X1  = X(2:N,:).^2.0;
    G   = 1.0 + 9.0*(X1 - X(1))'*(X1 - X(1))/(N-1.0);

    F(1)= X(1);
    F(2)= G*(1.0-(F(1)/G)^2.0);
end
end

%%
function p = zzj_f7(p,dim)
 p.name     = 'ZZJ_F7';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [zeros(dim,1) ones(dim,1)];
 p.func     = @evaluate;
 
function F = evaluate(X)
    F   = zeros(2,1);
    N   = size(X,1);
    X1  = X(2:N,:).^2.0;
    G   = 1.0 + 9.0*((X1 - X(1))'*(X1 - X(1))/9.0)^0.25;

    F(1)= 1.0-exp(-4.0*X(1))*sin(6.0*pi*X(1)).^6.0;
    F(2)= G*(1.0-(F(1)/G)^2.0);
end
end

%%
function p = zzj_f8(p,dim)
 p.name     = 'ZZJ_F8';
 p.pd       = dim;
 p.od       = 3;
 p.domain   = [zeros(dim,1) ones(dim,1)];
 p.func     = @evaluate;
 
function F = evaluate(X)
    F   = zeros(3,1);
    N   = size(X,1);
    X1  = X(3:N,:).^2.0;
    G   = (X1 - X(1))'*(X1 - X(1));
    
    F(1) = cos(0.5*pi*X(1))*cos(0.5*pi*X(2))*(1.0+G);
    F(2) = cos(0.5*pi*X(1))*sin(0.5*pi*X(2))*(1.0+G);    
    F(3) = sin(0.5*pi*X(1))*(1.0+G);
end
end

%%
function p = zzj_f9(p,dim)
 p.name     = 'ZZJ_F9';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [zeros(dim,1) ones(dim,1)];
 p.func     = @evaluate;
 
function F = evaluate(X)
    F   = zeros(2,1);
    N   = size(X,1);
    X1  = (X(2:N,:)*10.0).^2.0;
    G   = 2.0 + (X1 - X(1))'*(X1 - X(1))/(4000.0)+ prod(cos((X1-X(1))./((1:N-1)'.^0.5)));

    F(1)= X(1);
    F(2)= G*(1.0-sqrt(F(1)/G));
end
end

%%
function p = zzj_f10(p,dim)
 p.name     = 'ZZJ_F10';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [zeros(dim,1) ones(dim,1)];
 p.func     = @evaluate;
 
function F = evaluate(X)
    F   = zeros(2,1);
    N   = size(X,1);
    X1  = (X(2:N,:)*10.0).^2.0;
    G   = 1.0 + 10.0*(N-1) + (X1 - X(1))'*(X1 - X(1))/(4000.0)- 10.0*sum(cos(2*pi*(X1-X(1))));

    F(1)= X(1);
    F(2)= G*(1.0-sqrt(F(1)/G));
end
end

%%
function p = tec09_f1(p,dim)
 p.name     = 'TEC09_F1';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [zeros(dim,1) ones(dim,1)];
 p.func     = @evaluate;
 
function y = evaluate(x)
    n       = size(x,1);
    io      = 3:2:n;
    ie      = 2:2:n;
    ss      = x - x(1).^(0.5+1.5*((1:1:n)'-2.0)/(n-2.0));
    y       = zeros(2,1);
    y(1)    = x(1) + 2.0/length(io)*sum(ss(io).^2.0);
    y(2)    = 1.0 - sqrt(x(1)) + 2.0/length(ie)*sum(ss(ie).^2.0);
end
end

%%
function p = tec09_f2(p,dim)
 p.name     = 'TEC09_F2';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [-ones(dim,1) ones(dim,1)]; p.domain(1,1) = 0.0;
 p.func     = @evaluate;
 
function y = evaluate(x)
    n       = size(x,1);
    io      = 3:2:n;
    ie      = 2:2:n;
    ss      = x - sin(6.0*pi*x(1)+(1:1:n)'*pi/n);
    y       = zeros(2,1);
    y(1)    = x(1) + 2.0/length(io)*sum(ss(io).^2.0);
    y(2)    = 1.0 - sqrt(x(1)) + 2.0/length(ie)*sum(ss(ie).^2.0);
end
end

%%
function p = tec09_f3(p,dim)
 p.name     = 'TEC09_F3';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [-ones(dim,1) ones(dim,1)]; p.domain(1,1) = 0.0;
 p.func     = @evaluate;
 
function y = evaluate(x)
    n       = size(x,1);
    io      = 3:2:n;
    ie      = 2:2:n;
    ss1     = x - 0.8*x(1)*cos(6.0*pi*x(1)+(1:1:n)'*pi/n);
    ss2     = x - 0.8*x(1)*sin(6.0*pi*x(1)+(1:1:n)'*pi/n);
    y       = zeros(2,1);
    y(1)    = x(1) + 2.0/length(io)*sum(ss1(io).^2.0);
    y(2)    = 1.0 - sqrt(x(1)) + 2.0/length(ie)*sum(ss2(ie).^2.0);
end
end

%%
function p = tec09_f4(p,dim)
 p.name     = 'TEC09_F4';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [-ones(dim,1) ones(dim,1)]; p.domain(1,1) = 0.0;
 p.func     = @evaluate;
 
function y = evaluate(x)
    n       = size(x,1);
    io      = 3:2:n;
    ie      = 2:2:n;
    ss1     = x - 0.8*x(1)*cos((6.0*pi*x(1)+(1:1:n)'*pi/n)/3.0);
    ss2     = x - 0.8*x(1)*sin(6.0*pi*x(1)+(1:1:n)'*pi/n);
    y       = zeros(2,1);
    y(1)    = x(1) + 2.0/length(io)*sum(ss1(io).^2.0);
    y(2)    = 1.0 - sqrt(x(1)) + 2.0/length(ie)*sum(ss2(ie).^2.0);
end
end

%%
function p = tec09_f5(p,dim)
 p.name     = 'TEC09_F5';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [-ones(dim,1) ones(dim,1)]; p.domain(1,1) = 0.0;
 p.func     = @evaluate;
 
function y = evaluate(x)
    n       = size(x,1);
    io      = 3:2:n;
    ie      = 2:2:n;
    ss1     = x - (0.3*x(1)*x(1)*cos(24.0*pi*x(1)+4.0*(1:1:n)'*pi/n)+0.6*x(1)).*cos(6.0*pi*x(1)+(1:1:n)'*pi/n);
    ss2     = x - (0.3*x(1)*x(1)*cos(24.0*pi*x(1)+4.0*(1:1:n)'*pi/n)+0.6*x(1)).*sin(6.0*pi*x(1)+(1:1:n)'*pi/n);
    y       = zeros(2,1);
    y(1)    = x(1) + 2.0/length(io)*sum(ss1(io).^2.0);
    y(2)    = 1.0 - sqrt(x(1)) + 2.0/length(ie)*sum(ss2(ie).^2.0);
end
end

%%
function p = tec09_f6(p,dim)
 p.name     = 'TEC09_F6';
 p.pd       = dim;
 p.od       = 3;
 p.domain   = [-2.0*ones(dim,1) 2.0*ones(dim,1)]; p.domain(1:2,1) = 0.0; p.domain(1:2,2) = 1.0;
 p.func     = @evaluate;
 
function y = evaluate(x)
    n       = size(x,1);
    i1      = 4:3:n;
    i2      = 5:3:n;
    i3      = 3:3:n;
    ss      = x - 2.0*x(2)*sin(2.0*pi*x(1)+(1:1:n)'*pi/n);
    y       = zeros(3,1);
    y(1)    = cos(0.5*pi*x(1))*cos(0.5*pi*x(2)) + 2.0/length(i1)*sum(ss(i1).^2.0);
    y(2)    = cos(0.5*pi*x(1))*sin(0.5*pi*x(2)) + 2.0/length(i2)*sum(ss(i2).^2.0);
    y(3)    = sin(0.5*pi*x(1))                  + 2.0/length(i3)*sum(ss(i3).^2.0);    
end
end

%%
function p = tec09_f7(p,dim)
 p.name     = 'TEC09_F7';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [zeros(dim,1) ones(dim,1)];
 p.func     = @evaluate;
 
function y = evaluate(x)
    n       = size(x,1);
    io      = 3:2:n;
    ie      = 2:2:n;
    yy      = x - x(1).^(0.5+1.5*((1:1:n)'-2)/(n-2.0));
    ss      = 4*yy.*yy - cos(8*pi*yy) + 1.0;
    y       = zeros(2,1);
    y(1)    = x(1)              + 2.0/length(io)*sum(ss(io));
    y(2)    = 1.0 - sqrt(x(1))  + 2.0/length(ie)*sum(ss(ie));
end
end

%%
function p = tec09_f8(p,dim)
 p.name     = 'TEC09_F8';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [zeros(dim,1) ones(dim,1)];
 p.func     = @evaluate;
 
function y = evaluate(x)
    n       = size(x,1);
    io      = 3:2:n;
    ie      = 2:2:n;
    yy      = x - x(1).^(0.5+1.5*((1:1:n)'-2)/(n-2.0));
    ss1     = yy.*yy;
    ss2     = cos(20*pi*yy./sqrt(1:1:n)');
    y       = zeros(2,1);
    y(1)    = x(1)              + 2.0/length(io)*(4*sum(ss1(io))-2*prod(ss2(io))+2);
    y(2)    = 1.0 - sqrt(x(1))  + 2.0/length(ie)*(4*sum(ss1(ie))-2*prod(ss2(ie))+2);
end
end

%%
function p = tec09_f9(p,dim)
 p.name     = 'TEC09_F9';
 p.pd       = dim;
 p.od       = 2;
 p.domain   = [-ones(dim,1) ones(dim,1)]; p.domain(1,1) = 0;
 p.func     = @evaluate;
 
function y = evaluate(x)
    n       = size(x,1);
    io      = 3:2:n;
    ie      = 2:2:n;
    ss      = x - sin(6*pi*x(1) + (1:1:n)'*pi/n);
    y       = zeros(2,1);
    y(1)    = x(1)              + 2.0/length(io)*sum(ss(io).^2);
    y(2)    = 1.0 - x(1).*x(1)  + 2.0/length(ie)*sum(ss(ie).^2);
end
end

%cec09 UF1 - UF10
function p=cecproblems(p, testname,dim)
 p.name=upper(testname);
 p.pd=dim;
 
 p.domain=xboundary(upper(testname),dim);
 %p.domain = [zeros(dim,1),ones(dim,1)];
 p.func=cec09(upper(testname)); 
end

%cec09 UF11 - UF13
function p=cecproblems2(p, testname, dim)
 p.name=upper(testname);
 p.pd=dim;
 p.od=2;
 
 p.domain=xboundary(upper(testname),dim);
 %p.domain = [zeros(dim,1),ones(dim,1)];
 p.func=@evaluate;
 
function y = evaluate(x)
    y = cec09m(x, p.name); 
end
end

%DTLZ4 function generator
function p=dtlz4(p,dim)
 p.name='DTLZ4';
 p.pd=dim;
 p.od=3;
 p.domain=[zeros(dim,1) ones(dim,1)];
 p.func=@evaluate;
 
    % evaluation function.
    function y=evaluate(x)
        alp= 100.0;
        su = (x-0.5).^2;
        g  = sum(su(3:end));
        y  = zeros(3,1);
        y(1) = cos(0.5*pi*x(1)^alp)*cos(0.5*pi*x(2)^alp)*(1+g);
        y(2) = cos(0.5*pi*x(1)^alp)*sin(0.5*pi*x(2)^alp)*(1+g);
        y(3) = sin(0.5*pi*x(1)^alp)*(1+g);
        clear alp su g;
   end
end

%DTLZ5 function generator
function p=dtlz5(p,dim)
 p.name='DTLZ5';
 p.pd=dim;
 p.od=3;
 p.domain=[zeros(dim,1) ones(dim,1)];
 p.func=@evaluate;
 
    % evaluation function.
    function y=evaluate(x)
        su = (x-0.5).^2;
        g  = sum(su(3:end));
        th1= 0.5*pi*x(1);
        th2= pi*(1+2*g*x(2))/(4+4*g);
        y  = zeros(3,1);
        y(1) = cos(th1)*cos(th2)*(1+g);
        y(2) = cos(th1)*sin(th2)*(1+g);
        y(3) = sin(th1)*(1+g);
        clear alp su g;
   end
end
