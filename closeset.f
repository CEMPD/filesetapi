
       LOGICAL FUNCTION CLOSESET( ROOTNAME )

!***********************************************************************
!  Function body starts at line 41
!
!  DESCRIPTION:
!     Closes a file set
!
!  PRECONDITIONS REQUIRED:
!     File set has been opened with OPENSET
!
!  SUBROUTINES AND FUNCTIONS CALLED:
!     CLOSE3 - closes an individual file
!     CLEANUP - cleans up internal memory structures
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
       
!........  Include files
       INCLUDE 'IODECL3.EXT'  ! I/O API function declarations
       
!........  External functions
       INTEGER, EXTERNAL :: INDEX1
       
!........  Function arguments
       CHARACTER*(*), INTENT(IN) :: ROOTNAME  ! logical file name for file set

!........  Local variables
       INTEGER            I           ! counter
       INTEGER            FILEIDX     ! file index
       
       CHARACTER(LEN=16)  ROOTNAME16  ! fixed length root file name
       CHARACTER(LEN=256) MESG        ! message buffer

!---------------------------------
!  Begin body of function CLOSESET
!---------------------------------

!........  Check length of file name
       IF( LEN( ROOTNAME ) > 16 ) THEN
           MESG = 'Max file name length (16) exceeded for "' // 
     &            ROOTNAME // '"'
           CALL M3MSG2( MESG )
           CLOSESET = .FALSE.
           RETURN
       END IF

!........  Get file index
       ROOTNAME16 = ROOTNAME
       FILEIDX = INDEX1( ROOTNAME16, MXFILE3, RNAMES )

!........  If file is not open, exit with error
       IF( FILEIDX == 0 ) THEN
           MESG = 'File set "' // TRIM( ROOTNAME ) // '" is not ' //
     &            'currently open'
           CALL M3MSG2( MESG )
           CLOSESET = .FALSE.
           RETURN
       END IF

!........  Loop through individual files
       DO I = 1, SIZE( FILE_INFO( FILEIDX )%LNAMES )
           IF( .NOT. CLOSE3( FILE_INFO( FILEIDX )%LNAMES( I ) ) ) THEN
               CLOSESET = .FALSE.
               RETURN
           END IF
       END DO

       CALL CLEANUP( FILEIDX )
       NOPENSETS = NOPENSETS - 1
       
       MESG = 'Closing file set "' // TRIM( ROOTNAME ) // '"'
       CALL M3MSG2( MESG )
       
       CLOSESET = .TRUE.

       END FUNCTION CLOSESET