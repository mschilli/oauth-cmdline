###########################################
package OAuth::Cmdline::Spotify;
###########################################
use strict;
use warnings;
use MIME::Base64;

use base qw( OAuth::Cmdline );

# VERSION
# ABSTRACT: Spotify-specific OAuth oddities

###########################################
sub site {
###########################################
    return "spotify";
}

###########################################
sub token_refresh_authorization_header {
###########################################
    my( $self ) = @_;

    my $cache = $self->cache_read();

    my $auth_header = 
        "Basic " . 
        encode_base64( 
            "$cache->{ client_id }:$cache->{ client_secret }", 
            "" # no line break!!
        );
    return ( "Authorization" => $auth_header );
}

1;

__END__

=head1 SYNOPSIS

    my $oauth = OAuth::Cmdline::Spotify->new( );
    $oauth->access_token();

=head1 DESCRIPTION

This class overrides methods of C<OAuth::Cmdline> to comply with
Spotify's Web API.
