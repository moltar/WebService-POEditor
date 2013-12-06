# NAME

WebService::POEditor - POEditor.com API wrapper

# VERSION

version v1.0.0

# SYNOPSIS

    use WebService::POEditor;

    my $poeditor = WebService::POEditor->new(api_token => 'XYZ');

    ## get a list of projects
    my $res = $poeditor->list_projects;
    my @projects = $res->list;

    ## create a project
    my $res = $poeditor->create_project({ name => 'Project X' });
    print $res->message if $res->code == 200; ## Project created.

# ATTRIBUTES

## api\_token

Set API token [obtained from POEditor.com](https://poeditor.com/account/api).

Alternatively, API token can be set via environment variable `POEDITOR_API_TOKEN`.

## server

API server URL.

Can also be altered via environment variable `POEDITOR_API_SERVER`.

Default: https://poeditor.com/api

# METHODS

## API methods

The following API methods (actions) are currently supported:

    add_contributor
    add_language
    add_terms
    available_languages
    clear_reference_language
    create_project
    delete_language
    delete_terms
    export
    list_contributors
    list_languages
    list_projects
    set_reference_language
    sync_terms
    update_language
    upload
    view_project
    view_terms

The method either takes no arguments (e.g. for listings), or takes one HashRef
as an argument (e.g. for creation of objects).

The return value is always an instance of [WebService::POEditor::Response](http://search.cpan.org/perldoc?WebService::POEditor::Response) object.

# AUTHOR

Roman F. <romanf@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Roman F..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
