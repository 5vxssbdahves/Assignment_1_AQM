clear*log using assignemnt1.log, replaceset more offset graphics oncd /Users/vrangbaek/Dropbox/Studieophold/College_of_Europe/AQM/Assignments/Assignment_1webuse lutkepohl2.dta, cleartssetdes*** a. ***** a.i. ln_inv **scatter ln_inv qtr, saving(ln_inv_qtr, replace) nodrawac ln_inv, saving(ac_ln_inv, replace) nodrawpac ln_inv, saving(pac_ln_inv, replace) nodrawquietly graph combine ln_inv_qtr.gph ac_ln_inv.gph pac_ln_inv.gphgraph export fig1.png, replace width(1000)scatter D.ln_inv qtr, saving(dln_inv_qtr, replace) nodrawac D.ln_inv, saving(dac_ln_inv, replace) nodrawpac D.ln_inv, saving(dpac_ln_inv, replace) nodrawgraph combine dln_inv_qtr.gph dac_ln_inv.gph dpac_ln_inv.gphgraph export fig4.png, replace width(1000)
qui {log using arima1.log, replacenoi di ". arima ln_inv, arima(0,1,0)"noi arima ln_inv, arima(0,1,0)log close}

qui {log using arima1a.log, replacenoi di ". arima ln_inv, arima(4,1,4)"noi arima ln_inv, arima(4,1,4)log close}

qui {log using arima1a.log, replacenoi di ". arima ln_inv, arima(4,1,4)"noi arima ln_inv, arima(4,1,4)
predict res1,rlog close}

qui {log using arima1b.log, replacenoi di ". armaroots"noi armaroots
graph export fig1b.png, replacelog close}

ac res1, saving(res1ac, replace) nodraw
pac res1, saving(res1pac, replace) nodraw
graph combine res1ac.gph res1pac.gph, cols(1) rows(2)
graph export fig1res.png, replace

qui {
log using arima1c.log, replace
noi di ". wntestq res1"
noi wntestq res1
log close
}** a.ii. ln_inc **scatter ln_inc qtr, saving(ln_inc_qtr, replace) nodrawac ln_inc, saving(ac_ln_inc, replace) nodrawpac ln_inc, saving(pac_ln_inc, replace) nodrawgraph combine ln_inc_qtr.gph ac_ln_inc.gph pac_ln_inc.gphgraph export fig7.png, replace width(1000)scatter D.ln_inc qtr, saving(dln_inc_qtr, replace) nodrawac D.ln_inc, saving(dac_ln_inc, replace) nodrawpac D.ln_inc, saving(dpac_ln_inc, replace) nodrawgraph combine dln_inc_qtr.gph dac_ln_inc.gph dpac_ln_inc.gphgraph export fig10.png, replace width(1000)arima ln_inc, arima(0,1,0)outreg2 using arima2, replace tex(frag) ** a.iii. ln_consumpscatter ln_consump qtr, saving(ln_consump_qtr, replace) nodrawac ln_consump, saving(ac_ln_consump, replace) nodrawpac ln_consump, saving(pac_ln_consump, replace) nodrawgraph combine ln_consump_qtr.gph ac_ln_consump.gph pac_ln_consump.gphgraph export fig13.png, replace width(1000)scatter D.ln_consump qtr, saving(ln_consump_qtr, replace) nodrawac D.ln_consump, saving(ac_ln_consump, replace) nodrawpac D.ln_consump, saving(pac_ln_consump, replace) nodrawgraph combine ln_consump_qtr.gph ac_ln_consump.gph pac_ln_consump.gphgraph export fig14.png, replace width(1000)*** b. ***
qui {
log using b1.log, replace
noi di ". reg ln_consump L(1/4).ln_consump ln_inc ln_inv"noi reg ln_consump L(1/4).ln_consump ln_inc ln_invlog close
}* Mis-specification testsqui {log using misspec.log, replacenoi estat ovtestnoi estat hettestnoi estat imtest, whitequietly capture drop omninormresquietly predict omninormres, residualsnoi omninorm omninormresquietly drop omninormresnoi estat bgodfreynoi estat archlmlog close}*** c. ***qui {log using c1.log, replacenoi reg dln_consump L(1/3).dln_consump dln_inc dln_inv L1.ln_consumplog close}
estimates store llu* Mis-specification testsqui {log using misspec2.log, replacenoi estat ovtestnoi estat hettestnoi estat hettest L(1/3).dln_consump dln_inc dln_inv L1.ln_consumpnoi estat imtest, whitequietly capture drop omninormresquietly predict omninormres, residualsnoi omninorm omninormresquietly drop omninormresnoi estat bgodfrey, lags(1 2 3 4)noi estat archlm, lags(1 2 3 4)log close}

*** d. ***
qui {log using c2.log, replacenoi reg dln_consump L(1/3).dln_consump dln_inc dln_invlog close}
estimates store llr
* Mis-specification testsqui {log using misspec3.log, replacenoi estat ovtestnoi estat hettestnoi estat hettest L(1/3).dln_consump dln_inc dln_invnoi estat imtest, whitequietly capture drop omninormresquietly predict omninormres, residualsnoi omninorm omninormresquietly drop omninormresnoi estat bgodfrey, lags(1 2 3 4)noi estat archlm, lags(1 2 3 4)log close}

qui {
log using d1.log, replace
noi testparm L3.dln_consump
log close
}

*** e. ***
qui {
log using e1.log, replace
noi di ". lrtest llu llr"
noi lrtest llu llr
log close
}

*** f. ***
* run VAR(4)
qui {
log using f0.log, replace
noi di ". var dln_consump dln_inc dln_inv, lags(1/4) dfk"
noi var dln_consump dln_inc dln_inv, lags(1/4) dfk
noi di ". varsoc"
noi varsoc
log close
}

* Determine lag structure
qui {
log using f1.log, replace
noi di ". var dln_consump dln_inc dln_inv, lags(1/3) dfk"
noi var dln_consump dln_inc dln_inv, lags(1/3) dfk
noi di ". varsoc"
noi varsoc
log close
}
qui {
log using f2.log, replace
noi di ". dln_consump dln_inc dln_inv, lags(1/2) dfk"
noi var dln_consump dln_inc dln_inv, lags(1/2) dfk
noi di ". varsoc"
noi varsoc
noi di ". varlmar"
noi varlmar
noi di ". varnorm"
noi varnorm
noi di ". varwle"
noi varwle
log close
}




*** g. ***
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
qui {
log using g1.log, replace
noi di ". var dln_consump dln_inc dln_inv, lags(1/2) dfk constraint (1 2 3 4 5 6 7 8)"
noi var dln_consump dln_inc dln_inv, lags(1/2) dfk constraint (1 2 3 4 5 6 7 8)
noi di ". varlmar"
noi varlmar
noi di ". varnorm"
noi varnorm
log close
}