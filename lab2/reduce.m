function rds = reduce(ds, parts)
% Funkcja redukcji liczby pr�bek poszczeg�lnych klas w zbiorze ds
% ds - zbi�r danych do redukcji; pierwsza kolumna zawiera etykiet�
% parts - wierszowy wektor wsp�czynnik�w redukcji dla poszczeg�lnych klas

	labels = unique(ds(:,1));
	if rows(labels) ~= columns(parts)
		error("Liczba klas nie zgadza sie z liczba wsp. redukcji.");
		rows(labels)
		columns(parts)
	end

	if max(parts) > 1 || min(parts) < 0
		error("Niewlasciwe wspolczynniki redukcji.");
	end
		rds = [];
	for c=2:rows(labels)
        datainclass = ds(ds(:, 1)==labels(c), :);
        reducedidx = randperm(floor(rows(datainclass)*parts(c)));
        rds = [rds; datainclass(reducedidx, :)];
	end

end
