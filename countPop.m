% jämför en kromosom med alla tidigare kromosomer och plussa med ett om
% lika om ej lika med någon tidigare lägg till som ny och plussa ett på
% den.


function [rListOfUniqeIndividuals rPopCount ]=countPop(aPop)

nInd=length(aPop);
discretePopulation=cell(nInd,1)
for i =1:nInd
    discretePopulation{i}=discretizieInd(aPop{i});
end
numberOfEach=[];
listToCompare{1}=discretePopulation{1};

for i =1:nInd
    
    lengthGenome=length(discretePopulation{i});
    count2=0;
    for j=1:length(listToCompare)
        
        if length(listToCompare{j})==lengthGenome
            
            count=0;
            for k=1:lenghtGenome
                if discretePopulation{i}(k)==listToCompare{i}(k)
                    count=count+1;
                end
            end
            
            if count==lengthGenome
                numberOfEach(i)=numberOfEach(i)+1
                count2=1;
                break
            end
            
        end
            
    end
    
    if count2==0
        listToCompare{end+1}=discretePopulation{i};
        numberOfEach(i)=1;
    end
    
end

rListOfUniqeIndividuals=listToCompare;
rPopCount=numberOfEach;
end