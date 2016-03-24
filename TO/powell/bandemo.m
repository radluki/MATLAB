%BANDEMO Banana function minimization demonstration. 
% 	 
%   This script-file demonstrates the minimization of the  
%   the banana function:   
%     
%           f(x)= 100*(x(2)-x(1)^2)^2+(1-x(1))^2  
%  
%   It is called the banana function because of the way the   
%   curvature bends around the origin (also called Rosenbrock's  
%   function). It is notorious in optimization examples because  
%   of the slow convergence with which most methods exhibit  
%   when trying to solve this  problem.  
%  
%   This function has a unique minimum at the point X=[1,1] f(x)=0.  
%   We demonstrate here a number of techniques for its minimization  
%   starting at the point X=[-1.9,2].  
%  
 
echo off 
clc 
help bandemo 
disp(' Strike any key for a mesh plot of the banana function') 
xx = [-2:0.125:2]'; 
yy = [-1:0.125:3]'; 
[x,y]=meshgrid(xx',yy') ; 
meshd = 100.*(y-x.*x).^2 + (1-x).^2;  
pause 
mesh(meshd) 
 
disp('') 
disp(' Strike any key for a contour plot of the banana function') 
pause 
clf 
conts = exp(3:20); 
contour(xx,yy,meshd,conts,'w--')  
xlabel('x1') 
ylabel('x2') 
title('Minimization of the Banana function') 
drawnow; % Draws current graph now  
hold on 
plot(-1.9,2,'o') 
text(-1.9,2,'Start Point') 
plot(1,1,'o') 
text(1,1,'Solution') 
disp('Please wait - compiling optimization routines') 
 
% test_long is a variable used for auto testing of this routine 
if ~exist('test_long')  test_long = 0; end 
if exist('method')~= 1 method = 7; end 
if ~length(method) method = 7; end 
l = 2; 
 
while 1 
	if ~test_long 
		clc 
		disp(' ') 
		disp('   Choose any of the following methods to minimize the banana function') 
		disp('')         
		disp('        UNCONSTRAINED:    1) Broyden-Fletcher-Golfarb-Shanno') 
		disp('                          2) Davidon-Fletcher-Powell') 
		disp('                          3) Steepest Descent') 
		disp('                          4) Simplex Search') 
		disp('         LEAST SQUARES:   5) Gauss-Newton') 
		disp('                          6) Levenberg-Marquardt ') 
		disp('') 
		disp('                          0) Quit') 
	end 
 
	if test_long 
		if l>=2 
		    method=method-1; 
		    l = 0; 
		end 
	else 
		method=-1; 
	end 
	while  (method < 0) | (method > 6)  
		method = []; 
		while ~length(method)  
          
         method = input('Select a method number: '); 
		end 
	end 
	if (method == 0)  
		hold off 
		return 
	end 
	OPTIONS=0; 
	if method==2, OPTIONS(6)=1; 
	elseif method==3, OPTIONS(6)=2; 
	elseif method==5, OPTIONS(5)=1; 
	end 
	if test_long 
		l = l + 1; 
	else 
		l = []; 
	end 
	if method~=4 
		disp('') 
		disp('    Choose any of the following line search methods') 
		disp('') 
		disp('           1) Mixed Polynomial Interpolation') 
		disp('           2) Cubic Interpolation') 
		disp('') 
		while ~length(l) 
		    l = input('Select a line search number: '); 
		end 
		if l==2, OPTIONS(7)=1; end 
	end 
	if method~=4 
		OPTIONS(14)=200; 
	else 
		OPTIONS(14)=300; 
	end 
	x=[-1.9,2]; 
	disp(' ') 
	if method<4 
		GRAD='[100*(4*x(1)^3-4*x(1)*x(2))+2*x(1)-2; 100*(2*x(2)-2*x(1)^2); banplot(x,OLDX)]'; 
		f='100*(x(2)-x(1)^2)^2+(1-x(1))^2'; 
		disp('[x, options] = fminu(f,x,OPTIONS,GRAD);') 
		[x, options] = fminu(f,x,OPTIONS,GRAD); 
	elseif method==4 
		f='[100*(x(2)-x(1)^2)^2+(1-x(1))^2; banplot2(x)]'; 
		disp('[x, options]=fmins(f,x,OPTIONS);') 
		[x, options]=fmins(f,x,OPTIONS); 
	else 
		GRAD='[-20*x(1), -1; 10, 0; banplot(x,OLDX)]'; 
		f='[10*(x(2)-x(1)^2),(1-x(1))]'; 
		disp('[x,options]=leastsq(f,x,OPTIONS,GRAD);') 
		[x,options]=leastsq(f,x,OPTIONS,GRAD); 
	end 
	if test_long 
		if OPTIONS(8)-100*(method==3) > 1e-8, error('Optimization Toolbox in datdemo'), end 
	end 
 
	disp(sprintf('\nValue of the function at the solution: %g', options(8)) );  
	disp(sprintf('Number of function evaluations: %g', options(10)) );  
	disp(sprintf('Number of gradient evaluations: %g\n\n', options(11)) );  
	disp('Strike any key for menu') 
	pause 
	clf 
	hold off 
        contour(xx,yy,meshd,conts,'w--')  
	xlabel('x1') 
	ylabel('x2') 
	title('Minimization of the Banana function') 
	hold on 
	plot(-1.9,2,'o') 
	text(-1.9,2,'Start Point') 
	plot(1,1,'o') 
	text(1,1,'Solution') 
end 


