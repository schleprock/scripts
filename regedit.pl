#! /usr/bin/env perl

use strict;

use Getopt::Long;
use Cwd;
use Cwd 'chdir';
$/ = "\r\n";

if(!@ARGV) {
  print("\nERROR: must provide a .reg file\n\n");
  exit 1;
}
my $regFile = $ARGV[0];
#print("\nregFile = $regFile\n");
if(! -e $regFile) {
  print("\nERROR: $regFile does not exist\n\n");
  exit 2;
}
$regFile = qx/cygpath -w $regFile/;
my $cmd = "cmd /C regedit.exe -s \"$regFile\"";
print("\nexec'ing $cmd\n");
system("$cmd");

