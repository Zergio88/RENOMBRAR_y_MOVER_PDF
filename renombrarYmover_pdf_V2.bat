@echo off

echo                **************************************
echo                ** Renombrar y mover pdf "PIRINCHO" **
echo                **************************************
echo.

REM uso:
REM Colocar el script en la carpeta donde se alojan los archivos PDF a mover

REM SETEAR PREVIAMENTE LAS VARIABLES "destino" e "imagenPid"

REM carpeta donde mover los archivos renombrados
set destino=D:/LABURO/PROBAR_MA¥ANA/RE/

REM observacion: incompatibilidad de caracteres especiales del español.
REM Las "Ñ" o acentos no son "leidos en la consola" como figuran en el script.
REM Para saldar eso, una alternativa es:
REM volcar el caracter especial de la "consola" a un "txt"
REM ejemplo: echo Ñ >archivo.txt
REM luego reemplazar en el script, el caracter volcado en el archivo.txt
REM y asegurarse de guardar el script en codificacion compatible con batch
REM por ejemplo ANSI

REM nombre(imagen)del proceso de lector PDF. Tomado del Administrador de tareas 
set imagenPid=SumatraPDF.exe

REM modo que habilita el uso de variable avanzado
setlocal enabledelayedexpansion

@for /f "tokens=*" %%z in ('dir *.pdf /b') do (

start %%z

set /p nombre=ingrese nombre del archivo:

REM crashea si no se setea un nombre. Se puso el siguiente "if" para solucionar eso:
if not defined nombre (

echo EL ARCHIVO NO SE MOVIO, SE DEBE PONER UN NOMBRE
REM los archivos NO MOVIDOS, no seran leidos hasta que cierre y vuelva a abrir el programa

taskkill /IM !imagenPid!>nul

pause >nul

) else (

taskkill /IM !imagenPid!>nul

timeout 2 /NOBREAK>nul

@move /-Y %%z !destino!!nombre!.pdf

pause >nul
echo.
echo.
	)

REM necesario limpiar la variable para usar "if not defined nombre"	
set nombre=
	
)

@echo terminado
@pause>nul