% evaluatePopulation.m Returns population fitness 
%    [fitness, distribution] = 
%         evaluatePopulation (population, param)
%    
%    @param N x 1 cell array with float vectors, population: 
%           population genomes
%
%    @param main parameter struct: param
% 
%    @return: N x 1 float vector, fitness: normalised fitness.
%             One value per individual
%
%    @return 1 x 3 float vector, distribution: normalised distribution 
%            of outcomes [dd, dc (or cd), cc] in all games. 
%
% The payoffmatrix contains the payoffs when each individual play against
% every other individual, entry (I,J) in the matrix contains the payoff
% that player I gets when playing against player J. So the payoff-matrix
% should be summed rowise into a single column to obtain the total
% payoff for every one individual


function [rFitness, rDist] = evaluatePopulation (aPopulation, aParam)

s = zeros(4,1); % order: DD, DC, CD, CC
payoffMatrix = zeros(aParam.nIndividuals);
outcomeCounts = zeros(1, 4);

%% Perform only the lower triangle  of the game. 
for iPlayer1 = 1:aParam.nIndividuals
  for iPlayer2 = 1:iPlayer1 - 1;

        %% Find the state table (from LarsH). 
        stateTable = genStateTable( aPopulation{iPlayer1} , aPopulation{iPlayer2} );
        
        %% Find the transition matrix.
        M = genTransMat (stateTable, aParam);
        
        %% Solv the equation through eigenvalue analysis, using a small
        %% domain as acceptance for eigenvalue = 1.
        [V,D] = eig(M);
        matrixIndexForH = -1;
        for i = 1:size(D,1)
          if D(i,i) > 1-1e-12 && D(i,i) < 1+1e-12
            matrixIndexForH = i;
          end
        end
        if matrixIndexForH == -1
            error('Please, never let this message appear...')
        end
        
        solutionProbabilities = V(:,matrixIndexForH);
	invSum = 1 / sum(solutionProbabilities);
	solutionProbabilities = invSum * solutionProbabilities;
        
        %% Add together the corresponding the elements of the state probabilities
        s = zeros(4,1); % order: DD, DC, CD, CC
	for i = 1:4:length(solutionProbabilities)
            s(1) = s(1) + solutionProbabilities(i+0);
            s(2) = s(2) + solutionProbabilities(i+1);
            s(3) = s(3) + solutionProbabilities(i+2);
            s(4) = s(4) + solutionProbabilities(i+3);
        end
        
        %% Calculate the payoffs
        payoffMatrix(iPlayer1,iPlayer2) = ...
	    s(1) * aParam.payoffDD +...
            s(2) * aParam.payoffDC + ...
	    s(3) * aParam.payoffCD +...
            s(4) * aParam.payoffCC;

	payoffMatrix(iPlayer2, iPlayer1) = ...
	    s(1) * aParam.payoffDD + ...
	    s(3) * aParam.payoffDC + ...
	    s(2) * aParam.payoffCD + ...
	    s(4) * aParam.payoffCC;	    

	%% Count outcomes
        outcomeCounts = outcomeCounts + s';

      end
end

%% Sum together for fitness, rowwise, and normalise. 
rFitness = sum (payoffMatrix , 2 );
invSum = 1 / sum (rFitness, 1);
rFitness = rFitness * invSum;

invSum = 1 / sum (outcomeCounts);
rDist = outcomeCounts * invSum;

end

