; Exemple de code pour  ATMEGA2560

.EQU	PINA = 0x00
.EQU	DDRA = 0x01
.EQU	PORTA = 0x02

.ORG	0x0000
	; Vecteur RESET
	JMP debut

.ORG	0x0080

debut:
		
		LDI R16, 0x01 ; config direction port A
		OUT DDRA, R16
		
boucle:

		IN R16, PINA
		LSR R16
		OUT PORTA, R16
		
		JMP boucle