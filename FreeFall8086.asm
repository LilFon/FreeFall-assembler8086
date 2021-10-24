.model medium


.data  
     
;variable que guarda la vida del jugador            
vida db 1 

;variable utilizada para la seleccion de la dificultad            
opcion db 0          

;variables utilizadas para almacenar numeros aleatorios  
lugar : dw ?, 0ah,"$"
letras: db "q","$", "w","$","e","$","r","$","t","$","y","$","u","$","i","$","o","$","p","$"


;Textos de la presentacion del juego
teclaC: db "Presione una tecla para continuar !!",13,10,"$"                 
titulo: db "Bienvenido a",13,10,"Free Fall",13,10,"$" 
menu: db "Seleccione una Dificultad:",13,10,"1.Facil 2.Media 3.Dificil 4.Extra",13,10,"$" 
uno: db "Selecciono la opcion 1",13,10,"$" 
dos: db "Selecciono la opcion 2",13,10,"$" 
tres:db "Selecciono la opcion 3",13,10,"$" 
ext: db "Selecciono la opcion Extra",13,10,"$"
 
x db 0
y db 0 
num: db 0




.code 


  ;Imprime numero 
   
  number macro num
    mov dl,num +48               ;guarda en el registro la posicion en la tabla ascii de el numero que elegiste
    mov ah,02h                   ;guarda en el registro la instruccion para imprimir el numero     
    
    int 21h 
    
  endm
  
  ;Imprime texto deseado  
  
  imprime macro string
    
    mov dx, string               ;guarda en el registro el string a imprimir      
  
    mov ah,9                     ;guarda en el registro la instruccion para imprimir
  
    int 21h 
    
  endm 
  
  ;Limpiar pantalla  
  
  limpia macro
    
    mov ax,0600h  ;funcion
    mov bh,07h    ;color letra:amarillo,fondo: verde
    mov cx,0000h  ;posicionamiento del cursor
    mov dh,25     ;filas hasta donde llegara el color
    mov dl,79     ;columnas hasta donde llegara el color
    int 10h    
                              ;limpia absolutamente toda la pantalla y vuelve a su fondo negro original
    
    
    
  endm
  
  
  
  
  ;Presiona una tecla para continuar (funcion)
     
  teclaContinuar macro 
    
    imprime teclaC                 
    
    mov ax,0c07h                 ;guarda en el registro la instruccion para aguardar una tecla 
    
    int 21h
      
      
  endm  
  
  
  ;Imprime caracter en una ubicacion determinada
  
  imprimeLocation macro texto,x,y  
    
   
    mov ah,02h                  
    mov bh,00d
    mov dh,x
    mov dl,y
  
    int 10h
  
    imprime texto
    
  endm 
  
  
  
  ;Lee un caracter ingresado por el usuario en la pantalla
   
  lee macro
    
    mov ah,01h
    int 21h
    sub al,30h
    mov opcion,al   
    int 21h
    sub al,30h
    mov cl,al 
    
  endm 
  
  ;Genera numero random
  
  random macro numero 
    
    mov ah,2ch
    int 21h
    xor ax,ax
    mov dh,01h
    add ax,dx
    aaa
    add ax,3030h
    mov numero,ax 
    
    
  endm 
  
 
 
  
  
  
  
  
  ;Genera Letra/numero en la pantalla 
  
  genera macro 
       
       
       
       bucle:
        
         
        
        
        
        inc x  
        desplaza x,0 
        inc x
        
        imprimeLocation letras[0],x,0 
        
        inc x  
        desplaza x,0 
        inc x
        
        imprimeLocation letras[0],x,0 
        
        
        
        inc x  
        desplaza x,5 
        inc x 
        
        imprimeLocation letras[2],x,5 
        
        inc x  
        desplaza x,10 
        inc x 
        
        imprimeLocation letras[4],x,10 
        
        inc x  
        desplaza x,10 
        inc x 
        
        imprimeLocation letras[4],x,10
        
        inc x  
        desplaza x,10 
        inc x 
        
        imprimeLocation letras[4],x,10
        
        dec x
        inc x  
        desplaza x,15 
        inc x 
        
        imprimeLocation letras[6],x,15
        
        dec x
        
        inc x  
        desplaza x,20 
        inc x 
        
        imprimeLocation letras[8],x,20 
        
        dec x
        dec x
        
        
        inc x  
        desplaza x,25 
        inc x  
        
        imprimeLocation letras[10],x,25
        
        inc x  
        desplaza x,25 
        inc x 
        
        imprimeLocation letras[10],x,25
        
        inc x  
        desplaza x,30 
        inc x  
        
        imprimeLocation letras[12],x,30 
        
        
        dec x
        desplaza x,35 
        inc x
        imprimeLocation letras[14],x,35 
        
        
        desplaza x,40 
        
        imprimeLocation letras[14],x,35
        
        inc x
        desplaza x,45 
        inc x
        imprimeLocation letras[16],x,45 
        
        dec x
        desplaza x,50
        inc x
        imprimeLocation letras[18],x,50
     
        
        
        
        
         
        
        
        
        
        
        
        
             
        
        
        
        
         
         
        
        
        
      
      
             
        
       cmp vida,0
       je salir
       
       ;pregunta si presiono 
       
       jmp bucle
       
  endm
  
  
  ;Retrasa el proceso 
  
  sleep macro  
    
    mov     cx, 3h
    mov     dx, 4240h
    mov     ah, 86h
    int     15h 
    
  endm
  
  
  
  
  ;Desplazar letra/numero
  
  desplaza macro x,y 
    
   
    
    mov ah,06h 
    mov al,00h
    mov dh,x
    mov dl,y
    int 10h 
    
    
  endm
 
  ;Color letra 
  
  Color macro
    
    mov ax,0600h  ;funcion
    mov bh,27h    ;color letra:amarillo,fondo: verde
    mov cx,0000h  ;posicionamiento del cursor
    mov dh,25     ;filas hasta donde llegara el color
    mov dl,79     ;columnas hasta donde llegara el color
    int 10h 
     
  endm 
  
  Color2 macro 
    
    mov ax,0600h  ;funcion
    mov bh,57h    ;color letra:amarillo,fondo: verde
    mov cx,0000h  ;posicionamiento del cursor
    mov dh,10     ;filas hasta donde llegara el color
    mov dl,79     ;columnas hasta donde llegara el color
    int 10h 
     
  endm
  
  
  
  
  
  
  
  
  
  
        
  ;inicio Programa

  .startup  
  
  
 
    
    ;asignamos el color de la consola y de las letras    
  
    Color                           
    Color2 
    
    ;mostramos la presentacion del juego
    
    imprime titulo
    teclaContinuar
    Color
    Color2
    imprimeLocation menu,0,0  
    
    ;leemos opcion ingresada por el usuario referente al tipo de dificultad que escogio 
    
    lee
        
    ;en base a dicha opcion ingresada comparamos para saber a que dificultad enviar al usuario
    
    cmp opcion,1
    
    je opcion1
    
    cmp opcion,2
    
    je opcion2  
    
    cmp opcion,3
    
    je opcion3
    
    cmp opcion,4
    
    je extra
    
    
  
  salir:
  
  .exit 
  
  
  ;Opcion facil del juego
  opcion1: 
  
  imprime uno 
  teclaContinuar 
  limpia 
  
  genera 
  
  
    
  
  .exit
  
  
  
  ;Opcion media del juego
  opcion2:
  
  imprime dos 
  teclaContinuar
  limpia
  
  
  
  
  
  
  
  
  
  
  .exit
  
  
  ;Opcion dificil del juego
  opcion3: 
  
  imprime tres 
  teclaContinuar 
  limpia
  
  
  .exit
  
  
  
 
  ;Opcion extra del juego
  extra:
  
  imprime ext
  teclaContinuar 
  limpia
  
   
  
  .exit
  
  

end




