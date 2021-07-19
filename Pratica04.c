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

void timer_count() iv 0x0008 ics ICS_AUTO {

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

void main(){
    // Define o pino C2 como output
    TRISC2_BIT = 0;

    // Configuracao do PWM
    PR2 = 255;
    CCPR1L = 0b00000000;
    CCP1CON = 0b00001100;

    // Configuracao do Timer2
    // Sem postscale
    // Prescaler de 4
    T2CON = 0b00000001;

    // Configura pinos da porta A como input
    TRISA = 0xFF;

    //Configura portas como analogicas
    ADCON1 = 0x0F;

    // Ativa o Timer2
    T2CON.F2 = 1;




    while(1){
        read_button();
    }
}