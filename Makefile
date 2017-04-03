DESTDIR=$HOME/bin
LIBDIR=$HOME/lib/sisyphus
install:
	mkdir -p $DESTDIR && sed -e 's,LIBDIR,$LIBDIR,' < ./sisyphus > $DESTDIR/sisyphus
	mkdir -p $LIBDIR && cp ./sisyphus.txt $LIBDIR
