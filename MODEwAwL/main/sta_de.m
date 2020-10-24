function sta_de(runs)
global u Covariance Lb Rl PreAss K Ub ;
path('../problem',path); 
path('../problem/portfolio problem',path); 
path('../public',path);
path('NSGA2',path); 

folder  = '../data';

problems = {'port5'};
pops     = [100];
fes      = [100000];

%% parameter 
NP = 100;
K = 10;
Lb = 0.01;
Ub = 1.0;
Rl = 0.008;
PreAss = [30];
nproblem = 1;

 %% main loop
for r=1:length(runs)
   for pn = 1 : nproblem
        % load data
          pfile = sprintf('%s.txt',char(problems(pn)));
          input = textread(pfile);
          [NoA u Covariance] = DataInput(input);
          Ub = repmat(Ub,NoA,1);
          Lb = repmat(Lb,NoA,1);
          t1 = clock;
          % run algorithm
          run_progm(char(problems(pn)), 2*NoA, fes(pn), pops(pn), runs(r), folder);
          t2 = clock;
          RunningTime = etime(t2,t1);      
          str = sprintf('MODEwAwL\t %s %s %d', datestr(clock), char(problems(pn)), runs(r));
          disp(str);
          sdir = sprintf("%s/%s/run%d", folder, char(problems(pn)), r);
          TimeFile = sprintf('%s/TIME.mat', sdir);
          save(TimeFile,'RunningTime');     
   end
end

end

%%
function run_progm(problem, dim, maxfes, popsize, run, folder)

global params population archive;

params  = [];
population = [];
archive = [];
mop     = testmop(problem, dim);

init('problem', mop, 'popsize', popsize, 'F', 0.5, 'CR', 0.9);
%Initializing of flags

it      = 0;
df      = [];
ds      = [];
dw      = [];
fes     = [];


while params.fes < maxfes
    step(mop);    
    if params.fes >= it*1000
        it    = it+1;
        df    = [df, population.objective];
        ds    = [ds, population.parameter];
        dw    = [dw, decode(population.parameter)];
        fes   = [fes,params.fes];
    end
end
% convert -return into return
df(2,:) = -df(2,:);
sdir = sprintf("%s/%s/run%d", folder, problem, run);
if ~exist(sdir, 'dir')
   mkdir(sdir)
end
sname = sprintf('%s/data.mat', sdir);
save(sname, 'ds','df','dw', 'fes');
end