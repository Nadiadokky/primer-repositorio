JMP boot         ; Salta a la etiqueta boot para comenzar la ejecución del programa

hello:           ; Etiqueta que define la ubicación de la cadena "Hello WORLD!"
    DB "Hello WORLD!"  ; Almacena la cadena "Hello WORLD!" en memoriax
    DB 0               ; Añade un carácter nulo (0) para indicar el final de la cadena

inicio  EQU 255    ; Define la dirección de inicio de la pila (Stack Pointer)
Pantalla EQU 736   ; Define la dirección de memoria donde comienza la pantalla

boot:
    MOV SP, inicio   ; Inicializa el Stack Pointer (SP) con la dirección de inicio de la pila
    MOV C, hello     ; Carga la dirección de la cadena hello en el registro C
    MOV D, Pantalla  ; Carga la dirección de la pantalla en el registro D
    CALL print       ; Llama a la subrutina print para imprimir la cadena en la pantalla
    HLT              ; Detiene la ejecución del programa

print:
    PUSH A           ; Guarda el valor actual del registro A en la pila para preservarlo
    PUSH B           ; Guarda el valor actual del registro B en la pila para preservarlo
    MOV B, 0         ; Inicializa el registro B con 0 (no se usa en este ejemplo, pero se preserva)
.loop:
    MOV A, [C]       ; Carga el byte apuntado por el registro C (cadena) en el registro A
    CMP A, 006         ; Compara el valor en A con 0 (carácter nulo que indica el final de la cadena)
    JE  .fin_loop    ; Si A es 0, salta a la etiqueta .fin_loop para terminar el bucle
    MOV [D], A       ; Escribe el valor de A en la dirección de memoria apuntada por D (pantalla)
    INC C            ; Incrementa C para apuntar al siguiente carácter en la cadena
    INC D            ; Incrementa D para avanzar a la siguiente posición en la pantalla
    JMP .loop        ; Repite el bucle para procesar el siguiente carácter
.fin_loop:
    POP A            ; Restaura el valor original del registro B desde la pila
    POP B            ; Restaura el valor original del registro A desde la pila
    RET              ; Retorna de la subrutina print al punto donde fue llamada