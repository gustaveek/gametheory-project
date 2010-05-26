% genPayOffMat.m Returns payoff-matrix (NxN) for the whole population given
% the whole population (N*1, cellarray)
%
%    @param N x N matrix: population
%    @param main parameter struct: param
%    @param individual == individual whose payoffmatrix should be found


% The payoffmatrix contains the payoffs when each individual play against
% every other individual, entry (i,j) in the matrix contains the payoff
% that player i gets when playing against player j. So the payoff-matrix
% should be summed columnwise into a single column to obtain the total
% payoff for one individual


function rFitness = evaluatePopulation (aPopulation, aParam)

s = zeros(4,1); % order: DD, DC, CD, CC
payoffMatrix = zeros(aParam.nIndividuals);
for iPlayer1 = 1:aParam.nIndividuals
    for iPlayer2 = 1:aParam.nIndividuals
        
        % Finding the state table (from LarsH)
        stateTable = genStateTable( aPopulation{iPlayer1} , aPopulation{iPlayer2} );
        
        % Finding the transition matrix
        M = genTransMat (stateTable, aParam);
        
        % Solving the equation through eigenvalue analysis, using a small
        % domain as acceptance for eigenvalue = 1.
        [V,D] = eig(M);
        matrixIndexForH = -1;
        for i = 1:size(D,1)
            if D(i,i) > 1-1e-12 && D(i,i) < 1+1e-12
                matrixIndexForH = i;
            end
        end
        if matrixIndexForH == -1
            disp('Please, never let this message appear...')
        end
        
        solutionProbabilities = V(:,matrixIndexForH);
        
        % Adding the corresponding the elements of the state probabilities
        for i = 1:4:length(solutionProbabilities)
            s(1) = s(1) + solutionProbabilities(i+0);
            s(2) = s(2) + solutionProbabilities(i+1);
            s(3) = s(3) + solutionProbabilities(i+2);
            s(4) = s(4) + solutionProbabilities(i+3);
        end
        
        % Calculating the payoff
        payoffMatrix(iPlayer1,iPlayer2) = s(1)*aParam.payoffDD +...
            s(2)*aParam.payoffDC + s(3)*aParam.payoffCD +...
            s(4)*aParam.payoffCC;
        
    end
end

% Summing together for fitness, summing columnwise
populationFitness = sum( payoffMatrix , 2 );
rFitness = populationFitness;

end

