###########################################
package OAuth::Cmdline::Tumblr;
###########################################
use strict;
use warnings;
use Net::OAuth::Client;

use base qw( OAuth::Cmdline );

###########################################
sub site {
###########################################
    return "tumblr";
}

###########################################
sub full_login_uri {
###########################################
    my( $self ) = @_;

    $self->{ oauth_client } =
      Net::OAuth::Client->new(
          $self->client_id(),
          $self->client_secret(),
          callback           => $self->redirect_uri(),
          request_token_path => $self->token_uri,
          authorize_path     => $self->login_uri,
          access_token_path  => $self->access_uri,
      );

      return $self->{ oauth_client }->authorize_url();
}

package OAuth::Cmdline::Mojo;
no warnings 'redefine';

TODO: $self needs to be OAuth::Cmdline::Tumblr, not OAuth::Cmdline::Mojo

###########################################
sub callback {
###########################################
  my ( $self ) = @_;

  $self->{ oauth_client }->oauth_token( $self->param( "oauth_token" ) );
  $self->{ oauth_client }->oauth_verifier( $self->param( "oauth_verifier" ) );

  $self->{ oauth_client }->token();
  $self->{ oauth_client }->token_secret();
}

my $t = WWW::Tumblr->new(
  consumer_key    => $cfg->{ consumer_key },
  secret_key      => $cfg->{ secret_key },
  token           => $cfg->{ token },
  token_secret    => $cfg->{ token_secret },
);

1;

__END__

=head1 NAME

OAuth::Cmdline::Tumblr - Tumblr-specific OAuth oddities

=head1 SYNOPSIS

    # don't use this directly

=head1 DESCRIPTION

This class overrides methods of C<OAuth::Cmdline> if Tumblr's Web API 
deviates from standard OAuth.

=head1 LEGALESE

Copyright 2014 by Mike Schilli, all rights reserved.
This program is free software, you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 AUTHOR

2014, Mike Schilli <cpan@perlmeister.com>
