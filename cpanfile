#!perl

requires "HTTP::Request::Common" => "1";
requires "JSON"                  => "1";
requires "Log::Log4perl"         => "1";
requires "LWP::UserAgent"        => "1";
requires "MIME::Base64"          => "1";
requires "Mojo::Base"            => "0";
requires "Moo"                   => "1";
requires "URI"                   => "1";
requires "YAML"                  => "0.90";

on "test" => sub {
    requires "Test::CPAN::Meta"          => "0";
    requires "Test::More"                => "0";
    requires "Test::NoTabs"              => "0";
    requires "Test2::Bundle::Extended"   => "0";
    requires "Test2::Tools::Explain"     => "0";
    requires "Test2::Plugin::NoWarnings" => "0";
};

