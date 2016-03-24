%% Wizualizacja danych
% Skrypt przeprowadzający wizualizację metody poszukiwań na kierunku
% W tym przypadku x1 = [1; 0], x2 = [0.01; 1]
% Dla kierunków ortogonalnych metoda szybko zbiega do minimum, natomiast
% dla kierunków niewiele różniących się od siebie zbieżność jest wolna.
% Istnieją funkcje dla których metoda tutaj użyta będzie wolno zbieżna.
% Warunkiem wystarczającym szybkiej zbieżności jest to aby poziomice  w
% przybliżeniu wyglądały jak okręgi.
% Na wykresie jest przedstawiony przykład dość wolnej zbieżności.
% Aby przyspieszyć algorytm można dopisać generację kierunków sprzężnonych.
% np. metoda Powela
clear all
fun = @(x1,x2) koszt([x1 x2]);
%x = [-2,2]; % zakresy mesh, contour
%y = [-2,2];

global max_it_zlo
global max_it_apr

max_it_zlo = 10;
max_it_apr = 10;
x0 =[1,3]; % dla kierunku
D = [1 .01; 0 1]; 
close all;
a1 = [];
b1 = [];
i=1;
delta=10000;
while (delta>1e-1 || i<=2)
    d = D(:,2-mod(i,2))';
    [a,b,z,q] = prosta1(x0,d); % a - xmin, b = zmin, na kieunku d, z,q wszystkie
    xxx = repmat(x0',1,length(z)) + d'*z; % x0+z*d
    xi = xxx(1,:);
    yi = xxx(2,:);
    
    figure(2)
    %axis equal
    xic{i} = xi;
    yic{i} = yi;
    x0c{i} = x0;
    dc{i} = d;
    ac{i} = a;
    bc{i} = b;
    i=i+1;
    x0=a;
    delta = norm(x0 - x0c{i-1});
    
end
rysuj(fun,xic,yic,x0c,dc,ac,bc,[2,0,25])