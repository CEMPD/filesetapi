       
       LOGICAL FUNCTION CHKSETDESC( FNAME )

!***********************************************************************
!  Function body starts at line 39
!
!  DESCRIPTION:
!     Checks a file description for internal consistency.
!
!  PRECONDITIONS REQUIRED:
!     File description information in MODFILESET has been entered
!
!  SUBROUTINES AND FUNCTIONS CALLED:
!
!  REVISION HISTORY:
!     Created 6/02 by C. Seppanen
!
!***************************************************************************
!
! Project Title: FileSetAPI
! File: @(#)$Id$
!
! COPYRIGHT (C) 2002, MCNC Environmental Modeling Center
! All Rights Reserved
!
! Environmental Modeling Center
! MCNC
! P.O. Box 12889
! Research Triangle Park, NC  27709-2889
!
! info@emc.mcnc.org
!
! Pathname: $Source$
! Last updated: $Date$ 
!
!*************************************************************************

!........  Modules for public variables
       USE MODFILESET
       
       IMPLICIT NONE

!........  Function arguments
       CHARACTER(LEN=16), INTENT(IN) :: FNAME  ! logical file name
              
!........  Local variables
       INTEGER              I                        ! counter
       INTEGER              IOS                      ! I/O status
       INTEGER              TOTALVARS                ! total number of variables
       
       LOGICAL ::           EFLAG = .FALSE.          ! true: error found
       
       CHARACTER(LEN=300)   MESG                     ! message buffer
       
       CHARACTER(LEN=16) :: FUNCNAME = 'CHKSETDESC'  ! function name
       
!------------------------------------
!  Begin body of function CHKSETDESC
!------------------------------------
       
       EFLAG = .FALSE.

!........  Check that total number of variables is valid
       IF( NVARSET <= 0 ) THEN
           MESG = 'Illegal number of variable for file set ' //
     &            TRIM( FNAME )
           CALL M3MSG2( MESG )
           CHKSETDESC = .FALSE.
           RETURN
       END IF

!........  Check that number of variables per file is set
       IF( .NOT. ALLOCATED( VARS_PER_FILE ) ) THEN
           MESG = 'Number of variables per file array is not ' //
     &            'allocated for file set ' // TRIM( FNAME ) // ';'
           CALL M3MSG2( MESG )
           MESG = 'using default of 120 variables per file'
           CALL M3MSG2( MESG )
           
           NFILESET = CEILING( NVARSET / 120. )  ! real division, convert back to int
           ALLOCATE( VARS_PER_FILE( NFILESET ), STAT=IOS )
           CALL CHECKMEM( IOS, 'VARS_PER_FILE', FUNCNAME )

           TOTALVARS = NVARSET
           I = 1
           DO
               IF( TOTALVARS - 120 <= 0 ) THEN
                   VARS_PER_FILE( I ) = TOTALVARS
                   EXIT
               ELSE
                   VARS_PER_FILE( I ) = 120
               END IF
               
               TOTALVARS = TOTALVARS - 120
               I = I + 1
           END DO

       END IF
       
!........  Check that total number of files is consistent
       IF( SIZE( VARS_PER_FILE ) /= NFILESET ) THEN
           MESG = 'Inconsistent number of files in file set ' // 
     &            TRIM( FNAME )
           CALL M3MSG2( MESG )
           EFLAG = .TRUE.
       END IF

!........  Count total number of variables in VARS_PER_FILE;
!..        also check that number of variables per file is not more than 120
       TOTALVARS = 0
       DO I = 1, NFILESET
           TOTALVARS = TOTALVARS + VARS_PER_FILE( I )
           IF( VARS_PER_FILE( I ) > 120 ) THEN
               MESG = 'More than 120 variables per file ' //
     &                'in file set ' // TRIM( FNAME )
               CALL M3MSG2( MESG )
               EFLAG = .TRUE.
           END IF
       END DO

!........  Check that total number of vars is consistent       	
       IF( TOTALVARS /= NVARSET ) THEN
           MESG = 'Inconsistent number of variables in file set ' //
     &            TRIM( FNAME )
           CALL M3MSG2( MESG )
           EFLAG = .TRUE. 
       END IF

!........  Make sure variable information is set
       IF( .NOT. ALLOCATED( VTYPESET ) .OR. 
     &     .NOT. ALLOCATED( VNAMESET ) .OR.
     &     .NOT. ALLOCATED( VUNITSET ) .OR.
     &     .NOT. ALLOCATED( VDESCSET ) ) THEN
           MESG = 'One or more variable information arrays are ' //
     &            'not allocated for file set ' // TRIM( FNAME )
           CALL M3MSG2( MESG )
           CHKSETDESC = .FALSE.
           RETURN
       END IF
       
!........  Check size of variable information arrays
       IF( SIZE( VTYPESET ) < NVARSET .OR.
     &     SIZE( VNAMESET ) < NVARSET .OR.
     &     SIZE( VUNITSET ) < NVARSET .OR.
     &     SIZE( VDESCSET ) < NVARSET ) THEN
           MESG = 'One or more variable information arrays are ' //
     &            'not as large as the number of variables in ' //
     &            'file set ' // TRIM( FNAME )
           CALL M3MSG2( MESG )
           EFLAG = .TRUE.
       END IF

!........  Set function value and return
       IF( EFLAG ) THEN
       	   CHKSETDESC = .FALSE.
       ELSE
           CHKSETDESC = .TRUE.
       END IF
       
       END FUNCTION CHKSETDESC