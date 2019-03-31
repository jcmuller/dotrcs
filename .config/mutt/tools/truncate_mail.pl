#!/usr/bin/perl 
#
# "Beautify" quoted message and make it "ready-to-reply".
#
# Michael Velten

use strict;

# Possible reply greetings (regexes) (note that '> ' will be prefixed)
my @greetings = (
	'Hello,',
	'Hi .*,',
);

# Possible reply "greetouts" (regexes) (note that '> ' will be prefixed)
my @greetouts = (
	'Mit freundlichen Gr.*en',
	'Viele Gr.*e',
	'Regards,',
	'Thanks,',
	'Greetings,',
);

# Possible reply leadins (regexes) (note that '> ' will be prefixed)
my @leadins = (
	'.*wrote:',
);

my $saw_greeting = 0;
my $saw_leadin = 0;
my $saw_greetout = 0;
my $saw_signature = 0;
my $prev_inds = 0;

my (@mail, @purged_mail);

my $msg = shift;
die "Usage: $0 MAIL" unless $msg;
open(MAIL, "+<$msg") or die "$0: Can't open $msg: $!";
push(@mail, $_) while <MAIL>;   # Read whole mail

# Process whole mail
LINE:
foreach my $line (@mail) {

	# If _my_ signature appears don't mess with it but just include
	# the rest of the message (i.e. the signature) unmodified
	# (hack)
	if ($line =~ /^-- $/ || $saw_signature) {
		$saw_signature = 1;
		push(@purged_mail, $line);
		next LINE;
	}

	# Treat non-quoted lines as is
	if ($line !~ /^>/) {
		push(@purged_mail, $line);
		next LINE;
	}

	# Remove empty quoted lines
#	next LINE if $line =~ /^>\s*$/;

	# Remove quoted greeting
	unless ($saw_greeting) {
		foreach my $greeting (@greetings) {
			if ($line =~ /^> $greeting$/) {
				$saw_greeting = 1;
				next LINE;
			}
		}
	}

	# Remove quoted "greetout"
	unless ($saw_greetout) {
		foreach my $greetout (@greetouts) {
			if ($line =~ /^> $greetout$/) {
				$saw_greetout = 1;
				next LINE;
			}
		}
	}

	# Remove quoted reply leadin
	# (check more than once because there might
	# be some double or more quoted lines)
	#unless ($saw_leadin) {
#	foreach my $leadin (@leadins) {
#		if ($line =~ /^>+ $leadin$/) {
#			$saw_leadin = 1;
#			next LINE;
#		}
#	}

#	# Remove line if >= 3rd indentation level,
#	# otherwise tighten "> > " to ">> "
	my ($pref, $suff) = $line =~ /^([> ]+)(.*)$/;
	my $inds = $pref =~ tr/>//;
	next LINE if $inds >= 3;
#	$pref =~ s/(> (?!$))/>/g;
	$line = $pref . $suff . "\n";

	# Insert 3 lines between 1st and >1st level quoting
	$line = "\n" x 2 . $line if $prev_inds == 1 && $inds > 1;

	# Save purged line
	push(@purged_mail, $line);

	# Store indendation level for next iteration
	$prev_inds = $inds;
}

# Overwrite original mail with purged mail
truncate(MAIL, 0);
seek(MAIL, 0, 0);
print MAIL @purged_mail;
close(MAIL);
