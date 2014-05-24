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
# pickup string from gromacs
# perl translate.pl mapfile.db structure.gro > out.gro
# written by Naoyuki Miyashita
# 2012/07/09

$mapfile=$ARGV[0];
$initial=$ARGV[1];

open(IN1,"$mapfile")|| die "can't open $mapfile\n";
$i=0;
while(<IN1>){
 chomp;
 @a=split(/\s+/,$_);
if($a[0] =~ m/\#/g ){next;}
 $gro[$i]=$a[0]; $gro[$i]=~ s/_/ /g;
 $c36[$i]=$a[1]; $c36[$i]=~ s/_/ /g;
#print "gro=$gro[$i] , c36=$c36[$i]\n";
 $i++;
}
$max2=$i;
close(IN1);

$switch=0;
open(IN,"$initial") || die "can't open $initial\n";
while(<IN>){
  $switch=0;
  chomp;
#$picup=substr($_,11,10); #print "pickup=$picup\n";
  $picup=substr($_,5,10); #print "pickup=$picup\n";
  for($i=0;$i<$max2;$i++){
# print "chk $i $picup $gro[$i] $c36[$i]\n";
    if($picup =~/$gro[$i]/){
      $head=substr($_,0,5);
      $tail=substr($_,16);
      print "$head";
      print "$c36[$i] ";
      print "$tail\n";
      $switch=1;
      last;
    }
  }
  if($switch==0){print "$_\n";}
}
close(IN);
