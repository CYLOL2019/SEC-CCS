function [Weight] = decode (population)
global Lb Rl PreAss K Ub
[NoA, NP] = size(population);
Weight = zeros(NoA,NP);

%% assignment assets

population1 = population;
pretemp = population1;%set pre-assignment to 1
pretemp(PreAss,:) = 1;
%
[~,I] = sort(pretemp,1,'descend');

I = I(1:K,:);%index of K assets

% Weight for K selected Asset
K_Weight = zeros(K,NP);
for i = 1:NP
    K_Weight(:,i) = population1(I(:,i),i);
end

Z = sum(K_Weight,1); %sum and regulation
K_Weight =  bsxfun(@rdivide , K_Weight, Z);



%% repair
for i = 1 : NP
    % index for vilolation of floor constraint
    index = find(K_Weight(:,i) < ceil(Lb(I(:,i))/Rl)*Rl);
    % meet the round lot constraint
    K_Weight(index,i) = ceil(Lb(I(index,i))/Rl)*Rl;
    K_Weight(:,i) = K_Weight(:,i) - mod(K_Weight(:,i),Rl);
    [~, index] = sort(K_Weight,1,'descend'); % sort K_Weight in descending order
    % sum of the allocation
    remainder = 1 - sum(K_Weight(:,i));
    % if sum of the allocation larger than 1
    if remainder < 0
       for j = 1 : K
            if (K_Weight(index(j),i)-Rl) >= Lb(I(j,i))
                addend1 = -floor((K_Weight(index(j),i) - Lb(I(j,i)))/Rl)*Rl;
                K_Weight(index(j),i) = K_Weight(index(j),i) + max(remainder,addend1);
                remainder = remainder - max(remainder,addend1);
                if remainder ==0
                    break;
                end
            end
       end
    % if sum of the allocation smaller than 1
    else
        for j = 1 : K
            if (K_Weight(index(j),i)+Rl) <= Ub(I(j,i))
                addend1 = floor((Ub(I(j,i)) - K_Weight(index(j),i))/Rl)*Rl;
                K_Weight(index(j),i) = K_Weight(index(j),i) + min(remainder,addend1);
                remainder = remainder - min(remainder,addend1);
                if remainder ==0
                    break;
                end
            end
        end
    end
    Weight(I(:,i),i) = K_Weight(:,i);
end

end
