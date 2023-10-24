ilkprogram segment ; Segment başlangıcı
anakod proc far ; İşlem başlangıcı
assume cs:ilkprogram, ds:ilkprogram ;Kod ve Veri segmentlerini 'ilkprogram' içerisinde var sayar.

mov ax, 0
push ds ax
mov ax, ilkprogram
mov ds, ax

jmp basla 
mesaj db 10,13,'merhaba$'
;Değişken İsmi | Veri Türü (Double Byte) | 10,13 (Satır atla, Satır başı)
;Strings ($ bitirici karakterdir, eğer konulmaz ise program string'i sonsuz boyutta sanar.)

basla:mov ah, 09h ; "09H" komutu çalıştırıldığında:
; Ekrana "DX" register'ı içerisindeki "adreste" bulunan metni yazdırır.
; ÖNEMLİ: "DX" içerisindeki veri metninin kendisi değil, adresi olmalıdır.

mov dx, offset mesaj ; "DX" register'ı içerisine, 'mesaj' değişkeninin offset'i (adresi) atanır.
int 21h ; AH Register'ı içerisindeki komutu çalıştırır.

; int 21h -> AH içeriğini oku, içerisinde belirtilen komutu çalıştır.
; AH -> 09H -> DX içeriğini oku, içerisindeki adrese git, o adresteki metni ekrana yazdır.

 ret ; Çalışmayı bitirir, asıl sisteme veya programa döner.
 
 anakod endp ; İşlem bitişi
 ilkprogram ends ; Segment bitişi
 end; Uygulama bitişi
 