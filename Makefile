# Version $Id$ 
# Path    $Source$ 
# Date    $Date$

# Makefile for FileSetAPI library

.f.o:
	$(FC) $(FFLAGS) -c -o $@ $<
.F.o:
	$(FC) $(FFLAGS) -c -o $@ $<

include $(FS_ROOT)/modmake.inc

FILES = \
  appendname.o  chkfileset.o  chksetdesc.o  cleanup.o     closeset.o  \
  createset.o   descset.o     openset.o     promptset.o   readset.o   \
  writeset.o

all: lib

lib: $(FSMODALL) $(FILES)
	ar rv $(FS_BIN)/libfileset.a $(FILES) 
	ar rv $(FS_BIN)/libfileset.a $(FSMODALL)

debug: $(FSMODALL) $(FILES)
	ar rv $(FS_BIN)/libfileset.debug.a $(FILES) 
	ar rv $(FS_BIN)/libfileset.debug.a $(FSMODALL)
#
# Module and include dependencies
#

chkfileset.o: $(MODFILESET)
chksetdesc.o: $(MODFILESET)
cleanup.o:    $(MODFILESET)
closeset.o:   $(MODFILESET) $(IOINC)/IODECL3.EXT
createset.o:  $(MODFILESET) $(IOINC)/IODECL3.EXT
descset.o:    $(MODFILESET) $(IOINC)/IODECL3.EXT
openset.o:    $(MODFILESET) $(IOINC)/IODECL3.EXT
readset.o:    $(MODFILESET) $(IOINC)/IODECL3.EXT
writeset.o:   $(MODFILESET) $(IOINC)/IODECL3.EXT

clean: 
	/bin/rm -f *.o $(FS_BIN)/*.o $(FS_BIN)/*.mod $(FS_BIN)/*.M
