% jämför en kromosom med alla tidigare kromosomer och plussa med ett om
% lika om ej lika med någon tidigare lägg till som ny och plussa ett på
% den.


function [rListOfUniqeIndividuals rPopCount ]=countPop(aPop)

nInd=length(aPop);
discretePopulation=cell(nInd,1);
for i =1:nInd
    discretePopulation{i}=discretizeInd(aPop{i});
end
listToCompare{1}=discretePopulation{1};
numberOfEach(1) = 1;

for iInd =2:nInd
    
    lengthGenome=length(discretePopulation{iInd});
    count2=0;
    for jComp=1:length(listToCompare)
        
        if length(listToCompare{jComp})==lengthGenome
            
            count=0;
            for k=1:lengthGenome % for indvidual iInd
                if discretePopulation{iInd}(k)==listToCompare{jComp}(k)
                    count=count+1;
                end
            end
            
            if count==lengthGenome
                numberOfEach(jComp)=numberOfEach(jComp)+1;
                count2=1;
                break
            end
            
        end
            
    end
    
    if count2==0
        listToCompare{end+1}=discretePopulation{iInd};
        numberOfEach(end+1)=1;
    end
    
end

rListOfUniqeIndividuals=listToCompare;
rPopCount=numberOfEach;
end