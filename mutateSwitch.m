% mutateSwitch.m loops through all the amino acids in the population and mutates an
%amino acid with probability param.pMutSwitch to 1-(amino acid). then
%returns the new mutated population

function  rSwitchedPopulation = mutateSwitch(aPopulation, aParam)

for i=1:size(aPopulation,1)
    
    for j=1:size(aPopulation{i},1)
        if rand<aParam.pMutSwitch
            aPopulation{i}(j)=1-aPopulation{i}(j);
        end
    end
end
rSwitchedPopulation=aPopulation;
end
