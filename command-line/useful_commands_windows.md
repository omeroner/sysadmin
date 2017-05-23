Klasor icindeki tum bat file calistir.
```cmd
for /f %%a IN ('dir /b .\batches\*.bat') do Start  Cmd /C batches\%%a 
pause
```

```cmd
copy D:\backup\db\adserver\adserver_db_*.BAK F:\backup\db\adserver\
xcopy \\212.101.96.109\onlinefriend\*.* Z:\facebook_onlinefriend\ /S/E/V/D/Y
```



