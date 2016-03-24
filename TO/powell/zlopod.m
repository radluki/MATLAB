function [zw,qw,z,q]=zlopod(x0,d,zw,qw,maxit,z,q)

% ZLOPOD Metoda z³otego podzia³u z punktem wewnêtrznym.
% Dane: tau - wspó³czynnik z³otego podzia³u
%       zw(1) - lewy koniec przedzia³u nieokreœlonoœci
%       zw(2) - punkt wewnêtrzny
%       zw(3) - prawy koniec przedzia³u nieokreœlonoœci
%       qw(i) - wartoœæ wskaŸnika jakoœci w punkcie zw(i)
%       maxit - liczba kroków.
% Wartoœci wskaŸnika jakoœci wylicza siê w KOSZT.M.

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
     