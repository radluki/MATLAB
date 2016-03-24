function [xn,qn,z,q]=prosta1(x0,d)

% PROSTA1 Metoda Gaussa - Seidela: przeszukiwanie prostej 
%         o kierunku d, przechodz�cej przez punkt x0.
global max_it_zlo
global max_it_apr
[zw,qw,wskaz,z,q]=ekspan(x0,d,.01,20);
if wskaz>1
    if max_it_zlo>0
   [zw,qw,z,q]=zlopod(x0,d,zw,qw,max_it_zlo,z,q);
    end
   if max_it_apr>0
    [zw,qw,z,q]=apropa(x0,d,zw,qw,max_it_apr,z,q);
   end
   i=2;
end
if wskaz==0,i=1;
elseif wskaz==1,i=3;
end
xn=x0+zw(i)*d;
qn=qw(i);


