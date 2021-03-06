require 'formula'

class Php <Formula
  url 'http://us.php.net/distributions/php-5.2.14.tar.gz'
  homepage 'http://www.php.net'
  md5 '6dff7429a1b43aa1c76a43e909215608'

# depends_on 'cmake'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}", "--with-mysql", "--with-mysqli", "--with-pdo-mysql", "--with-apxs2=/usr/sbin/apxs", "--enable-cli", "--with-curl=/usr"
#   system "cmake . #{std_cmake_parameters}"
    system "make"
    system "sudo make install"
  end
end
