%% Sprawozdanie TO - Łukasz Radzio
% Metody Powella
%
% 15.03.2016 wtorek 8.00
%
%%

% POWNAD Pierwsza i druga metoda Powella.
% Oznaczenia: n - wymiar zmiennej decyzyjnej
%             xn - przybliżenie rozwiązania
%             dm - macierz kierunków poszukiwania
%             e0 - dokładność obliczeµ.

im=inf;
maxit=100;
itp=1;
xn=[17;5];
n=length(xn);
dm=eye(n);
d=eye(n);
xa=xn;
qa=inf;
e0=1e-7;
clear xn_wsz
xn_wsz = {};
clear qn_wsz
qn_wsz = {};
iw = 0;
metoda =1;
%metoda=input('Wariant metody Powella (1 albo 2): ');
detDM = [];
zm_kier = [];
while 1
   if metoda==1,powe_1
   else powe_2
   end
   xa=xn;
   qa=qn;
   xn=xn+(rand(1)-0.5);
   if metoda==1,powe_1
   else powe_2
   end
   if qn>=qa,break,end
   delta=norm(xn-xa);
   if delta<e0,break,end
   dm(:,1)=[];
   dm(:,n)=(xn-xa)/delta;    
end
if qa<=qn
   qopt=qa;
   xopt=xa;
else
   qopt=qn;
   xopt=xn;
end   
dxy = 1;
xx = xn_wsz;
qq = qn_wsz;
ymin = 0;
xmin = 0;
xmax = 0;
ymax = 0;
qn_wsz = [];
for i = 1:iw
    xn_wsz = xx{i};
    qn_wsz = [qn_wsz qq{i}];
    xmin = min([min(xn_wsz(1,:)),xmin]);
    ymax = max([max(xn_wsz(2,:)),ymax]);
    xmax = max([max(xn_wsz(1,:)),xmax]);
    ymin = min([min(xn_wsz(2,:)),ymin]);
    
    
    plot(xn_wsz(1,:),xn_wsz(2,:),'r')
    hold on
    plot(xn_wsz(1,:),xn_wsz(2,:),'.')
    plot(xn_wsz(1,1),xn_wsz(2,1),'o');
    plot(xn_wsz(1,end),xn_wsz(2,end),'s');
    text(xn_wsz(1,1)+.1,xn_wsz(2,1)+.1,num2str(i));
    
   
end

    xmin = xmin - dxy;
    ymax = ymax + dxy;
    xmax = xmax + dxy;
    ymin = ymin - dxy;

xx1 = linspace(xmin,xmax,300);
    yy1 = linspace(ymin,ymax,300);
    [X,Y] = meshgrid(xx1,yy1);
    fun = @(x1,x2)  koszt({x1 x2});
    Z = fun(X,Y);
     hold on
    contour(X,Y,Z);
    contour(X,Y,Z,10);
    %contour(X,Y,Z,qn_wsz)
    hold off
    xopt;
    detDM;

    %% Dolina bananowa
    % Wskazane rozwiązanie numeryczne jest zależne od tego z której strony
    % algorytm zaczyna obliczenia. Z reguły otrzymuje się rozwiązania (1,
    % -1) oraz (1,1). Rozwiązaniem analitycznym jest (1,1).
    % Algorytm z zmierza do rozwiązania, ale nie każdy krok przynosi
    % jednakową poprawę rozwiązania. Wygląda to następująco: duża poprawa,
    % mały krok lub wręcz lekki powrót, przestój i następnie znów duży
    % krok. Można zaobserwować degenerację bazy, wyznacznik po paru
    % iteracjach potrafi zmniejszyć swoją wartość z 1 do 0.01.
    openfig('pow1_dol.fig');
    openfig('powe1_dm_06.fig');
    openfig('pow1_gor.fig');
    %% Druga metoda Powella
    % Dla drugiej metody degeneracja bazy jest ograniczona dlatego
    % nie obserwuje się powrotów. Do degeneracji dochodzi dopiero wtedy gdy
    % powe_2 zostaje wywołane zbyt dużą liczbę razy. Metoda 2. opóźnia
    % degenerację.
    openfig('pow2_gor.fig');
    %% Zadanie z kolokwium
    % $q = 10(x_1+x_2-5)^2 + (x_1-x_2)^2$
    % Funkcja celu jest funkcją kwadratową. Okazuje się, że metoda pierwsza
    % jest dla niej szybciej zbieżna.
    %%
    % <html><h3> Metoda 1.</h3></html>
    openfig('pow1_zad_zk');
    %% 
    % <html><h3> Metoda 2.</h3></html>
    openfig('pow2_zad_zk.fig');
    %% Wnioski
    % 1. Metoda Powella daje lepsze rezultaty dla funkcji dobrze
    % przybliżalnych funkcją kwadratową. Ma własność zbieżności drugiego
    % rzędu, tzn. znajduje rozwiązanie funkcji kwadratowej w skończonej
    % liczbie iteracji (maksymalnie n^2 poszukiwań na kierunku). 
    % Dla bardziej skomplikowanych funkcji może się okazać, że po paru
    % iteracjach baza kierunków zdegeneruje się, przez co kilka razy pod
    % rząd algorytm będzie przeszukiwał podobne kierunki niewiele posówając
    % się naprzód, bądź wręcz cofając się. Dla takich funkcji lepiej
    % sprawuje się druga metoda, która spowalnia i ogranicza degenerację bazy.
    