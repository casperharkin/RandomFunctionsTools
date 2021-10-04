#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SuperDetails := {}





;
;FileRead, OutputVar, C:\Users\babb\Desktop\SuperList.txt
;
;Loop, parse, OutputVar, `n, `r
;{
;	r .= "SuperDetails[""" . StrSplit(A_LoopField, ",").1 . """] := " SubStr(A_LoopField, Length := StrLen(StrSplit(A_LoopField, ",").1)+2) "`n"
;}
;	Clipboard := r

SuperDetails := {}
SuperDetails["NEPAXG"] := {Name:"AXA Generations Personal Super- Carol Duke",Street:"750 Collins Street", State:"West Victoria  VIC  8007"}
SuperDetails["NEPAXG"] := {Name:"SPNT PTY LTD",Street:"PO Box 1827", State:"New Farm  QLD  4005"}
SuperDetails["NEPNV1"] := {Name:"SPNT NL - FM (SALARY PACKAGING AND NEW TECHNOLOGY PTY LTD)",Street:"PO BOX 1827", State:"NEW FARM QLD 4005"}
SuperDetails["NEPNV2"] := {Name:"SPNT NL - ECM (SALARY PACKAGING AND NEW TECHNOLOGY PTY LTD)",Street:"PO BOX 1827", State:"NEW FARM QLD 4005"}
SuperDetails["NEPNV3"] := {Name:"EPAC NL - FM (EPAC SALARY SOLUTIONS PTY LTD)",Street:"PO BOX 373", State:"RUNDLE MALL SA 5000"}
SuperDetails["NEPNV4"] := {Name:"EPAC NL - ECM (EPAC SALARY SOLUTIONS PTY LTD)",Street:"PO BOX 373", State:"RUNDLE MALL SA 5000"}
SuperDetails["NEPNV5"] := {Name:"FLEETNETWORK NL - FM (FLEETNETWORK)",Street:"PO Box 2461", State:"MALAGA WA 6090"}
SuperDetails["NEPNV6"] := {Name:"FLEETNETWORK NL - ECM (FLEETNETWORK)",Street:"PO Box 2461", State:"MALAGA WA 6090"}
SuperDetails["NEPNV7"] := {Name:"Vehicle Solutions Australia (Novated Lease Company)",Street:"PO Box 1625", State:"PALMERSTON NT 0831"}
SuperDetails["NEPNV8"] := {Name:"Fleet Choice NT (Novated Lease Company)",Street:"GPO Box 3961", State:"DARWIN NT 0801"}
SuperDetails["NEPPOW"] := {Name:"PowerWater In-House Benefits",Street:"Salary Packaging Unit & Executive Payroll Unit", State:""}
SuperDetails["NEPX09"] := {Name:"The Portfolio Service (Executive)",Street:"Locked Bag 800", State:"Milsons Point NSW 1565"}
SuperDetails["NEPX13"] := {Name:"Smartsave Members Choice - J Harrison",Street:"PO Box 20314", State:"World Square"}
SuperDetails["NEPX14"] := {Name:"QSuper",Street:"GPO Box 200", State:"Brinband QLD 4002"}
SuperDetails["NEPX24"] := {Name:"MLC WRAP SUPER",Street:"GPO BOX 2567", State:"MELBOURNE  VIC  3001"}
SuperDetails["OTENJTK"] := {Name:"Central Australia Hospital Network CRA Fund",Street:"GPO Box 2391", State:"Darwin  NT  0801"}
SuperDetails["OTENTC"] := {Name:"DCIS CRA Fund",Street:"GPO Box 2391", State:"Darwin  NT  0801"}
SuperDetails["OTENTE"] := {Name:"NT Land Corp CRA Fund",Street:"PO Q106, QVB Post Shop", State:"Sydney NSW 1229"}
SuperDetails["OTENTG"] := {Name:"Government Printing Office CRA Fund",Street:"GPO Box 1447", State:"Darwin NT 0801"}
SuperDetails["OTENTJ"] := {Name:"Top End Hospital Network CRA Fund",Street:"GPO Box 2391", State:"Darwin  NT  0801"}
SuperDetails["OTENTL"] := {Name:"Legal Aid Commission CRA Fund",Street:"GPO Box 2391", State:"Darwin  NT  0801"}
SuperDetails["OTENTP"] := {Name:"PAWA CRA FUND",Street:"PO Box 2391", State:"Darwin  NT  0801"}
SuperDetails["OTENTS"] := {Name:"Batchelor CRA fund",Street:"RTM Palm Court", State:"PO Box 2391"}
SuperDetails["OTENTT"] := {Name:"Land Development Corporation CRA Fund",Street:"PO Box 2391", State:"Darwin  NT  0801"}
SuperDetails["OTN000"] := {Name:"Commonwealth Life Personal Super",Street:"PO Box 3306", State:"Sydney  NSW  1030"}
SuperDetails["OTN001"] := {Name:"Commonwealth Bank Superannuation Savings Account",Street:"GPO Box 3306", State:"Sydney NSW 2001"}
SuperDetails["OTN003"] := {Name:"Health Super Fund",Street:"Locked Bag 2900 Collins Street", State:"West Melbourne  VIC  8007"}
SuperDetails["OTN004"] := {Name:"AXA Australia",Street:"Super Department", State:"PO Box 14669"}
SuperDetails["OTN005"] := {Name:"MLC Empl Retirement Plan",Street:"PO Box 200", State:"North Sydney  NSW 2059"}
SuperDetails["OTN006"] := {Name:"MLC Universal Super",Street:"MLC Nominees Pty Ltd", State:"105-153 Miller Street"}
SuperDetails["OTN007"] := {Name:"REST",Street:"PO Box 350", State:"Parramatta  NSW 2124"}
SuperDetails["OTN008"] := {Name:"NAB All in One Super",Street:"PO Box 4341", State:"Melbourne  Vic  3001"}
SuperDetails["OTN009"] := {Name:"LifeTrack Superannuation Fund",Street:"GPO Box 264C", State:"Melbourne VIC 3001"}
SuperDetails["OTN012"] := {Name:"UNISUPER",Street:"Level 37 385 Burke", State:"Street Melbourne  Vic  3000"}
SuperDetails["OTN013"] := {Name:"HESTA",Street:"PO Box 600", State:"CARLTON SOUTH VIC 3053"}
SuperDetails["OTN015"] := {Name:"AMP Superleader Plan",Street:"Locked Bag 5095", State:"Parramatta, NSW 2124"}
SuperDetails["OTN022"] := {Name:"Westpac Lifetime Super",Street:"GPO BOX 3960", State:"Sydney  NSW  2001"}
SuperDetails["OTN024"] := {Name:"C+BUS",Street:"Locked Bag 999", State:"Carlton South  VIC 3053"}
SuperDetails["OTN026"] := {Name:"Host Plus Superannuation Fund",Street:"Locked Bag 999", State:"Carlton South  Vic  3053"}
SuperDetails["OTN027"] := {Name:"MTAA Superannuation Fund",Street:"Locked Bag 15", State:"HayMarket  NSW 1236"}
SuperDetails["OTN028"] := {Name:"TAL Superannuation and Insurance Fund",Street:"PO Box 142", State:"Milsons Point NSW 1565"}
SuperDetails["OTN030"] := {Name:"TWU Superannuation Fund",Street:"GPO Box 4689", State:"Melbourne  VIC  8060"}
SuperDetails["OTN031"] := {Name:"Media Super",Street:"Locked Bag 1229", State:"Wollongong  NSW  2500"}
SuperDetails["OTN032"] := {Name:"MLC Masterkey Superannuation Fund",Street:"PO Box 1315", State:"North Sydney  NSW  2059"}
SuperDetails["OTN033"] := {Name:"ASGARD Independence Plan Division One",Street:"PO Box 7490", State:"Cloisters Square  WA  6850"}
SuperDetails["OTN036"] := {Name:"Sunsuper Superannuation Fund",Street:"PO Box 2924", State:"Brisbane  QLD 4001"}
SuperDetails["OTN037"] := {Name:"CARE Superannuation",Street:"Locked Bag 5087", State:"Parramatta NSW 2124"}
SuperDetails["OTN039"] := {Name:"Asteron Life Ltd",Street:"GPO Box 1576", State:"Sydney  NSW 2001"}
SuperDetails["OTN041"] := {Name:"SYNERGY Superannuation Fund",Street:"GPO Box 852", State:"Hobart  TAS 7001"}
SuperDetails["OTN042"] := {Name:"The Portfolio Service",Street:"Locked Bag 800", State:"Milsons Point NSW 1565"}
SuperDetails["OTN043"] := {Name:"VICSUPER",Street:"PO Box 89", State:"Melbourne  Vic  3001"}
SuperDetails["OTN044"] := {Name:"BUSS(Q) Superannuation Fund",Street:"PO Box 902", State:"SPRING HILL QLD 4004"}
SuperDetails["OTN046"] := {Name:"BT Life Super",Street:"BT Financial Group", State:"GPO Box 2675"}
SuperDetails["OTN048"] := {Name:"ING Life Limited",Street:"GPO Box 5306", State:"Sydney  NSW  2001"}
SuperDetails["OTN050"] := {Name:"Zurich Australia Superannuation",Street:"PO Box 994", State:"North Sydney  NSW  2059"}
SuperDetails["OTN051"] := {Name:"ANZ Superannuation",Street:"GPO BOX 4028", State:"Sydney  NSW 2001"}
SuperDetails["OTN052"] := {Name:"MAP Personal Pension Plan",Street:"PO Box 1130", State:"Brisbane  QLD 4001"}
SuperDetails["OTN056"] := {Name:"APEX SUPER",Street:"GPO Box  398", State:"NORTH SYDNEY NSW 2059"}
SuperDetails["OTN057"] := {Name:"Australian Ethical Retail Superannuation Fund (aka Australian Ethical Super Fund)",Street:"Attn: Emily Price", State:"GPO Box 529"}
SuperDetails["OTN058"] := {Name:"Statewide Superannuation Trust",Street:"GPO Box 1749", State:"Adelaide  SA  5001"}
SuperDetails["OTN059"] := {Name:"Advance Super",Street:"GPO Box B87", State:"Perth  WA  6838"}
SuperDetails["OTN060"] := {Name:"Guild Super",Street:"GPO BOX 1088", State:"MELBOURNE  VIC  3001"}
SuperDetails["OTN063"] := {Name:"Catholic Superannuation Fund",Street:"PO Box 2163", State:"Melbourne  Vic  3001"}
SuperDetails["OTN064"] := {Name:"TASPLAN Super",Street:"PO Box 1547", State:"Hobart  TAS 7001"}
SuperDetails["OTN065"] := {Name:"AUSTSAFE Superannuation Fund",Street:"GPO Box 3113", State:"Brisbane  QLD  4001"}
SuperDetails["OTN066"] := {Name:"Colonial Mutual Super (aka Colonial Mutual Life Assurance)",Street:"PO Box 320", State:"Silverwater  NSW  2128"}
SuperDetails["OTN067"] := {Name:"Australian Primary Superannuation Fund",Street:"Locked Bag 2229", State:"Wollongong DC NSW 2500"}
SuperDetails["OTN068"] := {Name:"Summit Master Trust Personal Superannuation & Pension Plan",Street:"GPO Box 2754", State:"MELBOURNE  VIC  3001"}
SuperDetails["OTN069"] := {Name:"Colonial Master Fund (aka Colonial Select Superannuation Fund)",Street:"Locked Bag 5075", State:"Parramatta  NSW 2124"}
SuperDetails["OTN070"] := {Name:"AustralianSuper Corporate",Street:"GPO Box 4303", State:"Melbourne VIC 3001"}
SuperDetails["OTN072"] := {Name:"ANZ Super Advantage",Street:"GPO BOX 4028", State:"Sydney  NSW 2001"}
SuperDetails["OTN073"] := {Name:"Finium Super Master Plan",Street:"GPO Box 529", State:"Hobart  TAS  7001"}
SuperDetails["OTN080"] := {Name:"SimpleWRAP",Street:"GPO Box 2945, Melbourne VIC 3001", State:""}
SuperDetails["OTN081"] := {Name:"Health Industry Plan (HIP)",Street:"Locked Bag 20 Grosvenor Pl", State:"Sydney  NSW 1216"}
SuperDetails["OTN083"] := {Name:"ASSET (Australian Superannuation Savings Employment Trust)",Street:"GPO Box 4030", State:"Sydney  NSW 2001"}
SuperDetails["OTN090"] := {Name:"Symetry Lifetime Super",Street:"Locked Bag 3460", State:"Melbourne VIC 3001"}
SuperDetails["OTN091"] := {Name:"Navigator Super Solutions",Street:"GPO Box 2567", State:"Melbourne Vic 3001"}
SuperDetails["OTN092"] := {Name:"Plan B Superannuation Fund",Street:"Plan B Wealth Management", State:"PO Box 7008"}
SuperDetails["OTN095"] := {Name:"Non Government Schools Superannuation Fund",Street:"NGS Super", State:"GPO Box 4303"}
SuperDetails["OTN102"] := {Name:"Colonial Personal Super Fund",Street:"Locked Bag 5790", State:"Parramatta  NSW  2124"}
SuperDetails["OTN103"] := {Name:"Colonial First State First Choice",Street:"GPO Box 3956", State:"Sydney NSW 2001"}
SuperDetails["OTN107"] := {Name:"Retirement Portfolio Services",Street:"Locked Bag 50", State:"Australian Square NSW 1215"}
SuperDetails["OTN109"] := {Name:"AustChoice Super Plan",Street:"Attn: Emily Price", State:"GPO Box 529"}
SuperDetails["OTN117"] := {Name:"Christian Super",Street:"Locked Bag 5073", State:"Parramatta NSW 2124"}
SuperDetails["OTN119"] := {Name:"AustralianSuper Industry",Street:"GPO Box 1901R", State:"Melbourne Vic  3000"}
SuperDetails["OTN122"] := {Name:"New Name: MLC Navigator Retirement Plan",Street:"GPO Box 2567W", State:"Melbourne  Vic  3001"}
SuperDetails["OTN123"] := {Name:"Strategy Retirement Fund",Street:"Locked Bag 1000", State:"Wollongong NSW 2500"}
SuperDetails["OTN125"] := {Name:"QIEC Superannuation Trust",Street:"PO Box 2130", State:"MILTON QLD 4064"}
SuperDetails["OTN127"] := {Name:"Recruitment Services Superannuation Fund",Street:"GPO Box 4839VV", State:"Melbourne  VIC  3001"}
SuperDetails["OTN129"] := {Name:"WESTPAC Super Investment Fund",Street:"GPO Box 2362", State:"Adelaide  SA  5001"}
SuperDetails["OTN130"] := {Name:"Suncorp Metway Easy Super",Street:"PO Box 1453", State:"Brisbane  QLD 4001"}
SuperDetails["OTN131"] := {Name:"Perpetual Investor Choice Retirement Fund (aka Perpetual Wealth Focus Super Plan)",Street:"GPO Box 4171", State:"Sydney NSW 2001"}
SuperDetails["OTN137"] := {Name:"Bendigo Super Plan",Street:"GPO Box 529", State:"Hobart  TAS  7001"}
SuperDetails["OTN138"] := {Name:"AMP Retirement Savings Account",Street:"LOCKED BAG 5400", State:"PARAMATTA  NSW  1741"}
SuperDetails["OTN139"] := {Name:"AMP Miscellaneous",Street:"LOCKED BAG 5400", State:"PARAMATTA NSW 1741"}
SuperDetails["OTN140"] := {Name:"AMP Flexible Lifetime Super",Street:"LOCKED BAG 5400,", State:"PARAMATTA, NSW, 1741"}
SuperDetails["OTN143"] := {Name:"AustralianSuper Industry",Street:"GPO Box 1901R", State:"Melbourne Vic  3000"}
SuperDetails["OTN146"] := {Name:"Managed Australian Retirement Fund",Street:"PO Box 7074", State:"East Brisbane  QLD 4169"}
SuperDetails["OTN148"] := {Name:"Colonial Super Retirement Fund",Street:"PO Box 320", State:"Silverwater  NSW  2128"}
SuperDetails["OTN150"] := {Name:"Vision Super (aka Local Authorities Super)",Street:"PO Box 18041 Collins Street", State:"East Melbourne  VIC  8003"}
SuperDetails["OTN153"] := {Name:"Australian Catholic Superannuation & Retirement Fund",Street:"PO Box 656", State:"Burwood NSW 1805"}
SuperDetails["OTN161"] := {Name:"Mercer Super Trust",Street:"GPO Box 4303", State:"Melbourne  VIC   3001"}
SuperDetails["OTN162"] := {Name:"Combined Fund",Street:"GPO Box 4559", State:"Melbourne  VIC  3001"}
SuperDetails["OTN167"] := {Name:"IOOF Portfolio",Street:"GPO Box 264C", State:"Melbourne VIC 3001"}
SuperDetails["OTN175"] := {Name:"Mentor Superannuation Master Trust",Street:"Matrix Superannuation Fund", State:"Locked Bag 1000"}
SuperDetails["OTN180"] := {Name:"Club Super",Street:"PO Box 2239", State:"Milton QLD 4064"}
SuperDetails["OTN190"] := {Name:"SuperWrap Superannuation",Street:"GPO Box 2337", State:"Adelaide SA 5001"}
SuperDetails["OTN196"] := {Name:"Plum Superannuation Fund",Street:"GPO Box 63A", State:"Melbourne VIC 3000"}
SuperDetails["OTN199"] := {Name:"Intrust Superannuation Fund",Street:"GPO Box 1416", State:"BRISBANE QLD 4001"}
SuperDetails["OTN203"] := {Name:"Masterkey Custom Superannuation (aka Flexiplan Australia Ltd and aka HML Super fund - One source)",Street:"PO Box 7657", State:"Cloister Square WA 6850"}
SuperDetails["OTN211"] := {Name:"FSP Superannuation Fund",Street:"FSP Super Pty Limited", State:"Locked Bag 3460"}
SuperDetails["OTN223"] := {Name:"WA Local Government Superannuation Plan",Street:"PO Box Z5493", State:"St Georges Terrace"}
SuperDetails["OTN224"] := {Name:"Maritime Super - Seafarers",Street:"Level 4, 6 Riverside Quay", State:"Southbank  VIC  3006"}
SuperDetails["OTN230"] := {Name:"Medical & Associated Professions Superannuation Fund",Street:"c/- AMA", State:"14 Stirling Highway"}
SuperDetails["OTN232"] := {Name:"AMP Custom Super",Street:"LOCKED BAG 5400,", State:"PARAMATTA, NSW, 1741"}
SuperDetails["OTN242"] := {Name:"LUCRF (Labour Union Co-Operative Retirement Fund)",Street:"PO Box 211", State:"North Melbourne VIC 3051"}
SuperDetails["OTN243"] := {Name:"Telstra Superannuation Scheme",Street:"PO Box 14309", State:"Melbourne VIC 8001"}
SuperDetails["OTN249"] := {Name:"FuturePlus Super Fund",Street:"GPO Box 2617", State:"Sydney NSW 2001"}
SuperDetails["OTN254"] := {Name:"IPAC Iaccess Personal Super Plan",Street:"C/- Investor Services", State:"GPO BOX 2754"}
SuperDetails["OTN286"] := {Name:"Nationwide Superannuation Fund- NSF Super",Street:"PO Box 42", State:"Charlestown NSW 2290"}
SuperDetails["OTN287"] := {Name:"Australian Enterprise Superannuation Fund (AESuper)",Street:"GPO Box 2258", State:"Melbourne  VIC  3001"}
SuperDetails["OTN288"] := {Name:"Russell SuperSolutions",Street:"Locked Bag A4094", State:"Sydney South NSW 1235"}
SuperDetails["OTN289"] := {Name:"IAccess Personal Superannuation",Street:"PO Box 471  Collins Street", State:"WEST MELBOUNRE VIC 8007"}
SuperDetails["OTN291"] := {Name:"legalsuper",Street:"GPO Box 263C", State:"Melbourne  VIC  3001"}
SuperDetails["OTN296"] := {Name:"The Duncan Superannuation Fund",Street:"PO Box 1427", State:"KATHERINE NT 0851"}
SuperDetails["OTN312"] := {Name:"Virgin Superannuation Fund",Street:"Locked Bag 8", State:"Haymarket NSW 1236"}
SuperDetails["OTN314"] := {Name:"Maritime Super - Stevedores",Street:"Level 4, 6 Riverside Quay", State:"Southbank  VIC  3006"}
SuperDetails["OTN324"] := {Name:"LOCAL SUPER - Division of StatewideSuper)",Street:"PO Box 7035", State:"Hutt Street"}
SuperDetails["OTN330"] := {Name:"The Executive Superannuation Fund",Street:"10 Shelly Street", State:"Sydney  NSW  2000"}
SuperDetails["OTN331"] := {Name:"JR Childs PortfolioOne Superannuation Fund (only for AGS 77753756)",Street:"Locked Bag 50", State:"Australia Square NSW 1215"}
SuperDetails["OTN334"] := {Name:"AON Master Trust",Street:"PO BOX 9819", State:"Sydney NSW 2001"}
SuperDetails["OTN344"] := {Name:"Credit Suisse Asset Management Super MasterWrap",Street:"PO Box R240", State:"Royal Exchange NSW 1225"}
SuperDetails["OTN346"] := {Name:"First State Super",Street:"PO Box 1229", State:"Wollongong  NSW  2500"}
SuperDetails["OTN357"] := {Name:"REI Super Fund",Street:"GPO Box 4303", State:"Melbourne VIC 3001"}
SuperDetails["OTN365"] := {Name:"Spectrum Super Fund",Street:"GPO BOX 529", State:"HOBART   TAS   7001"}
SuperDetails["OTN366"] := {Name:"Lifetime Superannuation Fund",Street:"PO BOX 7008", State:"CLOISTERS SQUARE WA 6850"}
SuperDetails["OTN371"] := {Name:"The Corporate Superannuation Master Trust - Portable Plan",Street:"PO Box 1647", State:"MILTON BC  QLD  4064"}
SuperDetails["OTN396"] := {Name:"Mentor Superannuation Master Trust",Street:"Locked Bag 1000", State:"Wollongong NSW 2500"}
SuperDetails["OTN402"] := {Name:"Energy Super formerly ESI Super",Street:"PO Box 1958", State:"Milton  QLD  4064"}
SuperDetails["OTN421"] := {Name:"Netwealth Superannuation Master Trust Fund",Street:"Netwealth Investments Ltd", State:"Level 7/52 Collins Street"}
SuperDetails["OTN431"] := {Name:"LG Super",Street:"GPO Box 264                                       Brisbane  QLD  4001", State:""}
SuperDetails["OTN433"] := {Name:"Equipsuper Pty Ltd",Street:"Level 12, 114 William Street", State:"MELBOURNE VIC 3000"}
SuperDetails["OTN435"] := {Name:"PortfolioCare eWRAP Super Account",Street:"PortfolioCare", State:"GPO BOX C113"}
SuperDetails["OTN457"] := {Name:"AXA Retirement Bond",Street:"PO Box 14330", State:"Melbourne  VIC  8001"}
SuperDetails["OTN482"] := {Name:"NAB Group Superannuation Fund A (previous NAB employees) (aka NAB Retained Benefit Account)",Street:"PO BOX 1321", State:"MELBOURNE VIC 3001"}
SuperDetails["OTN507"] := {Name:"Garnet Superannuation Fund",Street:"GPO Box 4369", State:"Melbourne  VIC  3001"}
SuperDetails["OTN512"] := {Name:"AvSuper",Street:"GPO Box 367 Canberra ACT 2601", State:""}
SuperDetails["OTN520"] := {Name:"State Super Retirment Fund (aka State Super Personal Retirment Plan)",Street:"State Super Financial Services Pty Ltd", State:"GPO BOX 5336"}
SuperDetails["OTN522"] := {Name:"ANZ OneAnswer Personal Super",Street:"ING Custodians Pty Limited", State:"GPO Box 4028"}
SuperDetails["OTN531"] := {Name:"AMP SignatureSuper",Street:"C/- AMP Life Limited", State:"Locked Bag 5043"}
SuperDetails["OTN540"] := {Name:"Tauondi Rhema Super Fund",Street:"PO BOX 40559", State:"Casuarina NT 0810"}
SuperDetails["OTN544"] := {Name:"DIY Master Plan",Street:"PO BOX 361", State:"Collins Street West"}
SuperDetails["OTN553"] := {Name:"Navigator Access Super and Pension",Street:"Navigator Australia Limited", State:"GPO BOX 2567W"}
SuperDetails["OTN575"] := {Name:"ESS Super",Street:"GPO BOX 1974", State:"MELBOURNE VIC 3001"}
SuperDetails["OTN576"] := {Name:"BHP Billiton Super Fund",Street:"GPO BOX 63", State:"MELBOURNE VIC 3001"}
SuperDetails["OTN577"] := {Name:"AMG Universal Super",Street:"GPO BOX 330", State:"BRISBANE QLD 4000"}
SuperDetails["OTN598"] := {Name:"Wealthtrac",Street:"Locked Bag 1000", State:"WOLLONGONG  NSW  2500"}
SuperDetails["OTN604"] := {Name:"PLUM PERSONAL PLAN (previously Vanguard Personal Superannuation Plan)",Street:"PLUM FINANCIAL SERVICES LIMITED", State:"REPLY PAID 63"}
SuperDetails["OTN621"] := {Name:"TIC Retirement Plan",Street:"TIC Retirement Plan", State:"PO Box 1282"}
SuperDetails["OTN628"] := {Name:"Prime Super",Street:"PO Box 2229", State:"Wollongong  NSW  2500"}
SuperDetails["OTN647"] := {Name:"MLC MasterKey Business Super",Street:"MLC", State:"PO Box 200"}
SuperDetails["OTN653"] := {Name:"QSuper",Street:"GPO Box 200, Brisband QLD 4001", State:""}
SuperDetails["OTN659"] := {Name:"AUST(Q)",Street:"PO Box 329", State:"SPRING HILL QLD 4004"}
SuperDetails["OTN660"] := {Name:"North - Wealth Personal Superannuation + Pension Plan",Street:"North Service Centre", State:"GPO Box 2915 Melbourne, VIC 3001"}
SuperDetails["OTN664"] := {Name:"AMIST Super (Australian Meat Industry Super Trust)",Street:"1A Homebush Bay Drive", State:"Rhodes  NSW  2138"}
SuperDetails["OTN667"] := {Name:"Local Government Superannuation Scheme",Street:"PO Box N835", State:"Grosvenor Place NSW 1220"}
SuperDetails["OTN674"] := {Name:"Club Plus Superannuation",Street:"Locked Bag 5007", State:"Parramatta NSW 2124"}
SuperDetails["OTN714"] := {Name:"MLC Wrap Super",Street:"GPO BOX 2567", State:"MELBOURNE  VIC  3001"}
SuperDetails["OTN723"] := {Name:"FirstWrap Super",Street:"Avanteos Superannuation Trust Fund", State:"FirstWrap"}
SuperDetails["OTN749"] := {Name:"Water Corporation Superannuation Plan",Street:"PO Box 241", State:"West Perth WA 6872"}
SuperDetails["OTN750"] := {Name:"Super Directions for Business",Street:"PO Box 14669", State:"Melbourne VIC 8001"}
SuperDetails["OTN752"] := {Name:"Integra Super",Street:"GPO BOX 5306", State:"Sydney NSW 2001"}
SuperDetails["OTN766"] := {Name:"Super Directions Personal Super Plan",Street:"AXA Australia", State:"Custormer Service"}
SuperDetails["OTN785"] := {Name:"Emplus Superannuation",Street:"PO Box 3528", State:"TINGALPA DC, QLD 4173"}
SuperDetails["OTN856"] := {Name:"Medical & Associated Professions Superannuation Fund",Street:"GPO Box 529", State:"Hobart TAS 7001"}
SuperDetails["OTN865"] := {Name:"Voyage Superannution Master Trust",Street:"Locked Bag 1000", State:"Wollongong DC NSW 2500"}
SuperDetails["OTN873"] := {Name:"ING Direct Living Superannuation Fund",Street:"Reply Paid 4307", State:"Sydney NSW 2001"}
SuperDetails["OTN876"] := {Name:"BT Superannuation Investment Fund",Street:"GPO Box 2675 Sydney NSW 2001", State:""}
SuperDetails["OTN878"] := {Name:"Compass Ewarp",Street:"PO Box 7241", State:"Cloisters Square Perth WA 6839"}
SuperDetails["OTN891"] := {Name:"Quadrant Superannuation",Street:"GPO Box 863", State:"Hobart TAS 7001"}
SuperDetails["OTN907"] := {Name:"Qantas Staff Credit Union Retirement Savings Account",Street:"420 Forest Road", State:"Hurstville NSW 2220"}
SuperDetails["OTN912"] := {Name:"Police Credit SuperFuture RSA",Street:"PO Box 669", State:"CARTON SOUTH VIC 3053"}
SuperDetails["OTN948"] := {Name:"Mercy Super",Street:"PO Box 8334", State:"Woolloongabba QLD 4102"}

MsgBox % SuperDetails["NEPNV2"].Street
Exit
