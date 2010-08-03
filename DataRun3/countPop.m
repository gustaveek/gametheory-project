% jämför en kromosom med alla tidigare kromosomer och plussa med ett om
% lika om ej lika med någon tidigare lägg till som ny och plussa ett på
% den.returnerar en utökad lista med alla strategier som förekommit
%(utökad med de nya strategier som uppkommit under innevarande generation)
%returnear också en lista som förtäljer hur många procent av totalen varje
%strategi utgör

function [rListOfUniqeIndividuals rPopCount ]=countPop(aPop,listOfOldStrategies)
nInd=length(aPop);
discretePopulation=cell(nInd,1);
for i =1:nInd
    discretePopulation{i}=discretizeInd(aPop{i});
end


%om den inskickade listan är tom så fångas den av följande if-sats
if isempty(listOfOldStrategies)
    listOfOldStrategies{1}=discretePopulation{1};
end

%creates a list wich will tell how common each strategy is
numberOfEach=zeros(1,size(listOfOldStrategies,2));

for iInd =1:nInd %2:nInd
    
    lengthGenome=length(discretePopulation{iInd});
    count2=0;
    for jComp=1: length(listOfOldStrategies)
        
        if length(listOfOldStrategies{jComp})==lengthGenome
            
            count=0;
            for k=1:lengthGenome % for indvidual iInd
                if discretePopulation{iInd}(k) == ...
                        listOfOldStrategies{jComp}(k)
                    count = count + 1;
                end
            end
            
            if count == lengthGenome
                numberOfEach(jComp)=numberOfEach(jComp)+1;
                count2=1;
                break
            end
            
        end
        
    end
    
    if count2==0
        listOfOldStrategies{end+1}=discretePopulation{iInd};
        numberOfEach(end+1)=1;
    end
    
end

%gör om antal av varje strategi till procent av totalt antal individer i
%aktuell generation

for m=1:length(numberOfEach)
    percentOfEachStrategy(m)=numberOfEach(m)/sum(numberOfEach);
end

rListOfUniqeIndividuals= listOfOldStrategies;
rPopCount= percentOfEachStrategy;
end