	  �  D   k820309              12.1        ?&Q                                                                                                           
       functions.f90 FUNCTIONS                                                     
       DP DPC                                                     
       NMAX NVAL TOL                                                     
  	     BAND MOMMATELEM POSMATELEM DELTA TOLCHOICE OLDSTYLESCISSORS CALMOMMATELEM CALDELTA CALPOSMATELEM                                                     
  	     BAND MOMMATELEM POSMATELEM DELTA TOLCHOICE OLDSTYLESCISSORS CALMOMMATELEM CALDELTA CALPOSMATELEM                                                     
  	     BAND MOMMATELEM POSMATELEM DELTA TOLCHOICE OLDSTYLESCISSORS CALMOMMATELEM CALDELTA CALPOSMATELEM                                                                                                                                                                                                                       @      !                                                  @      !                                                  @      !                                
                      !                           	                   
                &                                                          !                           
                                   &                   &                   &                                                          !                                                              &                   &                   &                                                          !                                                              &                   &                   &                                                                                                                                               0               !                                                       !                                                              &                   &                   &                                                          !                                                              &                   &                   &                                                          !                                                              &                   &                   &                                           %         @                                                          #CALPOSITION%DABS    #ALPHA    #IV    #IC    #IK                                                    DABS           
                                                       
                                                       
                                                                                                    %         @                                                          #POSITION%DABS    #ALPHA    #IV    #IC    #IK                                                    DABS           
                                                       
                                                       
                                                                                                    %         @                                                          #GENDERIV2%DABS    #ALPHA     #BETA !   #IV "   #IC #   #IK $                                                   DABS           
                                                        
                                  !                     
                                  "                     
                                  #                                                      $            %         @                                %                          #GENDERIV%DABS &   #ALPHA '   #BETA (   #N )   #M *   #K +                                              &     DABS           
                                  '                     
                                  (                     
                                  )                     
                                  *                     
                                  +           %         @                                ,                          #GENDERCALPOSITIONF%DABS -   #ALPHA .   #BETA /   #N 0   #M 1   #K 2                                              -     DABS           
                                  .                     
                                  /                     
                                  0                     
                                  1                     
                                  2           %         @                                3                          #CFUNCTIONTMP%DABS 4   #ALPHA 5   #GAMMA 6   #IC 7   #IV 8                                              4     DABS           
                                  5                     
                                  6                     
                                  7                     
                                  8           %         @                                9                          #RMPRPNOMP%DABS :   #INDEX ;   #INDEX2 <   #ALPHA =   #BETA >   #IC ?   #IV @   #POW A                                              :     DABS           
                                  ;                     
                                  <                     
                                  =                     
                                  >                     
                                  ?                     
                                  @                     
                                  A              �          fn#fn    �   G   J  CONSTANTS      N   J  INPARAMS    U  �   J  ARRAYS    �  �   J  ARRAYS    �  �   J  ARRAYS    8  p       DP+CONSTANTS    �  p       DPC+CONSTANTS      @       NMAX+INPARAMS    X  @       NVAL+INPARAMS    �  @       TOL+INPARAMS    �  �       BAND+ARRAYS "   d  �       MOMMATELEM+ARRAYS "      �       POSMATELEM+ARRAYS    �  �       DELTA+ARRAYS !   �  q       TOLCHOICE+ARRAYS (   	  @       OLDSTYLESCISSORS+ARRAYS %   I  �       CALMOMMATELEM+ARRAYS     	  �       CALDELTA+ARRAYS %   �	  �       CALPOSMATELEM+ARRAYS    }
  �       CALPOSITION !     =      CALPOSITION%DABS "   C  @   a   CALPOSITION%ALPHA    �  @   a   CALPOSITION%IV    �  @   a   CALPOSITION%IC      @   a   CALPOSITION%IK    C  �       POSITION    �  =      POSITION%DABS      @   a   POSITION%ALPHA    F  @   a   POSITION%IV    �  @   a   POSITION%IC    �  @   a   POSITION%IK      �       GENDERIV2    �  =      GENDERIV2%DABS     �  @   a   GENDERIV2%ALPHA      @   a   GENDERIV2%BETA    T  @   a   GENDERIV2%IV    �  @   a   GENDERIV2%IC    �  @   a   GENDERIV2%IK      �       GENDERIV    �  =      GENDERIV%DABS    �  @   a   GENDERIV%ALPHA      @   a   GENDERIV%BETA    ^  @   a   GENDERIV%N    �  @   a   GENDERIV%M    �  @   a   GENDERIV%K #     �       GENDERCALPOSITIONF (   �  =      GENDERCALPOSITIONF%DABS )   �  @   a   GENDERCALPOSITIONF%ALPHA (   2  @   a   GENDERCALPOSITIONF%BETA %   r  @   a   GENDERCALPOSITIONF%N %   �  @   a   GENDERCALPOSITIONF%M %   �  @   a   GENDERCALPOSITIONF%K    2  �       CFUNCTIONTMP "   �  =      CFUNCTIONTMP%DABS #   �  @   a   CFUNCTIONTMP%ALPHA #   <  @   a   CFUNCTIONTMP%GAMMA     |  @   a   CFUNCTIONTMP%IC     �  @   a   CFUNCTIONTMP%IV    �  �       RMPRPNOMP    �  =      RMPRPNOMP%DABS     �  @   a   RMPRPNOMP%INDEX !   "  @   a   RMPRPNOMP%INDEX2     b  @   a   RMPRPNOMP%ALPHA    �  @   a   RMPRPNOMP%BETA    �  @   a   RMPRPNOMP%IC    "  @   a   RMPRPNOMP%IV    b  @   a   RMPRPNOMP%POW 