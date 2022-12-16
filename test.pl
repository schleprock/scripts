#! /usr/bin/env perl
use strict;

use Getopt::Long;
use Cwd;
use Cwd 'chdir';
use Cwd 'realpath';

my $scriptsPath = qx!cygpath -m "$ENV{'HOME'}/scripts"!;
print("$scriptsPath");
