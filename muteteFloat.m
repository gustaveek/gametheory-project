% mutateFloat.m loops through the population and changes with probability param.pMutFloat an amino acid to
% +-0.05 of it original value. 

function  rFloatPopulation = mutateFloat(aPopulation, aParam)

for i=1:size(aPopulation,1)

    for j=1:size(aPopulation{i},1) 
    if rand<aParam.pMutFloat
    aPopulation{i}(j)=aPopulation{i}(j)+sign(rand-0.5)*aParam.mutFloat;
    end
    end
end
rFloatPopulation=aPopulation; 
end
