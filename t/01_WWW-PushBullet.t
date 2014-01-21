use strict;
use warnings;

use FindBin; 
use Test::More tests => 4 + 5 + 1;

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
ok((defined $pb2) && (ref $pb2 eq 'WWW::PushBullet'), 
    "WWW::PushBullet->new({apikey => '$INVALID_API_KEY'}) => WWW::PushBullet object");

#
# checks api_key() function
#
my $api_key = $pb2->api_key();
ok($api_key eq $INVALID_API_KEY, 'WWW::PushBullet->api_key() => api_key');

foreach my $func ('push_address', 'push_file', 'push_link', 'push_list', 'push_note')
{
    ok($pb2->can($func), 'WWW::PushBullet->' . $func . '() exists');
}

my $version = $pb2->version();
ok(defined $version && $version =~ /^\d+.*/, 'WWW::PushBullet->version() => version');