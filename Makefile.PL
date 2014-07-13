######################################################################
# Makefile.PL for Oauth::Cmdline
# 2014, Mike Schilli <cpan@perlmeister.com>
######################################################################
use ExtUtils::MakeMaker;

my $meta_merge = {
    META_MERGE => {
        resources => {
            repository  => 'http://github.com/mschilli/oauth-cmdline.git',
        },
    }
};

WriteMakefile(
    'NAME'         => 'Oauth::Cmdline',
    'VERSION_FROM' => 'lib/Oauth/Cmdline.pm', # finds $VERSION
    'PREREQ_PM'    => {
        Log::Log4perl         => 1,
        Moo                   => undef,
        URI                   => undef,
        YAML                  => undef,
        HTTP::Request::Common => undef,
        JSON                  => undef,
        LWP::UserAgent        => undef,
        MIME::Base64          => undef,
    }, # e.g., Module::Name => 1.1
    $ExtUtils::MakeMaker::VERSION >= 6.50 ? (%$meta_merge) : (),
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/Oauth/Cmdline.pm',
       AUTHOR     => 'Mike Schilli <cpan@perlmeister.com>') : ()),
);
