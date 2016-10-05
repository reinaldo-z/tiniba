## metapost
set term mp solid color  latex magnification 1
set out 'fig.mp'
set multiplot
set lmargin 10
# set size 1.4,1.4
#
set xrange [1.6:2.1]
#
set origin 0,2

set ylabel "\\Large $\\eta^{yyz}(10^{8}\\,A\\,s^{-1}\\,V^{-2})$" 
g=1e-8
p 'data/cdse/eta_ec.sm_0.05_yyz_3234_15-spin_scissor_0.88_Nc_24' u 1:(g*$2) w l t ' '

set origin 0,1
set ylabel '\Large Swarm velocity $v^y$ (Km/s)' 
set xlabel "\\Large photon-energy (eV)"
f=2.958e-9
p '<paste data/cdse/eta2.kk_yyz_3234_15-spin_scissor_0.88_Nc_24 data/cdse/chi1.kk_xx_yy_zz_3234_15-spin_scissor_0.88_Nc_24' u 1:(f*$2/($5+$7+.0001)) w l t ' '
