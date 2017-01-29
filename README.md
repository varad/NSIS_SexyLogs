# NSIS_SexyLogs
A set of macros which make logging in NSIS easier. It automatically logs date, time and logging level.

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
- **logInit**: initializes Sexy log telling it where to log

  ```
  !insertmacro logInit "$PLUGINSDIR\sampleLog.log"
  ```  
- **log**```!insertmacro logInfo "Hello World!"```
- **logDebug**  ```!insertmacro logDebug "Hello World!"```
- **logInfo**   ```!insertmacro logInfo "Hello World!"```
- **logWarn**   ```!insertmacro logWarn "Hello World!"```
- **logError**  ```!insertmacro logError "Hello World!"```
