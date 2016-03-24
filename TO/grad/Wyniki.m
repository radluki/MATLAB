%% Sprawozdanie
%
%% Gradient sprz�ony
%% Dolina bananowa
% maxit=100;
% x0=[-2;3];
% e0=1e-8;
% 0) Najszybszy spadek 
%    liczba iteracji = 100
%    czas = 0.0652
%    rozw = (-1.7162,2.9507)
% 1) Fletcher - Reeves
%    liczba iteracji = 40
%    czas = 0.0307
%    rozw = (1.0001,1.0001)
% 2) 
%    liczba iteracji = 16
%    czas = 0.0169
%    rozw = (1.0000,1.0000)
% 3) 
%    liczba iteracji = 26
%    czas = 0.0235
%    rozw = (1.0000,1.0000)
% Metoda najszybszego spadku - przeskoki
% Algorytm wyko�ystuje metod� ekspansji i kontrakcji.
% Wsp�czynnik kontrakcji wp�ywa na czas w kt�rym nast�pi przeskok
% beta~0.9  szybki przeskok, beta~0.01 p�ny przeskok
%
% Wnioski:
% * Meoda najszbszego spadku jest bardzo wolnym i niewydajnym algorymem
% * Bardziej sk�plikowane wzory na bet� mog� zmniejszy� liczb� iteracji
%
%% Zad 1 - x1^2 + a*x2^2
% maxit=100;
% x0=[-2;3];
% e0=1e-8;
% a = 50
% poziomice = elipsy
% 0) Najszybszy spadek
%    liczba iteracji = 8
%    czas = 0.0092
%    rozw = (0,0.6294)*1e-7
% 1) Fletcher - Reeves 
%    liczba iteracji = 3
%    czas = 0.0082
%    rozw = (0,-0.6847)*1e-14
% 2) 
%    liczba iteracji = 3
%    czas =  0.0056
%    rozw = (0,0.1430)*1e-15
% 3) 
%    liczba iteracji = 3
%    czas =  0.0054
%    rozw = (0,0.1361)*1e-15
% 
% Wnioski:
% * Dla funkcji kwadratowej czas rozwi�zania metody najszybszego spadku
% jest por�wnywalny z metod� Fletchera-Reevesa, ale liczba iteracji jest
% prawie 3 razy wi�ksza.

%% Dodatkowe zadanie
% norma 
% maksima, minima
% miejsca zerowe, minimalizacja kwadratu


