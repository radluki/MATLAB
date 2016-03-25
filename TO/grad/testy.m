% testy
maxit=200;
e0=1e-3;
par = 0
global a
global zad
global rodz_grad
rodz_grad=1;
zad = 5
a = 10
for i=0:3
    x0=[-3;4];
    par = i;
    granad; 
end

%% Funkcja kwadratowa
% Między metodami 1,2,3 nie było różnicy w przebiegu. Wzory wyznaczały
% dokładnie te same kierunki. Jest to zgodne z rozumowaniem przeprowadzonym
% w książce Metody optymalizacji z ćwiczeniami lab. rozdz. 3.4.2
% Czas znalezienia rozwiązania najmniejszy był dla metody 1. Najgorszy dla
% metody 0, która zamiast 2 iteracji przeprowadziła 5 poszukiwań na
% kierunku dla a=10 x0=[-2,3].

%% Dolina bananowa
% e0=1e-3
% x0=[-2,3]
% maxit=200
% Gradient analityczny
% Czas dla metod 1:3 ok. 3 razy krutszy niż dla gradientu numerycznego,
% liczba iteracji bez zmian.
% Metoda najszybszego spadku nie znajduje rozwiązania. 
% Gradient numeryczny - metoda Eulera
% Czas wykonania: 3) 0.01 2) 0.0125 1) 0.0154 0) 0.1
% Iteracje: 3) 21 2) 26 1) 34 0) 180
% Dla metod gradientu sprzężonego z reguły każdy krok daje poprawę 
% oszacowania wyniku. Odległość od rozwiązania dla metody najszybszego
% spadku ma charakter skokowy. Niekiedy nawet przez 100 iteracji
% rozwiązanie może się prawie nic nie poprawić.