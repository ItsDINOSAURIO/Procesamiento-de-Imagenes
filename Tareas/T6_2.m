clear,clc,close

% Entradas y Variables

X0 = input('Posicion en X0: '); 
Y0 = input('Posicion en Y0: ');
Z0 = input('Posicion en Z0: ');

theta = input('Angulo Theta: ');
alpha = input('Angulo Alfa: ');
% 
% X0=2;
% Y0=3;
% Z0=7;
% alpha=180;
% theta=0;
lambda=0.035;
r=0;
r1=0;
r2=0;
r3=0;

% Figuras

Xp = [1 5 5 1 1 5 5 1 1 5 5 5 5 1 1 1 1 1];
Yp = [0 0 1 1 1 1 0 0 0 0 0 1 1 1 1 0 0 1];
Zp = [0 0 0 0 4 4 4 4 0 0 4 4 0 0 4 4 0 0];

[Xc,Yc,Zc] = cylinder([1.5,0],100);
Xc = Xc + 2; Yc = Yc + 3;
h = 5; Zc = Zc*h;

% Conversion prisma

len = length(Xp);

xuno = zeros(1, len);
yuno = zeros(1, len);

for i=1:len
    xuno(i) = lambda*(((Xp(i)-X0)*cosd(theta) + (Yp(i)-Y0)*sind(theta)-r1)/(-(Xp(i)-X0)*sind(theta)*sind(alpha)+(Yp(i)-Y0)*cosd(theta)*sind(alpha)-(Zp(i)-Z0)*cosd(alpha)+r3+lambda));
    yuno(i) = lambda*(((Xp(i)-X0)*sind(theta)*cosd(alpha) + (Yp(i)-Y0)*cosd(theta)*cosd(alpha)+(Zp(i)-Z0)*sind(alpha)-r2)/(-(Xp(i)-X0)*sind(theta)*sind(alpha)+(Yp(i)-Y0)*cosd(theta)*sind(alpha)-(Zp(i)-Z0)*cosd(alpha)+r3+lambda));
end

% xuno = 1e3 .* xuno;
% yuno = 1e3 .* yuno;

% Conversion Cono

% xcono = 1e3 .* lambda .* (( (Xc-X0).*cosd(theta) + (Yc-Y0).*sind(theta) - r ) ./ ( - (Xc-X0).*sind(theta).*sind(alpha) + (Yc-Y0).*cosd(theta).*sind(alpha) - (Zc-Z0).*cosd(alpha) + r + lambda ));
% ycono = 1e3 .* lambda .* (( (Xc-X0).*sind(theta).*cosd(alpha) + (Yc-Y0).*cosd(theta).*cosd(alpha) + (Zc-Z0).*sind(alpha) - r ) ./ ( - (Xc-X0).*sind(theta).*sind(alpha) + (Yc-Y0).*cosd(theta).*sind(alpha) - (Zc-Z0).*cosd(alpha) + r + lambda ));
xcono = lambda .* (( (Xc-X0).*cosd(theta) + (Yc-Y0).*sind(theta) - r ) ./ ( - (Xc-X0).*sind(theta).*sind(alpha) + (Yc-Y0).*cosd(theta).*sind(alpha) - (Zc-Z0).*cosd(alpha) + r + lambda ));
ycono = lambda .* (( (Xc-X0).*sind(theta).*cosd(alpha) + (Yc-Y0).*cosd(theta).*cosd(alpha) + (Zc-Z0).*sind(alpha) - r ) ./ ( - (Xc-X0).*sind(theta).*sind(alpha) + (Yc-Y0).*cosd(theta).*sind(alpha) - (Zc-Z0).*cosd(alpha) + r + lambda ));


% Plots

subplot(1,2,1), plot3(Xp,Yp,Zp), hold on, surf(Xc,Yc,Zc), shading interp, hold on, scatter3(X0,Y0,Z0,'filled')
grid on, xlabel("X"), ylabel("Y"), zlabel("Z"), title('Grafica 3D')

subplot(1,2,2), plot(xcono,ycono), shading interp, hold on, plot(xuno,yuno), shading interp
xlabel("X"), ylabel("Y"), grid on