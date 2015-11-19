clear
figure(1)
syms x y z
z=2*x^2+3*y^2;
ezmesh(z)
title('Funcion f(x,y)')
xlabel('eje x')
ylabel('eje y')
zlabel('eje z')
% clear;close
% figure(1)
% [x,y] = meshgrid(-2:.2:2, -2:.1:2);
% z=400-3*(x.^2).*y.^2;
% [f,g]=gradient(z,1,-2);
% quiver(f,g)
% title('Gradiente en P(1,-2) de f(x,y)')
figure(2)
syms x y z
z=400-3*(x.^2)*y.^2;
ezmesh(z)
title('Funcion f(x,y)')
xlabel('eje x')
ylabel('eje y')
zlabel('eje z')


% figure(5)
% [x,y] = meshgrid(-2:.2:2, -2:.2:2);
% z=(x.^2)*y.^3;
% [f,g]=gradient(z,2,3);
% contour(z)
% hold on
% quiver(f,g)
% hold off
% title('Gradiente en P(2,3) de f(x,y)')
figure(3)
syms x y z
z=(x.^2)*y.^3;
ezmesh(z)
title('Funcion f(x,y)')
xlabel('eje x')
ylabel('eje y')
zlabel('eje z')
figure(4)
z=4+x*sin(y);
ezmesh(z)
title('Funcion f(x,y)')
xlabel('eje x')
ylabel('eje y')
zlabel('eje z')
figure(5)
z=sqrt((26-(4*x^2+y^2))/2);
ezmesh(z)
title('Funcion f(x,y)')
xlabel('eje x')
ylabel('eje y')
zlabel('eje z')


