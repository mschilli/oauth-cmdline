# NAME

OAuth::Cmdline - OAuth2 for command line applications using web services

# VERSION

version 0.07

# SYNOPSIS

```perl
  # Use a site-specific class instead of the parent class, see
  # description below for generic cases

my $oauth = OAuth::Cmdline::GoogleDrive->new( );
$oauth->access_token();
```

# DESCRIPTION

OAuth::Cmdline helps standalone command line scripts to deal with 
web services requiring OAuth access tokens.

# WARNING: LIMITED ALPHA RELEASE

While `OAuth::Cmdline` has been envisioned to work with 
various OAuth-controlled web services, it is currently tested with the
following services, shown below with their subclasses:

- **OAuth::Cmdline::GoogleDrive**
- Google Drive
- **OAuth::Cmdline::Spotify**
- Spotify
- **OAuth::Cmdline::MicrosoftOnline**
- Azure AD and other OAuth2-authenticated services that use the Microsoft
Online common authentication endpoint (tested with Azure AD via the Graph
API)
- **OAuth::Cmdline::Automatic**
- Automatic.com car plugin
- **OAuth::Cmdline::Youtube**
- Youtube viewer reports
- **OAuth::Cmdline::Smartthings**
- Smartthings API

If you want to use this module for a different service, go ahead and try
it, it might just as well work. In this case, specify the `site` parameter,
which determines the name of the cache file with the access token and
other settings in your home directory:

```perl
  # Will use standard OAuth techniques and save your
  # tokens in ~/.some-other.site.yml
my $oauth = OAuth::Cmdline->new( site => "some-other-site" );
```

# GETTING STARTED

To obtain the initial set of access and refresh tokens from the 
OAuth-controlled site, you need to register your command line app
with the site and you'll get a "Client ID" and a "Client Secret" 
in return. Also, the site's SDK will point out the "Login URI" and
the "Token URI" to be used with the particular service.
Then, run the following script (the example uses the Spotify web service)

```perl
use OAuth::Cmdline;
use OAuth::Cmdline::Mojo;

my $oauth = OAuth::Cmdline::GoogleDrive->new(
    client_id     => "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
    client_secret => "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY",
    login_uri     => "https://accounts.google.com/o/oauth2/auth",
    token_uri     => "https://accounts.google.com/o/oauth2/token",
    scope         => "user-read-private",
);

my $app = OAuth::Cmdline::Mojo->new(
    oauth => $oauth,
);

$app->start( 'daemon', '-l', $oauth->local_uri );
```

and point a browser to the URL displayed at startup. Clicking on the
link displayed will take you to the OAuth-controlled site, where you need
to log in and allow the app access to the user data, following the flow
provided on the site. The site will then redirect to the web server
started by the script, which will receive an initial access token with 
an expiration date and a refresh token from the site, and store it locally
in the cache file in your home directory (~/.sitename.yml).

# ACCESS TOKEN ACCESS

Once the cache file has been initialized, the application can use the
`access_token()` method in order to get a valid access token. If 
`OAuth::Cmdline` finds out that the cached access token is expired, 
it'll automatically refresh it for you behind the scenes.

`OAuth::Cmdline` also offers a convenience function for providing a hash
with authorization headers for use with LWP::UserAgent:

```perl
my $resp = $ua->get( $url, $oauth->authorization_headers );
```

This will create an "Authorization" header based on the access token and
include it in the request to the web service.

## Public Methods

- `new()`

    Instantiate a new OAuth::Cmdline::XXX object. XXX stands for the specific
    site's implementation, and can be "GoogleDrive" or one of the other
    subclasses listed above.

- `authorization_headers()`

    Returns the HTTP header name and value the specific site requires for
    authentication. For example, in GoogleDrive's case, the values are:

    ```
    AuthorizationBearer xxxxx.yyy
    ```

    The method is used to pass the authentication header key and value 
    to an otherwise unauthenticated web request, like

    ```perl
    my $resp = $ua->get( $url, $oauth->authorization_headers );
    ```

- `token_expired()`

    (Internal) Check if the access token is expired and will be refreshed
    on the next call of `authorization_headers()`.

- `token_expire()`

    Force the expiration of the access token, so that the next request 
    obtains a new one.

# AUTHOR

Mike Schilli <cpan@perlmeister.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2022 by Mike Schilli.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
