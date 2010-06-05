% jämför en kromosom med alla tidigare kromosomer och plussa med ett om
% lika om ej lika med någon tidigare lägg till som ny och plussa ett på
% den.


function [rListOfUniqeIndividuals rPopCount ]=countPop(aPop,listOfOldStrategies)
nInd=length(aPop);
discretePopulation=cell(nInd,1);
for i =1:nInd
    discretePopulation{i}=discretizeInd(aPop{i});
end

if isempty(listOfOldStrategies)
listOfOldStrategies{1}=discretePopulation{1};

%numberOfEach(1)=1;
end    
    %listToCompare{1}=discretePopulation{1};
 %numberOfEach(1) = 1;

%creates a list wich will tell how common each strategy is
numberOfEach=zeros(1,size(listOfOldStrategies,2));%lenght(listOfOldStrategies));

for iInd =1:nInd %2:nInd
    
    lengthGenome=length(discretePopulation{iInd});
    count2=0;
    for jComp=1: length(listOfOldStrategies)    %listToCompare)
        
        if length(listOfOldStrategies{jComp})==lengthGenome   %listToCompare{jComp})==lengthGenome
            
            count=0;
            for k=1:lengthGenome % for indvidual iInd
                if discretePopulation{iInd}(k)==listOfOldStrategies{jComp}(k) %listToCompare{jComp}(k)
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
        %listToCompare{end+1}=discretePopulation{iInd};
        listOfOldStrategies{end+1}=discretePopulation{iInd};
        
        numberOfEach(end+1)=1;
    end
    
end
%sorts the list numberOfEach and takes out the indicies that we need to
%find the strategies who are most common


%[sortedNumberOfEach indexInNumberOfEach]=sort(numberOfEach,'descend');

%for l=1:length(listOfOldStrategies)
%    sortedListOfOldStrategies{l}=listOfOldStrategies{indexInNumberOfEach(l)};
%end

%for m=1:length(sortedNumberOfEach)
%    sortedPercentOfEachStrategy(m)=sortedNumberOfEach(m)/length(sortedNumberOfEach);
%end

for m=1:length(numberOfEach)
    percentOfEachStrategy(m)=numberOfEach(m)/sum(numberOfEach);
end

%for m=1:length(listOfOldStrategies)
%disp('ny')    
%listOfOldStrategies{m}
%sortedListOfOldStrategies{m}
%end
rListOfUniqeIndividuals= listOfOldStrategies;   %sortedListOfOldStrategies; %listToCompare;
rPopCount= percentOfEachStrategy; %numberOfEach;    %sortedPercentOfEachStrategy %sortedNumberOfEach 
end