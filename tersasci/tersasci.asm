; ASCII tablosunun ekrana yazılması.
tersasci segment
anakod proc far
assume cs:tersasci, ds:tersasci

mov ax, 0
push ds ax
mov ax, tersasci
mov ds, ax

jmp basla

mesaj db 10,13, "ASCII tablosu yukaridadir.$"


basla: mov cl, 128 ; CL içerisinde koyulan değer,
; döngünün kaç defa döneceğini belirtir.
; ÖNEMLİ: CL değer ataması, döngü dışında yapılmalıdır.
; Döngü içinde yapılır ise sonsuz döngü oluşur.

dongu: mov ah, 02h ; DL'deki değeri ekrana yazdırır.
	mov dl, cl ; DL'ye CL içerisindeki değer kopyalanır.
	; Bu sayede CL'deki değerin ASCII karşılığı ekrana yazılacaktır.
	; CL her döngüde i azalacağından, 128 - 1 arası tüm değerleri ekrana yazdırır.
	; 0 yazılmaz, çünkü CL = 0 olduğunda döngü biter.
	int 21h
	loop dongu ; CL içerisindeki değere bakar:
	; 1. CL = 0 ise işlem yapmadan normal aşağı çalışmaya devam eder.
	; 2. CL != 0 ise CL'deki değeri 1 azaltır.
	; belirtilen etikete dönüp çalışmaya oradan devam eder.

dur: mov ah, 09h
	mov dx, offset mesaj
	int 21h

ret
anakod endp
tersasci ends
end