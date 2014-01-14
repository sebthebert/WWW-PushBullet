use strict;
use warnings;

use 5.008;

use ExtUtils::MakeMaker;
WriteMakefile
(
	NAME         => 'WWW-PushBullet',
  	VERSION_FROM => 'lib/WWW/PushBullet.pm',
	PREREQ_PM    => {
		'File::Slurp' => 0,
		'FindBin' => 0,
		'Getopt::Long' => 0,
		'JSON' => 0,
		'LWP' => 0,
		'Pod::Usage' => 0,
		'Test::More' => 0,
		},
);
