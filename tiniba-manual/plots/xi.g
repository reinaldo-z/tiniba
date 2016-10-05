## metapost
set term mp solid color  latex magnification 1
set out 'fig.mp'
#set multiplot
#set lmargin 10
#
set xrange [1:5]
#

set ylabel "\\Large $\\xi^{xx}(\\omega)(10^{24}\\,V^{-2}\\,m^{-1}\\,s^{-1})$]" 
set xlabel '\Large $\hbar\omega$ (eV)'

#set origin 0,2
f=2.1102
p 'data/gaas/chi1.kk_xx_yy_zz_5216_15-spin_scissor_0_Nc_24' u 1:(f*$3) w l t 'GaAs',\
  'data/si/chi1.kk_xx_yy_zz_5216_15-spin_scissor_0_Nc_24' u 1:(f*$3) w l t 'Si'

