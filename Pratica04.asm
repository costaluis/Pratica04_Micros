
_timer_count:

;Pratica04.c,20 :: 		void timer_count() iv 0x0008 ics ICS_AUTO {
;Pratica04.c,21 :: 		rpm = TMR1H;
	MOVF        TMR1H+0, 0 
	MOVWF       _rpm+0 
	MOVLW       0
	MOVWF       _rpm+1 
;Pratica04.c,22 :: 		rpm <<= 8;
	MOVF        _rpm+0, 0 
	MOVWF       _rpm+1 
	CLRF        _rpm+0 
;Pratica04.c,23 :: 		rpm += TMR1L;
	MOVF        TMR1L+0, 0 
	ADDWF       _rpm+0, 1 
	MOVLW       0
	ADDWFC      _rpm+1, 1 
;Pratica04.c,25 :: 		TMR1H = 0x00;
	CLRF        TMR1H+0 
;Pratica04.c,26 :: 		TMR1L = 0x00;
	CLRF        TMR1L+0 
;Pratica04.c,28 :: 		TMR0H = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;Pratica04.c,29 :: 		TMR0L = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;Pratica04.c,30 :: 		}
L_end_timer_count:
L__timer_count9:
	RETFIE      1
; end of _timer_count

_read_button:

;Pratica04.c,33 :: 		void read_button(){
;Pratica04.c,34 :: 		if(PORTA.F0){
	BTFSS       PORTA+0, 0 
	GOTO        L_read_button0
;Pratica04.c,35 :: 		CCPR1L = 0x00;
	CLRF        CCPR1L+0 
;Pratica04.c,36 :: 		CCP1CON.F5 = 0;
	BCF         CCP1CON+0, 5 
;Pratica04.c,37 :: 		CCP1CON.F4 = 0;
	BCF         CCP1CON+0, 4 
;Pratica04.c,38 :: 		}
L_read_button0:
;Pratica04.c,39 :: 		if(PORTA.F1){
	BTFSS       PORTA+0, 1 
	GOTO        L_read_button1
;Pratica04.c,40 :: 		CCPR1L = 0x3F;
	MOVLW       63
	MOVWF       CCPR1L+0 
;Pratica04.c,41 :: 		CCP1CON.F5 = 1;
	BSF         CCP1CON+0, 5 
;Pratica04.c,42 :: 		CCP1CON.F4 = 1;
	BSF         CCP1CON+0, 4 
;Pratica04.c,43 :: 		}
L_read_button1:
;Pratica04.c,44 :: 		if(PORTA.F2){
	BTFSS       PORTA+0, 2 
	GOTO        L_read_button2
;Pratica04.c,45 :: 		CCPR1L = 0x80;
	MOVLW       128
	MOVWF       CCPR1L+0 
;Pratica04.c,46 :: 		CCP1CON.F5 = 0;
	BCF         CCP1CON+0, 5 
;Pratica04.c,47 :: 		CCP1CON.F4 = 0;
	BCF         CCP1CON+0, 4 
;Pratica04.c,48 :: 		}
L_read_button2:
;Pratica04.c,49 :: 		if(PORTA.F3){
	BTFSS       PORTA+0, 3 
	GOTO        L_read_button3
;Pratica04.c,50 :: 		CCPR1L = 0xC0;
	MOVLW       192
	MOVWF       CCPR1L+0 
;Pratica04.c,51 :: 		CCP1CON.F5 = 0;
	BCF         CCP1CON+0, 5 
;Pratica04.c,52 :: 		CCP1CON.F4 = 0;
	BCF         CCP1CON+0, 4 
;Pratica04.c,53 :: 		}
L_read_button3:
;Pratica04.c,54 :: 		if(PORTA.F4){
	BTFSS       PORTA+0, 4 
	GOTO        L_read_button4
;Pratica04.c,55 :: 		CCPR1L = 0xFF;
	MOVLW       255
	MOVWF       CCPR1L+0 
;Pratica04.c,56 :: 		CCP1CON.F5 = 1;
	BSF         CCP1CON+0, 5 
;Pratica04.c,57 :: 		CCP1CON.F4 = 1;
	BSF         CCP1CON+0, 4 
;Pratica04.c,58 :: 		}
L_read_button4:
;Pratica04.c,59 :: 		}
L_end_read_button:
	RETURN      0
; end of _read_button

_main:

;Pratica04.c,61 :: 		void main(){
;Pratica04.c,63 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Pratica04.c,66 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Pratica04.c,69 :: 		Lcd_Cmd(_LCD_TURN_ON);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Pratica04.c,72 :: 		TRISC2_BIT = 0;
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;Pratica04.c,75 :: 		TRISC0_BIT = 1;
	BSF         TRISC0_bit+0, BitPos(TRISC0_bit+0) 
;Pratica04.c,79 :: 		PR2 = 255;
	MOVLW       255
	MOVWF       PR2+0 
;Pratica04.c,83 :: 		CCPR1L = 0b00000000;
	CLRF        CCPR1L+0 
;Pratica04.c,84 :: 		CCP1CON = 0b00001100;
	MOVLW       12
	MOVWF       CCP1CON+0 
;Pratica04.c,89 :: 		T2CON = 0b00000001;
	MOVLW       1
	MOVWF       T2CON+0 
;Pratica04.c,92 :: 		TRISA = 0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;Pratica04.c,95 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;Pratica04.c,98 :: 		T2CON.F2 = 1;
	BSF         T2CON+0, 2 
;Pratica04.c,105 :: 		T1CON = 0b10000111;
	MOVLW       135
	MOVWF       T1CON+0 
;Pratica04.c,112 :: 		T0CON = 0b00000100;
	MOVLW       4
	MOVWF       T0CON+0 
;Pratica04.c,115 :: 		INTCON = 0b11100000;
	MOVLW       224
	MOVWF       INTCON+0 
;Pratica04.c,118 :: 		INTCON2.F2 = 1;
	BSF         INTCON2+0, 2 
;Pratica04.c,121 :: 		T0CON.F0 = 1;
	BSF         T0CON+0, 0 
;Pratica04.c,123 :: 		TMR0H = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;Pratica04.c,124 :: 		TMR0L = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;Pratica04.c,126 :: 		while(1){
L_main5:
;Pratica04.c,127 :: 		read_button();
	CALL        _read_button+0, 0
;Pratica04.c,129 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Pratica04.c,132 :: 		IntToStr(rpm, output);
	MOVF        _rpm+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _rpm+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _output+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_output+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Pratica04.c,134 :: 		strcpy(output, "arroz\0");
	MOVLW       _output+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_output+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr1_Pratica04+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr1_Pratica04+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;Pratica04.c,137 :: 		Lcd_Out(1, 1, "teste");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Pratica04+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Pratica04+0)
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
