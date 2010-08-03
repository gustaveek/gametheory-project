% main.m Main script for game theory project.
%   main

clc; clear; clf;

%% main parameters
nIndividuals = 16;
param = ...
    struct( ...
    'nIndividuals', nIndividuals, ... % population size
    'nParents', round(nIndividuals*0.4), ...
    'selectionPressure', 0.1, ...
    'selectionMethod', 'fitnessproportional', ... % or 'exponential'
    'nGenerations', 10, ...
    'pMutSwitch', 0.0001, ...
    'pMutSplit', 0.0001, ...
    'pMutDuplicate', 0.0001, ...
    'mutFloatLength', 0.05, ...
    'pMutFloat', 0.0001, ...
    'pError', 0.01,...
    'payoffCC', 3, ...
    'payoffDC', 5, ...
    'payoffCD', 0, ...
    'payoffDD', 1);

%% Sweeping parameters
pMut = [0.01]% 0.001 0.0001 0.00001];
selectionPressureS=[0.1]% 0.01 0.001 0.5];
for i = 1:length(pMut)
    param.pMutFloat = pMut(i);
    param.pMutSwitch = pMut(i);
    param.pMutDuplicate = 0.1*pMut(i);
    param.pMutSplit = 0.1*pMut(i);
        
    disp('Runns with:')
    disp(param);
    [dataPop{i}, dataDist{i} dataStrategies{i} dataPercentOfEachStrategy{i}]= mainLoop2 (param);
    
   % for j=1:length(selectionPressureS)
   % param.selectionPressure=selectionPresureS(j)
   % end
    
    dataParam{i} = param;
    
       %save data5.mat dataPop dataDist dataParam dataStrategies %strategyOccuransMatrix
    
end





strategyOccuransMatrix=zeros(param.nGenerations,length(dataPercentOfEachStrategy{1}{param.nGenerations}));

for j=1:param.nGenerations
    for k=1:length(dataPercentOfEachStrategy{1}{j})
        strategyOccuransMatrix(j,k)=dataPercentOfEachStrategy{1}{j}(k);
    end
end

%M = cell( 1 , size(strategyOccuransMatrix,2) );
%for i = 1:size(strategyOccuransMatrix,2)
%    M{i} = int2str(dataStrategies{1}{i});
%end

hold on
subplot(2,1,1)
g=area(strategyOccuransMatrix);
set(g(:),'FaceColor',[1 1 1])
set(g,'LineStyle','-','LineWidth',1)
axis([1 param.nGenerations 0 1 ])
%legend(M)
xlabel('generations')
ylabel('percent of population')

percentDemandedToBeInThePlot=0.2;
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
%numberOfStrategiesWithHighEnoughPercent

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
xlabel('generations')
ylabel('chosen actions')

saveas(figure(1),'bild.png','png')
save data5.mat dataPop dataDist dataParam dataStrategies strategyOccuransMatrix
