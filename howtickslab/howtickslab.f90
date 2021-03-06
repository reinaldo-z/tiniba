MODULE SMEAR_MOD
  IMPLICIT NONE
  INTEGER, PARAMETER :: DP = KIND(1.d0)
  REAL(DP), ALLOCATABLE :: arr(:,:), x(:)
  REAL(DP), ALLOCATABLE :: arrdata(:,:), xdata(:)

CONTAINS
!========================================================  
  SUBROUTINE READFILE(FNAME,nMax,LNCOL)
!========================================================
    IMPLICIT NONE
    CHARACTER(LEN=*), INTENT(IN) :: fname
    INTEGER, INTENT(INOUT) :: nMax
    INTEGER, INTENT(IN) :: LNCOL
    REAL(DP), ALLOCATABLE :: array_tmpX(:), array_tmp(:,:)
    REAL(DP) :: tot, energy, h, intmpx, intmpf(6)
    INTEGER :: i, ioerror
    INTEGER :: oldSize, newSize
    nMax = 1
    
    ALLOCATE( arr(nMax,(LNCOL-1)), x(nMax) )
    OPEN(UNIT = 1,FILE = FNAME)
    PRINT *, 'FILE IS OPEN ',trim(FNAME)
    i=0
    oldSize=0
    newSize=0
    DO
       READ(1,FMT=*,IOSTAT=ioerror) intmpx, intmpf(1:(LNCOL-1))
       ! WRITE(6,*) intmpx, intmpf(1:6)
       !
       ! PRINT *,'ioerror ', ioerror
       ! 
       IF (ioerror==0) THEN ! all the arrays should increase.
          ! First copy the old arrays into temporary arrays
          oldSize = i
          i=i+1
          newSize = i
          
          ALLOCATE(array_tmpX(oldSize))
          ALLOCATE(array_tmp(oldSize,(LNCOL-1)))

          array_tmpX(1:oldSize)=x(1:oldSize)
          DEALLOCATE(x)
          
          ! Now increase size of x to store new value
          ! WRITE(*,*) 'i = ', i
          ALLOCATE(x(newSize))

          ! Copy back temporary array into x
          x(1:oldSize)=array_tmpX(1:oldSize)

          ! And place new varable in ith location
          x(i)=intmpx

          ! Do the same with the actual function
          DEALLOCATE(array_tmp)
          ALLOCATE(array_tmp(oldSize,(LNCOL-1)))

          array_tmp(1:oldSize,1:(LNCOL-1)) = arr(1:oldSize,1:(LNCOL-1))
          DEALLOCATE(arr)
          ALLOCATE(arr(newSize,(LNCOL-1)))

          arr(1:oldSize,1:(LNCOL-1)) = array_tmp(1:oldSize,1:(LNCOL-1))
          arr(i,1:(LNCOL-1))=intmpf(1:(LNCOL-1))
         !  WRITE(6,*) 'NEW', x(i), arr(i,1:6)
          DEALLOCATE(array_tmp)
          DEALLOCATE(array_tmpX)
       ELSE IF (ioerror == -1) THEN
          IF (i == 0) THEN
             STOP 'Error:  Input file is possibly empty'
          END IF
          nMax = i
          EXIT
       ELSE
          STOP 'ERROR'
       END IF
    ENDDO
  END SUBROUTINE READFILE

!!!<><><>
!========================================================  
  SUBROUTINE READFILEdata(FNAMEdata,nMaxdata,LNCOLdata)
!========================================================
    IMPLICIT NONE
    CHARACTER(LEN=*), INTENT(IN) :: fnamedata
    INTEGER, INTENT(INOUT) :: nMaxdata
    INTEGER, INTENT(IN) :: LNCOLdata
    REAL(DP), ALLOCATABLE :: array_tmpXdata(:), array_tmpdata(:,:)
    !REAL(DP) :: totdata, energydata, hdata, intmpxdata, intmpfdata(6)
    REAL(DP) :: totdata, energydata, hdata, intmpxdata, intmpfdata(50)
    INTEGER :: idata, ioerrordata
    INTEGER :: oldSizedata, newSizedata
    nMaxdata = 1
    
    ALLOCATE( arrdata(nMaxdata,(LNCOLdata-1)), xdata(nMaxdata) )
    OPEN(UNIT = 1,FILE = FNAMEdata)
    PRINT *, 'FILE IS OPEN'
    idata=0
    oldSizedata=0
    newSizedata=0
    DO
       READ(1,FMT=*,IOSTAT=ioerrordata) intmpxdata, intmpfdata(1:(LNCOLdata-1))
       ! WRITE(6,*) intmpx, intmpf(1:6)
       !
       ! PRINT *,'ioerror ', ioerror
       ! 
       IF (ioerrordata==0) THEN ! all the arrays should increase.
          ! First copy the old arrays into temporary arrays
          oldSizedata = idata
          idata=idata+1
          newSizedata = idata
          
          ALLOCATE(array_tmpXdata(oldSizedata))
          ALLOCATE(array_tmpdata(oldSizedata,(LNCOLdata-1)))

          array_tmpXdata(1:oldSizedata)=xdata(1:oldSizedata)
          DEALLOCATE(xdata)
          
          ! Now increase size of x to store new value
          ! WRITE(*,*) 'i = ', i
          ALLOCATE(xdata(newSizedata))

          ! Copy back temporary array into x
          xdata(1:oldSizedata)=array_tmpXdata(1:oldSizedata)

          ! And place new varable in ith location
          xdata(idata)=intmpxdata

          ! Do the same with the actual function
          DEALLOCATE(array_tmpdata)
          ALLOCATE(array_tmpdata(oldSizedata,(LNCOLdata-1)))

          array_tmpdata(1:oldSizedata,1:(LNCOLdata-1)) = arrdata(1:oldSizedata,1:(LNCOLdata-1))
          DEALLOCATE(arrdata)
          ALLOCATE(arrdata(newSizedata,(LNCOLdata-1)))

          arrdata(1:oldSizedata,1:(LNCOLdata-1)) = array_tmpdata(1:oldSizedata,1:(LNCOLdata-1))
          arrdata(idata,1:(LNCOLdata-1))=intmpfdata(1:(LNCOLdata-1))
         !  WRITE(6,*) 'NEW', x(i), arr(i,1:6)
          DEALLOCATE(array_tmpdata)
          DEALLOCATE(array_tmpXdata)
       ELSE IF (ioerrordata == -1) THEN
          IF (idata == 0) THEN
             STOP 'Error:  Input file is possibly empty'
          END IF
          nMaxdata = idata
          EXIT
       ELSE
          STOP 'ERROR'
       END IF
    ENDDO
  END SUBROUTINE READFILEdata


 subroutine NumberofRows(filein, NofR)
!! Cabellos 28 Septiembre 2008 a 16:20
implicit none
character(len=255), intent(IN) :: filein
integer, intent(out) :: NofR
!!----local variables
integer :: n, error,i,j
character(len=255) :: s
real :: value
!!!===begin to count the number of columns of file========
 ! write(*,*)"Openeing ESTE",trim(filein)
   open(99,FILE=filein,status="unknown")
    do
      read (99,'(a)',end=100)s
       !write(*,*)"s",s
        do i =1,254 ! The very maximum that the string can contain
           read( s, *, iostat=error ) ( value,j=1,i )
            if ( error .ne. 0 ) then
             NofR =i-1
             !write(*,*)NofR
              exit
            endif
        enddo
    end do
100 continue
    !write(*,*)NofR
   close(99)
end subroutine NumberofRows
!!!!<><><><><><><><><><><><><><><><><><><><><><
!!!!<><><><><><><><><><><><><><><><><><><><><><
!!!<><><><><><><><><><><><><><><><><><><><><><>
!!!<><><><><><><><><><><><><><><><><><><><><><>
!!!<><><><><><><><><><><><><><><><><><><><><><>
END MODULE SMEAR_MOD

!!!========================================================
PROGRAM SMEARING
!!!=========================================================
  ! A simple smearing implementation
  USE SMEAR_MOD
  IMPLICIT NONE
  INTEGER :: numberOfCommandLineArguments
  integer   :: IArgC
  INTEGER :: nMax=0
  INTEGER :: nMaxdata=0
  REAL(DP), ALLOCATABLE :: res(:,:)
  REAL(DP) :: tot, h
  CHARACTER(1) :: flag
  !!CHARACTER(60) :: fname, ofname
  CHARACTER(255) :: fname, fnamedata,fnamedataout
  CHARACTER(255) :: mhw
  REAL(DP) :: mhwf
  INTEGER :: itmp
  INTEGER :: NCOL,i
  REAL(DP) :: zmin,zmax,zminabs,zmaxabs,anchoBOHR,anchoNANOMETROS,anchoAMSTRONG
  REAL(DP) :: anchoMETROS
  real(DP) :: bohr
  logical :: flag1,flag2
  CHARACTER(len=255) :: cwd
  integer :: ii1,largo
  character(len=255) :: fileout
   
  
  double precision :: amstrong = 1d-10 !!! metros     
  double precision :: nano = 1d-9 !!! metros     
 !!The conversion factor between Bohr and Angstrom is 1 Bohr=0.529177249 Angstrom
write(*,*)"<><><><><><><><><><><><><><><><><><><><><><><><><>"
write(*,*)"<><><><><><><><><><><><><><><><><><><><><><><><><>"
write(*,*)"<><><><><><><><><><><><><><><><><><><><><><><><><>"
!!!!<><><> begin code <><><><><><><>
  bohr=0.5291772108d0 !in Angstrom from abinit, Anstrogm=1x10-10  metros  
  numberOfCommandLineArguments = iargc()
  if (numberOfCommandLineArguments.eq.2) THEN
   WRITE (6,*) 'stopping right now ...!'
  STOP
  end if
  !!!! <><><><><><><><><><><><>
  !!!! <><><><><><><><><<?><
  CALL GetEnv('PWD',cwd)
    ii1=index(cwd(1:255),'/',BACK = .TRUE.)
    fileout=(trim(cwd(ii1+1:255)))
     fileout=trim(fileout)
      largo=LEN_TRIM(fileout)
        !write(*,*)LEN_TRIM(fileout)
        !write(*,*)"Output  here: ",trim(fileout)
         fname=trim(fileout)//'.xyz'
       !!!!! 
      !!   if (largo.eq.0)then
      !    write(*,*)"Im not able to get te file name"
      !    write(*,*)"taking the default name ",trim(fname)
      !!    fileout='si_As_que'
      !!  end if 
 




  !CALL GETARG(1,fname)
  

  inquire(file= trim(fname),exist=flag1)
       if (.NOT.flag1) then
        write(*,*)"I cant find FILE :  ",trim(fname)
        write(*,*)"Stop right now ...  "
        stop
       end if
  PRINT *,'Opening :  ',trim(fname)



  call NumberofRows(fname, NCOL)    
  write(*,*)"NUMERO DE COLUMNAS ",NCOL
  CALL READFILE(fname,nMax,NCOL)
  !OPEN(UNIT=2,FILE=OUTFILE)
    DO i = 1, nMax, 1
       !WRITE(*,'(F10.5,6E16.6)') x(i), arr(i,1:(NCOL-1))
       WRITE(3,*) x(i), arr(i,1:(NCOL-1))
    ENDDO
! write(*,*)arr(1,2) 
 write(*,*)x(1),arr(1,1),arr(1,2) 
 write(*,*)x(nMax),arr(nMax,1),arr(nMax,2)
 zmin=arr(1,2) 
 zmax=arr(nMax,2)
 write(*,*)"Zmin = ",zmin
 write(*,*)"Zmax = ",zmax
 zminabs=abs(zmin)
 zmaxabs=abs(zmax)
  
 anchoBOHR=zminabs+zmaxabs
 anchoAMSTRONG=bohr*anchoBOHR
 anchoNANOMETROS=0.1d0*anchoAMSTRONG
 anchoMETROS=nano*anchoNANOMETROS
 !write(*,*)"Ancho slab (Bhors)", zminabs+zmaxabs
 write(*,*)"========================================" 
 write(*,*)"Ancho slab (Bohrs)", anchoBOHR
 write(*,*)"Ancho slab (Anstrong)", anchoAmstrong
 write(*,*)"Ancho slab (Nanometros)", anchoNANOMETROS
 write(*,*)"Ancho slab (Metros)", anchoMETROS
 write(*,*)"from = ",trim(fname)
 write(*,*)"========================================"
 
deallocate(arr)




 if (numberOfCommandLineArguments.eq.1)then 

       !CALL GETARG(2,fnamedata)
       CALL GETARG(1,fnamedata)
     !inquire(file= trim(fnamedata),exist=flag1)
     ! if (.NOT.flag1) then
     !   write(*,*)"perro " 
     !   write(*,*)"I cant find your file:  ",trim(fname)
     !   stop
     ! end if


   PRINT *,'Opening :  ',trim(fnamedata)
  call NumberofRows(fnamedata, NCOL)    
  write(*,*)"NUMERO DE COLUMNAS ",NCOL
  CALL READFILEdata(fnamedata,nMaxdata,NCOL)
  write(*,*)"NUMERO DE COLUMNAS ",NCOL

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!! PARANOIA !!!!!!!!!!!!!!

 !!fnamedataout=trim(fnamedata)//'-Lslab'
   fnamedataout=trim(fnamedata)
   fnamedataout=trim(fnamedataout)
   OPEN(unit=20,FILE=fnamedataout, STATUS="UNKNOWN")


   ! DO i = 1, nMaxdata, 1
    DO i = 1, nMaxdata
      !!! well i have to modificate this format .....
       WRITE(20,'(F10.5,50E16.6)') xdata(i),(anchoMETROS*arrdata(i,1:(NCOL-1)))
       !WRITE(20,'(F10.5,50E16.6)') xdata(i),(arrdata(i,1:(NCOL-1)))
       !WRITE(4,'(F10.8,6F20.6)') xdata(i), arrdata(i,1:(NCOL-1))
       !WRITE(4,*) xdata(i), arrdata(i,1:(NCOL-1))
       !WRITE(4,*) arrdata(i,:)
       !WRITE(4,*) xdata(i), arrdata(i,1:(NCOL-1))
    ENDDO
close(20)
write(*,*)"Output FILE:",trim(fnamedataout) 
write(*,*)"<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
write(*,*)"<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
write(*,*)"<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
 else 
 write(*,*)"Solo tome la medida del salb"
 end if

call system('~/abinit_shells/utils/volume.sh') 

END PROGRAM SMEARING

!**************************************************
