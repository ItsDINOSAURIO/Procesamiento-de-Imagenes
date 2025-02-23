clc, clear, close all

vd=VideoReader('caminata_1.mp4');  %   Crea un objeto de lectura de video.
cd=read(vd); %se utiliza para leer los cuadros (frames) de un archivo de video. 

[X, Y, Z, W]=size(cd); %Filas, columanas, canales de color y numero de cuadros en el video


bn=zeros(X,Y,W);
G=zeros(X,Y,W);
O=zeros(X,Y,W);
B=zeros(X,Y,W);

for k=1:W
    for i=1:X
        for j=1:Y 
            if cd(i,j,1,k)<=140 && cd(i,j,2,k)>=190  %Bolita verde  
                bn(i,j,k)=255;
                G(i,j,k)=255;
            elseif cd(i,j,1,k)>=220 && cd(i,j,2,k)<=200 %Bolita naranja
                bn(i,j,k)=255;
                O(i,j,k)=255;
            elseif  cd(i,j,1,k)<=130 && cd(i,j,2,k)>=160 && cd(i,j,3,k)>=130 %bolita azul
                bn(i,j,k)=255;  
                B(i,j,k)=255;
            end 

        end
    end
end 

figure, imshow(B(:,:,1)/255);
figure, imshow(G(:,:,1)/255);
figure, imshow(O(:,:,1)/255);
figure, imshow(bn(:,:,1)/255);

% Centroides
AZ=zeros(W,2);
VR=zeros(W,2);
NJ=zeros(W,2);

for i=1:W

    cB = regionprops(B(:,:,i),'centroid'); %Mide la imagen y obtiene el centro
    cG = regionprops(G(:,:,i),'centroid');
    cO = regionprops(O(:,:,i),'centroid');

    cdB = cat(1,cB.Centroid);   %Extrae los centroides de la imagen
    cdG = cat(1,cG.Centroid);
    cdO = cat(1,cO.Centroid);

    cfB=cdB(cdB>0);  %Elige el centroide más apto
    cfG=cdG(cdG>0);
    cfO=cdO(cdO>0);

    NJ(i,1)=cfB(1);          % Guarda el centroide en naranja
    NJ(i,2)=cfB(2);

    if isempty(cfG)==1
       VR(i,1)=VR(i-1,1);
       VR(i,2)=VR(i-1,2);
    else
       VR(i,1)=cfG(1);     % Guarda el centroide calculado en verde
       VR(i,2)=cfG(2);
    end
    
    if isempty(cfO)==1
       NJ(i,1)=NJ(i-1,1);
       NJ(i,2)=NJ(i-1,2);
    else
       NJ(i,1)=cfO(1);     % Guarda el centroide calculado en azul
       NJ(i,2)=cfO(2);
    end
end


% Gráficas
cad=zeros(W,1);
aux=zeros(W,1);
rod=zeros(W,1);

for i=1:W
    cad(i)=atand((VR(i,1)-AZ(i,1))/((VR(i,2)-AZ(i,2))));
    aux(i)=atand((NJ(i,1)-VR(i,1))/((NJ(i,2)-VR(i,2))));
    rod(i)=cad(i)-aux(i);
end

X=linspace(0,100,W);  

figure
subplot(1,2,1)
plot(X,cad),title('Cinemática de la cadera en un ciclo'), xlabel('Porcentaje del ciclo de marcha'), ylabel('ángulo de giro')
subplot(1,2,2)
plot(X,rod),title('Cinemática de la rodilla en un ciclo'),xlabel('Porcentaje del ciclo de marcha'), ylabel('ángulo de giro')