# Version $Id$ 
# Path    $Source$ 
# Date    $Date$

# Makefile for FileSetAPI library

.f.o:
	$(FC) $(FFLAGS) -c -o $@ $<
.F.o:
	$(FC) $(FFLAGS) -c -o $@ $<

MODFILESET = $(FSDIR)/modfileset.o

FILES = appendname.o chkfileset.o chksetdesc.o cleanup.o closeset.o \
	createset.o descset.o openset.o promptset.o readset.o \
	writeset.o

all: lib

lib: $(MODFILESET) $(FILES)
	ar rv $(FSDIR)/libfileset.a $(FILES)
	ar rv $(FSDIR)/libfileset.a $(MODFILESET)

debug: $(MODFILESET) $(FILES)
	ar rv $(FSDIR)/libfileset.debug.a $(FILES) 
	ar rv $(FSDIR)/libfileset.debug.a $(MODFILESET)

$(MODFILESET): $(FSDIR)/modfileset.f $(IOINC)/PARMS3.EXT $(IOINC)/FDESC3.EXT
	$(FC) $(FFLAGS) -c -o $@ $(FSDIR)/modfileset.f
#	if ( test -f modfileset.mod ) ; then mv modfileset.mod $(FSDIR) ; fi
#	if ( test -f modfileset.M   ) ; then mv modfileset.M   $(FSDIR) ; fi
#	if ( test -f MODFILESET.mod ) ; then mv MODFILESET.mod $(FSDIR) ; fi

#
# Module and include dependencies
#

chkfileset.o: $(MODFILESET)
chksetdesc.o: $(MODFILESET)
cleanup.f: $(MODFILESET)
closeset.f: $(MODFILESET) $(IOINC)/IODECL3.EXT
createset.f: $(MODFILESET) $(IOINC)/IODECL3.EXT
descset.f: $(MODFILESET) $(IOINC)/IODECL3.EXT
openset.f: $(MODFILESET) $(IOINC)/IODECL3.EXT
readset.F: $(MODFILESET) $(IOINC)/IODECL3.EXT
writeset.F: $(MODFILESET) $(IOINC)/IODECL3.EXT

clean: 
	/bin/rm *.o *.mod
