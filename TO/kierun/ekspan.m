function [zw,qw,wskaz,z,q]=ekspan(x0,d,zn,maxit)

% EKSPAN Metoda ekspansji na prostej o kierunku d, przechodz�cej
%        przez punkt x0.
% Dane: z(1)=0 - punkt startowy
%       zn - krok pocz�tkowy
%       alfa - wsp�czynnik ekspansji
%       maxit - maksymalna liczba krok�w ekspansji.
% Wyj�cie: wskaz=0 - ekspansja w lewo bez obramowania
%               =2 - ekspansja w lewo z obramowaniem
%               =1 - ekspansja w prawo bez obramowania
%               =3 = ekspansja w prawo z obramowaniem
%          zw - macierz wynikowych warto�ci argumentu:
%          zw(1) - lewy koniec przedzia�u nieokre�lono�ci
%          zw(2) - przybli�enie rozwi�zania optymalnego
%          zw(3) - prawy koniec przedzia�u nieokre�lono�ci
%          qw - macierz wynikowych warto�ci kosztu:
%               qw(i)=koszt(zw(i))
%          z - zawiera wszystkie warto�ci argumentu,
%              dla kt�rych wyliczono koszt (w kolejno�ci 
%              liczenia)
%          q - odpowiednia macierz warto�ci kosztu.
% Warto�ci wska�nika jako�ci wylicza si� w KOSZT.M.

alfa=3;
z=[0 zn];
qs=koszt(x0,0,d);
qn=koszt(x0,zn,d);
q=[qs qn];
if qn>=qs         % ekspansja w lewo
   wskaz=0;
   zn=-zn;
   for i=1:maxit      
      qn=koszt(x0,zn,d);
      z=[z zn];
      q=[q qn];
      if qn>=qs, wskaz=2;break,end
      qs=qn;
      zn=alfa*zn;      
   end  
else              % ekspansja w prawo
   wskaz=1;
   for i=1:maxit
      qs=qn;
      zn=alfa*zn;
      qn=koszt(x0,zn,d);
      z=[z zn];
      q=[q qn];
      if qn>=qs, wskaz=3;break,end
   end
end

k=length(z);
if wskaz==0
   zw=[-inf z(k) z(k-1)];
   qw=[nan q(k) q(k-1)];
elseif wskaz==1
   zw=[z(k-1) z(k) inf];
   qw=[q(k-1) q(k) nan];
elseif wskaz==2 & k==3
   zw=[z(3) 0 z(2)];
   qw=[q(3) q(1) q(2)];
elseif wskaz==2 & k==4
   zw=[z(4) z(3) 0];
   qw=[q(4) q(3) q(1)];
elseif wskaz==2 & k>4
   zw=[z(k) z(k-1) z(k-2)];
   qw=[q(k) q(k-1) q(k-2)];
elseif wskaz==3
   zw=[z(k-2) z(k-1) z(k)];
   qw=[q(k-2) q(k-1) q(k)];
end