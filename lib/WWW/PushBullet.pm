
=head1 NAME

WWW::PushBullet

=head1 DESCRIPTION

=head1 SYNOPSIS

=cut

package WWW::PushBullet;

use strict;
use warnings;

use JSON;
use LWP::UserAgent;

our $VERSION = '0.4';

my %PUSHBULLET = (
    REALM   => 'Pushbullet',
    SERVER  => 'api.pushbullet.com:443',
    URL_API => 'https://api.pushbullet.com/api',
);

$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0;

=head1 SUBROUTINES/METHODS

=head2 new

Creates a new instance of PushBullet API

=cut

sub new
{
    my ($class, $params) = @_;

    my $ua = LWP::UserAgent->new;
    $ua->agent("WWW::PushBullet/$VERSION");
    $ua->credentials($PUSHBULLET{SERVER}, $PUSHBULLET{REALM}, $params->{apikey},
        '');

    my $self = {
        _ua     => $ua,
        _apikey => $params->{apikey},
    };

    bless $self, $class;

    return ($self);
}

=head2 api_key()

Returns current PushBullet API key

=cut

sub api_key
{
    my $self = shift;

    return ($self->{_apikey});
}

=head2 devices()

Returns list of devices

=cut

sub devices
{
    my $self = shift;

    my $req = HTTP::Request->new(GET => $PUSHBULLET{URL_API} . "/devices");
    my $res = $self->{_ua}->request($req);

    if ($res->is_success)
    {
        my $data = JSON->new->decode($res->content);
        return ($data->{devices});
    }
    else
    {
        print $res->status_line, "\n";
        return (undef);
    }
}

=head2 pushes($content)

=cut

sub pushes
{
    my ($self, $content) = @_;

    my $req = HTTP::Request->new(POST => $PUSHBULLET{URL_API} . "/pushes");
    $req->content_type('application/x-www-form-urlencoded');
    $req->content($content);
    my $res = $self->{_ua}->request($req);

    if ($res->is_success)
    {
        my $data = JSON->new->decode($res->content);
        return ($data);
    }
    else
    {
        print $res->status_line, "\n";
        return (undef);
    }
}

=head2 push_note($params)

Pushes note (with title & body)

=cut

sub push_note
{
    my ($self, $params) = @_;

    my $content =
          "device_id=$params->{device_id}"
        . "&type=note"
        . "&title=$params->{title}"
        . "&body=$params->{body}";
    printf "content: %s\n", $content;
    my $result = $self->pushes($content);

    return ($result);
}

1;

=head1 AUTHOR

Sebastien Thebert <stt@ittool.org>

=cut
