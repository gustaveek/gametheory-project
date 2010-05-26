% mutateDuplicate.m duplicates a players genome and returns it 

function  rDuplicatedGenome = mutateDuplicate(aGenome)


rDuplicatedGenome=[aGenome;aGenome];

if size(aGenome,1)==16
rDuplicatedGenome=aGenome;
end

end