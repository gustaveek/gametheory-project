% main.m Main script for game theory project.
%   main

clc; clear; clf;

%% main parameters
nIndividuals = 100;
param = ...
    struct( ...
    'nIndividuals', nIndividuals, ... % population size
    'nParents', round(nIndividuals*0.4), ...
    'selectionPressure', 0.1, ...
    'selectionMethod', 'fitnessproportional', ... % or 'exponential'
    'nGenerations', 100, ...
    'pMutSwitch', 0.001, ...
    'pMutSplit', 0.001, ...
    'pMutDuplicate', 0.001, ...
    'mutFloatLength', 0.05, ...
    'pMutFloat', 0.001, ...
    'pError', 0.01,...
    'payoffCC', 3, ...
    'payoffDC', 5, ...
    'payoffCD', 0, ...
    'payoffDD', 1);

%% Sweeping parameters
pMutFloats = [0.01]% , 0.05, 0.1];

for i = 1:length(pMutFloats)
    tic
    param.pMutFloat = pMutFloats(i);
    disp('Runns with:')
    disp(param);
    [dataPop{i}, dataDist{i} dataStrategies{i} dataPercentOfEachStrategy{i}]= mainLoop2 (param);
    
    dataParam{i} = param;
    save data5.mat dataPop dataDist dataParam dataStrategies dataPercentOfEachStrategy
    toc
end

strategyOccuransMatrix=zeros(param.nGenerations,length(dataPercentOfEachStrategy{1}{param.nGenerations}));

for j=1:param.nGenerations
    for k=1:length(dataPercentOfEachStrategy{1}{j})
        strategyOccuransMatrix(j,k)=dataPercentOfEachStrategy{1}{j}(k);
    end
end

M = cell( 1 , size(strategyOccuransMatrix,2) );
for i = 1:size(strategyOccuransMatrix,2)
    M{i} = int2str(dataStrategies{1}{i});
end

hold on
subplot(2,1,1)
g=area(strategyOccuransMatrix);
set(g(:),'FaceColor',[1 1 1])
set(g,'LineStyle','-','LineWidth',1)
axis([1 param.nGenerations 0 1 ])
%legend(M)

percentDemandedToBeInThePlot=0.3;
numberOfStrategiesWithHighEnoughPercent=0;
for i = 1:size(strategyOccuransMatrix,2)
    
    for j = 1:param.nGenerations
        if strategyOccuransMatrix(j,i)>=percentDemandedToBeInThePlot
            
            numberOfStrategiesWithHighEnoughPercent = numberOfStrategiesWithHighEnoughPercent + 1;
            dataStrategiesWithHighEnoughPercent=dataStrategies{1}{i};
            [highestValue(numberOfStrategiesWithHighEnoughPercent) generationWithHighestPercent(numberOfStrategiesWithHighEnoughPercent)]=max(strategyOccuransMatrix(:,i));
            strategyOriginalNumber(numberOfStrategiesWithHighEnoughPercent) = i;
            break
        end
    end
end
numberOfStrategiesWithHighEnoughPercent

for i=1:numberOfStrategiesWithHighEnoughPercent
yled(i) = sum(strategyOccuransMatrix(generationWithHighestPercent(i),1:(strategyOriginalNumber(i)-1)))+0.5*highestValue(i);
end



for i=1:numberOfStrategiesWithHighEnoughPercent
    
    s = [];
    for j =1:length(dataStrategies{1}{strategyOriginalNumber(i)})
        s = [s sprintf( '%.2f ', strategyTranslator(dataStrategies{1}{strategyOriginalNumber(i)}(j)))];
    end
    text((generationWithHighestPercent(i)),yled(i), s);
end

subplot(2,1,2)
h=area(dataDist{1});
set(h(:),'FaceColor',[1 1 1])
set(h,'LineStyle','-','LineWidth',1)
%legend('DD','DC','CD','CC')
axis([1 param.nGenerations 0 1 ])
text(2,0.2, 'DD')
text(2,0.4, 'CD')
text(2,0.6, 'DC')
text(2,0.8, 'CC')
