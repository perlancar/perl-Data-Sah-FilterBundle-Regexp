package Data::Sah::Filter::perl::Regexp::replace;

use 5.010001;
use strict;
use warnings;

use Data::Dmp;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    +{
        v => 1,
        summary => 'Replace a regexp pattern with a simple string',
        might_fail => 0,
        args => {
            from_pat => {schema=>'re*', req=>1},
            to_str => {schema=>'str*', req=>1},
        },
        examples => [
            {value=>'0812000000', filter_args=>{from_pat=>qr/\A0/, to_str=>'+62'}, filtered_value=>'+62812000000'},
        ],
    };
}

sub filter {
    my %fargs = @_;

    my $dt = $fargs{data_term};
    my $gen_args = $fargs{args} // {};

    my $res = {};
    $res->{expr_filter} = join(
        "",
        "do { ", (
            "my \$tmp = $dt; my \$from_pat = ", dmp($gen_args->{from_pat}), "; my \$to_str = ", dmp($gen_args->{to_str}), "; ",
            "\$tmp =~ s/\$from_pat/\$to_str/g; ",
            "\$tmp ",
        ), "}",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$

=head1 SEE ALSO
