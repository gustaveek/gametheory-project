function svar=areaskript(strategyOccuransMatrix, dataStrategies, dataDist)  
clf
nGenerations=10000;
%nGenerations=100;

%strategyOccuransMatrix( end-1000:end , : );

hold on
subplot(2,1,1)
g=area(strategyOccuransMatrix);
set(g(:),'FaceColor',[1 1 1])
set(g,'LineStyle','-','LineWidth',1)
%axis([9000 nGenerations 0 1 ])
axis([1 nGenerations 0 1 ])
title('Life and death of strategies')
%legend(M)
xlabel('generation')
ylabel('proportion of population')

percentDemandedToBeInThePlot=0.2;
numberOfStrategiesWithHighEnoughPercent=0;
for i = 1:size(strategyOccuransMatrix,2)
    
    %for j = 9000:nGenerations
    for j = 1:nGenerations 
        if strategyOccuransMatrix(j,i)>=percentDemandedToBeInThePlot
            
            numberOfStrategiesWithHighEnoughPercent = numberOfStrategiesWithHighEnoughPercent + 1;
            dataStrategiesWithHighEnoughPercent=dataStrategies{i};
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
    for j =1:length(dataStrategies{strategyOriginalNumber(i)})
        s = [s sprintf( '%.2f ', strategyTranslator(dataStrategies{strategyOriginalNumber(i)}(j)))];
    end
    text((generationWithHighestPercent(i)),yled(i), s);
end


subplot(2,1,2)
h=area(dataDist);
set(h(:),'FaceColor',[1 1 1])
set(h,'LineStyle','-','LineWidth',1)
%legend('DD','DC','CD','CC')
axis([1 nGenerations 0 1 ])
text(2,0.2, 'DD')
text(2,0.4, 'CD')
text(2,0.6, 'DC')
text(2,0.8, 'CC')
xlabel('generation')

title('Distribution of game outcomes')

end