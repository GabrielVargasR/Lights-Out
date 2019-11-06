; Autor: Gabriel Vargas Rodríguez - 2018103129
; Arquitectura de Computadores - Grupo 2




; -------- Manual de usuario ----------


; -------- Análisis de resultados ---------



datos segment

  nom db "lvl001.txt$", 0
  handle dw ?
  cont db 30 dup(?)

  contador dw 1

datos ends


pila segment stack 'stack'

   dw 256 dup (?)

pila ends


codigo segment

   assume  cs:codigo, ds:datos, ss:pila


cambiaNom proc
    push ax
    push cx
    push di

    normal:
    xor ah, ah
    xor di, di
    mov di, 3
    mov ax, contador
    mov cx, 10

    cmp ax, 10
    jl unDigito
    cmp ax, 100
    jl dosDigitos

    div cl; contador / 10
    add ah, 30h; para ascii
    mov byte ptr [nom + 6], ah; último dígito queda en el ah
    xor ah, ah; queda solo al en el ax
    div cl; cociente de contadorNivel / 10
    add al, 30h
    mov byte ptr [nom + di], al
    inc di
    add ah, 30h
    mov byte ptr [nom + di], ah
    jmp finCambiaNom

    unDigito:
        mov byte ptr [nom + di], '0'
        inc di
        mov byte ptr [nom + di], '0'
        inc di
        add al, 30h
        mov byte ptr [nom + di], al
        jmp finCambiaNom
    dosDigitos:
        mov byte ptr [nom + di], '0'
        inc di
        div cl
        add al, 30h
        mov byte ptr [nom + di], al
        inc di
        add ah, 30h
        mov byte ptr [nom + di], ah

    finCambiaNom:
    pop di
    pop cx
    pop ax
    ret
cambiaNom endP


inicio: mov ax, ds ; se mueve primero a un registro porque no se puede hacer un mov entre dos segmentos
        mov es, ax ; para no perder la direccion del psp

        mov ax, datos
        mov ds, ax

        mov ax, pila
        mov ss, ax

        xor di, di
        xor si, si

        mov si, 82h
        mov cx, 5

        linealoop:
            mov bx, 5
            linea:
            cmp bx, 0
            je finLinea
            mov ah, byte ptr es:[si]
            mov byte ptr [cont+di], ah
            inc si
            inc di
            dec bx
            jmp linea
            finLinea:
            mov byte ptr [cont+di], 0Ah
            inc di
        loop linealoop

        abre:
        mov ax, 3D02h
        lea dx, nom
        int 21h; intenta abrir archivo
        jc crea; nombre no existe, ahora sí se puede seguir
        mov bx, ax; handle a bx
        mov ax, 3E00h
        int 21h; cierra archivo que creó
        inc contador
        call cambiaNom; intenta el siguiente nombre
        jmp abre

        crea:
        mov ax, 3C00h
        xor cx, cx
        mov cx, 02
        lea dx, nom
        int 21h
        mov handle, ax

        escribe:
        mov ax, 4000h
        mov bx, handle
        mov cx, 30
        lea dx, cont
        int 21h
        jmp final

        mov ax, 3E00h
        mov bx, handle
        int 21h; cierra archivo



final:
        mov ax, 4C00h ; para finalizacion en 21h
        int 21h ; termina programa

codigo ends

end inicio ; para que apunte a inicio cuando vaya a correr el programa
