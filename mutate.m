% mutate.m Mutates inserted individuals
%    newPopulation = mutate (population, inserted, param)
%
%    @param cell array offspring:
%    @param struct, param: main parameters
%    @return cell array mutatedOffspring
%    Performes all different mutations. 

function rPop = mutate (aPop, aParam)

leangthPop=size(aPop,1);

for i = 1:leangthPop
    if rand<aParam.pMutDuplicate
        aPop{i}=mutateDuplicate(aPop{i});
    end
    
    if rand<aParam.pMutSplit
        aPop{i}=mutateSplit(aPop{i});
    end
    
end
aPop=mutateSwitch(aPop, aParam);
rPop=mutateFloat(aPop, aParam);

end
