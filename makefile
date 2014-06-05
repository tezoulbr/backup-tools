.PHONY: man install clean arch help

help:
	@echo \'make man\' - generate man page
	@echo \'make install\' - install to \'DESTDIR\'
	@echo \'make clean\' - remove trash
	@echo \'make archdev\' - make ArchLinux devel package
	@echo \'make arch\' - make ArchLinux release package
	@echo \'make help\' - show this text

man:
	rst2man --no-generator README.rst | gzip > backup-tools.1.gz

install:
	install -D -m644 sample.conf $(DESTDIR)/usr/share/backup-tools/sample.conf
	install -D -m644 sample.conf $(DESTDIR)/etc/backup-tools.conf
	install -D -m644 logrotate.conf $(DESTDIR)/etc/logrotate.d/backup-tools
	install -D -m644 backup-tools.1.gz $(DESTDIR)/usr/share/man/man1/backup-tools.1.gz
	install -D -m644 LICENSE $(DESTDIR)/usr/share/licenes/backup-tools/LICENSE
	install -D -m755 backup-tools $(DESTDIR)/usr/bin/backup-tools

clean:
	rm -rf .backup-tools.log backup-tools.1.gz src pkg test PKGBUILD backup-tools.install backup-tools*.xz

archdev:
	ln -s "arch/PKGBUILD.devel" "PKGBUILD"
	ln -s "arch/backup-tools.install" "backup-tools.install"
	makepkg

arch:
	ln -s "arch/PKGBUILD" "PKGBUILD"
	ln -s "arch/backup-tools.install" "backup-tools.install"
	makepkg
