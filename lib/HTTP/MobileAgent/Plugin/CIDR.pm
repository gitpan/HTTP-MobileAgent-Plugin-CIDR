package HTTP::MobileAgent::Plugin::CIDR;

use warnings;
use strict;
use Carp;
use HTTP::MobileAgent;
use HTTP::MobileAgent::Plugin::CIDR::RegEx;

use version; our $VERSION = qv('0.0.1');

package # hide from PAUSE
       HTTP::MobileAgent;

sub check_network {
    my ($self,$ip) = @_;

    my $ipbit = masked_ipbit($ip,32);

    $ipbit =~ $self->__network_regex ? 1 : 0;
}

sub __network_regex{ qr(^[01]{32}$) }

sub masked_ipbit {
    my ($ip,$snm,$setrest) = @_;
    $snm =~ s|/||g;

    my $ret = $snm ? substr(join("", map { unpack("B8",  pack("C", $_)) } split(/\./,$ip)),0,$snm) :
                     "";
    if ($setrest) {
        $ret .= sprintf("[01]{%d}",32-$snm) if (32-$snm);
    }

    return $ret;
}

1; # Magic true value required at end of module
__END__

=head1 NAME

HTTP::MobileAgent::Plugin::CIDR - Add IP address check method to HTTP::MobileAgent


=head1 VERSION

This document describes HTTP::MobileAgent::Plugin::CIDR version 0.0.1


=head1 SYNOPSIS

  use HTTP::MobileAgent::Plugin::CIDR;
  
  my $ma = HTTP::MobileAgent->new;

  # Check Gateway IP address 
   
  print $ma->check_network($ip) ? "Good GW address" : "Bad GW address";


=head1 DEPENDENCIES

=over

=item L<HTTP::MobileAgent>

=back


=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to C<nene@kokogiko.net>.


=head1 AUTHOR

OHTSUKA Ko-hei  C<< <nene@kokogiko.net> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2008, OHTSUKA Ko-hei C<< <nene@kokogiko.net> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
