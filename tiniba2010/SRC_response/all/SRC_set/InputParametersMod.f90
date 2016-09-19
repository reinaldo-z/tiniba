!!!######################
MODULE InputParametersMod
!!!######################
  
  USE ConstantsMod, ONLY : DP, pi
  
  IMPLICIT NONE
  
  INTEGER :: nMaxCC      !Partial Number of bands 
  !! nueva variable 28 enero 2008
  REAL(DP) :: tolSHGt                
  !!!tolerance for degeneracy shg transversal 
  !! nueva variable 4 Marzo 2008
  REAL(DP) :: tolSHGL                
  
  !!! nueva variable 15 Febrero 2008  
  INTEGER :: nVal          ! number of valence bands
  INTEGER :: nMax          ! total number of bands
  INTEGER :: kMax          ! number of kpoints
  INTEGER :: nTetra         ! number of tetrahedra
  INTEGER :: nTrans          ! number of transitions
  INTEGER :: nSpinor=0.d0      ! number of spinor components (1 or 2 only)
!!!                            ! if nSpinor==2 then will look for smn.d file
  INTEGER :: nSym                ! number of symmetry operations
  REAL(DP) :: actual_band_gap=0.d0  ! actual band gap in eV
  REAL(DP) :: scissor             ! scissor shift in eV
  REAL(DP) :: tol                 ! tolerance for degeneracy  
  
  CHARACTER(LEN=10) :: crystal_class ! name of crystal type
  ! crystal_class can be zincblende or wurtzite
  
  CHARACTER(LEN=80) :: paramFile
  
  CHARACTER(LEN=80) ::  energy_data_filename  ! energy input file
  CHARACTER(LEN=80) ::  energys_data_filename ! scissored energy file
  CHARACTER(LEN=80) ::  pmn_data_filename     ! momentum me input file
  CHARACTER(LEN=80) ::  rmn_data_filename     ! position me output file
  CHARACTER(LEN=80) ::  der_data_filename     ! derivative me output file
  CHARACTER(LEN=80) ::  smn_data_filename     ! spin me output file
  
  REAL(DP) :: spin_factor = 0.d0
  REAL(DP) :: units_factor = 0.d0
  
  LOGICAL, PARAMETER :: writeoutMEdata = .false.   ! flag controlling whether
  !        matrix element output is written or not. Much slower if outputting.
  LOGICAL, PARAMETER :: oldStyleScissors = .false.
  
!!!##########################
END MODULE InputParametersMod
!!!##########################
