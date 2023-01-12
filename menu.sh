#!/bin/bash
#SEKCJA LOGO
#-----------
: ${DIALOG_ESC=11}
showlogo()
{
for((i=0; $i <= 1; i++))
do
clear
echo -n $'\E[31m'
echo $'        __                              ___   __        
     z$$$$$. $$
    $$$$$$$$$$$
   $$$$$$**$$$$             eeeeer
  $$$$$%    $$$             $$$$$F
 4$$$$P     *$$             *$$$$F
 $$$$$       $$    .ee.      ^$$$F            ..e.
 $$$$$       ""  .$$$$$$b     $$$F 4$$$$$$   $$$$$$c
4$$$$F          4$$$""$$$$    $$$F  *$$$$*  $$$P"$$$L
4$$$$F         .$$$F  ^$$$b   $$$F  J$$$   $$$$  ^$$$.
4$$$$F         d$$$    $$$$   $$$F J$$P   .$$$F   $$$$
4$$$$F         $$$$    3$$$F  $$$FJ$$P    4$$$   $$$$
4$$$$F        4$$$$    4$$$$  $$$$$$$r    $$$$$$$$$$$$
4$$$$$        4$$$$    4$$$$  $$$$$$$$    $$$$********
 $$$$$        4$$$$    4$$$F  $$$F4$$$b   *$$$r
 3$$$$F       d$$$$    $$$$  $$$F *$$$F  4$$$L     .
  $$$$$.     d$$$$$.   $$$$   $$$F  $$$$.  $$$$    z$P
   $$$$$e..d$$$$$$b  4$$$   J$$$L    $$$$  $$$b..d$$
    *$$$$$$$$$  ^$$$be$$$  $$$$$$$  3$$$$F   $$$$$$$
     ^*$$$$P     *$$$$*    $$$$$$$   $$$$F  ^*$$$'
sleep 1
clear
echo $'
         __                              ___   __        .ama     ,
      ,d888a                          ,d88888888888ba.  ,88/I)   d
     a88.]8i                         a88..88)   `"8888:88  / _a8
   .d8P. PP                        .d8P..8  d)      "8:88:baad8P
  ,d8P. ,ama,   .aa,  .ama.g ,mmm  d8P. 8  .8.        88):888P
 ,d88. d8[ .8..a888 ,8I.88[ I88. d88   ]IaI"        d8[         
 a88. dP .bm8mP8.(8..8I  8[      d88.    ..         .88          
,88I ]8.  .d.8     88. ,8. I[  ,88P ,ama    ,ama,  d8[  .ama.g
[88. I8, .d. ]8,  ,88B ,d8 aI   (88.,88.8)  d8[ .8. 88 ,8I.88[
]88  `888P.  `8888. .88P.8m.    I88 88[ 8[ dP .bm8m88[.8I  8[
]88,          _,,aaaaaa,_       I88 8.  8 ]P.  .d. 88 88. ,8. I[
`888a,.  ,aadd88888888888bma.   )88,  ,]I I8, .d/ )88a8B ,d8 aI
  /888888PP         `8///////8   /888PP/  `888P/  `88P/88P 8m'
sleep 1
clear
done

}
#-----------
#SEKCJA MENU GLOWNEGO
#----------------
showmenu()
{
OPC=$(dialog --title "Menu główne" \
--backtitle "Adam Cinal 2Ic" \
--cancel-label "Wyjdź" \
--menu "Wybierz opcję: " 0 0 0  \
1 "Polecenia: grupy i użytkownicy" \
2 "Wyświetl środowiska graficzne" \
3 "Zmiana daty/czasu" \
4 "Polecenia sieciowe" \
5 "Utwórz komunikat" \
6 "Polecenia system" \
7 "TMP" \
8 "Polecenia na plikach" \
9 "Wykonaj zrzut ekranu " \
10 "Test EE08" --stdout)

case $OPC in
	1) groupusers;;
	2) showgui;;
	3) datatime;;
	4) network;;
	5) event;;
	6) systemtasks;;
	7) tmpmenu;;
	8) files;;
	9) screenshot;;
	10) technikstart;;
	*) exit
	
esac
}
#SEKCJA GRUPY I UŻYTKOWNIKOW
#--------------------------
#--------------------------
#OPCJA PIERWSZA GU
showusers()
{
dialog --title "Lista użytkowników" --backtitle "Adam Cinal 2Ic" --exit-label "Wróć" --clear --textbox /etc/passwd 0 0

exitst=$?;
if [ $exitst==0 ];
then
	groupusers
else 
	groupusers
fi
}
#DRUGA OPCJA GU
#===========================================
showgroups()
{
groups=$(groups $USER)
dialog --title "Grupy do których należysz:" --ok-label "Wróć" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "$groups"  0 0

exitst=$?;
if [ $exitst==0 ];
then
	groupusers
else 
	groupusers
fi
}
#TRZECIA OPCJA GU
#===========================================
blockuser()
{
uzytkownik=$(dialog \
--title "Zablokuj użytkownika" \
--backtitle "Adam Cinal 2Ic" \
--clear \
--inputbox "Wpisz nazwę użytkownika do zablokowania: " 0 0 --stdout)

if id -u "$uzytkownik" >/dev/null 2>&1;
then
	sudo passwd -l "$uzytkownik"
	dialog --title "Sukces!" --ok-label "Wróć do menu" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "Pomyślnie zablokowano tego użytkownika!" 0 0
	exitst=$?;
	if [ $exitst==0 ];
	then
		groupusers
	else 
		groupusers
	fi
else
	dialog --title "Błąd!" --ok-label "Wróć do menu" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "Nie ma takiego użytkownika w systemie!" 0 0
	exitst=$?;
	if [ $exitst==0 ];
	then
		groupusers
	else 
		groupusers
	fi
fi
}
#CZWARTA OPCJA GU
logout()
{
	exit
	gnome-session-quit
}
#===========================================
groupusers()
{
GU=$(dialog --title "Menu dot. poleceń na użytkownikach" \
--backtitle "Adam Cinal 2Ic" \
--cancel-label "Wyjdź" \
--menu "Wybierz opcję: " 0 0 0 \
1 "Wyświetl wszystkich użytkowników" \
2 "Wyświetl grupy do których należysz" \
3 "Zablokuj wybrane konto" \
4 "Wyloguj się" \
5 "Powróc do menu głównego" --stdout)
case $GU in
	1) showusers;;
	2) showgroups;;
	3) blockuser;;
	4) logout;;
	5) showmenu;; 
	*) exit;;
	
esac
}


#-------------------------
#DRUGA OPCJA MENU
#=================================
showgui()
{
result=$(ls /usr/bin/*session)
dialog --title "Zainstalowane środowiska graficzne:" --ok-label "Wróć" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "$result"  0 0

exitst=$?;
if [ $exitst==0 ];
then
	showmenu
else 
	showmenu
fi	
}

#=================================
#TRZECIA OPCJA MENU
datatime()
{
DT=$(dialog --title "Zmień czas lub godzinę" \
--backtitle "Adam Cinal 2Ic" \
--cancel-label "Wyjdź" \
--menu "Wybierz opcję: " 0 0 0 \
1 "Zmień datę" \
2 "Zmień czas" \
3 "Powróc do menu głównego" --stdout)
case $DT in
	1) data;;
	2) czas;;
	3) showmenu;; 
	*) exit;;
	
esac	
}
#=======================================
#Pierwsza opcja datatime
data()
{
DIALOG=${DIALOG=dialog}

USERDATE=`$DIALOG --stdout --title "Kalendarz" --backtitle "Adam Cinal 2Ic" --cancel-label "Wróć" --calendar "Wybierz datę: " 0 0 1 1 2022	`
case $? in
	0)
		sudo date -s "$USERDATE"
		dialog --title "Pomyślnie zmieniono datę!" --ok-label "Wróć" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "Jeśli nie widzisz zmienionej daty - jest to spowodowane automatyczną synchronizacją z czasem lokalnym"  0 0

		exitst=$?;
		if [ $exitst==0 ];
		then
			showmenu
		else 
			showmenu
		fi;;
	1)
		showmenu
esac

}
#======================================
#DRUGA OPCJA DATATIME
czas()
{
DIALOG=${DIALOG=dialog}

USERTIME=`$DIALOG --stdout --title "Zegarek" --backtitle "Adam Cinal 2Ic" --cancel-label "Wróć" --timebox "Ustaw czas systemowy(Poruszaj się strzałkami): " 0 0 00 00 00 `
case $? in
	 0)
	 sudo date +%T -s "$USERTIME"
	 dialog --title "Pomyślnie zmieniono czas systemowy!" --ok-label "Wróć" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "Jeśli nie widzisz zmienionego czasu  - jest to spowodowane automatyczną synchronizacją z czasem lokalnym"  0 0

		exitst=$?;
		if [ $exitst==0 ];
		then
			datatime
		else 
			datatime
		fi;;
	 1) 
		showmenu
esac
}


#======================================
#CZWARTA OPCJA W MENU
network()
{
	NET=$(dialog --title "Menu dot. poleceń sieciowych" \
--backtitle "Adam Cinal 2Ic" \
--cancel-label "Wyjdź" \
--menu "Wybierz opcję: " 0 0 0 \
1 "Zmiana konfiguracji kart sieciowych (adres IP)" \
2 "Wyświetlenie konfiguracji kart sieciowych" \
3 "Powróc do menu głównego" --stdout)
case $NET in
	1) change;;
	2) showcards;;
	3) showmenu;;
	*) exit;;
	
esac
}

#========================================
#STATYCZNA ZMIANA
static()
{
	cardname=""
	ip=""
	maska=""
	
	FORM=$(dialog --ok-label "Zatwierdź" \
	--backtitle "Adam Cinal 2Ic" \
	--title "Zmiana adresu IP" \
	--form "Ustaw statyczny adres IP"  15 50 0 \
		"Nazwa karty: " 1 1 "$cardname" 1 13 15 0 \
		"Adres IP: " 2 1 "$ip" 2 13 15 0 \
		"Maska: " 3 1 "$maska" 3 13 15 0 --stdout)
	cardname=$(echo "$FORM" | sed -n 1p)
	ip=$(echo "$FORM" | sed -n 2p)
	maska=$(echo "$FORM" | sed -n 3p)
	sudo ifconfig  "$cardname" "$ip" netmask "$maska" up && 
	if ! (($?));
	then
		dialog --title "Sukces!" --ok-label "Wróć do menu " --backtitle "Adam Cinal 2Ic" --stdout --msgbox "Pomyślnie zmieniono parametry wskazanej karty sieciowej" 0 0
		exitst=$?;
		if [ $exitst==0 ];
		then
			network
		else 
			network
		fi
	else 
		dialog --title "Błąd!" --ok-label "Wróć do menu " --backtitle "Adam Cinal 2Ic" --stdout --msgbox "Użyłeś niepoprawnej wartości do któregoś z podpunktów, sprawdź jeszcze raz poprawność wprowadzonych danych!" 0 0
		exitst=$?;
		if [ $exitst==0 ];
		then
			network
		else 
			network
		fi
	fi
}
#==================================
#DYNAMICZNA ZMIANA
dhcp()
{
karta=$(dialog \
--title "Ustaw adres pobierany z DHCP" \
--backtitle "Adam Cinal 2Ic" \
--clear \
--inputbox "Wpisz nazwę karty sieciowej: " 0 0 --stdout)

sudo dhclient "$karta" 
if !(($?));
then
	dialog --title "Sukces!" --ok-label "Wróć do menu" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "Pomyślnie zmieniono ustawienia tej karty sieciowej" 0 0
	exitst=$?;
	if [ $exitst==0 ];
	then
		network
	else 
		network
	fi
else
	dialog --title "Błąd!" --ok-label "Wróć do menu" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "Nie ma takiej karty sieciowej!" 0 0
	exitst=$?;
	if [ $exitst==0 ];
	then
		network
	else 
		netowrk
	fi
fi

}
#=================================
change()
{
		NET=$(dialog --title "Zmiana adresu IP karty" \
--backtitle "Adam Cinal 2Ic" \
--cancel-label "Wyjdź" \
--menu "Wybierz opcję: " 0 0 0 \
1 "Ustaw statyczny adres IP" \
2 "Ustaw dynamiczny adres IP (DHCP)" \
3 "Powróc do menu poleceń sieciowych" --stdout)
case $NET in
	1) static;;
	2) dhcp;;
	3) network;;
	*) exit;;
	
esac
}
#========================================
showcards()
{
result=$(ifconfig)
dialog --title "Informacje na temat kart sieciowych:" --ok-label "Wróć" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "$result"  0 0

exitst=$?;
if [ $exitst==0 ];
then
	network
else 
	netowrk
fi	
}

#=======================================
#EVENT
event()
{
	sudo apt-get install cron
	(crontab -l 2>/dev/null; echo "0 8 * * * /home/$USER/Pulpit/wiadomosc.sh")| crontab -
	showmenu
}
#========================================
#SYSTEM
systemtasks()
{
SYS=$(dialog --title "Menu dot. poleceń systemowych" \
--backtitle "Adam Cinal 2Ic" \
--cancel-label "Wyjdź" \
--menu "Wybierz opcję: " 0 0 0 \
1 "Wyświetl jak długo system jest uruchomiony" \
2 "Wyłącz komputer" \
3 "Sprawdź wolne miejsce na dysku" \
4 "Powróc do menu głównego" --stdout)
case $SYS in
	1) howlong;;
	2) shutup;;
	3) freespace;;
	4) showmenu;; 
	*) exit;;
	
esac		

}
#==============================================
#HOW LONG SYSTEM; #1
howlong()
{
result=$(uptime -p)
dialog --title "System operacyjny uruchomiony jest przez:" --ok-label "Wróć" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "$result"  0 0

exitst=$?;
if [ $exitst==0 ];
then
	systemtasks
else 
	systemtasks
fi	
	
}
#====================================
#2 POZYCJA W MENU SYSTEM
shutup()
{
	dialog --title "Wyłączenie komputera" \
	--backtitle "Adam Cinal 2Ic" \
	--yesno "Czy napewno chcesz wyłączyć komputer?" 0 0 
	
	answer=$?
	case $answer in
		0) shutdown now;;
		1) systemtasks;;
	esac
}
#===================================
#3 FREE SPACE ON DISK
freespace()
{
	result=$(df)
	dialog --title "Zajęte miejsce na dysku:" --ok-label "Wróć" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "$result"  0 0

	exitst=$?;
	if [ $exitst==0 ];
	then
		systemtasks
	else 
		systemtasks
fi	
}
#=====================
#TMP MENU SECTION
tmpmenu()
{
SYS=$(dialog --title "Menu dot. operacji na plikach tymczasowych" \
--backtitle "Adam Cinal 2Ic" \
--cancel-label "Wyjdź" \
--menu "Wybierz opcję: " 0 0 0 \
1 "Wyświetl pliki tmp" \
2 "Usuń pliki tmp" \
3 "Powróc do menu głównego" --stdout)
case $SYS in
	1) tmpshow;;
	2) tmpdel;;
	3) showmenu;;
	*) exit;;
	
esac		
}
#==================================
#TMP SHOW
tmpshow()
{
result=$(ls -alh /tmp)
dialog --title "Pliki w folderze tmp:" --ok-label "Wróć" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "$result"  0 0

exitst=$?;
if [ $exitst==0 ];
then
	tmpmenu
else 
	tmpmenu
fi	
		
}
#==================================
#TMP DELETE
tmpdel()
{
	dialog --title "Usuwanie plików tymczasowych" \
	--backtitle "Adam Cinal 2Ic" \
	--yesno "Jesteś pewien?" 0 0 
	
	answer=$?
	case $answer in
		0) sudo rm -rf /tmp/* && tmpmenu;;
		1) tmpmenu;;
	esac
}
#==================================
#FILES
files()
{
SYS=$(dialog --title "Menu dot. poleceń na plikach" \
--backtitle "Adam Cinal 2Ic" \
--cancel-label "Wyjdź" \
--menu "Wybierz opcję: " 0 0 0 \
1 "Zmień umask" \
2 "Znajdź pliki większe niż... I wyświetl" \
3 "Powróc do menu głównego" --stdout)
case $SYS in
	1) umaske;;
	2) findfiles;;
	3) showmenu;;
	*) exit;;
	
esac	
	
}
#============================
#UMASK
umaske()
{
umaske=$(dialog \
--title "Ustaw umask(ograniczenie praw dostępu do pliku)" \
--backtitle "Adam Cinal 2Ic" \
--clear \
--inputbox "(3 liczby 0-7, 1-dla właściciela, 2-dla grupy, 3-dla pozostałych działa na zasadzie różnicy 0-to pełne uprawnienia.)\n Wpisz odpowiedni umask: " 0 0 --stdout)

umask $umaske
if !(($?));
then
	dialog --title "Sukces!" --ok-label "Wróć do menu" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "Pomyślnie ustawiono parametr umask" 0 0
	exitst=$?;
	if [ $exitst==0 ];
	then
		files
	else 
		files
	fi
else
	dialog --title "Błąd!" --ok-label "Wróć do menu" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "Żle wprowadzony umask!" 0 0
	exitst=$?;
	if [ $exitst==0 ];
	then
		files
	else 
		files
	fi
fi
	
}
#FIND FILES
findfiles()
{
size=$(dialog \
--title "Szukanie plików większych niż.." \
--backtitle "Adam Cinal 2Ic" \
--clear \
--inputbox "Wpisz wartość powyżej jakiej chcesz szukać pliki: \n liczba + (k/M/G/c)" 0 0 --stdout)

find -size '+'$size 
if !(($?));
then
	rm plik.txt
	find -size '+'$size  >> plik.txt
	clear 
	cat -n plik.txt
	echo "Aby wrócić do menu wciśnij jakiś numer bądź literę:"
	read exist
	if [$exist==1 ];
	then 
		files
	else 
		files
	fi

else
	dialog --title "Błąd!" --ok-label "Wróć do menu" --backtitle "Adam Cinal 2Ic" --stdout --msgbox "Żle wprowadzana wartość do wyszukiwania!" 0 0
	exitst=$?;
	if [ $exitst==0 ];
	then
		files
	else 
		files
	fi
fi	
}
#=====================================
#TAKE A SCREENSHOT
screenshot()
{

	scrot -e 'mv $f ~/Pulpit/' 
	if (($?));
	then
	 sudo apt-get install scrot
	 clear
	 showmenu
	 scrot -e 'mv $f ~/Pulpit/' 
	else 
		showmenu
	fi
}
#=========================================
#TEST EE08

#=======================================
#PYTANIA TEST
Pytanie1()
{

xdg-open /home/$USER/Pulpit/Menu/Pytanie1.png
SYS=$(dialog --title "Pytanie 1" \
--backtitle "Adam Cinal 2Ic" \
--cancel-label "Wyjdź" \
--menu "Jaki adres IP ma stacja robocza na przedstawionym zrzucie ekranu z ipconfig? " 0 0 0  \
A "192.168.0.11" \
B "62.21.99.95" \
C "192.168.0.1" \
D "62.21.99.95"  --stdout)

case $SYS in
	A) echo Pytanie 1: A - Poprawna >> rezultaty.txt
	Pytanie2;;
	B) echo Pytanie 1: B - Niepoprawna  >> rezultaty.txt
	Pytanie2;;
	C) echo  Pytanie 1: C - Niepoprawna  >> rezultaty.txt
	Pytanie2;;
	D) echo  Pytanie 1: D - Niepoprawna  >> rezultaty.txt
	Pytanie2;;
	*) exit;;
	
esac	
}
#==============================================
#Pytanie 2
Pytanie2()
{
xdg-open /home/$USER/Pulpit/Menu/Pytanie2.png
SYS=$(dialog --title "Pytanie 2" \
--backtitle "Adam Cinal 2Ic" \
--cancel-label "Wyjdź" \
--menu "Jaki typ wejścia został przedstawiony na poniższym zdjęciu?" 0 0 0  \
A "Micro USB" \
B "Thunderbolt" \
C "DisplayPort" \
D "HDMI"  --stdout)
case $SYS in
	A) echo Pytanie 2: A - Niepoprawna >> rezultaty.txt   
	Pytanie3;;
	B) echo Pytanie 2: B - Poprawna >> rezultaty.txt   
	Pytanie3;;
	C) echo Pytanie 2: C - Niepoprawna >> rezultaty.txt   
	Pytanie3;;
	D) echo Pytanie 2: D - Niepoprawna >> rezultaty.txt   
	Pytanie3;;
	*) exit;;
	
esac	
}
#===========================================
#Pytanie 3
Pytanie3()
{
SYS=$(dialog --title "Pytanie 3" \
--backtitle "Adam Cinal 2Ic" \
--cancel-label "Wyjdź" \
--menu "Polecenie systemu Windows stosowane do sprawdzenia trasy, po której są przesyłane pakiety w sieci, to:  " 0 0 0  \
A "tracert" \
B "ipconfig" \
C "route" \
D "netstat"  --stdout)
case $SYS in
	A) echo Pytanie 3: A - Poprawna >> rezultaty.txt  
	Pytanie4;;
	B) echo Pytanie 3: B - Niepoprawna >> rezultaty.txt  
	Pytanie4;;
	C) echo Pytanie 3: C - Niepoprawna >> rezultaty.txt  
	Pytanie4;;
	D) echo Pytanie 3: D - Niepoprawna >> rezultaty.txt  
	Pytanie4;;
	*) exit;;
	
esac		
}
#============================================
#Pytanie 4
Pytanie4()
{
xdg-open /home/$USER/Pulpit/Menu/Pytanie4.jpg
SYS=$(dialog --title "Pytanie 4" \
--backtitle "Adam Cinal 2Ic" \
--cancel-label "Wyjdź" \
--menu " Jaką kartę rozszerzeń komputera przedstawiono na zdjęciu? " 0 0 0  \
A "dzwiękowa" \
B "graficzna" \
C "sieciowa" \
D "telewizyjna"  --stdout)
case $SYS in
	A) echo Pytanie 4: A - Niepoprawna >> rezultaty.txt 
	Pytanie5;;
	B) echo Pytanie 4: B - Niepoprawna >> rezultaty.txt 
	Pytanie5;;
	C) echo Pytanie 4: C - Poprawna >> rezultaty.txt
	Pytanie5;;
	D) echo Pytanie 4: D - Niepoprawna >> rezultaty.txt 
	Pytanie5;;
	*) exit;;
	
esac		
}
#===============================================================
#Pytanie 5
Pytanie5()
{
SYS=$(dialog --title "Pytanie 5" \
--backtitle "Adam Cinal 2Ic" \
--cancel-label "Wyjdź" \
--menu "Który z wymienionych systemów operacyjnych nie jest obsługiwany przez system plików ext4? " 0 0 0  \
A "Mandriva" \
B "Gentoo" \
C "Fedora" \
D "Windows"  --stdout)
case $SYS in
	A)echo Pytanie 5: A - Niepoprawna >> rezultaty.txt  
	echo Data zakończenia: >> rezultaty.txt
	date >> rezultaty.txt
	technikoniec;;
	B) echo Pytanie 5: B - Niepoprawna >> rezultaty.txt
	echo Data zakończenia: >> rezultaty.txt
	date >> rezultaty.txt
	technikoniec;; 
	C) echo Pytanie 5: C - Niepoprawna >> rezultaty.txt 
	echo Data zakończenia: >> rezultaty.txt
	date >> rezultaty.txt
	technikoniec;;
	D) echo Pytanie 5: D - Poprawna >> rezultaty.txt  
	echo Data zakończenia: >> rezultaty.txt
	date >> rezultaty.txt
	technikoniec;;
	*) exit;;
	
esac		
}
#========================================================
#POCZATEK TESTU
technikstart()
{
	
dialog --title "TEST EE08" \
	--backtitle "Adam Cinal 2Ic" \
	--yesno "Czy chcesz rozpocząć test z pytaniami EE08? \n (Aby zaznaczyć odpowiedź, najpierw zamknij zdjęcie)" 0 0 
	
	answer=$?
	case $answer in
		0) rm rezultaty.txt
		   echo Wyniki testu: >> rezultaty.txt
		   echo Data rozpoczęcia: >> rezultaty.txt
		   date >> rezultaty.txt
			Pytanie1;;
		1) showmenu;;
	esac	
	
}
#========================================================
#KONIEC TESTU
technikoniec()
{
dialog --title "Wyniki testu" --backtitle "Adam Cinal 2Ic" --exit-label "Wróć do menu" --clear --textbox rezultaty.txt 0 0

exitst=$?;
if [ $exitst==0 ];
then
	showmenu
else 
	showmenu
fi	
}
#==========================================
exit()
{
clear
echo Pomyślnie zakończono działanie programu!
}
showlogo
showmenu
