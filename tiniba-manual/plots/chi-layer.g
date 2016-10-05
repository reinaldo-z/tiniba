## metapost
set term mp solid color  latex magnification 1
set out 'fig.mp'
set multiplot
set lmargin 15
set size .7,1
#
# set xrange [2:10]
#
set origin 0,2
set ylabel "\\Large Im[$\\chi(\\omega)$]" 
p 'data/25hs.dat' u 1:3 t "$L=25$" w l ,\
  'data/45hs.dat' u 1:3 t "$L=45$" w l ,\
  'data/65hs.dat' u 1:3 t "$L=65$" w l
#
set origin 0,1
set ylabel "\\Large Im[$\\chi(\\omega)$]" 
set xlabel "\\Large photon-energy (eV)"
p 'data/25hs.dat' u 1:($3*25) t "$\\times 25$" w l ,\
  'data/45hs.dat' u 1:($3*45) t "$\\times 45$" w l ,\
  'data/65hs.dat' u 1:($3*65) t "$\\times 65$" w l
#
#
set origin .5,1.95
set size .7,1.05
unset ylabel 
set xlabel "\\Large photon-energy (eV)"
p 'data/25hss.dat' u 1:($3) t "$L=25$" w l ,\
  'data/45hss.dat' u 1:($3) t "$L=45$" w l ,\
  'data/65hss.dat' u 1:($3) t "$L=65$" w l
#
