#!/usr/bin/perl

use Term::ANSIColor;

weechat::register("greentext","qorg","0.1","WTFPL","Grentexts.","","");

# Paints green the messages that begin with '>'

sub greentext_cb($$$$) {
	my ($data, $modifier, $modifier_data, $string) = @_;
	my ($nick, $msg) = split "\t", $string;
	my @chars = split("",$msg);
	if($chars[0] eq '>') {
		return sprintf("%s\t%s%s",$nick, weechat::color("green"),$msg);
	} else {
		return $string;
	}

}

weechat::hook_modifier("weechat_print","greentext_cb","");
