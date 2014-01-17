use strict;
use warnings;

use 5.008;

use ExtUtils::MakeMaker;
WriteMakefile
(
	NAME         => 'WWW-PushBullet',
  	VERSION_FROM => 'lib/WWW/PushBullet.pm',
	EXE_FILES    => ['bin/pushbullet'],
	PREREQ_PM    => {
		'File::Slurp' => 0,
		'FindBin' => 0,
		'Getopt::Long' => 0,
		'JSON' => 0,
		'LWP' => 0,
		'Pod::Usage' => 0,
		'Test::More' => 0,
		},
	($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/WWW/PushBullet.pm') : ()),
    ( $ExtUtils::MakeMaker::VERSION >= 6.46 ? (
        'META_MERGE' => {
            resources => {
                repository  => 'https://github.com/sebthebert/WWW-PushBullet',
            },
        } ) : ()
    ),

	INSTALLDIRS => 'perl',
	INSTALLBIN => '/usr/bin/',
);
