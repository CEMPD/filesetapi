# @(#)$Header$
#
# Include file for making modules and doing needed copies, etc.
#
FSMOD_OUT = $(FS_ROOT)/$(EDSS_EXE)

MODFILESET = $(FSMOD_OUT)/modfileset.o

#
FSMODALL   = $(MODFILESET)

# 
# Module dependencies...  

$(MODFILESET): $(FS_ROOT)/modfileset.f $(ETINC)/IOPRVT3.EXT $(ETINC)/IOSTRG3.EXT
	$(FC) $(FFLAGS) -c -o $@ $(FS_ROOT)/modfileset.f
	if ( test -f modfileset.mod ) ; then mv modfileset.mod $(FSMOD_OUT) ; fi
	if ( test -f modfileset.M   ) ; then mv modfileset.M   $(FSMOD_OUT) ; fi
#	if ( test -f modfileset.d   ) ; then mv modfileset.d   $(FSMOD_OUT) ; fi
	if ( test -f MODFILESET.mod ) ; then mv MODFILESET.mod $(FSMOD_OUT) ; fi
