#! /usr/bin/env perl
use strict;

use Getopt::Long;
use Cwd;
use Cwd 'chdir';
use Cwd 'realpath';

print("env = $ENV{\"PATH\"}\n");
my $oldPath = $ENV{"PATH"};
print("oldPath = $oldPath\n");
$ENV{"PATH"} = "";
print("env = $ENV{\"PATH\"}\n");
$ENV{"PATH"} = "FOOBAR:${oldPath}";
print("env = $ENV{\"PATH\"}\n");
