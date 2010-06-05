% initalizePopulation.m Initializes the first population
% population = initializePopulation (parameter)
%
%    @param struct parameter: main parameters
%    @return cell array population: population

function rPop = initializePopulation(aParam)
%aParam.nIndividuals=5
%initialize array
if mod(aParam.nIndividuals,4)~=0
    error('initializePopulation 1, Det blir mycket lättare om det är en population som är jämt delbar med 4')
end

populationArray=cell(aParam.nIndividuals,1);


% initialize values in array with individuals of memory leangth 0 and randomized
% memory


%for i=1:aParam.nIndividuals
%    populationArray{i}(1)=rand;
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize values in array with individuals of memory leangth 0. 50% all cooperate (1)
% and 50% all defect (0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i=1: (aParam.nIndividuals)/2
%     populationArray{i}(1)=1;
% end
%
% for j= ((aParam.nIndividuals)/2+1):aParam.nIndividuals
%     populationArray{j}(1)=0;
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize values in array with individuals of memory leangth 1 and randomized
% memory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%for i=1:aParam.nIndividuals
%   populationArray{i}(1)=rand;
%   populationArray{i}(2)=rand;
%end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize values in array with individuals of memory leangth 1 and 25% CC 25%DD
% 25% tit for tat 25% anti tit for tat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:(aParam.nIndividuals)/4
    populationArray{i}(1)=1;
    populationArray{i}(2)=1;
    
end

for i=((aParam.nIndividuals)/4+1):(aParam.nIndividuals)/2
    populationArray{i}(1)=0;
    populationArray{i}(2)=0;
    
end

for i=((aParam.nIndividuals)/2+1):((aParam.nIndividuals)/2+aParam.nIndividuals/4)
    populationArray{i}(1)=1;
    populationArray{i}(2)=0;
    
end

for i=((aParam.nIndividuals)/2+aParam.nIndividuals/4 +1):aParam.nIndividuals
    populationArray{i}(1)=0;
    populationArray{i}(2)=1;
    
end

rPop = populationArray;

end