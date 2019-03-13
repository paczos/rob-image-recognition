function para = para_indep(ts)
% Liczy parametry dla funkcji pdf_indep
% ts zbi�r ucz�cy (pr�bka = wiersz; w pierwszej kolumnie etykiety)
% para - struktura zawieraj�ca parametry:
%	para.labels - etykiety klas
%	para.mu - warto�ci �rednie cech (wiersz na klas�)
%	para.sig - odchylenia standardowe cech (wiersz na klas�)

	labels = unique(ts(:,1));
	para.labels = labels;

	para.mu = zeros(rows(labels), columns(ts)-1);
	para.sig = zeros(rows(labels), columns(ts)-1);

    for i=1:rows(labels)
		data = ts(ts(:, 1) == labels(i), :);
		para.mu(i, :) = mean(data(:, 2:end));
		para.sig(i, :) = std(data(:, 2:end));
	end
end