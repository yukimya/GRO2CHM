#!/usr/bin/perl
#-------------------------------------------------------------------------------
##    This source code is part of
##    GRO2CHM version 1.0
##
##    Written by Naoyuki Miyashita and Yuji Sugita
##    Copyright (c) 2012, RIKEN, Japan
##
##    This program is free software; you can redistribute it and/or
##    modify it under the terms of the GNU General Public License
##    as published by the Free Software Foundation, either 
##    version 3 of the License, or (at your option) any later version.
##
##    This program is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied 
##    warranty of MERCHANTABILITY or FITNESS FOR 
##    A PARTICULAR PURPOSE.  
##    See the GNU General Public License for more details.
##
##    You should have received a copy of the GNU General 
##    Public License along with GRO2CHM.  
##    If not, see <http://www.gnu.org/licenses/>.
##-------------------------------------------------------------------------------
# split pdb
# perl select_pdb.pl A input.pdb > out.pdb
# written by Naoyuki Miyashita
# 2012/07/09

$id=$ARGV[0];
$infile=$ARGV[1];

open(IN,$infile)|| die"can't open $infile\n";
while(<IN>){
        $get_id=substr($_,21,1);
        if($get_id eq $id){ print $_; }
}
