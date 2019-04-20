function extr = extrGroupFromEnsemble(ovo, group)

pairs = nchoosek(1:columns(group), 2);
extr = false(rows(ovo),1);

for i=1:rows(pairs)
    f = pairs(i, 1);
    s = pairs(i, 2);
    extr |=  ovo(:, 1) == group(f) & ovo(:, 2)==group(s);
end

extr = ovo(extr, :)

end