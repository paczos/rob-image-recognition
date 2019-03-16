% malutki plik do uruchomienia funkcji pdf
load pdf_test.txt
size(pdf_test)
format longE
% ile jest klas?
labels = unique(pdf_test(:,1));

% ile jest pr�bek w ka�dej klasie?
[labels'; sum(pdf_test(:,1) == labels')];
		  % ^^^ dobrze by�oby pomy�le� o tym wyra�eniu

% jak uk�adaj� si� pr�bki?


pdfindep_para = para_indep(pdf_test);
% para_indep jest do zaimplementowania, tak �eby dawa�a:

% pdfindep_para =
%  scalar structure containing the fields:
%    labels =
%       1
%       2
%    mu =
%       0.7970000   0.8200000
%      -0.0090000   0.0270000
%    sig =
%       0.21772   0.19172
%       0.19087   0.27179

% teraz do zaimplementowania jest sama funkcja licz�ca pdf 
pi_pdf = pdf_indep(pdf_test([2 7 12 17],2:end), pdfindep_para);

%pi_pdf =
%  1.4700e+000  4.5476e-007
%  3.4621e+000  4.9711e-005
%  6.7800e-011  2.7920e-001
%  5.6610e-008  1.8097e+000

% wielowymiarowy rozk�ad normalny - parametry ...

pdfmulti_para = para_multi(pdf_test);

% pout.sig(:,:, i) = cov(....)

%pdfmulti_para =
%  scalar structure containing the fields:
%    labels =
%       1
%       2
%    mu =
%       0.7970000   0.8200000
%      -0.0090000   0.0270000
%    sig =
%    ans(:,:,1) =
%       0.047401   0.018222
%       0.018222   0.036756
%    ans(:,:,2) =
%       0.036432  -0.033186
%      -0.033186   0.073868  



% ... i funkcja licz�ca g�sto��
pm_pdf = pdf_multi(pdf_test([2 7 12 17],2:end), pdfmulti_para);

%pm_pdf =
%  7.9450e-001  6.5308e-017
%  3.9535e+000  3.8239e-013
%  1.6357e-009  8.6220e-001
%  4.5833e-006  2.8928e+000

% parametry dla aproksymacji oknem Parzena
pdfparzen_para = para_parzen(pdf_test, 0.5);
									 % ^^^ szeroko�� okna

%pdfparzen_para =
%  scalar structure containing the fields:
%    labels =
%       1
%       2
%    samples =
%    {
%      [1,1] =
%         1.10000   0.95000
%         0.98000   0.61000
% .....
%         0.69000   0.93000
%         0.79000   1.01000
%      [2,1] =
%        -0.010000   0.380000
%         0.250000  -0.440000
% .....
%        -0.110000   0.030000
%         0.120000  -0.090000
%    }
%    parzenw =  0.50000

pp_pdf = pdf_parzen(pdf_test([2 7 12 17],2:end), pdfparzen_para);

%pp_pdf =
%  9.7779e-001  6.1499e-008
%  2.1351e+000  4.2542e-006
%  9.4059e-010  9.8823e-001
%  2.0439e-006  1.9815e+000


% wreszcie mo�na zaj�� si� kartami!
load train.txt
load test.txt

% poniewa� dane s� w istocie z dw�ch populacji zmieniamy
% etykiety "klienta" na etykiety pasuj�ce do klasyfikacji
for i=77:152:1824
	train(i:i+75,1) += 4;
	test(i:i+75,1) += 4;
end

% pierwszy rzut oka na dane
%size(train)
%size(test)
labels = unique(train(:,1));
unique(test(:,1));
[labels'; sum(train(:,1) == labels')];

% pierwszym zadaniem po za�adowaniu danych jest sprawdzenie,
% czy w zbiorze ucz�cym nie ma pr�bek odstaj�cych
% do realizacji tego zadania przydadz� si� funkcje licz�ce
% proste statystyki: mean, median, std, 
% wy�wietlenie histogramu cech(y): hist
% spojrzenie na dwie cechy na raz: plot2features (dostarczona w pakiecie)

%[mean(train); median(train)];
%hist(train(:,1));


% do identyfikacji odstaj�cych pr�bek doskonale nadaj� si� wersje
% funkcji min i max z dwoma argumentami wyj�ciowymi

for i=2:size(train,2)
%    [mv midx] = min(train(:, i));
%    fprintf("min %d for class %d is at %d", mv,  i, midx);
end

for i=2:size(train,2)
%    [mv midx ] = min(train(:, i));
%    fprintf("min %d for class %d is at %d", mv,  i, midx);
end

%[mv midx] = min(train)

% poniewa� warto�ci minimalne czy maksymalne da si� wyznaczy� zawsze,
% dobrze zweryfikowa� ich odstawanie spogl�daj�c przynajmniej na s�siad�w
% podejrzanej pr�bki w zbiorze ucz�cym

% je�li nabra�em przekonania, �e pr�bka midx jest do usuni�cia, to:
%size(train)
train([186, 642], :) = [];
%size(train)

Combs = nchoosek(labels(2:end), 2);
for i=1:size(Combs)
     f1 = Combs(i, 1);
     f2 = Combs(i, 2);
     %plot2features(train, f1, f2);
end

% procedur� szukania i usuwania warto�ci odstaj�cych trzeba powtarza� do skutku

% po usuni�ciu warto�ci odstaj�cych mo�na zaj�� si� wyborem DW�CH cech dla klasyfikacji
% w tym przypadku w zupe�no�ci wystarczy poogl�da� wykresy dw�ch cech i wybra� te, kt�re
% daj� w miar� dobrze odseparowane od siebie klasy

% Po ustaleniu cech (dok�adniej: indeks�w kolumn, w kt�rych cechy siedz�):
first_idx = 4;
second_idx = 6;
train = train(:, [1 first_idx second_idx]);
test = test(:, [1 first_idx second_idx]);

% to nie jest najros�dniejszy wyb�r; 4 i 6 na pewno trzeba zmieni�

% tutaj jawnie tworz� struktur� z parametrami dla klasyfikatora Bayesa
% (po prawdzie, to dla funkcji licz�cej g�sto�� prawdobie�stwa) z za�o�eniem,
% �e cechy s� niezale�ne

pdfindep_para = para_indep(train);
pdfmulti_para = para_multi(train);
pdfparzen_para = para_parzen(train, 0.001);
% w sprawozdaniu trzeba podawa� szeroko�� okna (nie liczymy tego parametru z danych!)

% wyniki do punktu 3
sprintf("pkt 3: ")
fprintf("\n|cechy|pdfindep_para|pdfmulti_para|pdfparzen_para|\n")
fprintf("--------\n")
base_ercf = zeros(1,3);
apriori = repmat([0.25], rows(test(:,2:end)), 1);
base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para, apriori) != test(:,1));
base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para, apriori) != test(:,1));
base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para, apriori) != test(:,1));
fprintf("|%d  %d|%f|%f|%f|\n", first_idx, second_idx, base_ercf(1), base_ercf(2), base_ercf(3)) % odpowiednio  sformatowany wiersz tabeli dla markdowna

% W kolejnym punkcie przyda si� funkcja reduce, kt�ra redukuje liczb� pr�bek w poszczeg�lnych
% klasach (w tym przypadku redukcja b�dzie taka sama we wszystkich klasach - ZBIORU UCZ�CEGO)
% Poniewa� reduce ma losowa� pr�bki, to eksperyment nale�y powt�rzy� 5 (lub wi�cej) razy
% W sprawozdaniu prosz� poda� tylko warto�� �redni� i odchylenie standardowe wsp�czynnika b��du
% 4:
parts = [0.1 0.25 0.5];
rep_cnt = 1; % przynajmniej 5
sprintf("pkt 4:")
labels = unique(train(:,1));
fprintf("\n|czesc|powtorzenie|cechy|pdfindep_para|pdfmulti_para|pdfparzen_para|\n")
fprintf("----------\n")
    for p=1:columns(parts)
        for rep=1:rep_cnt
        tr = reduce(train, repmat([parts(p)], rows(labels), 1)');
        pdfindep_para = para_indep(tr);
        pdfmulti_para = para_multi(tr);
        pdfparzen_para = para_parzen(tr, 0.001);
        base_ercf = zeros(1,3);
        apriori = repmat([0.25], rows(test(:,2:end)), 1);
        base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para, apriori) != test(:,1));
        base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para, apriori) != test(:,1));
        base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para, apriori) != test(:,1));
        fprintf("|%f|%d|%d  %d|%f|%f|%f|\n", parts(p), rep, first_idx, second_idx, base_ercf(1), base_ercf(2), base_ercf(3)) % odpowiednio  sformatowany wiersz tabeli dla markdowna
    end
end

% Punkt 5 dotyczy jedynie klasyfikatora z oknem Parzena (na pe�nym zbiorze ucz�cym)
parzen_widths = [0.0001, 0.0005, 0.001, 0.005, 0.01];
parzen_res = zeros(1, columns(parzen_widths));
apriori = repmat([0.25], rows(test(:,2:end)), 1);

fprintf("\n|parzen width|error|\n")
fprintf("-------------\n")
for w=1:columns(parzen_widths)
        pdfparzen_para = para_parzen(tr, parzen_widths(w));
        base_ercf = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para, apriori) != test(:,1));
        fprintf("|%f|%f|\n", parzen_widths(w), base_ercf)
end

[parzen_widths; parzen_res]
% Tu a� prosi si� do�o�y� do danych numerycznych wykres
semilogx(parzen_widths, parzen_res)

% W punkcie 6 redukcja dotyczy ZBIORU TESTOWEGO (nie ma potrzeby zmiany zbioru ucz�cego)
% 
apriori = [0.165 0.085 0.085 0.165 0.165 0.085 0.085 0.165];
parts = [1.0 0.5 0.5 1.0 1.0 0.5 0.5 1.0]; % todo bierzemy klasy z takimi częściami, raz wykonujemy
sprintf("pkt 6:")
labels = unique(train(:,1));
fprintf("\n|czesc|powtorzenie|cechy|pdfindep_para|pdfmulti_para|pdfparzen_para|\n")
fprintf("----------\n")
    for p=1:columns(parts)
        for rep=1:rep_cnt
        pdfindep_para = para_indep(tr);
        pdfmulti_para = para_multi(tr);
        pdfparzen_para = para_parzen(tr, 0.001);
        base_ercf = zeros(1,3);

        testred = reduce(test, repmat([parts(p)], rows(labels), 1)');
        base_ercf(1) = mean(bayescls(testred(:,2:end), @pdf_indep, pdfindep_para, apriori) != testred(:,1));
        base_ercf(2) = mean(bayescls(testred(:,2:end), @pdf_multi, pdfmulti_para, apriori) != testred(:,1));
        base_ercf(3) = mean(bayescls(testred(:,2:end), @pdf_parzen, pdfparzen_para, apriori) != testred(:,1));
        fprintf("|%f|%d|%d  %d|%f|%f|%f|\n", parts(p), rep, first_idx, second_idx, base_ercf(1), base_ercf(2), base_ercf(3)) % odpowiednio  sformatowany wiersz tabeli dla markdowna
    end
end


% W ostatnim punkcie trzeba zastanowi� si� nad normalizacj�
std(train(:,2:end))
% Mo�e warto sprawdzi�, jak to wygl�da w poszczeg�lnych klasach?

% Normalizacja potrzebna?
% Je�li TAK, to jej parametry s� liczone na zbiorze ucz�cym
% Procedura normalizacji jest aplikowana do zbioru ucz�cego i testowego

% YOUR CODE GOES HERE 
% czy wyniki leave1out różnią się od  

