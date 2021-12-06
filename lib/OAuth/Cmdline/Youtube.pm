###########################################
package OAuth::Cmdline::Youtube;
###########################################
use strict;
use warnings;
use MIME::Base64;
use base qw( OAuth::Cmdline );

###########################################
sub site {
###########################################
    return "youtube";
}

1;

__END__

=head1 NAME

OAuth::Cmdline::Youtube - Youtube-specific settings for OAuth::Cmdline

=head1 SYNOPSIS

    my $oauth = OAuth::Cmdline::Youtube->new( );
    $oauth->access_token();

=head1 DESCRIPTION

This class overrides methods of C<OAuth::Cmdline> if Youtube's Web API 
requires it.

=head1 LEGALESE

Copyright 2016 by Mike Schilli, all rights reserved.
This program is free software, you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 AUTHOR

2016, Mike Schilli <cpan@perlmeister.com>
