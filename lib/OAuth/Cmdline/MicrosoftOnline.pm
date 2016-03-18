###########################################
package OAuth::Cmdline::MicrosoftOnline;
###########################################
use strict;
use warnings;
use MIME::Base64;
use base qw( OAuth::Cmdline );
use Moo;

has resource => (
  is => "rw",
  required => 1,
);

###########################################
sub site {
###########################################
    return "microsoft-online";
}

1;

###########################################
sub tokens_get_additional_params {
###########################################
    my( $self, $params ) = @_;

    push(@$params, resource => $self->resource);

    return $params;
}

###########################################
sub update_refresh_token {
###########################################
    my( $self, $cache, $data ) = @_;

    # MS Online returns a new refresh token with every access token.
    # We need to use this new token each time otherwise in 14 days
    # we have to re-authorise. By updating the refresh token, we
    # get 90 days
    $cache->{ refresh_token } = $data->{ refresh_token };

    return ($cache, $data);
}

__END__

=head1 NAME

OAuth::Cmdline::MicrosoftOnline - Microsoft Online-specific settings for OAuth::Cmdline

=head1 SYNOPSIS

    my $oauth = OAuth::Cmdline::MicrosoftOnline->new( resource => "https://graph.windows.net", ... );
    $oauth->access_token();

=head1 DESCRIPTION

This class overrides methods of C<OAuth::Cmdline> if Microsoft Online's Web API 
requires it.

The parameter 'resource' is mandatory, and is poorly described at L<https://msdn.microsoft.com/en-us/library/azure/dn645542.aspx>. It tells the OAuth API what protected resource you are trying to access. For example, to access Azure Graph (to manage user accounts in Azure AD etc.), the correct resource URI is C<https://graph.windows.net>. A URI does not have to be a URL, but Microsoft choose to use URLs for their URIs, so if you are trying to access a different endpoint protected by the Microsoft Online OAuth system, then it will probably look like a URL.

To use this module with Azure AD:

=over

=item *
Set up a temporary web service for callbacks as described in C<OAuth::Cmdline> and as in eg/microsoft-online-token-init

=item *
Sign up for Azure AD for your Office 365 (free).

=item *
Add an Azure AD app of type Web, with callbacks pointing to your temporary web service

=item *
Retrieve the ID and key (secret) from the app page

=item *
Update your web service with the ID and secret and start it

=item *
Go to your web service and follow the link

=item *
Authenticate to O365

=back

Your web service will retrieve the tokens and store them. You can then use

    $oauth->access_token()

to get an access token to carry out calls against the Azure Graph API as shown in eg/microsoft-online-users. Remember the token is tied to the user account - if the user account is removed or disabled, the calls will stop working.

Example code is in the eg folder

=head1 LEGALESE

Copyright 2015 Mike Schilli, all rights reserved.
This program is free software, you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 AUTHOR

2015, Ian Gibbs
