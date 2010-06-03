% harshGame.m Returns the harsh number for a pair of players
%      harshNumber = harshGame (ind1, ind2, param)
%
%    @param 1 x N integer vector, ind1: first chromosome
%    @param 1 x N integer vector, ind1: first chromosome
%    @param struct, param: the usual parameter struct 
%    @return integer, harshNumber: the harsh number
%
%    The harsh transformation is a fast, deterministic, and uniformly
%    distributed, but not unique mapping. The harsh number should be
%    used as index into a cell array. 

function rHarsh = harshGame( aInd1, aInd2, aParam)

  rHarsh = 0;
  for i = 1: length (aInd1)
    rHarsh = 2 * rHarsh + aInd1(i);
  end
  rHarsh = rem(abs(fix(rHarsh)), aParam.nHarshes) + 1;

  for i = 1: length (aInd2)
    rHarsh = 2 * rHarsh + aInd2(i);
  end
  rHarsh = rem(abs(fix(rHarsh)), aParam.nHarshes) + 1;


  if ~ (isinteger(rHarsh))
    disp('Not integer');
%    keyboard;
  end
  

end