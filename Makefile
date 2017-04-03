DESTDIR=$(HOME)/bin
LIBDIR=$(HOME)/lib/sisyphus

echo:
	echo $(DESTDIR) $(LIBDIR)
install:
	mkdir -p $(DESTDIR) && sed -e 's,LIBDIR,$(LIBDIR),' < ./sisyphus > $(DESTDIR)/sisyphus && chmod +x $(DESTDIR)/sisyphus
	mkdir -p $(LIBDIR) && cp ./sisyphus.txt $(LIBDIR)/sisyphus.txt
