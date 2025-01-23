#! /usr/bin/env perl
use strict;

use Getopt::Long;
use Cwd;
use Cwd 'chdir';
use Cwd 'realpath';

if(-l "95549a") {
  print("link");
} else {
  print("not link");
}
print("\n");
