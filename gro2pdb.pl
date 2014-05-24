#!/usr/bin/perl
#-------------------------------------------------------------------------------
#    This source code is part of
#    GRO2CHM version 1.0
#
#    Written by Naoyuki Miyashita and Yuji Sugita
#    Copyright (c) 2012, RIKEN, Japan
#
#    This program is free software; you can redistribute it and/or
#    modify it under the terms of the GNU General Public License
#    as published by the Free Software Foundation, either 
#    version 3 of the License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied 
#    warranty of MERCHANTABILITY or FITNESS FOR 
#    A PARTICULAR PURPOSE.  
#    See the GNU General Public License for more details.
#
#    You should have received a copy of the GNU General 
#    Public License along with GRO2CHM.  
#    If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------
# gro2pdb
# perl gro2pdb.pl coord.gro > coord.pdb
# written by Naoyuki Miyashita
# 2012/07/09

sub trim{
   my $val=shift;
   $val =~ s/^\s*(.*?)\s*$/$1/;
   return $val;
}

$grofile=$ARGV[0];
open(IN,$grofile)||die"can't open $grofile\n";
$title=<IN>;
$num=<IN>;
for($i=0;$i<$num;$i++){
   $a=<IN>;
 $nres    = trim(substr($a,0,5 ));
 $resname = trim(substr($a,5,4 ));
 $atomname= trim(substr($a,9,6 ));
 $natom   = trim(substr($a,15,5));
 $gro_x   = trim(substr($a,20,8)); $pdb_x=10*$gro_x;
 $gro_y   = trim(substr($a,28,8)); $pdb_y=10*$gro_y;
 $gro_z   = trim(substr($a,36,8)); $pdb_z=10*$gro_z;
 $atom    = "ATOM";
 $b1      = " ";
 $b2      = "  "  ;
 $zero    = 0.00  ;
 $inum    = $i+1  ;

 $len_atom = length($atomname);  # 4
 $len_nres = length($nres);      # 4
 #
 $id = "P";
 if   ($resname =~/TIP3/)                  {$id="W";}
 elsif($resname =~/POPC/)                  {$id="L";}
 elsif($resname =~/SOD/ || $resname=~/CLA/){$id="I";}
 #
 if   ($len_atom <= 3){$atname=sprintf("%2s%-3s",$b2,$atomname);}
 elsif($len_atom =  4){$atname=sprintf("%1s%-4s",$b1,$atomname);}
 if   ($len_nres <= 4){$numres=sprintf("%4d%2s%2s",$nres,$b2,$b2);}
 elsif($len_nres =  5){$numres=sprintf("%5d%1s%2s",$nres,$b1,$b2);}
 elsif($len_nres =  6){$numres=sprintf("%6d%2s",$nres,$b2);}
 #
 $pdb_line[$i]=sprintf("%-4s%7d%5s%1s%-4s%1s%8s%8.3f%8.3f%8.3f%6.2f%6.2f",
       $atom,$inum,$atname,$b1,$resname,$id,$numres,$pdb_x,$pdb_y,$pdb_z,$zero,$zero);
}
$b=<IN>;
$gro_box_x=substr($b,0,10);   $pdb_box_x=10*$gro_box_x;
$gro_box_y=substr($b,10,10);  $pdb_box_y=10*$gro_box_y;
$gro_box_z=substr($b,20,10);  $pdb_box_z=10*$gro_box_z;
$cryst="CRYST1"; $tail="  90.00  90.00  90.00 P 1           1";
$pdb_first_line = sprintf("%6s%9.3f%9.3f%9.3f%37s",$cryst,$pdb_box_x,$pdb_box_y,$pdb_box_z,$tail);
close(IN);

# PRINT OUT PDB
print "$pdb_first_line\n";
for($i=0;$i<$num;$i++){
  print "$pdb_line[$i]\n";
}
