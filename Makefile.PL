######################################################################
# Makefile.PL for Oauth::Cmdline
# 2014, Mike Schilli <cpan@perlmeister.com>
######################################################################
use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'         => 'Oauth::Cmdline',
    'VERSION_FROM' => 'lib/Oauth/Cmdline.pm', # finds $VERSION
    'PREREQ_PM'    => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/Oauth/Cmdline.pm',
       AUTHOR     => 'Mike Schilli <cpan@perlmeister.com>') : ()),
);
