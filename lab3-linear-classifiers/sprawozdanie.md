# ROB lab 3,4 Rozpoznawanie cyfr pisanych ręcznie Paweł Paczuski (271082)

## Klasyfikacji znaków przy użyciu klasyfikatorów liniowych

## Algorytm wyznaczania parametrów płaszczyzny decyzyjnej

## Jakość klasyfikacji


### Rozwiązanie referencyjne

Zbiór uczący MINST

|OK|Błąd |Odrzucenie|
|---|---|---|
| 0.9134| 0.0572|0.0294|

Zbiór testowy MINST

|OK|Błąd |Odrzucenie|
|---|---|---|
| 0.9155| 0.0549|0.0296|

### Perceptron

Zbiór uczący MINST

|OK|Błąd |Odrzucenie|
|---|---|---|
| 0.8951| 0.0759|0.0288|

``` 
   5599      0     23     12      5     61     71      4     29      2    117
      0   6376     57     25      4     20      9     45    115      5     86
     45     39   5258     69     74     24    104     54     95     16    180
     24     49    101   5340      3    211     30     62     84     43    184
      6     23     44      2   5272     12     76     16     29    205    157
     61     37     20    181     28   4525     79     47    113     45    285
     47     25     83      1     21     80   5523      0     27      0    111
     12     42     64     21     46     14      5   5749     17    135    160
     35    103     65    120     27    155     36     48   4908     79    275
     27     19     31     80    170     33      1    198     52   5161    177
```


Zbiór testowy MINST

|OK|Błąd |Odrzucenie|
|---|---|---|
| 0.8980| 0.0723|0.0297|

```
    932      0      2      2      0     13     10      2      1      0     18
      0   1074      4      7      0      1      4      2     31      0     12
      7      3    917     15     12      2     11      8     17      4     36
      4      2     14    907      0     23      2     18     14      3     23
      1      4      7      0    896      1     11      3      4     31     24
     11      5      5     35      3    738     12      8     16     10     49
     11      2      8      0      7     15    891      0      3      0     21
      1     10     19      5      7      0      1    931      4     23     27
     10      7     13     21      8     23      9     15    816     11     41
      5      3      5      8     33      5      1     23      2    878     46
```