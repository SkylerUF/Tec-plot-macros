#Important!! This macro must reside in the folder in which you are trying to plot the files! Also pay attention 
#to the extension on your files (.dat,.plt,etc.) it needs to be changed. This macro can be adjusted as need be on a 
#user to user bases
#!MC 1410

$!VarSet |numDigits|     = ""
$!VarSet |FileBase|      = ""
$!VarSet |increment|     = ""
$!VarSet |numberoffiles| = ""
$!VARSET |variable|      = ""

$!PROMPTFORTEXTSTRING |numDigits|
	INSTRUCTIONS = "Number of digits in filename (max 10)"
$!PROMPTFORTEXTSTRING |FileBase|
	INSTRUCTIONS = "Base filename"
$!PROMPTFORTEXTSTRING |increment|
	INSTRUCTIONS = "Increment of file numbers"
$!PROMPTFORTEXTSTRING |numberoffiles|
	INSTRUCTIONS = "Number of total files"
$!PROMPTFORTEXTSTRING |variable|
	INSTRUCTIONS = "Integer Value of desired y axis variable"		

$!LOOP |numberoffiles|
	$!VARSET |add| = (|LOOP|*|increment|)
	$!VARSET |n|   = "|add|"

# format file numbers to correct digits
	$!If |numDigits| == 0
		$!VarSet |finalN| = "|n|"
	$!ElseIf |numDigits| == 1
		$!VarSet |finalN| = "|n|"
	$!ElseIf |numDigits| == 2
		$!VarSet |finalN| = "|n%02d|"
	$!ElseIf |numDigits| == 3
		$!VarSet |finalN| = "|n%03d|"
	$!ElseIf |numDigits| == 4
		$!VarSet |finalN| = "|n%04d|"
	$!ElseIf |numDigits| == 5
		$!VarSet |finalN| = "|n%05d|"
	$!ElseIf |numDigits| == 6
		$!VarSet |finalN| = "|n%06d|"
	$!ElseIf |numDigits| == 7
		$!VarSet |finalN| = "|n%07d|"
	$!ElseIf |numDigits| == 8
		$!VarSet |finalN| = "|n%08d|"
	$!ElseIf |numDigits| == 9
		$!VarSet |finalN| = "|n%09d|"
	$!ElseIf |numDigits| == 10
		$!VarSet |finalN| = "|n%010d|"

	$!Endif

	$!READDATASET "|macrofilepath|/|FileBase||finalN|.dat"
	READDATAOPTION  = APPEND
	VARLOADMODE     = BYNAME
	ASSIGNSTRANDIDS = YES
	VARNAMELIST     = '"x" "Rho Liq" "Rho Gas" "vel" "pressure" "Vol fraction" "mix rho"'
	$!ACTIVELINEMAPS += [1-|numberoffiles|]
	$!LINEMAP  ASSIGN{YAXISVAR = |variable|}

$!ENDLOOP

$!LOOP |numberoffiles|
	$!VARSET |count|=|LOOP|
	$!VARSET |counter|="|count|"
	$!LINEMAP [|counter|]  ASSIGN{ZONE =|counter|}
$!ENDLOOP

$!VIEW FIT

#Will add animation capability in later
