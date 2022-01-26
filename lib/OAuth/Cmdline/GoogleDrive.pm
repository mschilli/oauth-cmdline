###########################################
package OAuth::Cmdline::GoogleDrive;
###########################################
use strict;
use warnings;
use MIME::Base64;
use base qw( OAuth::Cmdline );

# VERSION
# ABSTRACT: GoogleDrive-specific settings for OAuth::Cmdline

###########################################
sub site {
###########################################
    return "google-drive";
}

1;

__END__

=head1 SYNOPSIS

    my $oauth = OAuth::Cmdline::GoogleDrive->new( );
    $oauth->access_token();

=head1 DESCRIPTION

This class overrides methods of C<OAuth::Cmdline> if Google Drives' Web API 
requires it.
