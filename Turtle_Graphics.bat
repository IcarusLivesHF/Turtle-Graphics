@echo off & setlocal enableDelayedExpansion
set /a "wid=200, hei=150"
mode %wid%,%hei%

call :turtleGraphics

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
(for /f %%a in ('echo prompt $E^| cmd') do set "\e=%%a" )
<nul set /p "=%\e%[?25l"

(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

set "sin=(a=((x*31416/180)%%62832)+(((x*31416/180)%%62832)>>31&62832), b=(a-15708^a-47124)>>31,a=(-a&b)+(a&~b)+(31416&b)+(-62832&(47123-a>>31)),a-a*a/1875*a/320000+a*a/1875*a/15625*a/16000*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000) / 10000"
set "cos=(a=((15708-x*31416/180)%%62832)+(((15708-x*31416/180)%%62832)>>31&62832), b=(a-15708^a-47124)>>31,a=(-a&b)+(a&~b)+(31416&b)+(-62832&(47123-a>>31)),a-a*a/1875*a/320000+a*a/1875*a/15625*a/16000*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000) / 10000"
set /a "DFX=wid / 2", "DFY=hei / 2", "DFA=0", "turtle.R=255","turtle.G=255","turtle.B=255", "push=0"
set "penDown=false"
set "turtleGraphics=%\e%[38;2;!turtle.R!;!turtle.G!;!turtle.B!m"

set turtle.forward=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "DFX+=(%%~1+1)*^!cos:x=DFA^!", "DFY+=(%%~1+1)*^!sin:x=DFA^!"%\n%
	if /i "^!penDown^!" equ "true" (%\n%
		^<nul set /p "turtleGraphics=^!turtleGraphics^!%\e%[^!dfy^!;^!dfx^!HÛ"%\n%
	)%\n%
)) else set args=

set turtle.backward=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "DFX-=(%%~1+1)*^!cos:x=DFA^!", "DFY-=(%%~1+1)*^!sin:x=DFA^!"%\n%
	if /i "^!penDown^!" equ "true" (%\n%
		^<nul set /p "turtleGraphics=^!turtleGraphics^!%\e%[^!dfy^!;^!dfx^!HÛ"%\n%
	)%\n%
)) else set args=

set turtle.left=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "DFA-=%%~1"%\n%
)) else set args=

set turtle.right=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "DFA+=%%~1"%\n%
)) else set args=

set turtle.setx=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "dfx=%%~1"%\n%
)) else set args=

set turtle.sety=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "dfy=%%~1"%\n%
)) else set args=

set turtle.seta=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	set /a "dfa=%%~1"%\n%
)) else set args=

set turtle.goto=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1,2" %%1 in ("^!args^!") do (%\n%
	set /a "dfx=%%~1", "dfy=%%~2"%\n%
)) else set args=

set turtle.define=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set /a "dfx=%%~1", "dfy=%%~2", "dfa=%%~3"%\n%
)) else set args=

set turtle.circle=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1" %%1 in ("^!args^!") do (%\n%
	for /l %%i in (0,3,360) do (%\n%
		set /a "cx=%%~1 * ^!cos:x=%%i^! + dfx", "cy=%%~1 * ^!sin:x=%%i^! + dfy"%\n%
		^<nul set /p "turtleGraphics=^!turtleGraphics^!%\e%[^!cy^!;^!cx^!HÛ"%\n%
	)%\n%
)) else set args=

set turtle.color=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	if "%%~1" neq "" ( set "turtle.R=%%~1"%\n%
	if "%%~2" neq "" ( set "turtle.G=%%~2"%\n%
	if "%%~3" neq "" ( set "turtle.B=%%~3" )))%\n%
	set "turtleGraphics=^!turtleGraphics^!%\e%[38;2;^!turtle.R^!;^!turtle.G^!;^!turtle.B^!m"%\n%
)) else set args=

set "HSL(n)=k=(n*100+(%%1 %% 3600)/3) %% 1200, x=k-300, y=900-k, x=y-((y-x)&((x-y)>>31)), x=100-((100-x)&((x-100)>>31)), max=x-((x+100)&((x+100)>>31))"
set turtle.HSLtoRGB=for %%# in (1 2) do if %%#==2 ( for /f "tokens=1-3" %%1 in ("^!args^!") do (%\n%
	set /a "%HSL(n):n=0%", "r=(%%3-(%%2*((10000-%%3)-(((10000-%%3)-%%3)&((%%3-(10000-%%3))>>31)))/10000)*max/100)*255/10000","%HSL(n):n=8%", "g=(%%3-(%%2*((10000-%%3)-(((10000-%%3)-%%3)&((%%3-(10000-%%3))>>31)))/10000)*max/100)*255/10000", "%HSL(n):n=4%", "b=(%%3-(%%2*((10000-%%3)-(((10000-%%3)-%%3)&((%%3-(10000-%%3))>>31)))/10000)*max/100)*255/10000"%\n%
)) else set args=
set "hsl(n)="

set turtle.stamp=set /a "stamp+=1" ^& ^<nul set /p "turtleGraphics=^!turtleGraphics^!%\e%[^!dfy^!;^!dfx^!H^!stamp^!"
set turtle.push=(set /a "push+=1" ^& for %%p in (^^!push^^!) do (set /a "sX[%%p]=DFX, sY[%%p]=DFY, sA[%%p]=DFA"))
set turtle.pop=(for %%p in (^^!push^^!) do (set /a "DFX=sX[%%p], DFY=sY[%%p], DFA=sA[%%p]") ^& set /a "push-=1")
set turtle.home=set /a "DFX=0, DFY=0, DFA=0"
set turtle.center=set /a "DFX=wid/2, DFY=hei/2, DFA=0"
set "turtle.penDown=set penDown=true"
set "turtle.penUp=set penDown=false"
set "turtle.clear=cls & set turtleGraphics="
goto :eof