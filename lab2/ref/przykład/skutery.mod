# plik modelu dla zadania planowania produkcji

# deklaracje zbiorów i parametrów zawartych w pliku danych
set SKUTERY;
set ODDZIALY;

param praca {ODDZIALY, SKUTERY} >= 0;
param moc {ODDZIALY} >= 0;
param cena {SKUTERY} >= 0;

# zmienne
var prod {SKUTERY} >= 0;
var obc {ODDZIALY};
var wol {ODDZIALY} >= 0;
var zysk;

# funkcja celu
maximize FunCelu: zysk;

# ograniczenie zysku
s.t. OgrZysk:
   zysk = sum {k in SKUTERY} cena[k] * prod[k];

# ograniczenia obci¹¿enia
s.t. OgrObc {o in ODDZIALY}:
    obc[o] = sum {k in SKUTERY} praca[o,k] * prod[k];

# ograniczenia wolnych mocy
s.t. OgrWolMoc {o in ODDZIALY}:
    wol[o] = moc[o] - obc[o];
