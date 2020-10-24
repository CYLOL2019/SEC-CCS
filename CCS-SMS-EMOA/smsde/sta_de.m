function sta_de(runs)
global u Covariance Lb Rl PreAss K Ub NoA;
path('../problem',path); 
path('../problem/portfolio problem',path); 
path('../public',path);


folder  = '../data';

problems = {'port5'};
pops     = [100];
maxfes      = [100000];

%% parameter 
NP = 100;
K = 10;
Lb = 0.01;
Ub = 1.0;
Rl = 0.008;
PreAss = [30];
nproblem = 1;

 %% main loop
for r =1:length(runs)
    for pn = 1 :nproblem
        df      = [];
        ds      = [];
        dw      = [];
        fes     = [];
 %% load NoA u cov variance for decode function
          pfile = sprintf('%s.txt',char(problems(pn)));
          input = textread(pfile);
          [NoA u Covariance] = DataInput(input);
          Ub = repmat(Ub,NoA,1);
          Lb = repmat(Lb,NoA,1);
 %%
        t1 = clock;
        [df, ds, fes] = SMSEMOA(char(problems(pn)),[],[],pops(pn),maxfes(pn));
        df = df';
        ds = ds';
        dw = decode(ds);
        t2 = clock;
        % convert -return into return
        df(2,:) = -df(2,:);
        sdir = sprintf("%s/%s/run%d", folder, char(problems(pn)), r);
        if ~exist(sdir, 'dir')
           mkdir(sdir)
        end
        sname = sprintf('%s/data.mat', sdir);
        save(sname, 'ds','df','dw', 'fes');
        RunningTime = etime(t2,t1);      
        str = sprintf('CCS_MOEAD\t %s %s %d', datestr(clock), char(problems(pn)), r);
        disp(str);
        TimeFile = sprintf('%s/TIME.mat', sdir);
        save(TimeFile,'RunningTime');     
    end
end

end


