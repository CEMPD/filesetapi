
       MODULE MODFILESET

!***********************************************************************
!  Module body starts at line 38
!
!  DESCRIPTION:
!     This module contains the public and private variables and arrays  
!     needed to use the FileSetAPI.
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

       IMPLICIT NONE
       SAVE

!.........  Include files
       INCLUDE 'PARMS3.EXT'  ! I/O API parameters
       INCLUDE 'FDESC3.EXT'  ! I/O API file description data structures

!.........  Parameters
       INTEGER, PARAMETER :: ALLFILES = -1         ! flag: read all files in set

!.........  File set information        
       INTEGER              :: NVARSET             ! total number of variables in the file set
       INTEGER              :: NFILESET            ! total number of files in the file set
       INTEGER, ALLOCATABLE :: VARS_PER_FILE( : )  ! number of variables per file

!.........  Arrays for storing variable information (dim: NVARSET)
       INTEGER,           ALLOCATABLE :: VTYPESET( : )  ! variable types
       CHARACTER(LEN=16), ALLOCATABLE :: VNAMESET( : )  ! variable names
       CHARACTER(LEN=16), ALLOCATABLE :: VUNITSET( : )  ! variable units
       CHARACTER(LEN=80), ALLOCATABLE :: VDESCSET( : )  ! variable descriptions

!.........  Internal wrapper data
       TYPE :: CHAR_PTR_ARRAY
           LOGICAL                    :: RDONLY        ! read-only status
           CHARACTER(LEN=16), POINTER :: VARS( :,: )   ! variable names
           CHARACTER(LEN=16), POINTER :: LNAMES( : )   ! logical file names
       END TYPE
        
       INTEGER                :: NOPENSETS = 0         ! total number of open file sets
       CHARACTER(LEN=16)      :: RNAMES( MXFILE3 )     ! logical file names for open file sets
       TYPE( CHAR_PTR_ARRAY ) :: FILE_INFO( MXFILE3 )  ! file information for open file sets
       
       END MODULE MODFILESET
       