@echo off & setlocal enableDelayedExpansion

call :turtleGraphics turtle 200 150

%turtle.define% wid/2 hei/2-30 0
%turtle.penDown%
for /l %%j in (0,100,3600) do (
	%turtle.stamp%
	%turtle.HSLtoRGB% %%j 10000 5000
	%turtle.color% !r! !g! !b!
	%turtle.circle% 30
	%turtle.right% 10
	%turtle.penUp%
	%turtle.forward% 5
	%turtle.penDown%
)
%turtle.penUp%

echo=%turtleGraphics%%\e%[5;5HRecommended Font: "Raster Fonts" Size: "8x8"
pause >nul & exit /b







:turtleGraphics
if "%~3" neq "" (
	set /a "wid=%~2, hei=%~3"
) else (
	set /a "wid=80, hei=60"
)
mode %wid%,%hei%


(for /f %%a in ('echo prompt $E^| cmd') do set "\e=%%a" )
<nul set /p "=%\e%[?25l"

(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

call :lineMacro

set "sin=(a=((x*31416/180)%%62832)+(((x*31416/180)%%62832)>>31&62832), b=(a-15708^a-47124)>>31,a=(-a&b)+(a&~b)+(31416&b)+(-62832&(47123-a>>31)),a-a*a/1875*a/320000+a*a/1875*a/15625*a/16000*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000) / 10000"
set "cos=(a=((15708-x*31416/180)%%62832)+(((15708-x*31416/180)%%62832)>>31&62832), b=(a-15708^a-47124)>>31,a=(-a&b)+(a&~b)+(31416&b)+(-62832&(47123-a>>31)),a-a*a/1875*a/320000+a*a/1875*a/15625*a/16000*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000) / 10000"
set /a "DFX=wid / 2", "DFY=hei / 2", "DFA=0", "tdfx=dfx", "tdfy=dfy", "turtle.R=255","turtle.G=255","turtle.B=255"
set "penDown=false"
set "saved="
set "turtleGraphics=%\e%[38;2;!turtle.R!;!turtle.G!;!turtle.B!m"

if "%~1" neq "" ( set "prefix=%~1" ) else ( set "prefix=turtle" )

set %prefix%.forward=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2" %%1 in ("^!args^!") do (%\n%
	set /a "tDFX=(1+%%~1) * ^!cos:x=DFA^! + dfx", "tDFY=(1+%%~1) * ^!sin:x=DFA^! + dfy"%\n%
	if /i "^!penDown^!" equ "true" (%\n%
		^!line^! ^^!dfx^^! ^^!dfy^^! ^^!tdfx^^! ^^!tdfy^^!%\n%
		^<nul set /p "turtleGraphics=^!turtleGraphics^!^!$line^!"%\n%
	)%\n%
	set /a "dfx=tdfx", "dfy=tdfy"%\n%
)) else set args=

set %prefix%.backward=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2" %%1 in ("^!args^!") do (%\n%
	set /a "tDFX=(1-%%~1) * ^!cos:x=DFA^! + dfx", "tDFY=(1-%%~1) * ^!sin:x=DFA^! + dfy"%\n%
	if /i "^!penDown^!" equ "true" (%\n%
		^!line^! ^^!dfx^^! ^^!dfy^^! ^^!tdfx^^! ^^!tdfy^^!%\n%
		^<nul set /p "turtleGraphics=^!turtleGraphics^!^!$line^!"%\n%
	)%\n%
	set /a "dfx=tdfx", "dfy=tdfy"%\n%
)) else set args=

set %prefix%.left=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "DFA=(dfa - %%~1) %% 360"%\n%
)) else set args=

set %prefix%.right=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "DFA=(dfa + %%~1) %% 360"%\n%
)) else set args=

set %prefix%.setx=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "dfx=%%~1"%\n%
	if ^^!dfx^^! lss 0 ( set "dfx=0" ) else if ^^!dfx^^! gtr %wid% set /a "dfx=wid"%\n%
)) else set args=

set %prefix%.sety=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "dfy=%%~1"%\n%
	if ^^!dfy^^! lss 0 ( set "dfy=0" ) else if ^^!dfy^^! gtr %hei% set /a "dfy=hei"%\n%
)) else set args=

set %prefix%.seta=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "dfa=%%~1 %% 360"%\n%
)) else set args=

set %prefix%.goto=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2" %%1 in ("^!args^!") do (%\n%
	set /a "dfx=%%~1", "dfy=%%~2"%\n%
	if ^^!dfx^^! lss 0 ( set "dfx=0" ) else if ^^!dfx^^! gtr %wid% set /a "dfx=wid"%\n%
	if ^^!dfy^^! lss 0 ( set "dfy=0" ) else if ^^!dfy^^! gtr %hei% set /a "dfy=hei"%\n%
)) else set args=

set %prefix%.define=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set /a "dfx=%%~1", "dfy=%%~2", "dfa=%%~3 %% 360"%\n%
	if ^^!dfx^^! lss 0 ( set "dfx=0" ) else if ^^!dfx^^! gtr %wid% set /a "dfx=wid"%\n%
	if ^^!dfy^^! lss 0 ( set "dfy=0" ) else if ^^!dfy^^! gtr %hei% set /a "dfy=hei"%\n%
)) else set args=

set %prefix%.circle=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	for /l %%i in (0,3,360) do (%\n%
		set /a "cx=%%~1 * ^!cos:x=%%i^! + dfx", "cy=%%~1 * ^!sin:x=%%i^! + dfy"%\n%
		if ^^!cx^^! gtr 0 if ^^!cx^^! lss %wid% if ^^!cy^^! gtr 0 if ^^!cy^^! lss %hei% (%\n%
			^<nul set /p "turtleGraphics=^!turtleGraphics^!%\e%[^!cy^!;^!cx^!HÛ"%\n%
		)%\n%
	)%\n%
)) else set args=

set %prefix%.color=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	if "%%~1" neq "" ( set "turtle.R=%%~1"%\n%
	if "%%~2" neq "" ( set "turtle.G=%%~2"%\n%
	if "%%~3" neq "" ( set "turtle.B=%%~3" )))%\n%
	set "turtleGraphics=^!turtleGraphics^!%\e%[38;2;^!turtle.R^!;^!turtle.G^!;^!turtle.B^!m"%\n%
)) else set args=

set "HSL(n)=k=(n*100+(%%1 %% 3600)/3) %% 1200, x=k-300, y=900-k, x=y-((y-x)&((x-y)>>31)), x=100-((100-x)&((x-100)>>31)), max=x-((x+100)&((x+100)>>31))"
set %prefix%.HSLtoRGB=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set /a "%HSL(n):n=0%", "r=(%%3-(%%2*((10000-%%3)-(((10000-%%3)-%%3)&((%%3-(10000-%%3))>>31)))/10000)*max/100)*255/10000","%HSL(n):n=8%", "g=(%%3-(%%2*((10000-%%3)-(((10000-%%3)-%%3)&((%%3-(10000-%%3))>>31)))/10000)*max/100)*255/10000", "%HSL(n):n=4%", "b=(%%3-(%%2*((10000-%%3)-(((10000-%%3)-%%3)&((%%3-(10000-%%3))>>31)))/10000)*max/100)*255/10000"%\n%
)) else set args=
set "hsl(n)="

set %prefix%.dot=(%\n%
	if ^^!dfx^^! gtr 0 if ^^!dfx^^! lss %wid% if ^^!dfy^^! gtr 0 if ^^!dfy^^! lss %hei% (%\n%
		set /a "stamp+=1" ^& ^<nul set /p "turtleGraphics=^!turtleGraphics^!%\e%[^!dfy^!;^!dfx^!HÛ"%\n%
))

set %prefix%.stamp=(%\n%
	if ^^!dfx^^! gtr 0 if ^^!dfx^^! lss %wid% if ^^!dfy^^! gtr 0 if ^^!dfy^^! lss %hei% (%\n%
		^<nul set /p "turtleGraphics=^!turtleGraphics^!%\e%[^!dfy^!;^!dfx^!H^!dfa^!"%\n%
))

set %prefix%.push=(set "saved=^!tdfx^!,^!tdfy^!,^!DFX^!,^!DFY^!,^!DFA^! ^!saved^!")
set %prefix%.pop=(for /f "tokens=1-5 delims=, " %%v in ("^!saved^!") do (set /a "tdfx=%%v","tdfy=%%w","DFX=%%x, DFY=%%y, DFA=%%z") ^& set "saved=^!saved:* =^!")
set %prefix%.home=set /a "DFX=0, DFY=0, DFA=0"
set %prefix%.center=set /a "DFX=wid/2, DFY=hei/2, DFA=0"
set "%prefix%.penDown=set penDown=true"
set "%prefix%.penUp=set penDown=false"
set "%prefix%.clear=cls & set turtleGraphics="
goto :eof

:lineMacro
rem line x0 y0 x1 y1 color
set line=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-5" %%1 in ("^!args^!") do (%\n%
	set "$line=[38;2;^!turtle.R^!;^!turtle.G^!;^!turtle.B^!m"%\n%
	set /a "xa=%%~1", "ya=%%~2", "xb=%%~3", "yb=%%~4", "dx=%%~3 - %%~1", "dy=%%~4 - %%~2"%\n%
	if ^^!dy^^! lss 0 ( set /a "dy=-dy", "stepy=-1" ) else ( set "stepy=1" )%\n%
	if ^^!dx^^! lss 0 ( set /a "dx=-dx", "stepx=-1" ) else ( set "stepx=1" )%\n%
	set /a "dx<<=1", "dy<<=1"%\n%
	if ^^!dx^^! gtr ^^!dy^^! (%\n%
		set /a "fraction=dy - (dx >> 1)"%\n%
		for /l %%x in (^^!xa^^!,^^!stepx^^!,^^!xb^^!) do (%\n%
			if ^^!fraction^^! geq 0 set /a "ya+=stepy", "fraction-=dx"%\n%
			set /a "fraction+=dy"%\n%
			set "$line=^!$line^![^!ya^!;%%xHÛ"%\n%
		)%\n%
	) else (%\n%
		set /a "fraction=dx - (dy >> 1)"%\n%
		for /l %%y in (^^!ya^^!,^^!stepy^^!,^^!yb^^!) do (%\n%
			if ^^!fraction^^! geq 0 set /a "xa+=stepx", "fraction-=dy"%\n%
			set /a "fraction+=dx"%\n%
			set "$line=^!$line^![%%y;^!xa^!HÛ"%\n%
		)%\n%
	)%\n%
	set "$line=^!$line^![0m"%\n%
)) else set args=
goto :eof
