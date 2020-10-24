% funtest
path('../public',path);
global Lb Rl K Ub
problem = 'port5';
dim = 225;
mop     = testmop(problem, dim);
popsize = 100;
init('problem', mop, 'popsize', popsize, 'F', 0.3, 'CR', 0.9);
NoA = 225;
Lb = 0.01*ones(NoA,1);
Rl = 0.008;
K = 10;
Ub = ones(NoA,1);
parameter = zeros(2*NoA,1);
selection = [   214
                 9
               115
                43
               165
                62
                 2
                40
               215
                30];
parameter(selection) = 1;
parameter(selection+NoA) = 0.01;
parameter(selection(1)+NoA) = 0.99;
Weight = decode(parameter);
obj = evaluate(mop,Weight);
