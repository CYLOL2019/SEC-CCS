function f = evaluate(population)
global u Covariance;
Weight = decode(population');
Weight = Weight';


    f(1,1)  = sum(sum(Weight(1,:)'*Weight(1,:).*Covariance));
    f(1,2) =  -Weight(1,:)*u;

end