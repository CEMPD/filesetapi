# @(#)$Header$
#
# Include file for making modules and doing needed copies, etc.
#

MODFILESET = $(FS_BIN)/modfileset.o

#
FSMODALL   = $(MODFILESET)

# 
# Module dependencies...  

$(MODFILESET): $(FS_ROOT)/modfileset.f $(IOINC)/PARMS3.EXT $(IOINC)/FDESC3.EXT
	$(FC) $(FFLAGS) -c -o $@ $<
	if ( test -f modfileset.mod ) ; then mv modfileset.mod $(FS_BIN) ; fi
	if ( test -f modfileset.M   ) ; then mv modfileset.M   $(FS_BIN) ; fi
	if ( test -f MODFILESET.mod ) ; then mv MODFILESET.mod $(FS_BIN) ; fi
