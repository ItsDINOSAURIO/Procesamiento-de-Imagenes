% clear, close all, clc
% 
% [x, loc] = uigetfile({'*.png;*.jpg;*.jpeg', 'Image Files (*.png, *.jpg, *.jpeg)'}, 'Select a file', 'D:\Upiita\5to\PDI\');
% rgbtogray 
% [X,Y]=size(g);
% ni = zeros(X,Y);
% 
% imshow(g/255)
% [y,x] = ginput(1)

is = round(xBar); %coordenada en x
js = round(yBar); %coordenada en y
s = g(is,js);

% P = input('Ingresa el valor de P: ');
P=60;
ni(is,js) = 1;

%BUSQUEDA HORIZONTAL
 
%Busqueda al lado izquierdo de la semilla

i_izq = is;
j_izq = js-1;

while j_izq >= 1
    pixel1 = g(i_izq,j_izq);
    dist1 = abs(pixel1-s);
    if (dist1 <= P)
        ni(i_izq,j_izq) = 1;
       
        %Busqueda hacia arriba
        i_arriba = i_izq-1;
        while i_arriba >= 1
            pixel2 = g(i_arriba,j_izq);
            dist2 = abs(pixel2-s);
            if (dist2 <= P)
                ni(i_arriba,j_izq) = 1;
                i_arriba = i_arriba-1;
            else
                break
                    
            end
        end

        %Busqueda hacia abajo
        i_abajo = i_izq+1;
        while i_abajo <= X
            pixel2 = g(i_abajo,j_izq);
            dist2 = abs(pixel2-s);
            if (dist2 <= P)
                ni(i_abajo,j_izq) = 1;
                i_abajo = i_abajo+1;
            else
                break
            end
        end
        j_izq = j_izq - 1;
        
    else
        break
    end
        
end

%Busqueda al lado derecho de la semilla
i_der = is;
j_der = js+1;

while j_der <= Y
    pixel1 = g(i_der,j_der);
    dist1 = abs(pixel1-s);
    if (dist1 <= P)
        ni(i_der,j_der) = 1;
       
        %Busqueda hacia arriba
        i_arriba = i_der-1;
        while i_arriba >= 1
            pixel2 = g(i_arriba,j_der);
            dist2 = abs(pixel2-s);
            if (dist2 <= P)
                ni(i_arriba,j_der) = 1;
                i_arriba = i_arriba-1;
            else
                break
            end
        end

        %Busqueda hacia abajo
        i_abajo = i_der+1;
        while i_abajo <= X
            pixel2 = g(i_abajo,j_der);
            dist2 = abs(pixel2-s);
            if (dist2 <= P)
                ni(i_abajo,j_der) = 1;
                i_abajo = i_abajo+1;
            else
                break
            end
        end
        j_der = j_der + 1;
        
    else
        break
    end
        
end

%BUSQUEDA VERTICAL

%Busqueda hacia arriba de la semilla

i_arr = is-1;
j_arr = js;

while i_arr >= 1
    pixel1 = g(i_arr,j_arr);
    dist1 = abs(pixel1-s);
    if (dist1 <= P)
        ni(i_arr,j_arr) = 1;
        
        %Busqueda hacia la izquierda
        j_izquierda = j_arr-1;
        while j_izquierda >= 1
            pixel2 = g(i_arr,j_izquierda);
            dist2 = abs(pixel2-s);

             if (dist2 <= P)
                ni(i_arr,j_izquierda) = 1;
                j_izquierda = j_izquierda-1;
            else
                break
                    
            end
        end
        
        %Busqueda a la derecha
        j_derecha = j_arr+1;
        while j_derecha <= Y
            pixel2 = g(i_arr,j_derecha);
            dist2 = abs(pixel2-s);

             if (dist2 <= P)
                ni(i_arr,j_derecha) = 1;
                j_derecha = j_derecha+1;
            else
                break
                    
            end
        end

        i_arr = i_arr - 1;
    else
        break
    end
end

%Busqueda hacia abajo de la semilla

i_ab = is+1;
j_ab = js;

while i_ab <= X
    pixel1 = g(i_ab,j_ab);
    dist1 = abs(pixel1-s);
    if (dist1 <= P)
        ni(i_ab,j_ab) = 1;
        
        %Busqueda hacia la izquierda
        j_izquierda = j_ab-1;
        while j_izquierda >= 1
            pixel2 = g(i_ab,j_izquierda);
            dist2 = abs(pixel2-s);

             if (dist2 <= P)
                ni(i_ab,j_izquierda) = 1;
                j_izquierda = j_izquierda-1;
            else
                break
                    
            end
        end
        
        %Busqueda a la derecha
        j_derecha = j_ab+1;
        while j_derecha <= Y
            pixel2 = g(i_ab,j_derecha);
            dist2 = abs(pixel2-s);

             if (dist2 <= P)
                ni(i_ab,j_derecha) = 1;
                j_derecha = j_derecha+1;
            else
                break
                    
            end
        end

        i_ab = i_ab + 1;
    else
        break
    end
end

subplot(1,2,1)
hold on
imshow(g/255)
plot(js,is,'c*')
hold off
title("Semilla seleccionada")

subplot(1,2,2)
imshow(ni)
title("Región encontrada")

sgtitle("Crecimiento de región")