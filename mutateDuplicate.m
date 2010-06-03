% mutateDuplicate.m duplicates a players genome and returns it 

function  rDuplicatedGenome = mutateDuplicate(aGenome)

  if length (aGenome) < 16 % duplicate only if size < 4
    rDuplicatedGenome = [aGenome aGenome];
  else
    rDuplicatedGenome = aGenome;
  end
  
end