# tail simulator
# usage - perl tailSimulator.pl [log path] [interval] [lines per interval] [cycle flag] [output file] [max lines per file]
# eg. perl logSimulator.pl /home/xd/tploader/tploader.log 1 1000 1 test.log 10240

use strict;
use warnings;

my $log = $ARGV[0];
my $interval = $ARGV[1];
my $repeat = $ARGV[2];
my $cycleFlag = $ARGV[3];
my $output = $ARGV[4];
my $maxLine = $ARGV[5];

pop @ARGV;
pop @ARGV;
pop @ARGV;
pop @ARGV;
pop @ARGV;

my $totalCount = 0;
my $count = 0;
open OUT, ">$output";

while (<>)
{
  if ($count == $repeat)
  {
    $count = 0;
    sleep($interval);
  }

  if ($totalCount == $maxLine)
  {
    $totalCount = 0;

    close OUT;
    system("rm $output");
    open OUT, ">$output";
  }

  $totalCount = $totalCount + 1;
  $count = $count + 1;

  print OUT $_;
  select OUT;
  $|=1;
  select STDIN;

  if ($cycleFlag == 1)
  {
    $ARGV[0] = $log;
  }
}
