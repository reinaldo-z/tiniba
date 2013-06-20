!!!############
MODULE arrays
!!!############
  USE constants, ONLY : DP, DPC
  USE constants, ONLY : debug
  USE inparams, ONLY : nVal, nMax, nSym, kMax
  USE inparams, ONLY : scissor, actualbandGap, tol, crystal_class
  USE inparams, ONLY : energy_data_filename, energys_data_filename
  USE inparams, ONLY : half_energys_data_filename
  USE inparams, ONLY : pmn_data_filename,rmn_data_filename,der_data_filename
!!!FN
  USE inparams, ONLY : cal_data_filename
!  USE inparams, ONLY : den_data_filename, cur_data_filename
!!!FN
  USE inparams, ONLY : smn_data_filename, nSpinor
  USE inparams, ONLY : snn_data_filename
  IMPLICIT NONE
  COMPLEX(DPC), ALLOCATABLE :: momMatElem(:,:,:)
!!!FN
  COMPLEX(DPC), ALLOCATABLE :: calMomMatElem(:,:,:)
  COMPLEX(DPC), ALLOCATABLE :: calrho(:)
  COMPLEX(DPC), ALLOCATABLE :: denMatElem(:)
  COMPLEX(DPC), ALLOCATABLE :: curMatElem(:,:)
  LOGICAL :: layeredCalculation
  LOGICAL :: ndotCalculation
  LOGICAL :: spinCalculation
  LOGICAL :: microscopicDensityCalculation
  LOGICAL :: microscopicCurrentCalculation
!!!FN
  COMPLEX(DPC), ALLOCATABLE :: posMatElem(:,:,:)
  COMPLEX(DPC), ALLOCATABLE :: derMatElem(:,:,:,:)
  COMPLEX(DPC), ALLOCATABLE :: spiMatElem(:,:,:)
  COMPLEX(DPC), ALLOCATABLE :: Delta(:,:,:)
  COMPLEX(DPC), ALLOCATABLE :: calDelta(:,:,:)
  REAL(DP), ALLOCATABLE :: energy(:,:), energys(:,:)
  REAL(DP), ALLOCATABLE :: band(:)   ! REAL BAD USE OF WORD BAND !!!
                                     ! is actually all band energies
                                     ! for a given kpoint
  INTEGER, PARAMETER :: tolchoice = 0
  
  LOGICAL :: oldStyleScissors = .false.
CONTAINS
  
!!!########################
  SUBROUTINE allocateArrays
!!!########################
    IMPLICIT NONE
    INTEGER :: istat
    
    IF (debug) WRITE(*,*) "Program Flow: entered allocateArrays"
    
    ALLOCATE (momMatElem(3,nMax,nMax), STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not allocate momMatElem'
       WRITE(6,*) 'Stopping'
       STOP
    END IF
    
!!!FN
    IF (layeredCalculation) THEN
       WRITE(*,*) "Allocating calMomMatELem(3,",nMax,",",nMax,")"
       ALLOCATE (calMomMatElem(3,nMax,nMax), STAT=istat)
       IF (istat.EQ.0) THEN
          WRITE(*,*) 'Allocated array calMomMatElem'
       ELSE
          WRITE(6,*) 'Could not allocate calMomMatElem'
          WRITE(6,*) 'Stopping'
          STOP
       END IF
    END IF
    
    IF (microscopicDensityCalculation) THEN
       ALLOCATE(denMatElem(nMax))
    END IF
    
    IF (microscopicCurrentCalculation) THEN
       ALLOCATE(curMatElem(3,nMax))
    END IF
!!!FN
    
    ALLOCATE (posMatElem(3,nMax,nMax), STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not allocate posMatElem'
       WRITE(6,*) 'Stopping'
       STOP
    END IF
    ALLOCATE (calrho(nMax), STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not allocate calrho'
       WRITE(6,*) 'Stopping'
       STOP
    END IF
    ALLOCATE (derMatElem(3,3,nMax,nMax), STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not allocate derMatElem'
       WRITE(6,*) 'Stopping'
       STOP
    END IF
    ALLOCATE (Delta(3,nMax,nMax), STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not allocate Delta'
       WRITE(6,*) 'Stopping'
    END IF
    ALLOCATE (calDelta(3,nMax,nMax), STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not allocate calDelta'
       WRITE(6,*) 'Stopping'
    END IF
    ALLOCATE (energy(kMax,nMax), STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not allocate energy'
       WRITE(6,*) 'Stopping'
       STOP
    END IF
    ALLOCATE (energys(kMax,nMax), STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not allocate energys'
       WRITE(6,*) 'Stopping'
       STOP
    END IF
    ALLOCATE (band(nMax), STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not allocate energy'
       WRITE(6,*) 'Stopping'
       STOP
    END IF
    
    IF (nSpinor == 2) THEN
       ALLOCATE (spiMatElem(3,nMax,nMax), STAT=istat)
       IF (istat.NE.0) THEN
          WRITE(6,*) 'Could not allocate spiMatElem'
          WRITE(6,*) 'Stopping'
       END IF
    END IF
    
!!!****************************
  END SUBROUTINE allocateArrays
!!!****************************
  
!!!########################
  SUBROUTINE deallocateArrays
!!!########################
    IMPLICIT NONE
    INTEGER :: istat
    DEALLOCATE (momMatElem, STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not deallocate momMatElem'
       WRITE(6,*) 'Stopping'
       STOP
    END IF
    
!!!FN
    IF (layeredCalculation) THEN
       DEALLOCATE (calMomMatElem, STAT=istat)
       IF (istat.NE.0) THEN
          WRITE(6,*) 'Could not deallocate calMomMatElem'
          WRITE(6,*) 'Stopping'
          STOP
       END IF
       DEALLOCATE (calrho, STAT=istat)
       IF (istat.NE.0) THEN
          WRITE(6,*) 'Could not deallocate calrho'
          WRITE(6,*) 'Stopping'
          STOP
       END IF
    END IF

!!       DEALLOCATE(denMatElem)
!!       DEALLOCATE(curMatElem)

!!!FN
    
    DEALLOCATE (posMatElem, STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not deallocate posMatElem'
       WRITE(6,*) 'Stopping'
       STOP
    END IF
    DEALLOCATE (derMatElem, STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not deallocate derMatElem'
       WRITE(6,*) 'Stopping'
       STOP
    END IF
    DEALLOCATE (Delta, STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not deallocate Delta'
       WRITE(6,*) 'Stopping'
    END IF
    DEALLOCATE (calDelta, STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not deallocate calDelta'
       WRITE(6,*) 'Stopping'
    END IF
    DEALLOCATE (energy, STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not deallocate energy'
       WRITE(6,*) 'Stopping'
       STOP
    END IF
    DEALLOCATE (energys, STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not deallocate energys'
       WRITE(6,*) 'Stopping'
       STOP
    END IF
    DEALLOCATE (band, STAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) 'Could not deallocate energy'
       WRITE(6,*) 'Stopping'
       STOP
    END IF
    
    IF (nSpinor == 2) THEN
       DEALLOCATE (spiMatElem, STAT=istat)
       IF (istat.NE.0) THEN
          WRITE(6,*) 'Could not deallocate spiMatElem'
          WRITE(6,*) 'Stopping'
       END IF
    END IF
    
!!!****************************
  END SUBROUTINE deallocateArrays
!!!****************************
  
!!!##########################
  SUBROUTINE readEnergyFile
!!!##########################
    IMPLICIT NONE
    INTEGER :: ik, fik, i, istat
    
    IF (debug) WRITE(*,*) "Program Flow: entered readEnergyFile"
    
    OPEN(UNIT=10, FILE=energy_data_filename, STATUS='OLD', IOSTAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) "Could not open file ", TRIM(energy_data_filename)
       WRITE(6,*) "Stopping"
       STOP
    ELSE
       WRITE(6,*) 'Opened file: ', TRIM(energy_data_filename)
    END IF
    
    DO ik = 1, kMax
       READ(UNIT=10,FMT=*, IOSTAT=istat) fik, (energy(ik,i), i = 1, nMax)
       IF (istat.EQ.0) THEN
          IF ((ik<11).OR.(MOD(ik,100).EQ.0).OR.(ik.EQ.kMax)) THEN
             WRITE(6,*) ik, fik
          END IF
!!!       IF (ik.NE.fik) THEN
!!!          WRITE(6,*) ik, fik, energy(ik,1:nMax)
!!!          WRITE(6,*) 'PROBLEM'
!!!          STOP
!!!       END IF
       ELSE IF (istat.EQ.-1) THEN
          WRITE(6,*) 'Prematurely reached end of file ', TRIM(energy_data_filename)
          WRITE(6,*) 'Stopping'
          STOP
       ELSE IF (istat.EQ.1) THEN
          WRITE(6,*) 'Problem reading file', TRIM(energy_data_filename)
          WRITE(6,*) 'Stopping'
          STOP
       ELSE
          WRITE(6,*) 'Unexpected error reading file', TRIM(energy_data_filename)
          WRITE(6,*) 'IOSTAT error is: ', istat
       END IF
    END DO
    
    READ(UNIT=10,FMT=*, IOSTAT=istat) fik
    IF (istat.EQ.-1) THEN
       WRITE(*,*)
       WRITE(*,*) "Reached end of file ",TRIM(energy_data_filename)
       WRITE(*,*)
    ELSE
       ! File did not end
       WRITE(*,*) 
       WRITE(*,*) "Energy file ", TRIM(energy_data_filename), " was not at EOF"
       WRITE(*,*) "Stopping"
       STOP
    END IF
    CLOSE(UNIT=10)
    WRITE(6,*) 'ENERGIES READ'
!!!****************************
  END SUBROUTINE readenergyfile
!!!****************************
  
!!!#########################
  SUBROUTINE scissorEnergies
!!!#########################
    IMPLICIT NONE
    INTEGER :: ik, i, istat
    
    IF(debug) WRITE(*,*) "Program Flow: entered scissorEnergies"
    
    WRITE(6,*) 'Energy diffs between the HOVB and LUCB are:'
    WRITE(6,*) energy(1, nVal+1) - energy(1,nVal)
    
    IF (actualBandGap.LT.0.0d0) THEN
       STOP 'actualBandGap variable less than zero'
    END IF
    
    IF (actualBandGap.GT.1.d-8) THEN
       ! actual band gap given
       ! check that scissors agrees or is zero
       IF (scissor.GT.1.0d-8) THEN
          ! to be added
          WRITE(*,*)
          WRITE(*,*) '   actualBandGap > 0 and scissors > 0.  Must add'
          WRITE(*,*) '   code to make check consistency'
          STOP
       ELSE
          ! (scissors LT. 1.0d-8) must be adjusted
          scissor = actualBandGaP - energy(1, nVal+1) + energy(1,nVal)
       END IF
    ELSE
       ! (actualBandGap .LE. 1.d-8)
       ! use scissors as given
    END IF
    
    OPEN(UNIT=14, FILE=energys_data_filename, &
         STATUS='UNKNOWN', IOSTAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) "Error opening file ", TRIM(energys_data_filename)
       WRITE(6,*) "Stopping"
       STOP
    ELSE
       WRITE(6,*) 'Opened file: ', TRIM(energys_data_filename)
    END IF
    
    OPEN(UNIT=15, FILE=half_energys_data_filename, &
         STATUS='UNKNOWN', IOSTAT=istat)
    IF (istat.NE.0) THEN
       WRITE(6,*) "Error opening file ", TRIM(half_energys_data_filename)
       WRITE(6,*) "Stopping"
       STOP
    ELSE
       WRITE(6,*) 'Opened file: ', TRIM(half_energys_data_filename)
    END IF
    
    DO ik = 1, kMax
       energys(ik,1:nVal) = energy(ik,1:nVal)
       energys(ik,nVal+1:nMax) = energy(ik,nVal+1:nMax)+scissor
       WRITE(14,*) ik, (energys(ik,i), i = 1, nMax)
       WRITE(15,*) ik, (0.5d0*energys(ik,i), i = 1, nMax)
!!!       WRITE(6,*) ik, (energys(ik,i), i = 1,nMax)
    END DO
    
    WRITE(6,*) 'Scissor Shift is ', scissor
    WRITE(6,*) 'Adjusted Band Gap is', &
         energy(1, nVal+1) - energy(1,nVal) + scissor
    
    CLOSE(14)
    CLOSE(15)
!!!*******************************
  END SUBROUTINE scissorenergies
!!!*******************************
!!!****************
END MODULE arrays
!****************
