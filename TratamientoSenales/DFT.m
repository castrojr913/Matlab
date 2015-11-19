syms n
x=input('función x[n]: ');
y1=symsum(x,n,-inf,inf);
syms w
y2=exp(-i*w);
disp(' ')
y=simple(y1*y2)
pretty(y)