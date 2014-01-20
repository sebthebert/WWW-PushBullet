use strict;
use warnings;

use FindBin; 
use Test::More tests => 4;

use lib "$FindBin::Bin/../lib/";

use_ok 'WWW::PushBullet';

use WWW::PushBullet;

my $INVALID_API_KEY = '1234567890';

#
# checks new() function
#
my $pb = WWW::PushBullet->new();
ok(! defined $pb, "WWW::PushBullet->new() => undef");

my $pb2 = WWW::PushBullet->new({apikey => $INVALID_API_KEY});
ok(defined $pb2, "WWW::PushBullet->new({apikey => '$INVALID_API_KEY'})");

#
# checks api_key() function
#
my $api_key = $pb2->api_key();
ok($api_key eq $INVALID_API_KEY, "WWW::PushBullet->api_key()");