function pdf = pdf_parzen(pts, para)
% Aproksymuje warto�� g�sto�ci prawdopodobie�stwa z wykorzystaniem okna Parzena
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz)
% para - struktura zawieraj�ca parametry:
%	para.samples - tablica kom�rek zawieraj�ca pr�bki z poszczeg�lnych klas
%	para.parzenw - szeroko�� okna Parzena
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
%	liczba kolumn = liczba klas

	for c=1:rows(para.labels) % po klasach
    samples = para.samples{c};
    n = rows(samples);
    h = para.parzenw/sqrt(n);
      for pt=1:rows(pts) % po punktach
        pdfs = zeros(n, columns(samples));
          for feature=1:columns(samples) % po cechach
              pdfs(:, feature) = normpdf(pts(pt, feature), samples(:, feature), h);
          end
           pdf(pt, c) = mean(prod(pdfs, 2));
      end
	end
end