function pdf = pdf_multi(pts, para)
% Liczy funkcj� g�sto�ci prawdopodobie�stwa wielowymiarowego r. normalnego
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz)
% para - struktura zawieraj�ca parametry:
%	para.mu - warto�ci �rednie cech (wiersz na klas�)
%	para.sig - macierze kowariancji cech (warstwa na klas�)
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
%	liczba kolumn = liczba klas

	for i=1:rows(para.mu)
	pdf(:, i)  = mvnpdf(pts, para.mu(i, :), para.sig(:,:, i));
	end
end
