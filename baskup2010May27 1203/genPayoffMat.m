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

payoffMatrix = zeros(aParam.nIndividuals);
for iPlayer1 = 1:aParam.nIndividuals
    for iPlayer2 = 1:aParam.nIndividuals
        
        % Finding the state table (from LarsH)
        stateTable = genStateTable( aPopulation{iPlayer1} , aPopulation{iPlayer2} );
        
        % Finding the transition matrix
        M = genTransMat (stateTable, aParam);
        
        % Solving the equation through eigenvalue analysis
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
        
        payoffMatrix(iPlayer1,iPlayer2) = V(:,matrixIndexForH);
        
    end
end

% Summing together for fitness, summing columnwise
populationFitness = sum( payoffMatrix , 2 );
rFitness = populationFitness;

end

