#!/usr/bin/perl

# upload.pl
#
# weechat pluging for uploading files to a lainsafe instance
# license: WTFPL

use LWP::UserAgent;

our $returned_link;

weechat::register("upload.pl","qorg11","0.1","WTFPL","Uploads a file to a lainsafe instance","","");

my $hook = weechat::hook_command("upload","Uploads a file to lainsafe instance","file path","Does that","","upload_file_cb","");

sub upload_file_cb($$$) {
	my $instance = "https://ls.qorg11.net";
	my ($data, $buffer, $file_path) = @_;
	my @chars = split("",$file_path);
	if($chars[0] eq "~") {
		my $home = $ENV{HOME};
		$file_path =~ s/~/$home/;
	}
	my $ua = LWP::UserAgent->new;
	$ua->agent("weechat :D");
	my $req = $ua->post($instance,
					Content_Type=>'form-data',
					Content => ["file"=>[$file_path],]
				    );
	$returned_link = $req->{_content};
	weechat::command($buffer,$returned_link);
	return weechat::WEECHAT_RC_OK;
}
