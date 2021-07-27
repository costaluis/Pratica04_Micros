
_timer_count:

;Pratica04.c,7 :: 		void timer_count() iv 0x0008 ics ICS_AUTO {
;Pratica04.c,9 :: 		rpm = TMR1H;
	MOVF        TMR1H+0, 0 
	MOVWF       _rpm+0 
	MOVLW       0
	MOVWF       _rpm+1 
;Pratica04.c,10 :: 		rpm <<= 8;
	MOVF        _rpm+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	MOVWF       _rpm+0 
	MOVF        R1, 0 
	MOVWF       _rpm+1 
;Pratica04.c,11 :: 		rpm += TMR1L;
	MOVF        TMR1L+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _rpm+0 
	MOVF        R1, 0 
	MOVWF       _rpm+1 
;Pratica04.c,14 :: 		rpm *= 60;
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _rpm+0 
	MOVF        R1, 0 
	MOVWF       _rpm+1 
;Pratica04.c,16 :: 		rpm /= 7;
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _rpm+0 
	MOVF        R1, 0 
	MOVWF       _rpm+1 
;Pratica04.c,19 :: 		TMR1H = 0x00;
	CLRF        TMR1H+0 
;Pratica04.c,20 :: 		TMR1L = 0x00;
	CLRF        TMR1L+0 
;Pratica04.c,23 :: 		TMR0H = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;Pratica04.c,24 :: 		TMR0L = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;Pratica04.c,27 :: 		INTCON.F2 = 0;
	BCF         INTCON+0, 2 
;Pratica04.c,28 :: 		}
L_end_timer_count:
L__timer_count9:
	RETFIE      1
; end of _timer_count

_read_button:

;Pratica04.c,31 :: 		void read_button(){
;Pratica04.c,33 :: 		if(PORTA.F0){
	BTFSS       PORTA+0, 0 
	GOTO        L_read_button0
;Pratica04.c,35 :: 		CCPR1L = 0x00;
	CLRF        CCPR1L+0 
;Pratica04.c,36 :: 		CCP1CON.F5 = 0;
	BCF         CCP1CON+0, 5 
;Pratica04.c,37 :: 		CCP1CON.F4 = 0;
	BCF         CCP1CON+0, 4 
;Pratica04.c,39 :: 		strcpy(pwm_p, "PWM: 0%\0");
	MOVLW       _pwm_p+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_pwm_p+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr1_Pratica04+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr1_Pratica04+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;Pratica04.c,40 :: 		}
L_read_button0:
;Pratica04.c,42 :: 		if(PORTA.F1){
	BTFSS       PORTA+0, 1 
	GOTO        L_read_button1
;Pratica04.c,44 :: 		CCPR1L = 0x3F;
	MOVLW       63
	MOVWF       CCPR1L+0 
;Pratica04.c,45 :: 		CCP1CON.F5 = 1;
	BSF         CCP1CON+0, 5 
;Pratica04.c,46 :: 		CCP1CON.F4 = 1;
	BSF         CCP1CON+0, 4 
;Pratica04.c,48 :: 		strcpy(pwm_p, "PWM: 25%\0");
	MOVLW       _pwm_p+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_pwm_p+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr2_Pratica04+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr2_Pratica04+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;Pratica04.c,49 :: 		}
L_read_button1:
;Pratica04.c,50 :: 		if(PORTA.F2){
	BTFSS       PORTA+0, 2 
	GOTO        L_read_button2
;Pratica04.c,52 :: 		CCPR1L = 0x80;
	MOVLW       128
	MOVWF       CCPR1L+0 
;Pratica04.c,53 :: 		CCP1CON.F5 = 0;
	BCF         CCP1CON+0, 5 
;Pratica04.c,54 :: 		CCP1CON.F4 = 0;
	BCF         CCP1CON+0, 4 
;Pratica04.c,56 :: 		strcpy(pwm_p, "PWM: 50%\0");
	MOVLW       _pwm_p+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_pwm_p+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr3_Pratica04+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr3_Pratica04+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;Pratica04.c,57 :: 		}
L_read_button2:
;Pratica04.c,58 :: 		if(PORTA.F3){
	BTFSS       PORTA+0, 3 
	GOTO        L_read_button3
;Pratica04.c,60 :: 		CCPR1L = 0xC0;
	MOVLW       192
	MOVWF       CCPR1L+0 
;Pratica04.c,61 :: 		CCP1CON.F5 = 0;
	BCF         CCP1CON+0, 5 
;Pratica04.c,62 :: 		CCP1CON.F4 = 0;
	BCF         CCP1CON+0, 4 
;Pratica04.c,64 :: 		strcpy(pwm_p, "PWM: 75%\0");
	MOVLW       _pwm_p+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_pwm_p+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr4_Pratica04+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr4_Pratica04+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;Pratica04.c,65 :: 		}
L_read_button3:
;Pratica04.c,66 :: 		if(PORTA.F4){
	BTFSS       PORTA+0, 4 
	GOTO        L_read_button4
;Pratica04.c,68 :: 		CCPR1L = 0xFF;
	MOVLW       255
	MOVWF       CCPR1L+0 
;Pratica04.c,69 :: 		CCP1CON.F5 = 1;
	BSF         CCP1CON+0, 5 
;Pratica04.c,70 :: 		CCP1CON.F4 = 1;
	BSF         CCP1CON+0, 4 
;Pratica04.c,72 :: 		strcpy(pwm_p, " PWM: 100%\0");
	MOVLW       _pwm_p+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_pwm_p+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr5_Pratica04+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr5_Pratica04+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;Pratica04.c,73 :: 		}
L_read_button4:
;Pratica04.c,74 :: 		}
L_end_read_button:
	RETURN      0
; end of _read_button

_main:

;Pratica04.c,92 :: 		void main(){
;Pratica04.c,94 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;Pratica04.c,97 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Pratica04.c,100 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Pratica04.c,103 :: 		rpm = 0;
	CLRF        _rpm+0 
	CLRF        _rpm+1 
;Pratica04.c,106 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Pratica04.c,109 :: 		TRISC2_BIT = 0;
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;Pratica04.c,112 :: 		TRISC0_BIT = 1;
	BSF         TRISC0_bit+0, BitPos(TRISC0_bit+0) 
;Pratica04.c,116 :: 		PR2 = 255;
	MOVLW       255
	MOVWF       PR2+0 
;Pratica04.c,120 :: 		CCPR1L = 0b00000000;
	CLRF        CCPR1L+0 
;Pratica04.c,121 :: 		CCP1CON = 0b00001100;
	MOVLW       12
	MOVWF       CCP1CON+0 
;Pratica04.c,126 :: 		T2CON = 0b00000001;
	MOVLW       1
	MOVWF       T2CON+0 
;Pratica04.c,129 :: 		TRISA = 0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;Pratica04.c,132 :: 		T2CON.F2 = 1;
	BSF         T2CON+0, 2 
;Pratica04.c,135 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;Pratica04.c,136 :: 		TMR1H = 0;
	CLRF        TMR1H+0 
;Pratica04.c,143 :: 		T1CON = 0b10000011;
	MOVLW       131
	MOVWF       T1CON+0 
;Pratica04.c,147 :: 		TMR0H = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;Pratica04.c,148 :: 		TMR0L = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;Pratica04.c,151 :: 		INTCON = 0b10100000;
	MOVLW       160
	MOVWF       INTCON+0 
;Pratica04.c,158 :: 		T0CON = 0b10000100;
	MOVLW       132
	MOVWF       T0CON+0 
;Pratica04.c,161 :: 		strcpy(pwm_p, " PWM: 0%\0");
	MOVLW       _pwm_p+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_pwm_p+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr6_Pratica04+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr6_Pratica04+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;Pratica04.c,163 :: 		while(1){
L_main5:
;Pratica04.c,166 :: 		read_button();
	CALL        _read_button+0, 0
;Pratica04.c,169 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Pratica04.c,172 :: 		strcpy(output," RPM:");
	MOVLW       _output+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_output+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr7_Pratica04+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr7_Pratica04+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;Pratica04.c,173 :: 		Lcd_Out(2, 1, output);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _output+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_output+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Pratica04.c,176 :: 		IntToStr(rpm, output);
	MOVF        _rpm+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _rpm+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _output+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_output+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Pratica04.c,179 :: 		Lcd_Out(1, 1, pwm_p);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _pwm_p+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_pwm_p+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Pratica04.c,182 :: 		Lcd_Out(2, 5, output);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _output+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_output+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Pratica04.c,185 :: 		Delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
;Pratica04.c,186 :: 		}
	GOTO        L_main5
;Pratica04.c,187 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
