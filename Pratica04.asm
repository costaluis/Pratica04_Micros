
_timer_count:

;Pratica04.c,17 :: 		void timer_count() iv 0x0008 ics ICS_AUTO {
;Pratica04.c,19 :: 		}
L_end_timer_count:
L__timer_count8:
	RETFIE      1
; end of _timer_count

_read_button:

;Pratica04.c,22 :: 		void read_button(){
;Pratica04.c,23 :: 		if(PORTA.F0){
	BTFSS       PORTA+0, 0 
	GOTO        L_read_button0
;Pratica04.c,24 :: 		CCPR1L = 0x00;
	CLRF        CCPR1L+0 
;Pratica04.c,25 :: 		CCP1CON.F5 = 0;
	BCF         CCP1CON+0, 5 
;Pratica04.c,26 :: 		CCP1CON.F4 = 0;
	BCF         CCP1CON+0, 4 
;Pratica04.c,27 :: 		}
L_read_button0:
;Pratica04.c,28 :: 		if(PORTA.F1){
	BTFSS       PORTA+0, 1 
	GOTO        L_read_button1
;Pratica04.c,29 :: 		CCPR1L = 0x3F;
	MOVLW       63
	MOVWF       CCPR1L+0 
;Pratica04.c,30 :: 		CCP1CON.F5 = 1;
	BSF         CCP1CON+0, 5 
;Pratica04.c,31 :: 		CCP1CON.F4 = 1;
	BSF         CCP1CON+0, 4 
;Pratica04.c,32 :: 		}
L_read_button1:
;Pratica04.c,33 :: 		if(PORTA.F2){
	BTFSS       PORTA+0, 2 
	GOTO        L_read_button2
;Pratica04.c,34 :: 		CCPR1L = 0x80;
	MOVLW       128
	MOVWF       CCPR1L+0 
;Pratica04.c,35 :: 		CCP1CON.F5 = 0;
	BCF         CCP1CON+0, 5 
;Pratica04.c,36 :: 		CCP1CON.F4 = 0;
	BCF         CCP1CON+0, 4 
;Pratica04.c,37 :: 		}
L_read_button2:
;Pratica04.c,38 :: 		if(PORTA.F3){
	BTFSS       PORTA+0, 3 
	GOTO        L_read_button3
;Pratica04.c,39 :: 		CCPR1L = 0xC0;
	MOVLW       192
	MOVWF       CCPR1L+0 
;Pratica04.c,40 :: 		CCP1CON.F5 = 0;
	BCF         CCP1CON+0, 5 
;Pratica04.c,41 :: 		CCP1CON.F4 = 0;
	BCF         CCP1CON+0, 4 
;Pratica04.c,42 :: 		}
L_read_button3:
;Pratica04.c,43 :: 		if(PORTA.F4){
	BTFSS       PORTA+0, 4 
	GOTO        L_read_button4
;Pratica04.c,44 :: 		CCPR1L = 0xFF;
	MOVLW       255
	MOVWF       CCPR1L+0 
;Pratica04.c,45 :: 		CCP1CON.F5 = 1;
	BSF         CCP1CON+0, 5 
;Pratica04.c,46 :: 		CCP1CON.F4 = 1;
	BSF         CCP1CON+0, 4 
;Pratica04.c,47 :: 		}
L_read_button4:
;Pratica04.c,48 :: 		}
L_end_read_button:
	RETURN      0
; end of _read_button

_main:

;Pratica04.c,50 :: 		void main(){
;Pratica04.c,52 :: 		TRISC2_BIT = 0;
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;Pratica04.c,53 :: 		PR2 = 255;
	MOVLW       255
	MOVWF       PR2+0 
;Pratica04.c,54 :: 		CCPR1L = 0b00000000;
	CLRF        CCPR1L+0 
;Pratica04.c,55 :: 		CCP1CON = 0b00001100;
	MOVLW       12
	MOVWF       CCP1CON+0 
;Pratica04.c,60 :: 		T2CON = 0b00000001;
	MOVLW       1
	MOVWF       T2CON+0 
;Pratica04.c,63 :: 		TRISA = 0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;Pratica04.c,66 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;Pratica04.c,69 :: 		T2CON.F2 = 1;
	BSF         T2CON+0, 2 
;Pratica04.c,74 :: 		while(1){
L_main5:
;Pratica04.c,75 :: 		read_button();
	CALL        _read_button+0, 0
;Pratica04.c,76 :: 		}
	GOTO        L_main5
;Pratica04.c,77 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
