###########################################
package OAuth::Cmdline::Smartthings;
###########################################
use strict;
use warnings;
use MIME::Base64;

use base qw( OAuth::Cmdline );

###########################################
sub site {
###########################################
    return "smartthings";
}

1;

__END__

=head1 NAME

OAuth::Cmdline::Smartthings - Smartthings-specific OAuth oddities

=head1 SYNOPSIS

    my $oauth = OAuth::Cmdline::Smartthings->new( );
    $oauth->access_token();

=head1 DESCRIPTION

This class overrides methods of C<OAuth::Cmdline> to comply with
Smartthings's Web API.

To register with Smartthings, go to 

    https://graph-na02-useast1.api.smartthings.com (US)
    https://graph-eu01-euwest1.api.smartthings.com (UK)

and create a new app, enable the "OAuth" section, copy the 
client ID and client secret to your C<~/.smartthings.yml> file:

    client_id: xxx
    client_secret: yyy

Also use

    http://localhost:8082/callback

as a "redirect URI" (not optionial as the label would suggest) and then
run C<eg/smartthings-token-init> and point your browser to 

    http://localhost:8082

Then click the login link and follow the flow.

=head1 LEGALESE

Copyright 2016 by Mike Schilli, all rights reserved.
This program is free software, you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 AUTHOR

2016, Mike Schilli <cpan@perlmeister.com>
