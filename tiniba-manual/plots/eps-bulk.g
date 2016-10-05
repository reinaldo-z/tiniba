## metapost
set term mp solid color  latex magnification 1
set out 'fig.mp'
#set multiplot
# set size 1.4,1.4
#
 set xrange [2:10]
#
 set ylabel "\\Large Im[$\\epsilon(\\omega)$]" 
 set xlabel "\\Large photon-energy (eV)"
p 'data/chi1-vnl.sm_xx_29_10-nospin_scissor_0_Nc_12' u 1:3 t "with $v^{\\mathrm{nl}}$" w l ,\
  'data/chi1.sm_xx_29_10-nospin_scissor_0_Nc_12' u 1:3 t "without $v^{\\mathrm{nl}}$" w l 
#
