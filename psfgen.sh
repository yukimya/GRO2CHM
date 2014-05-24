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
~/bin/namd/psfgen << ENDMOL

package require psfgen

topology ./topfile/top_all27_prot_na.rtf
topology ./topfile/top_all36_lipid.rtf

segment P { 
  first ACE
  last  CT3
  pdb out_p.pdb
}

segment L {
  first NONE
  last  NONE
  pdb out_l.pdb
}

segment W {
  first NONE
  last  NONE
  auto none
  pdb out_w.pdb
}

segment I {
  first NONE
  last  NONE
  auto none
  pdb out_i.pdb
}

coordpdb out_p.pdb P
coordpdb out_l.pdb L
coordpdb out_w.pdb W
coordpdb out_i.pdb I
guesscoord


writepdb app_popc.pdb
writepsf app_popc.psf

ENDMOL
