clear , clc, close all

% X0=input("Ingrese el Valor de X0: ");
% Y0=input("Ingrese el Valor de Y0: ");
% Z0=input("Ingrese el Valor de Z0: ");
% r1=input("Ingrese el Valor de r1: ");
% r2=input("Ingrese el Valor de r2: ");
% r3=input("Ingrese el Valor de r3: ");
% al=input("Ingrese el Valor de alpha: ");
% te=input("Ingrese el Valor de tetha: ");
% la=input("Ingrese el Valor de lambda: ");
% X0=0.5;
% Y0=0.5;
% Z0=2.5;
% r3=0.01;
% r1=r3;
% r2=r1;
% al=220;
% te=50;
% la=0.035;
X0=0.5;
Y0=0.5;
Z0=2;
r3=0.01;
r1=r3;
r2=r1;
al=190;
te=20;
la=0.035;

p=zeros(3,8);
p(:,1)=[0.5,0.4,0];
p(:,2)=[0.5,0.6,0];
p(:,3)=[0.7,0.6,0];
p(:,4)=[0.7,0.4,0];
p(:,5)=[0.5,0.4,0.8];
p(:,6)=[0.5,0.6,0.8];
p(:,7)=[0.7,0.6,0.8];
p(:,8)=[0.7,0.4,0.8];

cd=zeros(2,8);

for i=1:8
    cd(1,i)=la*((p(1,i)-X0)*cosd(te)+(p(2,i)-Y0)*sind(te)-r1)/(-(p(1,i)-X0)*sind(te)*sind(al)+...
        (p(2,i)-Y0)*cosd(te)*sind(al)-(p(3,i)-Z0)*cosd(al)+r3+la);
    cd(2,i)=la*((p(1,i)-X0)*sind(te)*cosd(al)+(p(2,i)-Y0)*cosd(te)*cosd(al)+(p(3,i)-Z0)*sind(al)-r2)...
        /(-(p(1,i)-X0)*sind(te)*sind(al)+(p(2,i)-Y0)*cosd(te)*sind(al)-(p(3,i)-Z0)*cosd(al)+r3+la);  
end

disp(cd(:,:));

plot(cd(1,1:4),cd(2,1:4),'k')
hold on
plot(cd(1,5:8),cd(2,5:8),'k')
plot([cd(1,5) cd(1,8)],[cd(2,5) cd(2,8)],'k')
plot([cd(1,1) cd(1,4)],[cd(2,1) cd(2,4)],'k')
plot([cd(1,2) cd(1,6)],[cd(2,2) cd(2,6)],'k')
plot([cd(1,3) cd(1,7)],[cd(2,3) cd(2,7)],'k')
plot([cd(1,4) cd(1,8)],[cd(2,4) cd(2,8)],'k')
plot([cd(1,1) cd(1,5)],[cd(2,1) cd(2,5)],'k')