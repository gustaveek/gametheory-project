% discretizeInd.m Discretizize an individual
%      disChrom = discretizeInd (chrom)
%
%      @param float vector, chrom: chromosome
%      @return integer vector, disDhrome: the discrete version
%
% The formula used is this one
%
%      i(x) = floor (0.5 + f(x))
%      f(x) = (3*(N-e)+e)*x - 6*(N - e) * x*x + 4*(N-e) * x*x*x
%
% Where N is the number of bins and e is a very small positive number. Use N = 100 and e = 2.2e-11
%
%

function rDisGenome = discretizeInd (aGenome)

  nBins = 100;
  myEps = 2.2e-11;
  cons = nBins - myEps;
  f = (3 * cons + myEps) * aGenome ...
      - 6*cons * aGenome .* aGenome  ...
      + 4*cons * aGenome .* aGenome .* aGenome;

  rDisGenome = floor (0.5 + f);

end
