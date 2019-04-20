function extr = extrGroupFromEnsemble(ovo, group)

pairs = nchoosek(1:columns(group), 2);
extr = [];
for i=1:rows(pairs)
    f = pairs(i, 1);
    s = pairs(i, 2);
    extr = [extr; ovo(ovo(:, 1) == group(f) & ovo(:, 2)==group(s), :)];
    extr
end
end