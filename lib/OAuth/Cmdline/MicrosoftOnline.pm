###########################################
package OAuth::Cmdline::MicrosoftOnline;
###########################################
use strict;
use warnings;
use MIME::Base64;
use base qw( OAuth::Cmdline );

###########################################
sub site {
###########################################
    return "microsoft-online";
}

1;

__END__

=head1 NAME

OAuth::Cmdline::MicrosoftOnline - Microsoft Online-specific settings for OAuth::Cmdline

=head1 SYNOPSIS

    my $oauth = OAuth::Cmdline::MicrosoftOnline->new( );
    $oauth->access_token();

=head1 DESCRIPTION

This class overrides methods of C<OAuth::Cmdline> if Microsoft Online's Web API 
requires it.

To use this module with Azure AD:
- Set up a temporary web service for callbacks as described in C<OAuth::Cmdline and as in eg/microsoft-online-token-init
- Sign up for Azure AD for your Office 365 (free).
- Add an Azure AD app of type Web, with callbacks pointing to your temporary web service
- Retrieve the ID and key (secret) from the app page
- Update your web service with the ID and secret and start it
- Go to your web service and follow the link
- Authenticate to O365

Your web service will retrieve the tokens and store them. You can then use

    $oauth->access_token()

to get an access token to carry out calls against the Azure Graph API as shown in eg/microsoft-online-users. Remember the token is tied to the user account - if the user account is removed or disabled, the calls will stop working.

Example code is in the eg folder

=head1 LEGALESE

Copyright 2015 by Mike Schilli, all rights reserved.
This program is free software, you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 AUTHOR

2015, Ian Gibbs
