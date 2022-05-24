# plik modelu i danych dla uproszczonego zadania planowania produkcji

# zmienne
var x1 >= 0;
var x2 >= 0;

# funkcja celu
maximize FunCelu: 2*x1 + 3*x2;

# ograniczenia produkcyjne
s.t. Ogr1:
   2*x1 + 5*x2 <= 150;

s.t. Ogr2:
   3*x1 + 3*x2 <= 180;
