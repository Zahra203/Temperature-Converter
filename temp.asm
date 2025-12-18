.model small
.stack 100h

.data
title1 db 13,10,"======================================",13,10,'$'
title2 db "      TEMPERATURE CONVERTER (8086)      ",13,10,'$'
title3 db "======================================",13,10,'$'

madeby db 13,10,"        Made By: Fabiha | Zahra | Abdullah       ",'$'

menu1 db 13,10,"1. Celsius -> Fahrenheit",13,10,'$'
menu2 db "2. Celsius -> Kelvin",13,10,'$'
menu3 db "3. Fahrenheit -> Celsius",13,10,'$'
menu4 db "4. Fahrenheit -> Kelvin",13,10,'$'
menu5 db "5. Kelvin -> Celsius",13,10,'$'
menu6 db "6. Kelvin -> Fahrenheit",13,10,'$'
menu7 db "--------------------------------------",13,10,'$'
menu8 db "Enter your choice (1-6) and press ENTER: $"

prompt db 13,10,"Enter temperature value (press ENTER): $"
resultMsg db 13,10,"Converted Temperature: $"
errorMsg db 13,10,"Invalid choice! Program terminated.$"
newline db 13,10,'$'

choice db 0
temp dw 0
result dw 0

; --- Constants for Signed Arithmetic ---
const9 dw 9
const5 dw 5
; --------------------------------------

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 0
    mov al, 3
    int 10h

    ; --- Display UI ---
    mov dx, OFFSET title1
    mov ah, 09h
    int 21h
    mov dx, OFFSET title2
    mov ah, 09h
    int 21h
    mov dx, OFFSET title3
    mov ah, 09h
    int 21h
    mov dx, OFFSET madeby
    mov ah, 09h
    int 21h

    ; --- Display Menu ---
    mov dx, OFFSET menu1
    mov ah, 09h
    int 21h
    mov dx, OFFSET menu2
    mov ah, 09h
    int 21h
    mov dx, OFFSET menu3
    mov ah, 09h
    int 21h
    mov dx, OFFSET menu4
    mov ah, 09h
    int 21h
    mov dx, OFFSET menu5
    mov ah, 09h
    int 21h
    mov dx, OFFSET menu6
    mov ah, 09h
    int 21h
    mov dx, OFFSET menu7
    mov ah, 09h
    int 21h
    mov dx, OFFSET menu8
    mov ah, 09h
    int 21h

    ; --- READ MENU CHOICE ---
    mov ah, 01h
    int 21h
    sub al, '0'
    mov choice, al

    ; === CRITICAL FIX: FLUSH THE ENTER KEY ===
    ; This loop eats any remaining keys (like Enter) 
    ; until the line is clear, so they don't mess up the next input.
flush_input:
    mov ah, 01h
    int 21h
    cmp al, 13  ; Check if it was Enter
    jne flush_input
    ; =========================================

    ; Check range
    mov al, choice
    cmp al, 1
    jb invalid_choice
    cmp al, 6
    ja invalid_choice

    ; --- READ TEMPERATURE ---
    mov dx, OFFSET prompt
    mov ah, 09h
    int 21h

    call readNumber
    mov temp, ax

    ; --- EXECUTE CHOICE ---
    mov al, choice
    cmp al, 1
    je c1
    cmp al, 2
    je c2
    cmp al, 3
    je c3
    cmp al, 4
    je c4
    cmp al, 5
    je c5
    cmp al, 6
    je c6

c1: call c_to_f
    jmp show_result
c2: call c_to_k
    jmp show_result
c3: call f_to_c
    jmp show_result
c4: call f_to_k
    jmp show_result
c5: call k_to_c
    jmp show_result
c6: call k_to_f

show_result:
    mov dx, OFFSET resultMsg
    mov ah, 09h
    int 21h

    mov ax, result
    call printNumber

    mov dx, OFFSET newline
    mov ah, 09h
    int 21h
    jmp exit_program

invalid_choice:
    mov dx, OFFSET errorMsg
    mov ah, 09h
    int 21h

exit_program:
    mov ah, 4Ch
    int 21h
main endp

; ================= CONVERSIONS =================

c_to_f proc
    mov ax, temp
    cwd
    imul const9
    idiv const5
    add ax, 32
    mov result, ax
    ret
c_to_f endp

c_to_k proc
    mov ax, temp
    add ax, 273
    mov result, ax
    ret
c_to_k endp

f_to_c proc
    mov ax, temp
    sub ax, 32
    cwd
    imul const5
    idiv const9
    mov result, ax
    ret
f_to_c endp

f_to_k proc
    mov ax, temp
    sub ax, 32
    cwd
    imul const5
    idiv const9
    add ax, 273
    mov result, ax
    ret
f_to_k endp

k_to_c proc
    mov ax, temp
    sub ax, 273
    mov result, ax
    ret
k_to_c endp

k_to_f proc
    mov ax, temp
    sub ax, 273
    cwd
    imul const9
    idiv const5
    add ax, 32
    mov result, ax
    ret
k_to_f endp

; ================= INPUT (FIXED) =================
; Reads digits until Enter is pressed.
; Result is stored in AX.

readNumber proc
    xor bx, bx      ; BX holds the running total. Start at 0.
    xor cx, cx      ; Clear CX used for temporary digit storage.

read_loop:
    mov ah, 01h     ; Read 1 character
    int 21h

    cmp al, 13      ; If Enter key (ASCII 13)...
    je done_read    ; ...we are finished.

    sub al, '0'     ; Convert ASCII to digit (e.g., '5' -> 5)
    xor ah, ah      ; Clear AH, so AX is just the digit (0005)
    mov cx, ax      ; Save digit in CX momentarily

    ; Multiply current total (BX) by 10
    mov ax, bx      
    mov dx, 10
    mul dx          ; AX = BX * 10
    
    ; Add the new digit
    add ax, cx      ; AX = (Total * 10) + New Digit
    mov bx, ax      ; Save new total back to BX

    jmp read_loop   ; Get next character

done_read:
    mov ax, bx      ; Move final total to AX for return
    ret
readNumber endp

; ================= OUTPUT =================

printNumber proc
    push ax
    push bx
    push cx
    push dx

    mov bx, 10
    xor cx, cx

    cmp ax, 0
    jge p1
    mov dl, '-'
    mov ah, 02h
    int 21h
    neg ax

p1:
    xor dx, dx      ; Clear DX before division!
    div bx          ; Divide AX by 10
    push dx         ; Save remainder
    inc cx          ; Count digits
    cmp ax, 0
    jne p1

p2:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop p2

    pop dx
    pop cx
    pop bx
    pop ax
    ret
printNumber endp

end main