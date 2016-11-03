#!/usr/bin/perl

#******************************************************************
#
# vertools.pl module
#
#******************************************************************
#
# UC Davis Confidential Copyright © 2012 ECE Department
#
#******************************************************************
#
# created on:	05/02/2009 
# created by:	jwwebb
# last edit on:	05/13/2012 
# last edit by:	$Author: $
# revision:	$Revision: $
# comments:	Generated
# 
#******************************************************************
# Revision List:
#
#		1.0	05/02/2009	Initial release
#		1.1	05/13/2012	Add license verbage.
# 
#******************************************************************
# Verilog HDL Tools Module
#
#  This utility is intended to make designing with Verilog HDL
#  simpler. This utility supports the following options:
#
#      Usage: vertools.pl [-h] [-v] [-i|-t|-u|-a|-z] [-f <FILE>]
#      
#              -h              Print this help message.
#              -v              Verbose: Print Debug Information.
#              -i              Generate Verilog HDL Instantiation.
#              -t              Generate Verilog HDL Test Bench.
#              -u              Generate UCF file from Verilog HDL file.
#              -a              Generate new Verilog HDL sub module file from Template.
#              -z              Generate new Verilog HDL top-level module file from Template.
#              -f <FILE>       Verilog HDL input file.
#      
#  Example of Module Instantiation:
#  
#	vertools.pl -i -f sample.v
#	vertools.pl -a -f sample.v
#	vertools.pl -z -f sample.v
#	vertools.pl -t -f sample.v
#	vertools.pl -u -f sample.v
#  
#  Save this file in your home 'bin' directory.
#
#  Copyright (c) 2012, Jeremy W. Webb 
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions 
#  are met: 
#
#  1. Redistributions of source code must retain the above copyright 
#     notice, this list of conditions and the following disclaimer. 
#  2. Redistributions in binary form must reproduce the above copyright 
#     notice, this list of conditions and the following disclaimer in 
#     the documentation and/or other materials provided with the 
#     distribution. 
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
#  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
#  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
#  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
#  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
#  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
#  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS 
#  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED 
#  AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
#  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
#  THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
#  DAMAGE.
#
#  The views and conclusions contained in the software and documentation 
#  are those of the authors and should not be interpreted as representing 
#  official policies, either expressed or implied, of the FreeBSD Project.
#
#******************************************************************

#******************************************************************
# CPAN Modules
#******************************************************************
use strict;
use warnings;
use Getopt::Std;

#******************************************************************
# Custom Modules
#******************************************************************
use VerilogTools qw( printModInst 
		   genTBTestFile 
		   genUCFFile
		   genVerLowModule
		   genVerTopModule );

#******************************************************************
# Constants and Variables:
#******************************************************************
my (%verH, $ver_rH);
my (%opts)=();
my ($file);
my ($debug);

#******************************************************************
# Retrieve command line argument
#******************************************************************
getopts('hvituf:az',\%opts);

my $optslen = scalar( keys %opts );
print("Number of Options on Command-Line: $optslen\n") if $opts{v};
# check for valid combination of command-line arguments
if ( $opts{h} || !$opts{f} || !($opts{i} || $opts{t} || $opts{u} || $opts{a} || $opts{z}) || ($optslen eq "0") ) {
    print_usage();
    exit;
}

# parse command-line arguments
$file  = $opts{f};
$debug = $opts{v};

#******************************************************************
# Make Date int MM/DD/YYYY
#******************************************************************
my $year      = 0;
my $month     = 0;
my $day       = 0;
($day, $month, $year) = (localtime)[3,4,5];

#******************************************************************
# Grab username from PC:
#******************************************************************
my $author= "$^O user";
if ($^O =~ /mswin/i) { 
    $author= $ENV{USERNAME} if defined $ENV{USERNAME};
} else { 
    $author = getlogin();
}

#******************************************************************
# Initialize Verilog Hash:
#******************************************************************
$verH{ 'username' } = $author;
$verH{ 'file' } = $file;
$verH{ 'day' } = $day;
$verH{ 'month' } = $month;
$verH{ 'year' } = $year;
$verH{ 'debug' } = $debug;

#******************************************************************
# Generate Top-Level Verilog HDL Module:
#******************************************************************
if ($opts{a}) {
    print("Filename: $opts{f}\n") if $debug;
    $ver_rH = genVerTopModule(\%verH);
}

#******************************************************************
# Generate Lower Verilog HDL Module:
#******************************************************************
if ($opts{z}) {
    print("Filename: $opts{f}\n") if $debug;
    $ver_rH = genVerLowModule(\%verH);
}

#******************************************************************
# Print Module Declaration:
#******************************************************************
if ($opts{i}) {
    $ver_rH = printModInst(\%verH);
    print("\n\n");
}

#******************************************************************
# Generate UCF File:
#******************************************************************
if ($opts{u}) {
    $ver_rH = genUCFFile(\%verH);
}

#******************************************************************
# Generate Test Bench File:
#******************************************************************
if ($opts{t}) {
    $ver_rH = genTBTestFile(\%verH);
}


exit;
 
#******************************************************************
# Generic Error and Exit routine 
#******************************************************************
 
sub dienice {
    my($errmsg) = @_;
    print"$errmsg\n";
    exit;
}

sub print_usage {
    my ($usage);
    $usage = "\nUsage: $0 [-h] [-v] [-i|-t|-u|-a|-z] [-f <FILE>]\n";
    $usage .= "\n";
    $usage .= "\t-h\t\tPrint this help message.\n";
    $usage .= "\t-v\t\tVerbose: Print Debug Information.\n";
    $usage .= "\t-i\t\tGenerate Verilog HDL Instantiation.\n";
    $usage .= "\t-t\t\tGenerate Verilog HDL Test Bench.\n";
    $usage .= "\t-u\t\tGenerate UCF file from Verilog HDL file.\n";
    $usage .= "\t-a\t\tGenerate new Verilog HDL top-level module file from Template.\n";
    $usage .= "\t-z\t\tGenerate new Verilog HDL low-level module file from Template.\n";
    $usage .= "\t-f <FILE>\tVerilog HDL input file.\n";
    $usage .= "\n";
    $usage .= "\tExample of Module Instantiation:\n";
    $usage .= "\t\t$0 -i -f sample.v \n";
    $usage .= "\n";
    print($usage);
    return;
}
