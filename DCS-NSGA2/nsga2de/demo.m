function demo()
    
    sta_de(1);
    close all;
    % Unconstrained Pareto Front
    pfile = sprintf('../problem/portfolio problem/portef5.txt');
    ucpf = load(pfile);
    plot(ucpf(:,2),ucpf(:,1));
    hold on
    % Result
    pfile = sprintf('../data/port5/run1/data.mat');
    load(pfile);
    plot(df(1,end-99:end),df(2,end-99:end),'o');
    %
    xlabel('Risk');
    ylabel('Return');
    legend('UCPF','Result','Location','SouthEast')
end