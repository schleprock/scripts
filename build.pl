#! /usr/bin/env perl

use strict;

use Getopt::Long qw(:config pass_through);
use Cwd;
use Cwd 'chdir';

my $buildType = "debug";
my $buildBits = 64;
my $clean = 0;
my $all = 0;
my $nextgen = 0;
my $simplorer = 0;
my $noCore = 0;
my $useExe;
my $dryRun;
my $help;
GetOptions("type=s" => \$buildType, # debug, release ...
           "clean" => \$clean, # clean build or not, default is not
           "bits=s" => \$buildBits, # numb bits, 32/64
           "all" => \$all, # build it all
           "nextgen" => \$nextgen, # just build nextgen
           "simplorer" => \$simplorer, # just build simplorer
           "noCore" => \$noCore, # don't build ansoftcore
           "useExe" => \$useExe, # use devenv.exe instead of .com
           "dryRun" => \$dryRun, # don't do anything, just print what will be
           "help|?" => \$help, # print out help
    );

if($ARGV[0]) {
  print("ERROR: unknown option $ARGV[0]; aborting\n\n");
  printHelp();
  exit(1);
}

if($help) {
  printHelp();
  exit(0);
}

sub printHelp
{
  print "build [--type <debug/release>] [--bits <32/64>]\n";
  print "\t[ --all | --nextgen | --simplorer ]\n\t[ --noCore ] [ --clean ] [--help]\n\n";
  print "default is -t debug -b 64 -all\n";
  print "\t--type: type of build debug/release\n";
  print "\t--bits: 32/64 bit build\n";
  print "\t--all, nextgen, or simplorer: self explainatory\n";
  print "\t--noCore: only relevent for --nextgen or simplorer, skip building\n";
  print "\t\tansoft core\n";
  print "\t--clean: invoke clean before each build\n";
  print "\t--useExe: use devenv.exe instead of .com\n";
  print "\t--dryRun: don't actually build, just print what will be done\n";
  print "\t--help|?: print out this message\n\n";
}

if($useExe) {
  $useExe = " ";
} else {
  $useExe = "YES";
}

if (!$all && !$nextgen && !$simplorer) {
  $all = 1;
}
my $cleanSwitch = "NOCLEAN";
if($clean) {
  print("invoking clean build\n\n");
  $cleanSwitch = "CLEAN";
}
my $currentDir = getcwd();
if($all || $nextgen) {
  if(!chdir("nextgen")) {
    print("ERROR: $currentDir cannot chdir to nextgen\n\n");
    system("xmessage -center \"ERROR: $currentDir cannot chdir to nextgen\n\n\"");
    exit 1;
  }
  my $coreBuild = "COREBUILD";
  if($nextgen && $noCore) {
    $coreBuild = "NOCOREBUILD";
  }
  my $cmd = "./MakeSimplorerUI.bat $buildType $cleanSwitch DEV $buildBits $coreBuild NOPAUSE $useExe";
  print "\nexecing: $cmd\n\n";
  if(!$dryRun) {
    if(system($cmd) != 0) {
      print("ERROR: $currentDir/$cmd FAILED\n\n");
      system("xmessage -center \"ERROR: $currentDir/$cmd FAILED\"");
      exit 1;
    }
  }
  chdir($currentDir);
}
if($all || $simplorer) {
  if(!chdir("simplorer")) {
    print("ERROR: $currentDir cannot chdir to simplorer\n\n");
    system("xmessage \"ERROR: $currentDir cannot chdir to simplorer\n\n\"");
    exit 1;
  }
  my $coreBuild = "COREBUILD";
  if($all || $noCore) {
    $coreBuild = "NOCOREBUILD";
  }
  my $cmd = "./MakeSimplorerEngine.bat $buildType $cleanSwitch DEV $buildBits $coreBuild NOPAUSE $useExe";
  print "\nexecing: $cmd\n\n";
  if(!$dryRun) {
    if(system($cmd) != 0) {
      print("ERROR: $currentDir/$cmd FAILED\n\n");
      system("xmessage -center \"ERROR: $currentDir/$cmd FAILED\"");
      exit 1;
    }
  }
  chdir($currentDir);
}
# use the dev-services script to copy the thirdparty dll's to the 
# runtime area
my $cmd = "buildtools/scripts/git/ebugit.sh populate-runtime";
print("\nRunning $cmd ...\n\n");
if(system($cmd) != 0) {
  print("ERROR: $cmd FAILED\n\n");
  system("xmessage -center \"ERROR: $cmd FAILED\"");
  exit 1;
}

# if we got here, then it passed!
print("SUCCESS: $currentDir built!\n\n");
system("xmessage -center \"SUCCESS: $currentDir built!\"");
