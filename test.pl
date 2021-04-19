#! /usr/bin/env perl
use strict;

use Getopt::Long;
use Cwd;
use Cwd 'chdir';
use Cwd 'realpath';

my $type = "debug";


my $debugSw = "";
if("$type" eq "debug")
{
  $debugSw = "--debug=full";
}

print("debugSw = $debugSw\n");
