
       SUBROUTINE CLEANUP( FIDX )

!***********************************************************************
!  Subroutine body starts at line 39
!
!  DESCRIPTION:
!     Cleans up internal memory structures when closing a file or
!     when an error occurs
!
!  PRECONDITIONS REQUIRED:
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

!........  Subroutine arguments
       INTEGER, INTENT(IN) :: FIDX  ! file index

!........  Local variables
       INTEGER  IOS  ! I/O status

       CHARACTER(LEN=300) MESG  ! message buffer

       CHARACTER(LEN=16) :: PROGNAME = 'CLEANUP'  ! program name

!-----------------------------------
!  Begin body of subroutine CLEANUP       
!-----------------------------------

!........  Set root name back to missing
       RNAMES( FIDX ) = CMISS3

!........  Check if logical names pointer is associated, then deallocate
       IF( ASSOCIATED( FILE_INFO( FIDX )%LNAMES ) ) THEN
           DEALLOCATE( FILE_INFO( FIDX )%LNAMES, STAT=IOS )
           IF( IOS > 0 ) THEN
               MESG = 'Failure deallocating memory for ' //
     &                '"FILE_INFO%LNAMES" variable'
               CALL M3EXIT( PROGNAME, 0, 0, MESG, 2 )
           END IF
           NULLIFY( FILE_INFO( FIDX )%LNAMES )
       END IF

!........  Check if variable pointer is associated, then deallocate       
       IF( ASSOCIATED( FILE_INFO( FIDX )%VARS ) ) THEN
           DEALLOCATE( FILE_INFO( FIDX )%VARS, STAT=IOS )
           IF( IOS > 0 ) THEN
               MESG = 'Failure deallocating memory for ' //
     &                '"FILE_INFO%VARS" variable'
               CALL M3EXIT( PROGNAME, 0, 0, MESG, 2 )
           END IF
           NULLIFY( FILE_INFO( FIDX )%VARS )
       END IF

       END SUBROUTINE CLEANUP