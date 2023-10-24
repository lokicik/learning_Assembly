goruntule segment 
anakod proc far
assume cs:goruntule, ds:goruntule 


mov ax, 0
push ds ax 
mov ax, goruntule
mov ds, ax

jmp basla

mesaj1 db 10,13, 'Bir sayi giriniz: $'
mesaj2 db 10,13, 'Girdiginiz sayi: $'

basla: mov ah, 09h
	mov dx, offset mesaj1
	int 21h ; "Bir sayi giriniz" sorusunu yazdırır.
	
sayial:mov ah, 01h
	int 21h ; "01H" klavyede bir karakter alır. "AL" register'ında saklar.
	
yazi:mov ah, 09h
	mov dx, offset mesaj2
	int 21h ; 'Girdiginiz sayi" sorusunu yazdırdı.
	
alinanyazdir:mov ah, 02h ; "DL"deki değeri ekrana yazdırır.
	mov dl, al ; 01H ile aldığınız AL'deki değeri DL'ye kopyalar
	int 21h ; DL içindeki karakter ekrana yazılır.
	
ret 
anakod endp
goruntule ends
end