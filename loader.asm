; Autores: Gabriel Vargas Rodríguez - 2018103129
;          David Solano Fuentes - 2018167435
; Arquitectura de Computadores - Grupo 2

data segment
    stre db "1010101010"
data endS

code segment
    assume cs: code, ds: data

    ptrResultado EQU dword ptr ss:[bp+4]

loadLvl proc near
    public loadLvl

    push bp
    push ds

    mov bp, sp
    les di, ptrResultado
    lea si, stre

    xor si, si

    mov cx, 10
    lab:
        lodsb
        stosb
    loop lab

    pop ds
    pop bp
    ret
loadLvl endP
code endS
END
