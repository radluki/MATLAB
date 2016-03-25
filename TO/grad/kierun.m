function [x0,wskaz]=kierun(x0,d)

% KIERUN Przeszukuje kierunek d wychodz�c z punktu x0.

[zw,qw,wskaz,z,q]=ekskon(x0,d,1,3,1e-8);
if wskaz>1
   [zw,qw,z,q]=zlopod(x0,d,zw,qw,5,z,q);
   [zw,qw,z,q]=apropa(x0,d,zw,qw,1,z,q);
end
if wskaz>0   
   x0=x0+zw(2)*d;
end