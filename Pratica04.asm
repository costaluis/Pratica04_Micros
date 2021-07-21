
_timer_count:

;Pratica04.c,4 :: 		void timer_count() iv 0x0008 ics ICS_AUTO {
;Pratica04.c,5 :: 		rpm = TMR1H;
	MOVF        TMR1H+0, 0 
	MOVWF       _rpm+0 
	MOVLW       0
	MOVWF       _rpm+1 
;Pratica04.c,6 :: 		rpm <<= 8;
	MOVF        _rpm+0, 0 
	MOVWF       _rpm+1 
	CLRF        _rpm+0 
;Pratica04.c,7 :: 		rpm += TMR1L;
	MOVF        TMR1L+0, 0 
	ADDWF       _rpm+0, 1 
	MOVLW       0
	ADDWFC      _rpm+1, 1 
;Pratica04.c,9 :: 		TMR1H = 0x00;
	CLRF        TMR1H+0 
;Pratica04.c,10 :: 		TMR1L = 0x00;
	CLRF        TMR1L+0 
;Pratica04.c,12 :: 		TMR0H = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;Pratica04.c,13 :: 		TMR0L = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;Pratica04.c,14 :: 		}
L_end_timer_count:
L__timer_count9:
	RETFIE      1
; end of _timer_count

_read_button:

;Pratica04.c,17 :: 		void read_button(){
;Pratica04.c,18 :: 		if(PORTA.F0){
	BTFSS       PORTA+0, 0 
	GOTO        L_read_button0
;Pratica04.c,19 :: 		CCPR1L = 0x00;
	CLRF        CCPR1L+0 
;Pratica04.c,20 :: 		CCP1CON.F5 = 0;
	BCF         CCP1CON+0, 5 
;Pratica04.c,21 :: 		CCP1CON.F4 = 0;
	BCF         CCP1CON+0, 4 
;Pratica04.c,22 :: 		}
L_read_button0:
;Pratica04.c,23 :: 		if(PORTA.F1){
	BTFSS       PORTA+0, 1 
	GOTO        L_read_button1
;Pratica04.c,24 :: 		CCPR1L = 0x3F;
	MOVLW       63
	MOVWF       CCPR1L+0 
;Pratica04.c,25 :: 		CCP1CON.F5 = 1;
	BSF         CCP1CON+0, 5 
;Pratica04.c,26 :: 		CCP1CON.F4 = 1;
	BSF         CCP1CON+0, 4 
;Pratica04.c,27 :: 		}
L_read_button1:
;Pratica04.c,28 :: 		if(PORTA.F2){
	BTFSS       PORTA+0, 2 
	GOTO        L_read_button2
;Pratica04.c,29 :: 		CCPR1L = 0x80;
	MOVLW       128
	MOVWF       CCPR1L+0 
;Pratica04.c,30 :: 		CCP1CON.F5 = 0;
	BCF         CCP1CON+0, 5 
;Pratica04.c,31 :: 		CCP1CON.F4 = 0;
	BCF         CCP1CON+0, 4 
;Pratica04.c,32 :: 		}
L_read_button2:
;Pratica04.c,33 :: 		if(PORTA.F3){
	BTFSS       PORTA+0, 3 
	GOTO        L_read_button3
;Pratica04.c,34 :: 		CCPR1L = 0xC0;
	MOVLW       192
	MOVWF       CCPR1L+0 
;Pratica04.c,35 :: 		CCP1CON.F5 = 0;
	BCF         CCP1CON+0, 5 
;Pratica04.c,36 :: 		CCP1CON.F4 = 0;
	BCF         CCP1CON+0, 4 
;Pratica04.c,37 :: 		}
L_read_button3:
;Pratica04.c,38 :: 		if(PORTA.F4){
	BTFSS       PORTA+0, 4 
	GOTO        L_read_button4
;Pratica04.c,39 :: 		CCPR1L = 0xFF;
	MOVLW       255
	MOVWF       CCPR1L+0 
;Pratica04.c,40 :: 		CCP1CON.F5 = 1;
	BSF         CCP1CON+0, 5 
;Pratica04.c,41 :: 		CCP1CON.F4 = 1;
	BSF         CCP1CON+0, 4 
;Pratica04.c,42 :: 		}
L_read_button4:
;Pratica04.c,43 :: 		}
L_end_read_button:
	RETURN      0
; end of _read_button

_main:

;Pratica04.c,61 :: 		void main(){
;Pratica04.c,63 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Pratica04.c,65 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Pratica04.c,68 :: 		Lcd_Cmd(_LCD_TURN_ON);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Pratica04.c,71 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Pratica04.c,74 :: 		TRISC2_BIT = 0;
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;Pratica04.c,77 :: 		TRISC0_BIT = 1;
	BSF         TRISC0_bit+0, BitPos(TRISC0_bit+0) 
;Pratica04.c,81 :: 		PR2 = 255;
	MOVLW       255
	MOVWF       PR2+0 
;Pratica04.c,85 :: 		CCPR1L = 0b00000000;
	CLRF        CCPR1L+0 
;Pratica04.c,86 :: 		CCP1CON = 0b00001111;
	MOVLW       15
	MOVWF       CCP1CON+0 
;Pratica04.c,91 :: 		T2CON = 0b00000001;
	MOVLW       1
	MOVWF       T2CON+0 
;Pratica04.c,94 :: 		TRISA = 0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;Pratica04.c,97 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;Pratica04.c,100 :: 		T2CON.F2 = 1;
	BSF         T2CON+0, 2 
;Pratica04.c,107 :: 		T1CON = 0b10000111;
	MOVLW       135
	MOVWF       T1CON+0 
;Pratica04.c,114 :: 		T0CON = 0b00000100;
	MOVLW       4
	MOVWF       T0CON+0 
;Pratica04.c,117 :: 		INTCON = 0b11100000;
	MOVLW       224
	MOVWF       INTCON+0 
;Pratica04.c,120 :: 		INTCON2.F2 = 1;
	BSF         INTCON2+0, 2 
;Pratica04.c,123 :: 		T0CON.F0 = 1;
	BSF         T0CON+0, 0 
;Pratica04.c,125 :: 		TMR0H = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;Pratica04.c,126 :: 		TMR0L = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;Pratica04.c,128 :: 		while(1){
L_main5:
;Pratica04.c,129 :: 		read_button();
	CALL        _read_button+0, 0
;Pratica04.c,131 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Pratica04.c,134 :: 		IntToStr(rpm, output);
	MOVF        _rpm+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _rpm+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _output+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_output+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Pratica04.c,137 :: 		Lcd_Out(1, 1, output);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _output+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_output+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Pratica04.c,139 :: 		Delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
	NOP
	NOP
;Pratica04.c,140 :: 		}
	GOTO        L_main5
;Pratica04.c,141 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
