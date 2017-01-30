; A set of macros which make logging in NSIS easier.
; 
; It's basically wrapper around NSISLog plugin and adds a date and time
; to every logger call. Allows you to log at DEBUG, INFO, WARN or ERROR level.
;
; NSISLog plugin: http://nsis.sourceforge.net/NSISLog_plug-in
;
; Sample call: 
; !insertmacro logInfo "Hello World!"
; 
; The "sampleLog.log" in $PLUGINSDIR folder then contains:
; 2017-01-29 21:14:17 INFO  Hello World! 
;
; See sample installer in "sample\testSexyLogs.nsh".
;
!include FileFunc.nsh
!include TextFunc.nsh
; Include "StrFunc.nsh" (StrRep) if not already defined by someone else
!ifndef STRFUNC | StrRep_INCLUDED
  !ifdef __GLOBAL__
    !ifndef STRFUNC
      !include "StrFunc.nsh"
    !endif
    !ifdef STRFUNC
      !ifndef StrRep_INCLUDED
        ${StrRep}
      !endif
    !endif
  !else
    !error `SexyLogs: mandatory dependency is missing: StrFunc.nsh [StrRep]`
  !endif
!endif


Var /GLOBAL SexyLogsLogPath

Var /GLOBAL SexyLogsDay    
Var /GLOBAL SexyLogsMonth
Var /GLOBAL SexyLogsYear
Var /GLOBAL SexyLogsDayOfWeekName
Var /GLOBAL SexyLogsHour
Var /GLOBAL SexyLogsMinute
Var /GLOBAL SexyLogsSeconds

!macro logInit filePath
  StrCpy $SexyLogsLogPath ${filePath} 
!macroend

!macro log message
  nsislog::log "$SexyLogsLogPath" "${message}"
!macroend

!macro logInfo message
  ${GetTime} "" "L" $SexyLogsDay $SexyLogsMonth $SexyLogsYear $SexyLogsDayOfWeekName $SexyLogsHour $SexyLogsMinute $SexyLogsSeconds
  IntFmt $SexyLogsHour "%0.2u" $SexyLogsHour
  nsislog::log "$SexyLogsLogPath" "$SexyLogsYear-$SexyLogsMonth-$SexyLogsDay $SexyLogsHour:$SexyLogsMinute:$SexyLogsSeconds INFO  ${message}"
!macroend

!macro logDebug message
  ${GetTime} "" "L" $SexyLogsDay $SexyLogsMonth $SexyLogsYear $SexyLogsDayOfWeekName $SexyLogsHour $SexyLogsMinute $SexyLogsSeconds
  IntFmt $SexyLogsHour "%0.2u" $SexyLogsHour
  nsislog::log "$SexyLogsLogPath" "$SexyLogsYear-$SexyLogsMonth-$SexyLogsDay $SexyLogsHour:$SexyLogsMinute:$SexyLogsSeconds DEBUG ${message}"
!macroend

!macro logWarning message
  ${GetTime} "" "L" $SexyLogsDay $SexyLogsMonth $SexyLogsYear $SexyLogsDayOfWeekName $SexyLogsHour $SexyLogsMinute $SexyLogsSeconds
  IntFmt $SexyLogsHour "%0.2u" $SexyLogsHour
  nsislog::log "$SexyLogsLogPath" "$SexyLogsYear-$SexyLogsMonth-$SexyLogsDay $SexyLogsHour:$SexyLogsMinute:$SexyLogsSeconds WARN  ${message}"
!macroend

!macro logError message
  ${GetTime} "" "L" $SexyLogsDay $SexyLogsMonth $SexyLogsYear $SexyLogsDayOfWeekName $SexyLogsHour $SexyLogsMinute $SexyLogsSeconds
  IntFmt $SexyLogsHour "%0.2u" $SexyLogsHour
  nsislog::log "$SexyLogsLogPath" "$SexyLogsYear-$SexyLogsMonth-$SexyLogsDay $SexyLogsHour:$SexyLogsMinute:$SexyLogsSeconds ERROR ${message}"
!macroend


;
; Copy the log file to another destination. If the target file
; already exist then just append the content of the log to the
; end of the file.
; You can use placeholders:
; %Y - year
; %m - month
; %d - day
;
Var SexyLogs_fileExists
!macro logCopyTo targetLogPath
  Push $0 ; hide current $0 value
  
  ${GetTime} "" "L" $SexyLogsDay $SexyLogsMonth $SexyLogsYear $SexyLogsDayOfWeekName $SexyLogsHour $SexyLogsMinute $SexyLogsSeconds
  ${StrRep} '$0' '${targetLogPath}' '%Y' '$SexyLogsYear'
  ${StrRep} '$0' '$0' '%m' '$SexyLogsMonth'
  ${StrRep} '$0' '$0' '%d' '$SexyLogsDay'

  StrCpy $SexyLogs_fileExists "false"
  IfFileExists "$0" 0 +2
    StrCpy $SexyLogs_fileExists "true"
  
  ${If} $SexyLogs_fileExists == "true"
    ${FileJoin} '$0' '$SexyLogsLogPath' '$0'
  ${Else}
    CopyFiles "$SexyLogsLogPath" "$0"
  ${EndIf}
  
  Pop $0 ; pop the original $0 value  
!macroend
