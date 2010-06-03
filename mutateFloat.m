% mutateFloat.m loops through the population and changes with probability param.pMutFloat an amino acid to
% +-0.05 of it original value.

function  rFloatPopulation = mutateFloat(aPopulation, aParam)
for i=1:size(aPopulation,1)
    for j=1:size(aPopulation{i},2)
        if rand<aParam.pMutFloat;
            
            %%%old code
            %generates a new floatnumber by randomly + or - adding
            %pMutFloat to gene-value (makes the model discrete with pMutFloat as the smallest step)
            
            %aPopulation{i}(j)=(aPopulation{i}(j)+sign(rand-0.5)*aParam.mutFloatLength);
            
            %%%
            
            %%%new code%%%
            %generates a floatnumber normally distributed around the gene
            %value (my) and with variance (sigma) equal to shortest
            %distance to a border (0 or 1 =closest border) multiplied by 0.5
            %(gives highest variance for values around 0.5) + 0.05 so that if the
            %gene-value is close to a boarder the smallest variance is at least 0.05
            
            floatNumber=-1;
            while floatNumber<0 || floatNumber>1
                my=aPopulation{i}(j);
                sigma=min(my,1-my)*0.5+0.05;
                floatNumber=my+sigma*randn;
            end
            aPopulation{i}(j)=floatNumber;
            
            if aPopulation{i}(j)<0
                error('fel i mutatefloat, producerade gen med värde mindre än noll')
            end
            if aPopulation{i}(j)>1
                error('fel i mutatefloat, producerade gen med värde större än ett')
                %aPopulation{i}(j)=1;
            end
            
        end
    end
end
rFloatPopulation=aPopulation;
end
