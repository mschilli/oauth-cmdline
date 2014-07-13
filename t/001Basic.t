######################################################################
# Test suite for Oauth::Cmdline
# by Mike Schilli <cpan@perlmeister.com>
######################################################################

use warnings;
use strict;

use Test::More qw(no_plan);
BEGIN { use_ok('Oauth::Cmdline') };

ok(1);
like("123", qr/^\d+$/);
