; Autores: Gabriel Vargas Rodríguez - 2018103129
;          David Solano Fuentes - 2018167435
; Arquitectura de Computadores - Grupo 2
data segment

  nom db "lvl001.txt$", 0
  handle dw ?
  cont db 30 dup(?)

  contador dw 1

data ends

code segment

   assume  cs:code, ds:data


creando proc near
    public creando
        push bp
        mov bp, sp
        xor di, di
        xor si, si

        push ds
        lds si, ss:[bp+4];matrizEditor
        mov cx, 5
        linealoop:
            mov bx, 5
            linea:
            cmp bx, 0
            je finLinea
            mov ah, byte ptr ds:[si]
            add ah,30h
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
        lea dx, cont      ;variable ascii
        int 21h

        mov ax, 3E00h
        mov bx, handle
        int 21h; cierra archivo

        pop ds
        pop bp
        ret 100

creando endP
code ends

END
