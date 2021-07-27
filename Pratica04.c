// Declaracao de variaveis
int rpm;
char output[15];
char pwm_p[15];

// Funcao de interrupcao - alta prioridade
void timer_count() iv 0x0008 ics ICS_AUTO {
    // Recebe o numero de pulsos contados em 1s
    rpm = TMR1H;
    rpm <<= 8;
    rpm += TMR1L;

    // Transforma em RPM
    rpm *= 60;
    // Divisao por 7 -> 7 pas da ventoinha
    rpm /= 7;

    // Zera novamente o contador
    TMR1H = 0x00;
    TMR1L = 0x00;

    // Atribui o valor inicial do timer
    TMR0H = 0x0B;
    TMR0L = 0xDC;

    // Desabilita a flag de interrupcao
    INTCON.F2 = 0;
}

//Leitura dos botoes
void read_button(){
    // Se o botao 0 for pressionado
    if(PORTA.F0){
        // Configura o PWM para 0% de duty cycle
        CCPR1L = 0x00;
        CCP1CON.F5 = 0;
        CCP1CON.F4 = 0;
        // Imprime a porcentagem do PWM
        strcpy(pwm_p, "PWM: 0%\0");
    }
    // Se o botao 1 for pressionado
    if(PORTA.F1){
        // Configura o PWM para 25% de duty cycle
        CCPR1L = 0x3F;
        CCP1CON.F5 = 1;
        CCP1CON.F4 = 1;
        // Seta a porcentagem do PWM para impressao
        strcpy(pwm_p, "PWM: 25%\0");
    }
    if(PORTA.F2){
        // Configura o PWM para 50% de duty cycle
        CCPR1L = 0x80;
        CCP1CON.F5 = 0;
        CCP1CON.F4 = 0;
        // Seta a porcentagem do PWM para impressao
        strcpy(pwm_p, "PWM: 50%\0");
    }
    if(PORTA.F3){
        // Configura o PWM para 75% de duty cycle
        CCPR1L = 0xC0;
        CCP1CON.F5 = 0;
        CCP1CON.F4 = 0;
        // Seta a porcentagem do PWM para impressao
        strcpy(pwm_p, "PWM: 75%\0");
    }
    if(PORTA.F4){
        // Configura o PWM para 100% de duty cycle
        CCPR1L = 0xFF;
        CCP1CON.F5 = 1;
        CCP1CON.F4 = 1;
        // Seta a porcentagem do PWM para impressao
        strcpy(pwm_p, " PWM: 100%\0");
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
    //Configura todas as portas como analogicas
    ADCON1 = 0x0F;

    // Inicia a utilizacao do LCD
    Lcd_Init();

    // Desabilita o cursor do display
    Lcd_Cmd(_LCD_CURSOR_OFF);

    // Seta o valor inicial da velocidade lida
    rpm = 0;

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
    CCP1CON = 0b00001100;

    // Configuracao do Timer2 - Sera usado para no PWM
    // Sem postscale
    // Prescaler de 4
    T2CON = 0b00000001;

    // Configura pinos da porta A como input
    TRISA = 0xFF;

    // Ativa o Timer2
    T2CON.F2 = 1;

    // Seta o valor inicial do contador de pulsos em 0
    TMR1L = 0;
    TMR1H = 0;

    // Configuracao do Timer1 - Usado para contagem de pulsos do sensor infravermelho
    // 16 bits
    // Sem prescaler
    // Utiliza pino RC0 como entrada de clock
    // Ativa o contador
    T1CON = 0b10000011;
    
    
    // Seta o valor inicial do timer0
    TMR0H = 0x0B;
    TMR0L = 0xDC;

    // Habilita interrupcao do Timer0
    INTCON = 0b10100000;

    // Configuracao do Timer0 - Usado para contar 1s
    // 16 bits
    // Utiliza clock do PIC
    // Transicao low-to-high
    // Prescaler 1:32
    T0CON = 0b10000100;

    // Porcentagem da largura de pulso inicial - Para ser impresso no display
    strcpy(pwm_p, " PWM: 0%\0");
    
    while(1){

        // Realiza a leitura dos botoes e verifica se algum foi pressionado
        read_button();

        // Limpa o display
        Lcd_Cmd(_LCD_CLEAR);
        
        // Imprime a mensagem da velocidade
        strcpy(output," RPM:");
        Lcd_Out(2, 1, output);

        // Realiza a conversao de int para cadeia de char para ser exibido no display
        IntToStr(rpm, output);

        // Imprime a porcentagem de duty cycle do PWM
        Lcd_Out(1, 1, pwm_p);

        // Exibe o valor lido na segunda linha do display
        Lcd_Out(2, 5, output);

        // Aguarda 200ms para recomecar o loop
        Delay_ms(200);
    }
}