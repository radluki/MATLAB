% GRANAD Zawiera nast�puj�ce metody gradientowe:
%        - najszybszego spadku (par=0)
%        - Fletchera - Reevesa (par=1)
%        - Polaka - Ribiere'a  (par=2)
%        - z pe�n� formu�� na wsp�czynnik beta (par=3).
% Oznaczenia: maxit - maksymalna liczba iteracji g�rnego poziomu
%             x0 - aktualne przybli�enie rozwi�zania optymalnego
%             e0 - metoda si� zatrzymuje, gdy kwadrat normy gradientu
%                  n2 spadnie poni�ej e0
%             g - gradient
%             d - kierunek poszukiwania
%             czod - cz�sto�� odnowy.

% maxit=200;
% x0=[-2;3];
% e0=1e-8;
% par = 0
% global a
% global zad
% global rodz_grad
% rodz_grad=0;
% zad = 5
% a = 1

czod=2*length(x0);
wskaz=0;
punkty = [x0];

tic
for i=1:maxit
   g=gradie(x0);
   n2=g'*g;
   if n2<e0,break,end
   if ~par|rem(i,czod)==1|~wskaz
      d=-g;
   else
      if par==1
         beta=n2/ns2;
      elseif par==2
         beta=g'*(g-gs)/ns2;         
      elseif par==3
         beta=g'*(g-gs)/(d'*(g-gs));
      elseif par == 0
         beta=0;
      end
      d=-g+beta*d;
   end % wyznaczenie d, kierunku poszukiwań
   
   if d'*g<0 
      ns2=n2; 
      gs=g;
      [x0,wskaz]=kierun(x0,d); % minimum na kierunku d
   else
      wskaz=0;
   end
   punkty = [punkty x0];
end  
czas = toc
rysuj(punkty,par,czas)

    
