
.EQU	PINA = 0x00
.EQU	DDRA = 0x01
.EQU	PORTA = 0x02
.EQU    PINB = 0x03
.EQU	DDRB = 0x04
.EQU	PORTB = 0x05

.org 0x0000
	jmp debut
	
.org 0x0100

afficheur:
	 .DB 0x7E, 0x0C, 0x37, 0x1F, 0x4D, 0x5B, 0x7B, 0x0E, 0x7F, 0x4F     ; 1 2 3 .. 7

.org 0x110
debut:
		    ; DDRA<-0b11111111
    		LDI R16,0b11111111
   			OUT DDRA,R16
    		
    		; INIT
    		LDI R20,5
    		
    		; Affichage juste au milieu
    		LDI R16,0b11110000
    		OUT 0x07,R16
    		LDI R16,0b01000000
    		OUT 0x08,R16
    		
    		
boucle:    
    		; PORTA@IO<-afficheur@ROM[R20]
		    MOV R16,R20
		    LDI R30,low(afficheur<<1)
		    LDI R31,high(afficheur<<1)
		    CLR R17
		    ADD R30,R16
		    ADC R31,R17
		    LPM R16,Z
		    OUT PORTA,R16
		    CALL Pause
		   	CPI R20,9
		   	BREQ remise_a_zero
		   	INC R20
		   	JMP saut
remise_a_zero:
			CLR R20		   		    
saut:			JMP boucle
		
				
Pause:
		LDI r24,8
tempo:
		SUBI R22,1
		SBCI R23,0
		SBCI R24,0
		BRCC tempo
		RET	