
use strict;
use Cwd;

my $ls=`ls -1`;
my @dirs=split('\n',$ls);
my $cwd=cwd();
foreach my $dir(@dirs) {
    print("dir: $dir\n");
    if( ! chdir("$dir") ) {
        print("ERROR: cannot cd to $dir\n\n");
        exit(1);
    }
    system("rm -f mergedMP3.mp3");
    system("cat *.mp3 > mergedMP3.mp3");
    chdir($cwd);
}

