function [xn,qn,tn]=prosta1(x0,d)

% PROSTA1 Przeszukiwanie prostej o kierunku d,
%         przechodz�cej przez punkt x0.

[zw,qw,wskaz,z,q]=ekspan(x0,d,1,10);
if wskaz>1
   [zw,qw,z,q]=zlopod(x0,d,zw,qw,5,z,q);
   [zw,qw,z,q]=apropa(x0,d,zw,qw,1,z,q);
   i=2;
end
if wskaz==0,i=1;
elseif wskaz==1,i=3;
end
tn=zw(i);
xn=x0+tn*d;
qn=qw(i);
