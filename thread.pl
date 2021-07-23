#! /usr/bin/env perl

use strict;

use Getopt::Long;
use Cwd;
use Cwd 'chdir';

use Thread;
use Thread::Queue;

# create a shared queue
my $queue = Thread::Queue->new();

sub myPrint {
  my $done = "0";
  while(!$done) {
    my $count = $queue->dequeue();
    if((defined($count)) && ($count != "-1")) {
      my $cmd = "xterm -e \"echo crap $count; sleep 3\"";
      system($cmd);
    }
    if($count == "-1") {
      $done = "1";
    }
  }
  return 0;
}

# figure out how many processors
my $numProc = $ENV{NUMBER_OF_PROCESSORS};
if(defined($numProc)) {
  print("$numProc processors detected\n");
} else {
  print("cannot determine numb of processors, using 4\n");
  $numProc = "4";
}
# create a thread per cpu
my @threads;
for(my $count = "0"; $count < $numProc; ++$count) {
  $threads[$count] = Thread->new(\&myPrint);
}
print("num processors = $ENV{NUMBER_OF_PROCESSORS}\n");

for(my $count = 0; $count < 50; ++$count) {
  $queue->enqueue($count);
}
for(my $count = 0; $count < $numProc; ++$count) {
  $queue->enqueue("-1");
}
for(my $count = 0; $count < $numProc; ++$count) {
  my $ret = $threads[$count]->join();
}
