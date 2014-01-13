# About

This is a Perl module and program giving easy access to [PushBullet](https://www.pushbullet.com/) API from Perl.


# Requirements

You need a PushBullet API key. 
You can get your API key in your [PushBullet account settings](https://www.pushbullet.com/account).

You also need this Perl modules:

  * [File::Slurp](https://metacpan.org/release/File-Slurp)
  * [FindBin](https://metacpan.org/pod/FindBin)
  * [Getopt::Long](https://metacpan.org/release/Getopt-Long)
  * [JSON](https://metacpan.org/release/JSON)
  * [LWP](https://metacpan.org/release/libwww-perl)
  * [Pod::Usage](https://metacpan.org/release/Pod-Usage)


# Usage

    pushbullet address [ -k <pushbullet_apikey> ] [ -d <device_id> ]
        --name 'address name' --address 'complete address'
    pushbullet link [ -k <pushbullet_apikey> ] [ -d <device_id> ]
        --title 'your title' --url 'http://address'
    pushbullet list [ -k <pushbullet_apikey> ] [ -d <device_id> ]
        --title 'your title' --item item1 --item item2 --item item3
    pushbullet note [ -k <pushbullet_apikey> ] [ -d <device_id> ]
        --title 'your title' --body 'your body message'
