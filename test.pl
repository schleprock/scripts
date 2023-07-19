#! /usr/bin/env perl
use strict;

use Getopt::Long;
use Cwd;
use Cwd 'chdir';
use Cwd 'realpath';

my $cmd = "$ENV{SHELL} -c 'test2.pl | tee /tmp/crap;exit \${PIPESTATUS[0]}' ";
print("cmd = $cmd\n");
print("SHELL = $ENV{SHELL}\n");
if(system($cmd)) {
  print("ERROR: $cmd FAILED\n\n");
} else {
  print("SUCCESS\n");
}

