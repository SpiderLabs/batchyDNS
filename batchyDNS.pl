#!/usr/bin/perl
=header
    batchyDNS - A DNS recon tool
	Created by Kevin Stadmeyer <kstadmeyer@trustwave.com>
    Copyright (C) 2009-2010 Trustwave Holdings, Inc.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
=cut

use strict;
use warnings;
use Net::IP;
use Net::DNS;

# Usage
unless($ARGV[0]) {
     print "batchyDNS, written by Kevin Stadmeyer\n";
     print "Usage: batchyDNS.pl (IP list file)\n";
     exit;
}
open(MYINPUTFILE, $ARGV[0]);
while(<MYINPUTFILE>)
{
 my($line) = $_;
 chomp($line);
 my $ip = new Net::IP($line,4);
 if ($ip) {
     my $res = Net::DNS::Resolver->new;
     my $answer = $res->query($ip->reverse_ip(),'PTR');
     my $namer = $answer->{'answer'}[0];
     print "$namer->{'ptrdname'}\n";
 }
}
