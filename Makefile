# Version $Id$ 
# Path    $Source$ 
# Date    $Date$

# Makefile for FileSetAPI library

.f.o:
	$(FC) $(FFLAGS) -c -o $@ $<
.F.o:
	$(FC) $(FFLAGS) -c -o $@ $<

MODFILESET = $(FS_BIN)/modfileset.o

FILES = appendname.o chkfileset.o chksetdesc.o cleanup.o closeset.o \
	createset.o descset.o openset.o promptset.o readset.o \
	writeset.o

all: lib

lib: $(MODFILESET) $(FILES)
	ar rv $(FS_BIN)/libfileset.a $(FILES) $(MODFILESET)

debug: $(MODFILESET) $(FILES)
	ar rv $(FS_BIN)/libfileset.debug.a $(FILES) $(MODFILESET)

$(MODFILESET): $(FS_ROOT)/modfileset.f $(IOINC)/PARMS3.EXT $(IOINC)/FDESC3.EXT
	$(FC) $(FFLAGS) -c -o $@ $(FS_ROOT)/modfileset.f
	if ( test -f modfileset.mod ) ; then mv modfileset.mod $(FS_BIN) ; fi
	if ( test -f modfileset.M   ) ; then mv modfileset.M   $(FS_BIN) ; fi
	if ( test -f MODFILESET.mod ) ; then mv MODFILESET.mod $(FS_BIN) ; fi

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
	/bin/rm -f *.o $(FS_BIN)/*.o $(FS_BIN)/*.mod $(FS_BIN)/*.M
