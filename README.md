# NSIS_SexyLogs
A set of macros which make logging in NSIS easier. It automatically logs date, time and logging level. 

If you log date and time manually without SexyLogs you have to write another two lines of code for every log messge. These macros do that work for you behind the scenes and make your code more concise.

It depends on NSISLog plugin http://nsis.sourceforge.net/NSISLog_plug-in

See sample\textSexyLogs.nsh sample script. How to use SexyLogs:

1. Download NSISLog plugin, put it in some folder and register it using "!addplugindir"

2. Include sexyLogs.nsh to your NSIS script using "!include"

3. Call SexyLogs macros

Sample log file:
  ```
  2017-01-29 21:36:35 INFO  Hello World!
  2017-01-29 21:36:35 DEBUG Hello World!
  2017-01-29 21:36:35 WARN  Hello World!
  2017-01-29 21:36:35 ERROR Hello World!
  ```

Macros:
- **logInit**: initializes SexyLogs telling it where to log.

  ```
  !insertmacro logInit "$PLUGINSDIR\sampleLog.log"
  ```  
- **log**: logs a message without a date, time and logging level

  ```!insertmacro logInfo "Hello World!"```
  
- **logDebug**: logs a message at Debug level

  ```!insertmacro logDebug "Hello World!"```
  
- **logInfo**: logs a message at Info level

  ```!insertmacro logInfo "Hello World!"```
  
- **logWarn**: logs a warning message

  ```!insertmacro logWarn "Hello World!"```
  
- **logError**: logs an error message
  
  ```!insertmacro logError "Hello World!"```
  
- **logCopyTo**: copies the log file to some other place.

  You can use placeholders in the file name: %Y - year, %m - month, %d - day

  You may want to call it from '.onInstSuccess' and '.onInstFailed' functions because they are called at the end when you close the installer.

  ```!insertmacro logCopyTo "$INSTDIR\sampleLog.log"```
