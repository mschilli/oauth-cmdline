###########################################
package Oauth::Cmdline;
###########################################
use strict;
use warnings;
use Moo;
use URI;
use YAML qw( DumpFile LoadFile );
use HTTP::Request::Common;
use LWP::UserAgent;
use Log::Log4perl qw(:easy);
use JSON qw( from_json );

our $VERSION = "0.01";

has client_id     => ( is => "ro" );
has client_secret => ( is => "ro" );
has local_uri      => ( 
  is      => "rw",
  default => "http://localhost:8082",
);
has homedir => ( 
  is      => "ro",
  default => glob '~',
);
has login_uri => ( is => "rw" );
has site      => ( is => "rw" );
has scope     => ( is => "rw" );
has token_uri => ( is => "rw" );
has redir_uri => ( is => "rw" );

###########################################
sub redirect_uri {
###########################################
    my( $self ) = @_;

    return $self->local_uri . "/callback";
}

###########################################
sub cache_file_path {
###########################################
    my( $self ) = @_;

      # creds saved  ~/.[site].yml
    return $self->homedir . "/." .
           $self->site . ".yml";
}

###########################################
sub full_login_uri {
###########################################
    my( $self ) = @_;

    my $full_login_uri = URI->new( $self->login_uri );

    $full_login_uri->query_form (
      client_id     => $self->client_id(),
      response_type => "code",
      redirect_uri  => $self->redirect_uri(),
      scope         => $self->scope(),
    );

    return $full_login_uri;
}

###########################################
sub tokens_get {
###########################################
  my( $self, $code ) = @_;

  $DB::single = 1;

  my $req = &HTTP::Request::Common::POST(
    $self->token_uri,
    [
      code          => $code,
      client_id     => $self->client_id,
      client_secret => $self->client_secret,
      redirect_uri  => $self->redirect_uri,
      grant_type    => 'authorization_code',
    ]
  );

  my $ua = LWP::UserAgent->new();
  my $resp = $ua->request($req);

  if( $resp->is_success() ) {
    my $data = 
      from_json( $resp->content() );

    return ( $data->{ access_token }, 
             $data->{ refresh_token },
             $data->{ expires_in } );
  }

  LOGDIE $resp->status_line();
  return undef;
}

###########################################
sub tokens_collect {
###########################################
  my( $self, $code ) = @_;

  my( $access_token, $refresh_token,
      $expires_in ) = $self->tokens_get( $code );

  umask 0177;

  DumpFile $self->cache_file_path, {
    access_token  => $access_token,
    refresh_token => $refresh_token,
    client_id     => $self->client_id,
    client_secret => $self->client_secret,
    expires       => time() + $expires_in,
  };
}

1;

__END__

=head1 NAME

Oauth::Cmdline - Oauth2 for command line applications using web services

=head1 SYNOPSIS

    my $oauth = Oauth::Cmdline->new(
      client_id     => "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
      client_secret => "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY",
      login_uri     => "https://accounts.spotify.com/authorize",
      token_uri     => "https://accounts.spotify.com/api/token",
      site          => "spotify",
      scope         => "user-read-private",
    );

=head1 DESCRIPTION

Oauth::Cmdline helps standalone command line scripts to deal with 
web services requiring OAuth access tokens.

=head1 LEGALESE

Copyright 2014 by Mike Schilli, all rights reserved.
This program is free software, you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 AUTHOR

2014, Mike Schilli <cpan@perlmeister.com>
