#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Marcus-Roberto-Google-Play-Google-Chrome.ico
#AutoIt3Wrapper_Compression=3
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Comment=Google Chrome
#AutoIt3Wrapper_Res_Description=Google Chrome
#AutoIt3Wrapper_Res_Fileversion=45.0.2454.101
#AutoIt3Wrapper_Res_LegalCopyright=Copyright 2012 Google Inc. All rights reserved.
#AutoIt3Wrapper_Res_Language=1055
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
Opt("TrayIconHide", 1)
Opt("TrayAutoPause", 0)
#include <SendMessage.au3>
#include <WindowsConstants.au3>
#include <Crypt.au3>
#include <file.au3>
#include <array.au3>
#include <WinAPIFiles.au3>
RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run","IMD")

Func _FileRename($s_Source, $s_Destination, $i_Flag = 0)
	Local $i
	$i = FileMove($s_Source, $s_Destination, $i_Flag)
	Return $i
 EndFunc

$chromedizin = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe","Path")

If FileExists(@AppDataDir & "\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Google Chrome.lnk") = True Then
Local $parametreler = FileGetShortcut(@AppDataDir & "\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Google Chrome.lnk")
Else
If FileExists(@DesktopDir & "\Google Chrome.lnk") = True then
Local $parametreler = FileGetShortcut(@DesktopDir & "\Google Chrome.lnk")
   ElseIf FileExists(@DesktopCommonDir & "\Google Chrome.lnk") = True Then
	   Local $parametreler = FileGetShortcut(@DesktopCommonDir & "\Google Chrome.lnk")
	  EndIf
EndIf

ConsoleWrite($parametreler[0] & @CRLF)
ConsoleWrite($parametreler[1] & @CRLF)
ConsoleWrite($parametreler[2] & @CRLF)
ConsoleWrite($parametreler[3] & @CRLF)
ConsoleWrite($parametreler[4] & @CRLF)
ConsoleWrite($parametreler[5] & @CRLF)
ConsoleWrite($parametreler[6] & @CRLF)

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

FileCreateShortcut($parametreler[0],@AppDataDir & "\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Google Chrome.lnk",$parametreler[1],"",$parametreler[3],$parametreler[4],$parametreler[5],0,@SW_SHOWNORMAL)
FileCreateShortcut($parametreler[0],@DesktopCommonDir & "\Google Chrome.lnk",$parametreler[1],"",$parametreler[3],$parametreler[4],$parametreler[5],0,@SW_SHOWNORMAL)
