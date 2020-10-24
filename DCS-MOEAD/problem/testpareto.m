function pf = testpareto(name, no)
path('../problem',path); 
path('../problem/portfolio problem',path); 
path('../public',path);

    if nargin<2, no  = 500; end
    switch name
        case {'zzj_f1','zzj_f5','zzj_f9','zzj_f10','tec09_f1','tec09_f2','tec09_f3','tec09_f4','tec09_f5','tec09_f7','tec09_f8'}
            pf          = zeros(2,no);
            pf(1,:)     = linspace(0,1,no);
            pf(2,:)     = 1-sqrt(pf(1,:));
        case {'zzj_f2','tec09_f9'}
            pf            = zeros(2,no);
            pf(1,:)       = linspace(0,1,no);
            pf(2,:)       = 1-pf(1,:).^2;
        case {'zzj_f3','zzj_f7'}
            pf          = zeros(2,no);
            x           = linspace(0,1,no);
            pf(1,:)     = 1-exp(-4*x).*(sin(6*pi*x)).^6;
            pf(2,:)     = 1-pf(1,:).^2;
            clear x;
        case {'zzj_f4','zzj_f8','tec09_f6'}
            weights     = pf3D(33);
            no          = size(weights,2);
            pf          = zeros(3,no);
            pf(1,:)     = cos(0.5*pi*weights(1,:)).*cos(0.5*pi*weights(2,:));
            pf(2,:)     = cos(0.5*pi*weights(1,:)).*sin(0.5*pi*weights(2,:));
            pf(3,:)     = sin(0.5*pi*weights(1,:));
            clear weights;
        case 'zzj_f6'
            pf          = zeros(2,no);
            x           = linspace(0,1,no);
            pf(1,:)     = sqrt(x);
            pf(2,:)     = 1-pf(1,:).^2;
            clear x;
        case {'port1','port2','port3','port4','port5','port6','port7','port8','port9','port10'}
            str=name(1:4);
            str2=name(5:end); 
             y=str2num(str2);

            pfile = sprintf('%sef%d.txt',str,y);
           
            
            portef=load(pfile);
            pf          = zeros(2,no);
            pf(1,:)     = portef(1:no,2)';
            pf(2,:)     = portef(1:no,1)';
           % plot(pf(1,:),pf(2,:))
            %pause;
    end
end

%%
function weights = pf3D(unit)

popsize = 0;
for i=0:1:unit, for j=0:1:unit, if i+j<=unit, popsize = popsize+1; end, end, end
weights = zeros(2, popsize);
n = 1;
for i=0:1:unit
    for j=0:1:unit
        if i+j<=unit
            weights(1,n) = i/unit;
            weights(2,n) = j/unit;
            n            = n+1;
        end
    end
end

end
