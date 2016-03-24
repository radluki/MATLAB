function [zw,qw,z,q]=zlopod(x0,d,zw,qw,maxit,z,q)

% ZLOPOD Metoda z�otego podzia�u z punktem wewn�trznym.
% Dane: tau - wsp�czynnik z�otego podzia�u
%       zw(1) - lewy koniec przedzia�u nieokre�lono�ci
%       zw(2) - punkt wewn�trzny
%       zw(3) - prawy koniec przedzia�u nieokre�lono�ci
%       qw(i) - warto�� wska�nika jako�ci w punkcie zw(i)
%       maxit - liczba krok�w.
% Warto�ci wska�nika jako�ci wylicza si� w KOSZT.M.

if nargin==6, maxit=1; end
tau=.5*sqrt(5)-.5;
for i=1:maxit
   del=zw(2)-zw;
   [D,j]=sort(abs(del));
   zz=zw(j(3))+tau*del(j(3));
   qq=koszt(x0,zz,d);
   if qq<qw(2) 
      zw([2 j(2)])=[zz zw(2)];
      qw([2 j(2)])=[qq qw(2)];
   else
      zw(j(3))=zz;
      qw(j(3))=qq;
   end
z=[z zz];
q=[q qq];
end
     