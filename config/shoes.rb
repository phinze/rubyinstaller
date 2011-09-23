require 'ostruct'

module Shoes

  Shoes = OpenStruct.new(
  :release => 'tophat',
  #:version => 'r1134',
  :url => 'http://shoooes.net/dist',
  :checkout => 'git://github.com/shoes/shoes',
  :checkout_target => 'sandbox/shoes',
  :target => 'sandbox/shoes',

  :build_target => 'sandbox/shoes_build',
  :install_target => 'sandbox/shoes_mingw',
  :configure_options => [],
  :files => [
    'shoes2.tar.gz'
  ],
  :dependencies => [
      :cairo, :glib, :libjpeg, :libungif, :pango, :portaudio, :sqlite3, :winhttp
  ]
  )


  Cairo = OpenStruct.new(
  :url => "http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies",
  :version => '1.8.10-1',
  :target => 'sandbox/cairo',
  :files => [
    'cairo-dev_1.8.10-1_win32.zip',
    'cairo_1.8.10-1_win32.zip'
  ]
  )

  Glib = OpenStruct.new(
  :url => "http://ftp.gnome.org/pub/gnome/binaries/win32/glib/2.24",
  :version => '2.24.0-2',
  :target => 'sandbox/glib',
  :files => [
    'glib-dev_2.24.0-2_win32.zip',
    'glib_2.24.0-2_win32.zip'
  ]
  )

  LibJpeg = OpenStruct.new(
  :url => "http://www.ijg.org/files",
  #:url => "http://www.ijg.org/",
  :version => '8c',
  :target => "sandbox/libjpeg",
  :files => [
    'jpegsr8c.zip',
    #'libjpeg_v8_bin_lib_include.zip'
  ]
  )

  LibUnGif = OpenStruct.new(
  :url => "http://gnuwin32.sourceforge.net/downlinks",
  :version => '',
  :target => 'sandbox/libungif',
  :files => [
    'libungif-bin-zip.php',
    'libungif-lib-zip.php'
#    'libungif-4.1.4-bin.zip',
#    'libungif-4.1.4-lib.zip'
  ]
  )

  Pango = OpenStruct.new(
  :url => "http://ftp.gnome.org/pub/gnome/binaries/win32/pango/1.28",
  :version => '1.28.0-1',
  :target => 'sandbox/pango',
  :files => [
    'pango-dev_1.28.0-1_win32.zip',
    'pango_1.28.0-1_win32.zip'
  ]
  )

  PortAudio = OpenStruct.new(
  :url => "http://www.portaudio.com/archives",
  :target => 'sandbox/portaudio',
  :install_target => 'sandbox/port_audio',
  :files => ['pa_snapshot.tgz']
  )

  Sqlite3 = OpenStruct.new(
  :url => "http://www.sqlite.org",
  :target => 'sandbox/sqlite3',
  :files => [
    'sqlitedll-3_6_23_1.zip',
    'sqlite-amalgamation-3_6_23_1.zip'
  ]
  )

  Winhttp = OpenStruct.new(
  :url => "http://www.holymonkey.com/shoes-packages",
  :target => 'sandbox/winhttp',
  :files => ['winhttp.zip']
  )

end
