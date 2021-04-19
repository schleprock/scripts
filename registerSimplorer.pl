#! /usr/bin/env perl

use strict;

use Getopt::Long;
use Cwd;
use Cwd 'chdir';

my $buildType = "debug";
my $buildBits = 64;
my $help;

GetOptions("type=s" => \$buildType, # debug, release ...
           "bits=s" => \$buildBits, # numb bits, 32/64
           "help|?" => \$help, # print out help
    );
if($help) {
  print "registerSimplorer [--type <debug/release>] [--bits <32/64>] ";
  print "[--help|?]\n";
  print "\tdefault is -t debug -b 64\n";
  print "\t--type: type of build debug/release\n";
  print "\t--bits: 32/64 bit build\n";
  print "\t--help|?: print out this message\n\n";
  exit;
}

my $cmd = "./Register.bat $buildType %buildBits NOPAUSE SILENTREG";
if(system($cmd) != 0) {
  print("\n\nERROR: $cmd FAILED\n\n");
}
