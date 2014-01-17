
=head1 NAME

WWW::PushBullet - Module giving easy access to PushBullet API

=head1 DESCRIPTION

Module giving easy access to PushBullet API

=head1 SYNOPSIS

    use WWW::PushBullet;
    
    my $pb = WWW::PushBullet->new({apikey => $apikey});
    
    $pb->push_address({ device_id => $device_id, name => $name, 
        address => $address });
        
    $pb->push_file({ device_id => $device_id, file => $filename);
        
    $pb->push_link({ device_id => $device_id, title => $title,
        url => $url });
        
    $pb->push_list({ device_id => $device_id, title => $title, 
        items => \@items });
        
    $pb->push_note({ device_id => $device_id, title => $title,
        body => $body });

=cut

package WWW::PushBullet;

use strict;
use warnings;

use JSON;
use LWP::UserAgent;

our $VERSION = '0.8.2';

my %PUSHBULLET = (
    REALM   => 'Pushbullet',
    SERVER  => 'api.pushbullet.com:443',
    URL_API => 'https://api.pushbullet.com/api',
);

$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0;

=head1 SUBROUTINES/METHODS

=head2 new($params)

Creates a new instance of PushBullet API

    my $pb = WWW::PushBullet->new({apikey => $apikey});

=cut

sub new
{
    my ($class, $params) = @_;

    my $ua = LWP::UserAgent->new;
    $ua->agent("WWW::PushBullet/$VERSION");
    $ua->credentials($PUSHBULLET{SERVER}, $PUSHBULLET{REALM}, $params->{apikey},
        '');

    #$ua->proxy('https', 'http://localhost:8080/');
    my $self = {
        _ua     => $ua,
        _apikey => $params->{apikey},
    };

    bless $self, $class;

    return ($self);
}

=head2 api_key()

Returns current PushBullet API key

    my $apikey = $pb->api_key();

=cut

sub api_key
{
    my $self = shift;

    return ($self->{_apikey});
}

=head2 devices()
    
Returns list of devices

    my $devices = $pb->devices();
    
    foreach my $d (@{$devices})
    {
        printf "Device '%s' => id %s\n", $d->{extras}->{model}, $d->{id};
    }

=cut

sub devices
{
    my $self = shift;

    my $res = $self->{_ua}->get("$PUSHBULLET{URL_API}/devices");

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

=head2 _pushes($content)

Generic pushes function (not supposed to be used directly)

=cut

sub _pushes
{
    my ($self, $content) = @_;

    my $type = undef;
    foreach my $i (0 .. $#{$content})
    {
        $type = $content->[$i + 1] if ($content->[$i] eq 'type');
    }
    my $res = $self->{_ua}->post(
        "$PUSHBULLET{URL_API}/pushes",
        Content_Type => ($type eq 'file' ? 'form-data' : undef),
        Content => $content
    );

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

=head2 push_address($params)

Pushes address (with name & address)

    $pb->push_address(
        {
            device_id => $device_id,
            name      => 'GooglePlex',
            address   => '1600 Amphitheatre Pkwy, Mountain View, CA 94043, Etats-Unis'
        }
        );

=cut

sub push_address
{
    my ($self, $params) = @_;

    my $content = [
        type      => 'address',
        device_id => $params->{device_id},
        name      => $params->{name},
        address   => $params->{address},
    ];
    my $result = $self->_pushes($content);

    return ($result);
}

=head2 push_file($params)

Pushes file

    $pb->push_file({ device_id => $device_id, file => '/var/www/index.html' });

=cut

sub push_file
{
    my ($self, $params) = @_;

    my $content = [
        type      => 'file',
        device_id => $params->{device_id},
        file      => [$params->{file}],
    ];
    my $result = $self->_pushes($content);

    return ($result);
}

=head2 push_link($params)

Pushes link (with title & url)

    $pb->push_link(
        {
            device_id => $device_id,
            title     => 'WWW::PushBullet Perl module on GitHub',
            url       => 'https://github.com/sebthebert/WWW-PushBullet'
        }
        );

=cut

sub push_link
{
    my ($self, $params) = @_;

    my $content = [
        type      => 'link',
        device_id => $params->{device_id},
        title     => $params->{title},
        url       => $params->{url},
    ];

    my $result = $self->_pushes($content);

    return ($result);
}

=head2 push_list($params)

Pushes list (with title & items)

    $pb->push_list(
        {
            device_id => $device_id,
            title     => 'One list with 3 items',
            items     => [ 'One', 'Two', 'Three' ]
        }
        );

=cut

sub push_list
{
    my ($self, $params) = @_;

    my $content = [
        type      => 'list',
        device_id => $params->{device_id},
        title     => $params->{title},
        items     => $params->{items},
    ];
    my $result = $self->_pushes($content);

    return ($result);
}

=head2 push_note($params)

Pushes note (with title & body)

    $pb->push_note(
        {
            device_id => $device_id,
            title     => 'Note Title',
            body      => 'Note Body'
        }
        );

=cut

sub push_note
{
    my ($self, $params) = @_;

    my $content = [
        type      => 'note',
        device_id => $params->{device_id},
        title     => $params->{title},
        body      => $params->{body},
    ];
    my $result = $self->_pushes($content);

    return ($result);
}

1;

=head1 AUTHOR

Sebastien Thebert <stt@ittool.org>

=cut
