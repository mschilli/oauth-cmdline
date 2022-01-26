###########################################
package OAuth::Cmdline::Mojo;
###########################################
use strict;
use warnings;
use Mojo::Base 'Mojolicious';

# VERSION
# ABSTRACT: Run a standalone token collector

###########################################
sub startup {
###########################################
  my( $self ) = @_;

  my $renderer = $self->renderer();
  push @{$renderer->paths}, $self->template_path();

  $self->routes->get('/')->to('main#root');
  $self->routes->get('/callback')->to('main#callback');
}

###########################################
sub template_path {
###########################################
  my( $self ) = @_;

    # point renderer to where our .html.ep 
    # templates are installed
  my $dir = $INC{ 'OAuth/Cmdline.pm' };
  $dir =~ s/\.pm//;
  $dir .= "/templates";

  return $dir;
}

###########################################
package OAuth::Cmdline::Mojo::Main;
###########################################
use Mojo::Base 'Mojolicious::Controller';

###########################################
sub root {
###########################################
  my ( $self ) = @_;

  $self->stash->{ login_url } = $self->app->{ oauth }->full_login_uri();
  $self->stash->{ site }      = $self->app->{ oauth }->site();

  $self->render( "main" );
}

###########################################
sub callback {
###########################################
  my ( $self ) = @_;

  my $code = $self->param( "code" );

  $self->app->{ oauth }->tokens_collect( $code );
  
  $self->render( 
      text   => "Tokens saved in " . $self->app->{ oauth }->cache_file_path,
      layout => 'default' );
};

1;

__END__

=head1 SYNOPSIS

    use OAuth::Cmdline::Mojo;
    app->start();

=head1 DESCRIPTION

OAuth::Cmdline::Mojo starts a web server, to which you should
point your browser, in order to go through the OAuth rigamarole and
collect the tokens for later use in command line scripts.
