require 'formula'

class Vim <Formula
  version '7.2'
  url "http://ftp.vim.org/pub/vim/unix/vim-#{version}.tar.bz2"
  homepage 'http://www.vim.org'
  md5 'f0901284b338e448bfd79ccca0041254'

  #depends_on 'gnu-tar' => :optional
  #depends_on 'grep'   => :optional

  # This keeps failing, so commenting out for now
  #def patches
  #  'http://ftp.vim.org/pub/vim/patches/7.2/7.2.320'
  #end

  def interp_option(type)
    @configure_args << "--enable-#{type}interp"
  end

  def features_option(type)
    @configure_args << "--with-features=#{type}"
  end

  def install
    @configure_args = []
    @configure_args << "--prefix=#{prefix}"
    @configure_args << "--enable-gui=no"
    @configure_args << "--without-x"
    @configure_args << "--disable-gpm"
    @configure_args << "--disable-nls"
    @configure_args << "--with-tlib=ncurses"
    @configure_args << "--enable-multibyte"

    if MACOS_VERSION >= 10.6 and Hardware.is_64_bit?
      @configure_args << "ARCHFLAGS='-arch x86_64'"
    end

    # Include any and all interpreter options
    interp_option :perl if ARGV.include? '--perl'
    interp_option :python if ARGV.include? '--python'
    interp_option :ruby if ARGV.include? '--ruby'
    interp_option :tcl if ARGV.include? '--tcl'

    # Do specific feature size if specified
    if ARGV.include? '--tiny'
      features_option :tiny
    elsif ARGV.include? '--small'
      features_option :small
    elsif ARGV.include? '--big'
      features_option :big
    elsif ARGV.include? '--huge'
      features_option :huge
    end

    if ARGV.include? '--cscope'
      @configure_args << '--enable-cscope'
    end

    if ARGV.include? '--nls'
      @configure_args << '--disable-nls'
    end

    if ARGV.include? '--xim'
      @configure_args << '--enable-xim'
    end
    
    system "./configure", *@configure_args  
    system "make"
    system "make install"
  end
end

