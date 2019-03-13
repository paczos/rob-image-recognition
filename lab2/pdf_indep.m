function pdf = pdf_indep(pts, para)
% Liczy funkcj� g�sto�ci prawdopodobie�stwa przy za�o�eniu, �e cechy s� niezale�ne
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz, bez etykiety!)
% para - struktura zawieraj�ca parametry:
%	para.mu - warto�ci �rednie cech (wiersz na klas�)
%	para.sig - odchylenia standardowe cech (wiersz na klas�)
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
%	liczba kolumn = liczba klas

	% znam rozmiar wyniku, wi�c go alokuj�
	pdf = zeros(rows(pts), rows(para.mu));

	
	% tu trzeba policzy� warto�� funkcji g�sto�ci
	% jako iloczyn g�sto�ci jednowymiarowych

	pdfs = zeros(rows(pts), columns(para.mu));
	for c=1:rows(para.mu)    % dla każdej klasy
	  for f=1:columns(para.mu)  % dla każdej cechy
	    pdfs(:, f) =  normpdf(pts(:, f), para.mu(c, f), para.sig(c,f));
	   end
	   pdf(:, c) = prod(pdfs, 2);
	end
% normpdf liczy jednowymiarową fun prawdopodobienstwa


end