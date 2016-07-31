###########################################
package OAuth::Cmdline::Automatic;
###########################################
use strict;
use warnings;
use MIME::Base64;

use base qw( OAuth::Cmdline );

###########################################
sub site {
###########################################
    return "automatic";
}

###########################################
sub redirect_uri {
###########################################
    my( $self ) = @_;

    return undef;
}

1;

__END__

=head1 NAME

OAuth::Cmdline::Automatic - Automatic-specific OAuth oddities

=head1 SYNOPSIS

    # don't use this directly

=head1 DESCRIPTION

This class overrides methods of C<OAuth::Cmdline> if Automatic's Web API 
deviates from standard OAuth.

Since Automatic doesn't allow a C<redirect_uri> parameter in the initial
token dance move, make sure to set the field C<"OAuth Redirect URL">
in the new app registration form to

    http://localhost:8082/callback

which is where C<eg/automatic-token-init> is waiting for the response
from the authentication server.

=head1 LEGALESE

Copyright 2016 by Mike Schilli, all rights reserved.
This program is free software, you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 AUTHOR

2016, Mike Schilli <cpan@perlmeister.com>
