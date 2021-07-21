unsigned int rpm=100;
char output[15];

void timer_count() iv 0x0008 ics ICS_AUTO {
    rpm = TMR1H;
    rpm <<= 8;
    rpm += TMR1L;

    TMR1H = 0x00;
    TMR1L = 0x00;

    TMR0H = 0x0B;
    TMR0L = 0xDC;
}

//Leitura dos botoes
void read_button(){
    if(PORTA.F0){
        CCPR1L = 0x00;
        CCP1CON.F5 = 0;
        CCP1CON.F4 = 0;
    }
    if(PORTA.F1){
        CCPR1L = 0x3F;
        CCP1CON.F5 = 1;
        CCP1CON.F4 = 1;
    }
    if(PORTA.F2){
        CCPR1L = 0x80;
        CCP1CON.F5 = 0;
        CCP1CON.F4 = 0;
    }
    if(PORTA.F3){
        CCPR1L = 0xC0;
        CCP1CON.F5 = 0;
        CCP1CON.F4 = 0;
    }
    if(PORTA.F4){
        CCPR1L = 0xFF;
        CCP1CON.F5 = 1;
        CCP1CON.F4 = 1;
    }
} 

// Configuracao dos pinos para utilizacao no LCD
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;

// Configuracao dos pinos para entrada e saida do LCD
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D7_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB0_bit;

void main(){
    // Inicia a utilizacao do LCD
    Lcd_Init();

    Lcd_Cmd(_LCD_CURSOR_OFF);

    // Liga o display
    Lcd_Cmd(_LCD_TURN_ON);

    // Limpa o display
    Lcd_Cmd(_LCD_CLEAR);
    
    // Define o pino C2 como output
    TRISC2_BIT = 0;

    // Define o pino C0 como input
    TRISC0_BIT = 1;

    // Configuracao do PWM
    // PR2 eh utilizado no calculo da frequencia do PWM
    PR2 = 255;

    // Seta o valor inicial para um duty cicle 0
    // Configura o modo CCP para PWM
    CCPR1L = 0b00000000;
    CCP1CON = 0b00001111;

    // Configuracao do Timer2 - Sera usado para no PWM
    // Sem postscale
    // Prescaler de 4
    T2CON = 0b00000001;

    // Configura pinos da porta A como input
    TRISA = 0xFF;

    //Configura portas como analogicas
    ADCON1 = 0x0F;

    // Ativa o Timer2
    T2CON.F2 = 1;

    // Configuracao do Timer1 - Usado para contagem de pulsos do sensor infravermelho
    // 16 bits
    // Sem prescaler
    // Utiliza pino RC0 como entrada de clock
    // Ativa o contador
    T1CON = 0b10000111;

    // Configuracao do Timer0 - Usado para contar 1s
    // 16 bits
    // Utiliza clock do PIC
    // Transicao low-to-high
    // Prescaler 1:32
    T0CON = 0b00000100;

    // Habilita interrupcao do Timer0
    INTCON = 0b11100000;

    // Configura interrupcao do Timer0 como alta prioridade
    INTCON2.F2 = 1;

    // Inicia a contagem do timer
    T0CON.F0 = 1;  

    TMR0H = 0x0B;
    TMR0L = 0xDC;
    
    while(1){
        read_button();
        // Limpa o display
        Lcd_Cmd(_LCD_CLEAR);

        // Realiza a conversao de float para cadeia de char para ser exibido no display
        IntToStr(rpm, output);

        // Exibe o valor lido na primeira linha do display
        Lcd_Out(1, 1, output);

        Delay_ms(300);
    }
}