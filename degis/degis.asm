; AL ve BL register'larında önceden belirli sayıların yerlerini değiştir.
degis segment
anakod proc far
assume cs:degis, ds:degis
mov ax, 0
push ds ax
mov ax, degis
mov ds, ax

jmp basla

mesaj1 db 10,13, "AL icerigi $"
mesaj2 db 10,13, "BL icerigi $"
mesaj3 db 10,13, "AL degerini giriniz $"
mesaj4 db 10,13, "BL degerini giriniz $"
;AL sayı alma işlemleri için kullanılacağından, sayıları depolamak için değişkenler tanımladık.
sayi1 db ? ; DB boyutunda, içeriği belirsiz bir değişken tanımlandı.
sayi2 db ?


basla: mov ah, 09h
	mov dx, offset mesaj3
	int 21h ;"AL degerini giriniz $"
	
	mov ah, 01h
	int 21h ; AL içerisine, kullanıcıdan gelen bir ASCII karakter alındı.
	sub al, 30h ; ASCII karakteri sayı değerine çevirdik.
	; 30h çıkarmak = ASCII -> Sayı
	
	
	mov sayi1, al ; AL içerisindeki sayı değeri, "sayi1" değişkenine depoladık
	
	mov ah, 09h
	mov dx, offset mesaj4
	int 21h ; BL degerini giriniz $"
	
	mov ah, 01h
	int 21h ; AL içerisine ASCII karakter aldık.
	sub al, 30h

	mov sayi2, al ; Sayıyı "sayi2" içinde depoladık.
	
	mov al, sayi1
	mov bl, sayi2
	
	xchg al, bl ; Verilen iki register'daki değerleri takip eder.
	; AL -> 7, BL -> 5 oldu.
	
	mov ah, 09h
	mov dx, offset mesaj1
	int 21h ; 'AL icerigi $' ekrana yazıldı.
	
	mov ah, 02h ; DL'deki değer ekrana yazılacak.
	mov dl, al ; AL'nin değeri ekrana yazılmak için DL'ye kopyalandı.
	
	; Eğer ekrana bu şekilde yazdırılırsa DL'deki sayısal değeri yazdırmaz.
	; Bunun yerine, onun ASCII karşılığını ekrana yazdırmaya çalışır.
	; Yani bizim istediğimiz sayıyı yazdırmak için, onun ASCII karşılığını yazdırmalıyız.
	; ASCII tablosunda 7 karakteri -> 55
	; 7 + 48 = 55
	; ASCII tablosunda 5 -> 53; 5 + 48 = 53
	; Gerçek sayı olarak saklanan değere 48/30h eklenir ise onun ASCII karşılığı elde edilmiş olur
	; fakat sürekli 48 yazımı matematiksel işlemler ile karışabilir.
	; Bu yüzden genelde 48 yerine onun hexadecimal karşılığı 30h yazılır. Tersi de geçerlidir, 
	; ASCII olarak saklanan sayıdan 70/30h çıkarılır ise gerçek sayı karşılığı elde edilmiş olur.
	; ÖNEMLİ: Bu anlatılanlar sadece rakamlarda geçerlidir.
	; İki veya daha çok basamaklı sayılar içinde ne yapılacağı sonraki derslerde anlatılacaktır.
	
	;add dl, 48 ; ADD komutu, ilk değere ikinci değeri ekler. (DL = DL + 48)
	add dl, 30h ; decimal 48 = hexadecimal 30h
	int 21h
	
	mov ah, 09h
	mov dx, offset mesaj2
	int 21h ; BL icerigi $ ekrana yazıldı.
	
	mov ah, 02h ; DL'deki değer ekrana yazılacak
	mov dl, bl
	add dl, 30h
	int 21h

ret
anakod endp
degis ends
end
