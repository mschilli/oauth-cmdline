###########################################
package OAuth::Cmdline::CustomFile;
###########################################
use strict;
use warnings;
use MIME::Base64;
use Moo;

extends 'OAuth::Cmdline';

has custom_file => ( is => "rw" );

# VERSION
# ABSTRACT: Use a custom cache file with  OAuth::Cmdline

###########################################
sub site {
###########################################
    return "custom-file";
}

###########################################
sub cache_file_path {
###########################################
    my ($self) = @_;

    return $self->custom_file;
}

1;

__END__

=head1 SYNOPSIS

    my $oauth = OAuth::Cmdline::CustomFile->new( custom_file => "<path>" );
    $oauth->access_token();

=head1 DESCRIPTION

This class overrides the cache_file_path method of C<OAuth::Cmdline>
and adds the custom_file attribute.
