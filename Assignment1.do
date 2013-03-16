clear*log using assignemnt1.log, replaceset more offset graphics oncd /Users/vrangbaek/Dropbox/Studieophold/College_of_Europe/AQM/Assignments/Assignment_1webuse lutkepohl2.dta, cleartssetdes*** a. ***** a.i. ln_inv **scatter ln_inv qtr,graph export fig1.png, replaceac ln_inv, graph export fig2.png, replacepac ln_inv, graph export fig3.png, replacescatter D.ln_inv qtr, graph export fig4.png, replaceac D.ln_inv, graph export fig5.png, replacepac D.ln_inv, graph export fig6.png, replacearima ln_inv, arima(0,1,0)outreg2 using arima1, replace tex(frag) ** a.ii. ln_inc **scatter ln_inc qtr, graph export fig7.png, replaceac ln_inc, graph export fig8.png, replacepac ln_inc, graph export fig9.png, replacescatter D.ln_inc qtr, graph export fig10.png, replaceac D.ln_inc, graph export fig11.png, replacepac D.ln_inc, graph export fig12.png, replacearima ln_inc, arima(0,1,0)outreg2 using arima2, replace tex(frag) ** a.iii. ln_consumpscatter ln_consump qtr, saving(ln_consump_qtr, replace) nodrawac ln_consump, saving(ac_ln_consump, replace) nodrawpac ln_consump, saving(pac_ln_consump, replace) nodrawgraph combine ln_consump_qtr.gph ac_ln_consump.gph pac_ln_consump.gphgraph export fig13.png, replace width(1000)scatter D.ln_consump qtr, saving(ln_consump_qtr, replace) nodrawac D.ln_consump, saving(ac_ln_consump, replace) nodrawpac D.ln_consump, saving(pac_ln_consump, replace) nodrawgraph combine ln_consump_qtr.gph ac_ln_consump.gph pac_ln_consump.gphgraph export fig14.png, replace width(1000)*** b. ***reg ln_consump L(1/4).ln_consump ln_inc ln_invoutreg2 using reg_b1, replace tex(frag)* Mis-specification testsqui {log using misspec.log, replacenoi estat ovtestnoi estat hettestnoi estat imtest, whitequietly capture drop omninormresquietly predict omninormres, residualsnoi omninorm omninormresquietly drop omninormresnoi estat bgodfreynoi estat archlmlog close}*** c. ***qui {log using c1.log, replacenoi reg dln_consump L(1/3).dln_consump dln_inc dln_inv L1.ln_consumplog close}
estimates store llu* Mis-specification testsqui {log using misspec2.log, replacenoi estat ovtestnoi estat hettestnoi estat hettest L(1/3).dln_consump dln_inc dln_inv L1.ln_consumpnoi estat imtest, whitequietly capture drop omninormresquietly predict omninormres, residualsnoi omninorm omninormresquietly drop omninormresnoi estat bgodfrey, lags(1 2 3 4)noi estat archlm, lags(1 2 3 4)log close}

*** d. ***

*** f. ***
* Determine lag structure
var dln_consump dln_inc dln_inv, lags(1/3) dfk
varsoc
var dln_consump dln_inc dln_inv, lags(1/2) dfk
varsoc
* Maybe more mis-specification tests
* Drop variables
constraint 1 [dln_consump]L.dln_inv=0
var dln_consump dln_inc dln_inv, lags(1/2) dfk constraint (1)
constraint 2 [dln_inc]L2.dln_inc=0
var dln_consump dln_inc dln_inv, lags(1/2) dfk constraint (1 2)
constraint 3 [dln_inv]L2.dln_inc=0
var dln_consump dln_inc dln_inv, lags(1/2) dfk constraint (1 2 3)
constraint 4 [dln_inc]L2.dln_consump=0
var dln_consump dln_inc dln_inv, lags(1/2) dfk constraint (1 2 3 4)
constraint 5 [dln_inv]L1.dln_inc=0
var dln_consump dln_inc dln_inv, lags(1/2) dfk constraint (1 2 3 4 5)
constraint 6 [dln_inc]L1.dln_inc=0
var dln_consump dln_inc dln_inv, lags(1/2) dfk constraint (1 2 3 4 5 6)
constraint 7 [dln_inv]L2.dln_inv=0
var dln_consump dln_inc dln_inv, lags(1/2) dfk constraint (1 2 3 4 5 6 7)
constraint 8 [dln_consump]L2.dln_consump=0
var dln_consump dln_inc dln_inv, lags(1/2) dfk constraint (1 2 3 4 5 6 7 8)
varlmar
varnorm


var dln_consump dln_inc dln_inv, lags(1) dfk
constraint 1 [dln_consump]L.dln_inv=0
constraint 2 [dln_inc]L.dln_inc=0
var dln_consump dln_inc dln_inv, lags(1) constraints (1 2) dfk
constraint 3 [dln_inv]L.dln_inc=0
var dln_consump dln_inc dln_inv, lags(1) constraints (1 2 3) dfk
constraint 4 [dln_inc]L.dln_inv=0
var dln_consump dln_inc dln_inv, lags(1) constraints (1 2 3 4) dfkvarlmar
varnorm*log close