# ROB lab 5, 6 Rozpoznawanie odzieży z wykorzystaniem sieci neuronowych Paweł Paczuski (271082)

## Rozpoznawanie odzieży z wykorzystaniem sieci neuronowych
Zadanie polegało na implementacji sieci neuronowej w celu klasyfikacji odzieży. Zbiórem danych był fashion-MNIST zawierający 10 rodzajów odzieży w identycznym formacie jak zbiór MNIST z cyframi.

## Wariant standardowy
Celem było uzyskanie sieci neuronowej, której uda się uzyskać lepsze wyniki niż:

Zbiór uczący:

|Poprawne|Błędne|
|---|---|
|90.38%|9.62%|

Zbiór testowy:

|Poprawne|Błędne|
|---|---|
|87.42%|12.58%|

Aby uzyskac lepsze wyniki zbudowano sieć neuronową o dwóch warstwach (1 ukryta 1 wyjściowa) z 400 neuronami w warstwie ukrytej, tempo uczenia 0.025 przez 70 epok:

Zbiór uczący

|Poprawne|Błędne|
|---|---|
|94.19%|5.81%|  


Zbiór trenujący

|Poprawne|Błędne|
|---|---|
|88.81%|11.19%|

Każda epoka zajmowała około 157 s, więc sumarycznie wytrenowanie sieci zajęło dużo czasu (3 h).


## Modyfikacja rozwiązania w celu uzyskania lepszych wyników

### Zmienne tempo uczenia
Pierwszym pomysłem było wprowadzenie zmiennego współczynnika uczenia sieci. Zastosowano proste rozwiazanie polegające na zmniejszaniu współczynnika błędu o 10%, gdy sieć zaczynała zwracać gorsze wyniki niż w poprzedniej epoce. 
Uczenie przebiegało bardzo powoli, ale przebiegało. Sieć uczyla się aż przez 200 epok i uzyskała lepsze wyniki niż rozwiązanie, które należało pokonać. Uczenie rozpoczęto z wartością tempa uczenia 0.25 i zmniejszano je aż do wartości 0.0005  

Zbiór testowy

|Poprawne|Błędne|
|---|---|
|97.28%|2.72%|     

Zbiór treningowy

|Poprawne|Błędne|
|---|---|
|89.13%|10.87%|

Warto zwrócić uwage na zbytnie dopasowanie sieci do danych. Chociaż jest to wynik spełniający oczekiwania, to podjęto dalsze poszukiwania rozwiazania, które nie dopasowywałoby się tak bardzo do danych treningowych lub pozwalaloby osiągać zbliżone wyniki szybciej.

### Normalizacja danych
W celu poprawy wyników podjęto próbę normalizacji danych treningowych testowych, jednak to rozwiązanie przyniosło znaczne pogorszenie wyników, więc zostało odrzucone – sieć oscylowała wokół 20% błędów na zbiorze testowym.

### Standaryzacja
Kolejnym pomysłem było dodanie do zmiennego tempa uczenia standaryzacji danych: od każdej próbki odjęto średnią wartość z jej kolumny i podzielono przez odchylenie standardowe kolumny. 

Parametry:

* 400 neuronów
* 200 epok
* startowe tempo uczenia 0.25
* spadek tempa uczenia 10%
* minimalne tempo uczenia 0.0005;

Już po 33 epokach osiągnięto obiecujące efekty

Zbiór trenujący 

|Poprawne|Błędne|
|---|---|
|97.13%|2.87%|

Zbiór testowy

|Poprawne|Błędne|
|---|---|
|88.87%|11.13%| 

Wyniki są nieco gorsze od najlszego uzyskanego za pomoca usprawnień rozwiązania, ale potrzeba mniej epok aby uzyskac lepsze niż zadane rozwiazanie. Jedna epoka trwała 150 s.

Podjęto próbę przyspieszenia rozwiązania – zmniejszono liczbę neuronów do 250, przyspieszono zmniejszanie tempa uczenia oraz zmniejszono startowe tempo uczenia. 

 Parametry:

* 250 neuronów
* 50 epok
* startowe tempo uczenia 0.1
* spadek tempa uczenia 30%
* minimalne tempo uczenia 0.0005;

Dzięki zmniejszeniu liczby neuronów, jedna epoka trwała 92 s – prawie dwukrotne przyspieszenie. Sieć osiąga najlepsze rozwiązanie przy 42. epoce, następnie oscyluje wokół tego rozwiazania.

Zbiór trenujący

|Poprawne|Błędne|
|---|---|  
|97.57%|2.43%|    

Zbiór testujący

|Poprawne|Błędne|
|---|---|
|89.01%|10.99%|

```
cfmx =

   5722      7     40     65     22      3    108      0     31      2      0
      9   5920      1     48      6      1     14      0      1      0      0
     34      8   5582     40    211      1     97      2     25      0      0
     37      8     11   5838     44      0     54      0      7      1      0
     14      4    121     60   5712      2     75      1     11      0      0
      2      0      1      1      0   5964      2     19      5      6      0
    153     11    103     88    114      1   5501      2     26      1      0
      0      0      1      0      0     24      0   5917      5     53      0
     12      3     11     10     17      1     18      8   5919      1      0
      0      0      0      0      0      7      0     65      1   5927      0
```

# Wnioski

Dostrajanie parametrów sieci może znacząco zmienić przebieg jej uczenia. W razie potrzeby dalszej poprawy klasyfikacji zawsze można skorzystać ze sztuczek korzystających z obserwacji własciwości uzywanych danych. Kolejnym krokiem usprawniającym działanie sieci mogłoby być zastosowanie regularyzacji w celu ograniczenia nadmiernego dopasowania, które w uzyskanym rozwiązaniu jest duże.

Wybrane rozwiązanie jest lepsze od rozwiązań referencyjnych i w przeciwieństwie do najlepszego ze wszystkich uzyskanych, osiągane jest stosunkowo szybko przy niewielkiej różnicy błędu.     