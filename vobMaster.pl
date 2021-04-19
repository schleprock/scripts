#! /usr/bin/env perl

use strict;

use Getopt::Long;
use Cwd;
use Cwd 'chdir';

my $debug;
my $help;

GetOptions("debug" => => \$debug, # enable debug output
           "help|?" => \$help, # print out help
    );

if($help) {
  printHelp();
}

my @files = @ARGV;

if($debug) {
  print("list of files:\n");
  for my $file(@files) {
    print("file: $file\n");
  }
}
chomp(@files);
for my $file(@files) {
  my $cmd = "cleartool describe -fmt \"%[master]p\\n\" \"${file}@@\" 2>&1";
  print("\nRunning cmd: $cmd\n") if($debug);
  my $output = qx/$cmd/;
  if($?) {
    print("$file:\n");
  } else {
    my @vob = split(/\\/,$output);
    print("$file: @vob[1]");
  }
}

sub printHelp {
  print "vobMaster.pl file/directory [-help|?]\n";
  print "\tprint out the vob that the file/directory belongs to.\n";
  print "\tsupports wildcards\n";
  print "\t--debug: print out debug messages\n";
  print "\t--help: print out this message\n\n";
  exit 1;
}
