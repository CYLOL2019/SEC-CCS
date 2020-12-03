function [NoA u Covariance] = DataInput(input)
% data from OR-Library
PortSize1 = [31 85 89 98 225];
NoA = input(1);
if ismember(NoA, PortSize1)
diagData = ones(1,NoA);
u = input(2:NoA+1,1);
variance = input(2:NoA+1,2);
cov = input(NoA+2:end,3);
A = tril(ones(NoA),0);

A(logical(A)) = cov;

cov = A + A' - diag(diagData);

Covariance = variance*variance'.*cov;
else
u = input(2:NoA+1,1);
Covariance = input(NoA+2:end,3);
diagData = ones(1,NoA);
A = tril(ones(NoA),0);

A(logical(A)) = Covariance;
diagData = diag(diagData)+1;
Covariance = A + A';
Covariance = Covariance./diagData;

end

end
