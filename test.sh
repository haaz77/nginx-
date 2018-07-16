# Non-root account is recommended for this process

# centos-specific prepration
sudo yum -y update && sudo yum -y groupinstall 'Development Tools' && sudo yum -y install curl irb m4 ruby

# Sanitize the environment
PATH=~/.linuxbrew/bin:/usr/local/bin:/usr/bin:/bin
unset LD_LIBRARY_PATH PKG_CONFIG_PATH

# install linuxbrew
git clone https://github.com/Homebrew/linuxbrew.git ~/.linuxbrew

ln -s $(which gcc) `brew --prefix`/bin/gcc-$(gcc -dumpversion |cut -d. -f1,2)
ln -s $(which g++) `brew --prefix`/bin/g++-$(g++ -dumpversion |cut -d. -f1,2)
ln -s $(which gfortran) `brew --prefix`/bin/gfortran-$(gfortran -dumpversion |cut -d. -f1,2)

brew doctor

mkdir `brew --prefix`/lib
#ln -s ~/.linuxbrew/lib ~/.linuxbrew/lib64
#ln -s /usr/lib64/libstdc++.so.6 /lib64/libgcc_s.so.1 ~/.linuxbrew/lib/

# install glibc 
brew install glibc
brew remove binutils
brew unlink glibc
#ln -s lib `brew --prefix`/lib64
ln -s `brew --prefix`/lib `brew --prefix`/lib64

# install zlib
brew install https://raw.githubusercontent.com/Homebrew/homebrew-dupes/master/zlib.rb

# install binutils
brew install binutils

# install gcc
brew link glibc
brew install patchelf
ln -s /usr/lib64/libstdc++.so.6 /lib64/libgcc_s.so.1 `brew --prefix`/lib/
brew install gcc --with-glibc -v
rm -f ~/.linuxbrew/lib/{libstdc++.so.6,libgcc_s.so.1}
brew unlink gcc && brew link gcc
export HOMEBREW_CC=gcc

# Install core libraries and utilities
brew install bzip2 curl expat
brew install git --with-brewed-curl --with-brewed-openssl --without-tcl-tk
brew tap homebrew/dupes
brew install coreutils findutils gawk gnu-sed gnu-which grep libpng libxml2 libxslt make ncurses readline
PATH=`brew --prefix`/bin:`brew --prefix`/sbin

# create symbol links
ln -s ncursesw/curses.h ncursesw/form.h ncursesw/ncurses.h ncursesw/term.h ncursesw/termcap.h `brew --prefix`/include
ln -s libncurses.a `brew --prefix`/lib/libcurses.a
ln -s libncurses.so `brew --prefix`/lib/libcurses.so

