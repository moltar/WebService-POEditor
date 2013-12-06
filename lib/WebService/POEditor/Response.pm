package WebService::POEditor::Response;

use Moose;
use namespace::clean;

=head2 res

Instance of L<Role::REST::Client::Response>.

=cut

has res => (
    is       => 'ro',
    isa      => 'Role::REST::Client::Response',
    required => 1,
);

=head2 method

Original request method.

=cut

has method => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

=head2 response

POEditor API response hash.

=cut

has response => (
    is      => 'ro',
    isa     => 'HashRef',
    lazy    => 1,
    builder => '_build_response',
);

sub _build_response {
    my $self = shift;

    return $self->res->data->{response};
}

=head2 status

POEditor API response status.

=cut

has status => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    builder => '_build_status',
);

sub _build_status {
    my $self = shift;

    return $self->response->{status};
}

=head2 code

POEditor API response code.

=cut

has code => (
    is      => 'ro',
    isa     => 'Int',
    lazy    => 1,
    builder => '_build_code',
);

sub _build_code {
    my $self = shift;

    return $self->response->{code};
}

=head2 message

POEditor API response message.

=cut

has message => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    builder => '_build_message',
);

sub _build_message {
    my $self = shift;

    return $self->response->{message};
}

=head2 list

Returns array of items for responses that return "list" (e.g. List Projects).

  my @list = $res->list;

=head3 count_list

Returns number of items in the list.

=head3 has_list

Returns true if list has items, false otherwise.

=head3 get_list_item($index)

Get list item by array index.

=cut

has _list => (
    is      => 'ro',
    isa     => 'ArrayRef',
    traits  => ['Array'],
    lazy    => 1,
    builder => '_build__list',
    handles => {
        list          => 'elements',
        count_list    => 'count',
        has_list      => 'count',
        get_list_item => 'get',
    },
);

sub _build__list {
    my $self = shift;

    return $self->res->data->{list} || [];
}

=head2 item

Returns item HashRef for responses that provide "item" (e.g. View Project Details).

B<NOTE>: For "Export" method call, even though it provides C<item>, the
response will be stored in L</export_url>.

=head3 get_item($item_key)

  my $id = $res->get_item('id');

Returns item by key.

=head3 has_item

Returns true if response has item, false otherwise.

=cut

has item => (
    is      => 'ro',
    isa     => 'HashRef',
    traits  => ['Hash'],
    lazy    => 1,
    builder => '_build_item',
    handles => {
        get_item => 'get',
        has_item => 'count',
    },
);

sub _build_item {
    my $self = shift;

    return $self->res->data->{item} || {};
}

=head2 details

Returns details HashRef for responses that provide "details" (e.g. Add Terms).

=head3 get_detail($key)

Get detail by key.

  my $parsed = $self->get_detail('parsed');

=head3 has_details

Return true if response has details, false otherwise.

=cut

has details => (
    is      => 'ro',
    isa     => 'HashRef',
    traits  => ['Hash'],
    lazy    => 1,
    builder => '_build_details',
    handles => {
        get_detail => 'get',
        has_details => 'count',
    },
);

sub _build_details {
    my $self = shift;

    return $self->res->data->{details} || {};
}

=head2 export_url

For "Export" method call returns an URL string.

=cut

has export_url => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    builder => '_build_export_url',
);

sub _build_export_url {
    my $self = shift;

    return $self->res->data->{item};
}

1;
