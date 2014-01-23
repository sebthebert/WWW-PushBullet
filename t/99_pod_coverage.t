use strict;
use warnings;

use FindBin;
use Test::More;

use lib "$FindBin::Bin/../lib/";

eval 'use Test::Pod::Coverage';
plan skip_all => 'Test::Pod::Coverage required for testing pod coverage' if $@;

all_pod_coverage_ok();