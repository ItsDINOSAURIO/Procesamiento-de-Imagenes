% clear , clc, close all

% X0=input("Ingrese el Valor de X0: ");
% Y0=input("Ingrese el Valor de Y0: ");
% Z0=input("Ingrese el Valor de Z0: ");
% r1=input("Ingrese el Valor de r1: ");
% r2=input("Ingrese el Valor de r2: ");
% r3=input("Ingrese el Valor de r3: ");
% al=input("Ingrese el Valor de alpha: ");
% te=input("Ingrese el Valor de tetha: ");
% la=input("Ingrese el Valor de lambda: ");
X0=2;
Y0=3;
Z0=7;
r3=0.01;
r1=r3;
r2=r1;
al=180;
te=0;
la=0.035;

p=zeros(3,8);

p(:,1)=[1,0,0];
p(:,2)=[1,1,0];
p(:,3)=[5,1,0];
p(:,4)=[5,0,0];
p(:,5)=[1,0,4];
p(:,6)=[1,1,4];
p(:,7)=[5,1,4];
p(:,8)=[5,0,4];

% Cono
[X, Y, Z]=cylinder([1.5,0],150);
figure, mesh(X+2,Y+3,Z*5),hold on
vp=[X(:),Y(:),Z(:)];

xlabel("Eje x"),ylabel("Eje y"),zlabel("Eje z")
% Prisma
plot3(p(1,1:4),p(2,1:4), p(3,1:4), 'b-')
plot3(p(1,5:8),p(2,5:8), p(3,5:8), 'b-')
plot3([p(1,5) p(1,8)],[p(2,5) p(2,8)], [p(3,5) p(3,8)], 'b-')
plot3([p(1,1) p(1,4)],[p(2,1) p(2,4)], [p(3,1) p(3,4)], 'b-')
plot3([p(1,2) p(1,6)],[p(2,2) p(2,6)], [p(3,2) p(3,6)], 'b-')
plot3([p(1,5) p(1,1)],[p(2,5) p(2,1)], [p(3,5) p(3,1)], 'b-')
plot3([p(1,7) p(1,3)],[p(2,7) p(2,3)], [p(3,7) p(3,3)], 'b-')
plot3([p(1,4) p(1,8)],[p(2,4) p(2,8)], [p(3,4) p(3,8)], 'b-')


% Cámara
plot3(X0, Y0, Z0, 'g*');

% Foto prisma
cd=zeros(2,8);

for i=1:8
    cd(1,i)=1e3 .* (la)*((p(1,i)-X0)*cosd(te)+(p(2,i)-Y0)*sind(te)-r1)/(-(p(1,i)-X0)*sind(te)*sind(al)+...
        (p(2,i)-Y0)*cosd(te)*sind(al)-(p(3,i)-Z0)*cosd(al)+r3+la);
    cd(2,i)=1e3 .* la*((p(1,i)-X0)*sind(te)*cosd(al)+(p(2,i)-Y0)*cosd(te)*cosd(al)+(p(3,i)-Z0)*sind(al)-r2)...
        /(-(p(1,i)-X0)*sind(te)*sind(al)+(p(2,i)-Y0)*cosd(te)*sind(al)-(p(3,i)-Z0)*cosd(al)+r3+la);  
end

disp(cd(:,:));

figure, plot(cd(1,1:4),cd(2,1:4),'k')
xlabel("Eje x"),ylabel("Eje y")
hold on
plot(cd(1,5:8),cd(2,5:8),'k')
plot([cd(1,1) cd(1,4)],[cd(2,1) cd(2,4)],'k')
plot([cd(1,5) cd(1,8)],[cd(2,5) cd(2,8)],'k')
plot([cd(1,2) cd(1,6)],[cd(2,2) cd(2,6)],'k')
plot([cd(1,1) cd(1,5)],[cd(2,1) cd(2,5)],'k')
plot([cd(1,3) cd(1,7)],[cd(2,3) cd(2,7)],'k')
plot([cd(1,4) cd(1,8)],[cd(2,4) cd(2,8)],'k')

%Foto cono
[m, n] = size(vp);
cc=zeros(2,m);

for i=1:m
    cc(1,i)=1e3 .* la.*((vp(i,1)-X0).*cosd(te)+(vp(i,2)-Y0).*sind(te)-r1)./(-(vp(i,1)-X0).*sind(te).*sind(al)+...
        (vp(i,2)-Y0).*cosd(te).*sind(al)-(vp(i,3)-Z0).*cosd(al)+r3+la);
    cc(2,i)=1e3 .* la.*((vp(i,1)-X0).*sind(te).*cosd(al)+(vp(i,2)-Y0).*cosd(te).*cosd(al)+(vp(i,3)-Z0).*sind(al)-r2)...
        ./(-(vp(i,1)-X0).*sind(te).*sind(al)+(vp(i,2)-Y0).*cosd(te).*sind(al)-(vp(i,3)-Z0).*cosd(al)+r3+la);   
end

% for i=1:m
    x=1e3 .* la.*((X-X0).*cosd(te)+(Y-Y0).*sind(te)-r1)./(-(Z-X0).*sind(te).*sind(al)+...
        (Y-Y0).*cosd(te).*sind(al)-(Z-Z0).*cosd(al)+r3+la);
    y=1e3 .* la.*((X-X0).*sind(te).*cosd(al)+(Y-Y0).*cosd(te).*cosd(al)+(Z-Z0).*sind(al)-r2)...
        ./(-(X-X0).*sind(te).*sind(al)+(Y-Y0).*cosd(te).*sind(al)-(Z-Z0).*cosd(al)+r3+la);   
% end
plot(x,y), shading interp