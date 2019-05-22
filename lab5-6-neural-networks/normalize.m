function A = normalize(M)
A = zeros(rows(M),columns(M));
for i=1:columns(M)
    magn = norm(M(:, i));
    A(:, i) = M(:, i)/magn;
end
end