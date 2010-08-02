function strategyValue = strategyTranslator(valueToTranslate)
% Translates an unevenly spaced number between 0 and 100 to a strategic
% value between 0 and 1 by solving the equation system.

% Following three lines ripped from discretizeInd, change both if change.
nBins = 100;
myEps = 2.2e-11;
cons = nBins - myEps;

startingPoint = 0.7; % Seems to work, do not pick 0.5, solver breaks down.

strategyValue = fsolve(@(x) 3*cons*x-6*cons*x^2+4*cons*x^3-valueToTranslate , startingPoint);

end