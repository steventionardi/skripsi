open (KUERI, "kueri.txt") or die "error";
while(<KUERI>)
{
    chomp;
    s/[\.!,?"\/><)(';:\-]//gi;     #Menghilangkan tanda baca, ganti spasi
    s/^\s+//gi;
    s/\s+$//gi;
    s/\s+/ /gi;  
    push(@kueri,$_);
}
close(KUERI);

$y=0;
$xy=0;

foreach my $tanya(@kueri)
{
        $tanya =~ tr/A-Z/a-z/;			#preproccesing
        $tanya =~ tr/#$%^@&*|[].,:;!?"\/(){}<+>//d;
        $tanya =~ tr/'\\'//d;
        s/^\s+//gi;
        s/\s+$//gi;
        s/\s+/ /gi; 
        @katatanyaunigram = split(/\s+/, $tanya );
#----------------------KUERI UNIGRAM-------------------------        
    for ($m=0; $m <= $#katatanyaunigram; $m++) 
    { 	
    if (!exists($katatanyaunigram[$m]))
      {
        $frekuensitanyaunigram{$katatanyaunigram[$m]} = 1;
      }
    else
      {
        $frekuensitanyaunigram{$katatanyaunigram[$m]}++;
      }
    }
    
    foreach $katatanyaunigram (sort{$a cmp $b}keys %frekuensitanyaunigram)
    {
      if ($katatanyaunigram =~ /\w/ )
      {
      $pertanyaan[$y] = "$katatanyaunigram";
      $kuerivsm[$xy]= "$katatanyaunigram.",".$frekuensitanyaunigram{$katatanyaunigram}";
      #print "$katatanyaunigram $frekuensitanyaunigram{$katatanyaunigram}\n";
       $y++;
       $xy++;
      }
    }
    

    
#----------------------KUERI BIGRAM-------------------------     
    @katatanyabigram = split(/\s+/, $tanya );
    for ($i=0; $i <= $#katatanyabigram; $i++) 
    { 	
      if(  $katatanyabigram[$i] =~ /\w\S+/ and $katatanyabigram[$i+1] =~ /\w\S+/  )		#cek apakah indeks i dan i+1 kosong
		  {
		  	$katatanyabigrams[$i] = $katatanyabigram[$i] . "" . $katatanyabigram[$i+1];
		  }
    }
    
     for ($i=0; $i <= $#katatanyabigrams; $i++) 
    { 	
        if (!exists($katatanyabigrams[$i]))
          {
            $frekuensitanyabigram{$katatanyabigrams[$i]} = 1;
          }
        else
          {
            $frekuensitanyabigram{$katatanyabigrams[$i]}++;
          }
    }
    foreach $katatanyabigrams (sort{$a cmp $b}keys %frekuensitanyabigram)
    {
      if ($katatanyabigrams =~ /\w/ )
      {
      $pertanyaan[$y] = "$katatanyabigrams";
       $y++;
      }
    }  
    
    
    #----------------------KUERI BIGRAMSKIPSATU-------------------------     
    @katatanyabigramskipsatu = split(/\s+/, $tanya );
 
    for ($i=0; $i <= $#katatanyabigramskipsatu; $i++) 
    { 	
      if(  $katatanyabigramskipsatu[$i] =~ /\w\S+/ and $katatanyabigramskipsatu[$i+2] =~ /\w\S+/  )		#cek apakah indeks i dan i+1 kosong
		  {
		  	$katatanyabigramskipsatus[$i] = $katatanyabigramskipsatu[$i] . "" . $katatanyabigramskipsatu[$i+2];
		  }
    }
    
     for ($i=0; $i <= $#katatanyabigramskipsatus; $i++) 
    { 	
        if (!exists($katatanyabigramskipsatus[$i]))
          {
            $frekuensitanyabigramskipsatu{$katatanyabigramskipsatus[$i]} = 1;
          }
        else
          {
            $frekuensitanyabigramskipsatu{$katatanyabigramskipsatus[$i]}++;
          }
    }
    foreach $katatanyabigramskipsatus (sort{$a cmp $b}keys %frekuensitanyabigramskipsatu)
    {
      if ($katatanyabigramskipsatus =~ /\w/ )
      {
      $pertanyaan[$y] = "$katatanyabigramskipsatus";
       $y++;
      }
    }  
    
    # #----------------------KUERI BIGRAMSKIPDUA-------------------------     
    # @katatanyabigramskipdua = split(/\s+/, $tanya );

    # for ($i=0; $i <= $#katatanyabigramskipdua; $i++) 
    # { 	
      # if(  $katatanyabigramskipdua[$i] =~ /\w\S+/ and $katatanyabigramskipdua[$i+3] =~ /\w\S+/  )		#cek apakah indeks i dan i+1 kosong
		  # {
		  	# $katatanyabigramskipduas[$i] = $katatanyabigramskipdua[$i] . "" . $katatanyabigramskipdua[$i+3]; 
		  # }
    # }
    
     # for ($i=0; $i <= $#katatanyabigramskipduas; $i++) 
    # { 	
        # if (!exists($katatanyabigramskipduas[$i]))
          # {
            # $frekuensitanyabigramskipdua{$katatanyabigramskipduas[$i]} = 1;
          # }
        # else
          # {
            # $frekuensitanyabigramskipdua{$katatanyabigramskipduas[$i]}++;
          # }
    # }
    # foreach $katatanyabigramskipduas (sort{$a cmp $b}keys %frekuensitanyabigramskipdua)
    # {
      # if ($katatanyabigramskipduas =~ /\w/ )
      # {
      # $pertanyaan[$y] = "$katatanyabigramskipduas";
       # $y++;
      # }
    # }  
    
        
#----------------------KUERI TRIGRAM-------------------------     
    @katatanyatrigram = split(/\s+/, $tanya );
    for ($i=0; $i <= $#katatanyatrigram; $i++) 
    { 	
      if(  $katatanyatrigram[$i] =~ /\w\S+/ and $katatanyatrigram[$i+1] =~ /\w\S+/ and $katatanyatrigram[$i+2] =~ /\w\S+/  )		#cek apakah indeks i dan i+1 kosong
		  {
		  	$katatanyatrigrams[$i] = $katatanyatrigram[$i] . "" . $katatanyatrigram[$i+1]. "" . $katatanyatrigram[$i+2];
		  }
    }
    
     for ($i=0; $i <= $#katatanyatrigrams; $i++) 
    { 	
        if (!exists($katatanyatrigrams[$i]))
          {
            $frekuensitanyatrigram{$katatanyatrigrams[$i]} = 1;
          }
        else
          {
            $frekuensitanyatrigram{$katatanyatrigrams[$i]}++;
          }
    }
    foreach $katatanyatrigrams (sort{$a cmp $b}keys %frekuensitanyatrigram)
    {
      if ($katatanyatrigrams =~ /\w/ )
      {
      $pertanyaan[$y] = "$katatanyatrigrams";
       $y++;
      }
    }  

        
#----------------------KUERI TRIGRAMSATUSKIPSATU-------------------------     
    @katatanyatrigramsatuskipsatu = split(/\s+/, $tanya );
    for ($i=0; $i <= $#katatanyatrigramsatuskipsatu; $i++) 
    { 	
      if(  $katatanyatrigramsatuskipsatu[$i] =~ /\w\S+/ and $katatanyatrigramsatuskipsatu[$i+2] =~ /\w\S+/ and $katatanyatrigramsatuskipsatu[$i+3] =~ /\w\S+/   )		#cek apakah indeks i dan i+1 kosong
		  {
		  	$katatanyatrigramsatuskipsatus[$i] = $katatanyatrigramsatuskipsatu[$i] . "" . $katatanyatrigramsatuskipsatu[$i+2]. "" . $katatanyatrigramsatuskipsatu[$i+3];
		  }
    }
    
     for ($i=0; $i <= $#katatanyatrigramsatuskipsatus; $i++) 
    { 	
        if (!exists($katatanyatrigramsatuskipsatus[$i]))
          {
            $frekuensitanyatrigramsatuskipsatu{$katatanyatrigramsatuskipsatus[$i]} = 1;
          }
        else
          {
            $frekuensitanyatrigramsatuskipsatu{$katatanyatrigramsatuskipsatus[$i]}++;
          }
    }
    foreach $katatanyatrigramsatuskipsatus (sort{$a cmp $b}keys %frekuensitanyatrigramsatuskipsatu)
    {
      if ($katatanyatrigramsatuskipsatus =~ /\w/ )
      {
      $pertanyaan[$y] = "$katatanyatrigramsatuskipsatus";
       $y++;
      }
    }  
    
        
#----------------------KUERI TRIGRAMSATUSKIPDUA-------------------------     
    @katatanyatrigramsatuskipdua = split(/\s+/, $tanya );
    for ($i=0; $i <= $#katatanyatrigramsatuskipdua; $i++) 
    { 	
      if(  $katatanyatrigramsatuskipdua[$i] =~ /\w\S+/ and $katatanyatrigramsatuskipdua[$i+3] =~ /\w\S+/  and $katatanyatrigramsatuskipdua[$i+4] =~ /\w\S+/  )		#cek apakah indeks i dan i+1 kosong
		  {
		  	$katatanyatrigramsatuskipduas[$i] = $katatanyatrigramsatuskipdua[$i] . "" . $katatanyatrigramsatuskipdua[$i+3]. "" . $katatanyatrigramsatuskipdua[$i+4];
		  }
    }
    
     for ($i=0; $i <= $#katatanyatrigramsatuskipduas; $i++) 
    { 	
        if (!exists($katatanyatrigramsatuskipduas[$i]))
          {
            $frekuensitanyatrigramsatuskipdua{$katatanyatrigramsatuskipduas[$i]} = 1;
          }
        else
          {
            $frekuensitanyatrigramsatuskipdua{$katatanyatrigramsatuskipduas[$i]}++;
          }
    }
    foreach $katatanyatrigramsatuskipduas (sort{$a cmp $b}keys %frekuensitanyatrigramsatuskipdua)
    {
      if ($katatanyatrigramsatuskipduas =~ /\w/ )
      {
      $pertanyaan[$y] = "$katatanyatrigramsatuskipduas";
       $y++;
      }
    }  
    
        
# #----------------------KUERI TRIGRAMDUASKIPSATU-------------------------     
    # @katatanyatrigramduaskipsatu = split(/\s+/, $tanya );
    # for ($i=0; $i <= $#katatanyatrigramduaskipsatu; $i++) 
    # { 	
      # if(  $katatanyatrigramduaskipsatu[$i] =~ /\w\S+/ and $katatanyatrigramduaskipsatu[$i+1] =~ /\w\S+/  and $katatanyatrigramduaskipsatu[$i+3] =~ /\w\S+/  )		#cek apakah indeks i dan i+1 kosong
		  # {
		  	# $katatanyatrigramduaskipsatus[$i] = $katatanyatrigramduaskipsatu[$i] . "" . $katatanyatrigramduaskipsatu[$i+1]. "" . $katatanyatrigramduaskipsatu[$i+3];
		  # }
    # }
    
     # for ($i=0; $i <= $#katatanyatrigramduaskipsatus; $i++) 
    # { 	
        # if (!exists($katatanyatrigramduaskipsatus[$i]))
          # {
            # $frekuensitanyatrigramduaskipsatu{$katatanyatrigramduaskipsatus[$i]} = 1;
          # }
        # else
          # {
            # $frekuensitanyatrigramduaskipsatu{$katatanyatrigramduaskipsatus[$i]}++;
          # }
    # }
    # foreach $katatanyatrigramduaskipsatus (sort{$a cmp $b}keys %frekuensitanyatrigramduaskipsatu)
    # {
      # if ($katatanyatrigramduaskipsatus =~ /\w/ )
      # {
      # $pertanyaan[$y] = "$katatanyatrigramduaskipsatus";
       # $y++;
      # }
    # }  

        
# #----------------------KUERI TRIGRAMDUASKIPDUA-------------------------     
    # @katatanyatrigramduaskipdua = split(/\s+/, $tanya );
    # for ($i=0; $i <= $#katatanyatrigramduaskipdua; $i++) 
    # { 	
      # if(  $katatanyatrigramduaskipdua[$i] =~ /\w\S+/ and $katatanyatrigramduaskipdua[$i+1] =~ /\w\S+/  and $katatanyatrigramduaskipdua[$i+4] =~ /\w\S+/  )		#cek apakah indeks i dan i+1 kosong
		  # {
		  	# $katatanyatrigramduaskipduas[$i] = $katatanyatrigramduaskipdua[$i] . "" . $katatanyatrigramduaskipdua[$i+1] . "" . $katatanyatrigramduaskipdua[$i+4];
		  # }
    # }
    
     # for ($i=0; $i <= $#katatanyatrigramduaskipduas; $i++) 
    # { 	
        # if (!exists($katatanyatrigramduaskipduas[$i]))
          # {
            # $frekuensitanyatrigramduaskipdua{$katatanyatrigramduaskipduas[$i]} = 1;
          # }
        # else
          # {
            # $frekuensitanyatrigramduaskipdua{$katatanyatrigramduaskipduas[$i]}++;
          # }
    # }
    # foreach $katatanyatrigramduaskipduas (sort{$a cmp $b}keys %frekuensitanyatrigramduaskipdua)
    # {
      # if ($katatanyatrigramduaskipduas =~ /\w/ )
      # {
      # $pertanyaan[$y] = "$katatanyatrigramduaskipduas";
       # $y++;
      # }
    # }  
}

$char_1 = "\x94";
$char_2 = "\x93";
$char_3 = "\x96";
$char_4 = "\x97";
$char_5 = "\B1";
$char_1_r = '';
$char_2_r = '';
$char_3_r = '';
$char_4_r = '';
$char_5_r = '';

my $dir = 'Tematik1';
$var=0;
foreach my $fp (glob("$dir/*.txt")) {
  # print "$fp\n";
push(@juduldok, $fp);
open my $fh, "<", $fp or die "can't read open '$fp': $OS_ERROR";
while (<$fh>) 
{
        chomp;      
        push(@judulDokumen, $_);  
        push(@judulDokumenn, $_);                
}

        for ($s=0; $s<=$#judulDokumenn; $s++) {
        $juduldokumenca[$var] =  $judulDokumenn[$s];
        }
        $var++;
        	
	close $fh or die "can't read close '$fp': $OS_ERROR";
}

$paTemp = scalar(@judulDokumen);
for ($i = 0; $i < $paTemp; $i++)
{
	if ($judulDokumen[$i] =~ /^<judul>/)
	{
		$sJudul[$i] = $judulDokumen[$i+1];
	}
}	
open (JUDUL , ">judul.txt") or die "error";
for ($i = 0; $i < $paTemp ; $i++) {
  print JUDUL "$sJudul[$i]\n" if ($sJudul[$i] =~ /\w/);
}

open (JUDUL , "judul.txt") or die "error";
while(<JUDUL>)
{
         chomp;
         s/<*judul>/ /gi;
         s/[\.!,?"\/><)(';:\-]//gi;     #Menghilangkan tanda baca, ganti spasi
         s/^\s+//gi;
         s/\s+$//gi;
         s/\s+/ /gi;  
         s/\n+//gi;
         s/ô//gi;
         s/ö//gi;
         s/$char_1/$char_1_r/;
         s/$char_2/$char_2_r/;
	 s/$char_3/$char_3_r/;
	 s/$char_4/$char_4_r/;
	 s/$char_5/$char_5_r/;
         push(@JudulDokumen, $_);
}
for($i=0;$i<=$#JudulDokumen;$i++)
{

   # $judull{$juduldok[$i]} = $JudulDokumen[$i];
}


foreach my $fp (glob("$dir/*.txt")) {
  # print "$fp\n";
push(@isidok, $fp);
open my $fh, "<", $fp or die "can't read open '$fp': $OS_ERROR";
while (<$fh>) 
    {
       chomp;          
       push(@isiDokumen, $_);  
       push(@isiDokumenn, $_);                  
    }

               
       for ($s=0; $s<=$#isiDokumenn; $s++) 
       {
       $isidokumenca[$var] =  $isiDokumenn[$s+1];
       }
        $var++;
        @isiDokumenn ="";
	close $fh or die "can't read close '$fp': $OS_ERROR";
}
for ($i = 0; $i <= $#isiDokumen ; $i++) {
  #print "$isiDokumen[$i]\n";
}

for ($i = 0; $i <= $#isiDokumen; $i++)
{
	if ($isiDokumen[$i] =~ /^<isi>/)
	{
		$sIsi[$i] = $isiDokumen[$i+1];
	}
}	


open (ISI , ">isi.txt") or die "error";
for ($i = 0; $i <= $#isiDokumen ; $i++) {
  print ISI "$sIsi[$i]\n" if ($sIsi[$i] =~ /\w/);
}

open (ISI , "isi.txt") or die "error";
while(<ISI>)
{
         chomp;
         s/<*isi>/ /gi;
         s/[\.!,?"\/><)(';:\-]//gi;     #Menghilangkan tanda baca, ganti spasi
         s/^\s+//gi;
         s/\s+$//gi;
         s/\s+/ /gi;  
         s/\n+//gi;
         s/ö//gi;
         s/ô//gi;
         s/$char_1/$char_1_r/;
	 s/$char_2/$char_2_r/;
	 s/$char_3/$char_3_r/;
	 s/$char_4/$char_4_r/;
	 s/$char_5/$char_5_r/;
         push(@IsiDokumen, $_);
}
for($i=0;$i<=$#IsiDokumen;$i++)
{

   # $isii{$juduldok[$i]} = $IsiDokumen[$i];
  
}



#-----------------------------UNIGRAM------------------------------------------
$y = 0;
$z=0;
$csunigram=0;
$dldunigram=0;
open(UNIGRAM, '>unigram.txt') or die "error ";
foreach my $unigram (@IsiDokumen)		#ambil isi tiap dok
{
        @unigrams = "";
        $unigram =~ tr/A-Z/a-z/;			#preproccesing
        $unigram =~ tr/#$%^@&*|[].,:;!?"\/(){}<+>//d;
        $unigram =~ tr/'\\'//d;
        $unigram =~ tr/0-9//d;
        $unigram =~ s/\n/ /gm;
        $unigram =~ s/\s\s+/ /gm;
        @unigrams = split(/\s+/, $unigram );	#split by space
        # print "@unigrams \n";
        
        for ($i=0; $i <= $#unigrams; $i++)
        { 
            #print "$unigrams[$i]\n";
            if (!exists($unigrams[$i]))
              {
                $frekuensiUnigram{$unigrams[$i]}= 1;
              }
            else
              {
                $frekuensiUnigram{$unigrams[$i]}++;
              }
         }

$batasKataUnigram[$y] = $i;               	        #batas kata perdokumen
                                        #lopp array baras dokumen
# print "$batasKata[$y]\n";
# print "dld dokumen $y = $batasKata[$y]\n";    #dld total frekuensi per dokumen			 
$z = 0;                                        #batas loop array  

  foreach $unigrams (sort{$a cmp $b}keys %frekuensiUnigram)
  {
    if ($unigrams  =~ /\w/ ){
      print UNIGRAM "$unigrams". "," ."$frekuensiUnigram{$unigrams}\n";
      $z += 1;
    }
  }
$batasUnigramSorted[$y] = $z;
$y += 1;
  push (@daftarUnigram , @unigrams);
  @unigrams = "";
  %frekuensiUnigram = "";
}

for ($i=0;$i<=$#IsiDokumen;$i++)
{
  $csunigram += $batasKataUnigram[$i];
  $dldunigram[$i] += $batasKataUnigram[$i]; # JUMLAH TOKEN DI SELURUH DOKUMEN
}
close(UNIGRAM);

for ($i = 0 ; $i <= $#daftarUnigram; $i++) {
    #print "$daftarUnigram[$i]\n";
    if (!exists($daftarUnigram[$i]))
      {
        $fUnigram{$daftarUnigram[$i]} = 1;
      }
    else
      {
        $fUnigram{$daftarUnigram[$i]}++;
      }
}
$i=0;
foreach $daftarUnigram (sort{$a cmp $b}keys %fUnigram){
    $sortdaftarUnigram[$i] = $daftarUnigram;
    $i++; 
}




open(UNIGRAM, 'unigram.txt') or die "error ";
while(<UNIGRAM>)
{
    chomp;
    push(@kataUnigram, $_);
}
close(UNIGRAM);
for ($i = 0; $i <= $#kataUnigram; $i++)
{
	@kataUnigrams = split /,/, $kataUnigram[$i];              #split by koma
	$KataUnigram[$i] = $kataUnigrams[0];                      #indeks 0 kata
	$fKataUnigram[$i] = $kataUnigrams[1];
	# print "$KataUnigram[$i]\n";
}


$z =0;

for ($i = 0 ;$i <= $#batasUnigramSorted;$i++)
{     
      # print "$batasKataUnigram[$i]\n";
      $batas = $batasUnigramSorted[$i] if ($i == 0);
      $batas = $batas + $batasUnigramSorted[$i] if ($i != 0);
      #print "$z\n";
      for ($z; $z< $batas ; $z++)
      {
          # print "$KataUnigram[$z] KataUnigram[$z]\n";
          #print "$KataUnigram[$z]\n";
          for ($y=0 ; $y <= $#sortdaftarUnigram ; $y++)
          {
             #print "$sortdaftarUnigram[$y]==========$KataUnigram[$z] \n";
              if($sortdaftarUnigram[$y] eq $KataUnigram[$z])
              {
                $daftarUnigrams[$i][$y] = $fKataUnigram[$z];
                last;
              }

              
          }
  
          #print "$sortdaftarUnigram[$z] $daftar[$i][$]\n";
      }
       $z=$batas;
}


for ($i =0; $i<= $#IsiDokumen;$i++)
{
      for($j = 0;$j<= $#sortdaftarUnigram;$j++)
      {
            if ($daftarUnigrams[$i][$j] == "")
            {
              $daftarUnigrams[$i][$j] =0;
            }
            # print "$sortdaftarUnigram[$j] $daftarUnigrams[$i][$j]daftarUnigrams[$i][$j] \n";
      }
      #print "-----------------\n";
}
@kataUnigram = ();
@kataUnigrams =();
@KataUnigram =();
@fKataUnigram =();


#-----------------------------BIGRAM------------------------------------------
$y=0;
$z=0;
$csbigram=0;
$dldbigram=0;
open(BIGRAM, '>bigram.txt') or die "error ";
foreach my $bigram (@IsiDokumen)		#ambil isi tiap dok
{
        $bigram =~ tr/A-Z/a-z/;			#preproccesing
        $bigram =~ tr/#$%^@&*|[].,:;!?"\/(){}<+>//d;
        $bigram =~ tr/'\\'//d;
        $bigram =~ tr/0-9//d;
        $bigram =~ s/\n/ /gm;
        $bigram =~ s/\s\s+/ /gm;
        @bigrams = split(/\s+/, $bigram );	#split by space
        #print "@bigrams \n";

        for ($i=0; $i <= $#bigrams; $i++)
        { 	
            if(  $bigrams[$i] =~ m/\w\S+/ and $bigrams[$i+1] =~ m/\w\S+/  )		#cek apakah indeks i dan i+1 kosong
		  {
		  	$katabigrams[$i] = $bigrams[$i] . "" . $bigrams[$i+1];
		  	#print "$katabigrams[$i] \n";
		  	
		  }
            if (!exists($katabigrams[$i]))
	    {   
	      $frekuensiBigram{$katabigrams[$i]} = 1;
              #print  "$katabigrams[$i]   $frekuensiBigram{$katabigrams[$i]}\n";
              last;
            }
            else
	    {
	       $frekuensiBigram{$katabigrams[$i]}++;
               #print "$katabigrams[$i]   $frekuensiBigram{$katabigrams[$i]}\n";
            }
         }

$batasKataBigram[$y] = $i;               	        #batas kata perdokumen                                     #lopp array baras dokumen
# print "$batasKata[$y]\n";
# print "dld dokumen $y = $batasKata[$y]\n";    #dld total frekuensi per dokumen			 
$z = 0;                                        #batas loop array  

  foreach $katabigrams (sort{$a cmp $b}keys %frekuensiBigram)
  {
    if ($katabigrams  =~ /\w/ ){
      print BIGRAM"$katabigrams". "," ."$frekuensiBigram{$katabigrams[$i]}\n";
      $z += 1;
    }
  }
  $batasBigramSorted[$y] = $z;
  $y += 1; 
  push (@daftarBigram, @katabigrams);
  %frekuensiBigram = "";
  @katabigrams = "";
}
close(BIGRAM);


for ($i = 0 ; $i <= $#daftarBigram; $i++) {
    #print "$daftarBigram[$i]\n";
    if (!exists($daftarBigram[$i]))
      {
        $fBigram{$daftarBigram[$i]} = 1;
      }
    else
      {
        $fBigram{$daftarBigram[$i]}++;
      }
}
$i=0;
foreach $daftarBigram (sort{$a cmp $b}keys %fBigram){
    $sortdaftarBigram[$i] = $daftarBigram;
    $i++;
}


for ($i=0;$i<=$#IsiDokumen;$i++)
{
  $csbigram += $batasKataBigram[$i];
  $dldbigram[$i] += $batasKataBigram[$i]; # JUMLAH TOKEN DI SELURUH DOKUMEN
}

open(BIGRAM, 'bigram.txt') or die "error";
while(<BIGRAM>)
{
    chomp;
    push(@kataBigram,$_);
}
close(BIGRAM);
for($i=0;$i<=$#kataBigram;$i++)
{
    @kataBigrams = split/,/, $kataBigram[$i];
    $KataBigram[$i] = $kataBigrams[0];
    $fKataBigram[$i] = $kataBigrams[1];
    #print "$KataBigram[$i] $fKataBigram[$i]\n";
    
}


# print $#sortdaftarBigram;
# print $#sortdaftarBigram;
# print "\n";
# print $#KataBigram;
$z=0;
for ($i = 0 ;$i <= $#batasBigramSorted;$i++)
{     
      # print "$batasKataBigram[$i]\n";
      $batas = $batasBigramSorted[$i] if ($i == 0);
      $batas = $batas + $batasBigramSorted[$i] if ($i != 0);
      #print "$z\n";
      for ($z; $z< $batas ; $z++)
      {
          # print "$KataBigram[$z] KataBigram[$z]\n";
          #print "$KataBigram[$z]\n";
          for ($y=0 ; $y <= $#sortdaftarBigram ; $y++)
          {
              #print "$sortdaftarBigram[$y]==========$KataBigram[$z] \n";
              if($sortdaftarBigram[$y] eq $KataBigram[$z])
              {
               # print "$fKataBigram[$z]\n";
                
                $daftarBigrams[$i][$y] = $fKataBigram[$z];
                #print "daftarBigrams[$i][$y] = $fKataBigram[$z]\n";
                last;
              } 
          } 
          #print "$sortdaftarBigram[$z] $daftar[$i][$z]\n";
      }
      $z=$batas;
}

# $total = $#sortdaftarBigram + $#sortdaftarUnigram;
for ($i =0; $i<= $#IsiDokumen;$i++)
{
      for($j=0;$j<= $#sortdaftarBigram;$j++)
      {
            if ($daftarBigrams[$i][$j] == "")
            {
              $daftarBigrams[$i][$j] =0;
            }
            # print "$sortdaftarBigram[$j] $daftarBigrams[$i][$j] [$i][$j]\n";
      }
     #print "-----------------\n";
}
@kataBigram = ();
@kataBigrams =();
@KataBigram =();
@fKataBigram =();




#-----------------------------TRIGRAM------------------------------------------
$y=0;
$z=0;
$cstrigram=0;
$dldtrigram=0;
open(TRIGRAM, '>trigram.txt') or die "error ";
foreach my $trigram (@IsiDokumen)		#ambil isi tiap dok
{
        $trigram =~ tr/A-Z/a-z/;			#preproccesing
        $trigram =~ tr/#$%^@&*|[].,:;!?"\/(){}<+>//d;
        $trigram =~ tr/'\\'//d;
        $trigram =~ tr/0-9//d;
        $trigram =~ s/\n/ /gm;
        $trigram =~ s/\s\s+/ /gm;
        @trigrams = split(/\s+/, $trigram );	#split by space
        #print "@trigrams \n";

        for ($i=0; $i <= $#trigrams; $i++)
        { 	
            if(  $trigrams[$i] =~ m/\w\S+/ and $trigrams[$i+1] =~ m/\w\S+/ and $trigrams[$i+2] =~ m/\w\S+/ )		#cek apakah indeks i dan i+1 kosong
		  {
		  	$katatrigrams[$i] = $trigrams[$i] . "" . $trigrams[$i+1]. "" . $trigrams[$i+2];
		  	#print "$katatrigrams[$i] \n";
		  	
		  }
            if (!exists($katatrigrams[$i]))
	    {   
	      $frekuensiTrigram{$katatrigrams[$i]} = 1;
              #print  "$katatrigrams[$i]   $frekuensiTrigram{$katatrigrams[$i]}\n";
              last;
            }
            else
	    {
	       $frekuensiTrigram{$katatrigrams[$i]}++;
               #print "$katatrigrams[$i]   $frekuensiTrigram{$katatrigrams[$i]}\n";
            }
         }

$batasKataTrigram[$y] = $i;               	        #batas kata perdokumen                                     #lopp array baras dokumen
# print "$batasKata[$y]\n";
# print "dld dokumen $y = $batasKata[$y]\n";    #dld total frekuensi per dokumen			 
$z = 0;                                        #batas loop array  

  foreach $katatrigrams (sort{$a cmp $b}keys %frekuensiTrigram)
  {
    if ($katatrigrams  =~ /\w/ ){
      print TRIGRAM"$katatrigrams". "," ."$frekuensiTrigram{$katatrigrams[$i]}\n";
      $z += 1;
    }
  }
  $batasTrigramSorted[$y] = $z;
  $y += 1; 
  push (@daftarTrigram, @katatrigrams);
  %frekuensiTrigram = "";
  @katatrigrams = "";
}
close(TRIGRAM);

for ($i = 0 ; $i <= $#daftarTrigram; $i++) {
    #print "$daftarTrigram[$i]\n";
    if (!exists($daftarTrigram[$i]))
      {
        $fTrigram{$daftarTrigram[$i]} = 1;
      }
    else
      {
        $fTrigram{$daftarTrigram[$i]}++;
      }
}
$i=0;
foreach $daftarTrigram (sort{$a cmp $b}keys %fTrigram){
    $sortdaftarTrigram[$i] = $daftarTrigram;
    $i++;
}

for ($i=0;$i<=$#IsiDokumen;$i++)
{
  $cstrigram += $batasKataTrigram[$i];
  $dldtrigram[$i] += $batasKataTrigram[$i]; # JUMLAH TOKEN DI SELURUH DOKUMEN
}


open(TRIGRAM, 'trigram.txt') or die "error";
while(<TRIGRAM>)
{
    chomp;
    push(@kataTrigram,$_);
}
close(TRIGRAM);
for($i=0;$i<=$#kataTrigram;$i++)
{
    @kataTrigrams = split/,/, $kataTrigram[$i];
    $KataTrigram[$i] = $kataTrigrams[0];
    $fKataTrigram[$i] = $kataTrigrams[1];
    #print "$KataTrigram[$i] $fKataTrigram[$i]\n";
    
}


# print $#sortdaftarTrigram;
# print "\n";
# print $#KataTrigram;
$z=0;
for ($i = 0 ;$i <= $#batasTrigramSorted;$i++)
{     
      # print "$batasKataTrigram[$i]\n";
      $batas = $batasTrigramSorted[$i] if ($i == 0);
      $batas = $batas + $batasTrigramSorted[$i] if ($i != 0);
      #print "$z\n";
      for ($z; $z< $batas ; $z++)
      {
          # print "$KataTrigram[$z] KataTrigram[$z]\n";
          #print "$KataTrigram[$z]\n";
          for ($y=0 ; $y <= $#sortdaftarTrigram ; $y++)
          {
              #print "$sortdaftarTrigram[$y]==========$KataTrigram[$z] \n";
              if($sortdaftarTrigram[$y] eq $KataTrigram[$z])
              {
               # print "$fKataTrigram[$z]\n";
                
                $daftarTrigrams[$i][$y] = $fKataTrigram[$z];
                #print "daftarTrigrams[$i][$y] = $fKataTrigram[$z]\n";
                last;
              } 
          } 
          #print "$sortdaftarTrigram[$z] $daftar[$i][$z]\n";
      }
      $z=$batas;
}

# $total = $#sortdaftarTrigram + $#sortdaftarUnigram;
for ($i =0; $i<= $#IsiDokumen;$i++)
{
      for($j=0;$j<= $#sortdaftarTrigram;$j++)
      {
            if ($daftarTrigrams[$i][$j] == "")
            {
              $daftarTrigrams[$i][$j] =0;
            }
             #print "$sortdaftarTrigram[$j] $daftarTrigrams[$i][$j] [$i][$j]\n";
      }
     #print "-----------------\n";
}
@kataTrigram = ();
@kataTrigrams =();
@KataTrigram =();
@fKataTrigram =();


#-----------------------------BIGRAMSKIP------------------------------------------
$y=0;
$z=0;
$csbigramskip=0;
$dldbigramskip=0;
open(BIGRAMSKIP, '>bigramskip.txt') or die "error ";
foreach my $bigramSkipSatu (@IsiDokumen)		#ambil isi tiap dok
{
        $bigramSkipSatu =~ tr/A-Z/a-z/;			#preproccesing
        $bigramSkipSatu =~ tr/#$%^@&*|[].,:;!?"\/(){}<+>//d;
        $bigramSkipSatu =~ tr/'\\'//d;
        $bigramSkipSatu =~ tr/0-9//d;
        $bigramSkipSatu =~ s/\n/ /gm;
        $bigramSkipSatu =~ s/\s\s+/ /gm;
        @bigramsSkipSatu = split(/\s+/, $bigramSkipSatu );	#split by space
        #print "@bigramsSkipSatu \n";

        for ($i=0; $i <= $#bigramsSkipSatu; $i++)
        { 	
            if(  $bigramsSkipSatu[$i] =~ m/\w\S+/ and $bigramsSkipSatu[$i+2] =~ m/\w\S+/)		#cek apakah indeks i dan i+1 kosong
		  {
		  	$katabigramsSkipSatu[$i] = $bigramsSkipSatu[$i] . "" . $bigramsSkipSatu[$i+2];
		  	#print "$katabigramsSkipSatu[$i] \n";
		  	
		  }
            if (!exists($katabigramsSkipSatu[$i]))
	    {   
	      $frekuensiBigramSkipSatu{$katabigramsSkipSatu[$i]} = 1;
              #print  "$katabigramsSkipSatu[$i]   $frekuensiBigramSkipSatu{$katabigramsSkipSatu[$i]}\n";
              last;
            }
            else
	    {
	       $frekuensiBigramSkipSatu{$katabigramsSkipSatu[$i]}++;
               #print "$katabigramsSkipSatu[$i]   $frekuensiBigramSkipSatu{$katabigramsSkipSatu[$i]}\n";
            }
         }

$batasKataBigramSkipSatu[$y] = $i;               	        #batas kata perdokumen                                     #lopp array baras dokumen
# print "$batasKata[$y]\n";
# print "dld dokumen $y = $batasKata[$y]\n";    #dld total frekuensi per dokumen			 
$z = 0;                                        #batas loop array  

  foreach $katabigramsSkipSatu (sort{$a cmp $b}keys %frekuensiBigramSkipSatu)
  {
    if ($katabigramsSkipSatu  =~ /\w/ ){
      print BIGRAMSKIP"$katabigramsSkipSatu". "," ."$frekuensiBigramSkipSatu{$katabigramsSkipSatu[$i]}\n";
      $z += 1;
    }
  }
  $batasBigramSkipSatuSorted[$y] = $z;
  $y += 1; 
  push (@daftarBigramSkipSatu, @katabigramsSkipSatu);
  %frekuensiBigramSkipSatu = "";
  @katabigramsSkipSatu = "";
}
close(BIGRAMSKIP);

for ($i = 0 ; $i <= $#daftarBigramSkipSatu; $i++) {
    #print "$daftarBigramSkipSatu[$i]\n";
    if (!exists($daftarBigramSkipSatu[$i]))
      {
        $fBigramSkipSatu{$daftarBigramSkipSatu[$i]} = 1;
      }
    else
      {
        $fBigramSkipSatu{$daftarBigramSkipSatu[$i]}++;
      }
}
$i=0;
foreach $daftarBigramSkipSatu (sort{$a cmp $b}keys %fBigramSkipSatu){
    $sortdaftarBigramSkipSatu[$i] = $daftarBigramSkipSatu;
    $i++;
}

for ($i=0;$i<=$#IsiDokumen;$i++)
{
  $csbigramskip += $batasKataBigramSkipSatu[$i];
  $dldbigramskip[$i] += $batasKataBigramSkipSatu[$i]; # JUMLAH TOKEN DI SELURUH DOKUMEN
}

open(BIGRAMSKIP, 'bigramskip.txt') or die "error";
while(<BIGRAMSKIP>)
{
    chomp;
    push(@kataBigramSkipSatu,$_);
}
close(BIGRAMSKIP);
for($i=0;$i<=$#kataBigramSkipSatu;$i++)
{
    @kataBigramsSkipSatu = split/,/, $kataBigramSkipSatu[$i];
    $KataBigramSkipSatu[$i] = $kataBigramsSkipSatu[0];
    $fKataBigramSkipSatu[$i] = $kataBigramsSkipSatu[1];
    #print "$KataBigramSkipSatu[$i] $fKataBigramSkipSatu[$i]\n";
    
}


# print $#sortdaftarBigramSkipSatu;
# print "\n";
# print $#KataBigramSkipSatu;
$z=0;
for ($i = 0 ;$i <= $#batasBigramSkipSatuSorted;$i++)
{     
      # print "$batasKataBigramSkipSatu[$i]\n";
      $batas = $batasBigramSkipSatuSorted[$i] if ($i == 0);
      $batas = $batas + $batasBigramSkipSatuSorted[$i] if ($i != 0);
      #print "$z\n";
      for ($z; $z< $batas ; $z++)
      {
          # print "$KataBigramSkipSatu[$z] KataBigramSkipSatu[$z]\n";
          #print "$KataBigramSkipSatu[$z]\n";
          for ($y=0 ; $y <= $#sortdaftarBigramSkipSatu ; $y++)
          {
              #print "$sortdaftarBigramSkipSatu[$y]==========$KataBigramSkipSatu[$z] \n";
              if($sortdaftarBigramSkipSatu[$y] eq $KataBigramSkipSatu[$z])
              {
               # print "$fKataBigramSkipSatu[$z]\n";
                
                $daftarBigramsSkipSatu[$i][$y] = $fKataBigramSkipSatu[$z];
                #print "daftarBigramsSkipSatu[$i][$y] = $fKataBigramSkipSatu[$z]\n";
                last;
              } 
          } 
          #print "$sortdaftarBigramSkipSatu[$z] $daftar[$i][$z]\n";
      }
      $z=$batas;
}

# $total = $#sortdaftarBigramSkipSatu + $#sortdaftarUnigram;
for ($i =0; $i<= $#IsiDokumen;$i++)
{
      for($j=0;$j<= $#sortdaftarBigramSkipSatu;$j++)
      {
            if ($daftarBigramsSkipSatu[$i][$j] == "")
            {
              $daftarBigramsSkipSatu[$i][$j] =0;
            }
             #print "$sortdaftarBigramSkipSatu[$j] $daftarBigramsSkipSatu[$i][$j] [$i][$j]\n";
      }
     #print "-----------------\n";
}
@kataBigramSkipSatu = ();
@kataBigramsSkipSatu = ();
@KataBigramSkipSatu = ();
@fKataBigramSkipSatu =();



# #-----------------------------BIGRAMSKIPDUA------------------------------------------
# $y=0;
# $z=0;
# $csbigramskipdua=0;
# $dldbigramskipdua=0;
# open(BIGRAMSKIPDUA, '>bigramSkipDua.txt') or die "error ";
# foreach my $bigramSkipDua (@IsiDokumen)		#ambil isi tiap dok
# {
        # $bigramSkipDua =~ tr/A-Z/a-z/;			#preproccesing
        # $bigramSkipDua =~ tr/#$%^@&*|[].,:;!?"\/(){}<+>//d;
        # $bigramSkipDua =~ tr/'\\'//d;
        # $bigramSkipDua =~ tr/0-9//d;
        # $bigramSkipDua =~ s/\n/ /gm;
        # $bigramSkipDua =~ s/\s\s+/ /gm;
        # @bigramSkipDuas = split(/\s+/, $bigramSkipDua );	#split by space
        # #print "@bigramSkipDuas \n";

        # for ($i=0; $i <= $#bigramSkipDuas; $i++)
        # { 	
            # if(  $bigramSkipDuas[$i] =~ m/\w\S+/ and $bigramSkipDuas[$i+3] =~ m/\w\S+/)		#cek apakah indeks i dan i+1 kosong
		  # {
		  	# $katabigramSkipDuas[$i] = $bigramSkipDuas[$i] . "" . $bigramSkipDuas[$i+3];
		  	# #print "$katabigramSkipDuas[$i] \n";
		  	
		  # }
            # if (!exists($katabigramSkipDuas[$i]))
	    # {   
	      # $frekuensiBigramSkipDua{$katabigramSkipDuas[$i]} = 1;
              # #print  "$katabigramSkipDuas[$i]   $frekuensiBigramSkipDua{$katabigramSkipDuas[$i]}\n";
              # last;
            # }
            # else
	    # {
	       # $frekuensiBigramSkipDua{$katabigramSkipDuas[$i]}++;
               # #print "$katabigramSkipDuas[$i]   $frekuensiBigramSkipDua{$katabigramSkipDuas[$i]}\n";
            # }
         # }

# $batasKataBigramSkipDua[$y] = $i;               	        #batas kata perdokumen                                     #lopp array baras dokumen
# # print "$batasKata[$y]\n";
# # print "dld dokumen $y = $batasKata[$y]\n";    #dld total frekuensi per dokumen			 
# $z = 0;                                        #batas loop array  

  # foreach $katabigramSkipDuas (sort{$a cmp $b}keys %frekuensiBigramSkipDua)
  # {
    # if ($katabigramSkipDuas  =~ /\w/ ){
      # print BIGRAMSKIPDUA"$katabigramSkipDuas". "," ."$frekuensiBigramSkipDua{$katabigramSkipDuas[$i]}\n";
      # $z += 1;
    # }
  # }
  # $batasBigramSkipDuaSorted[$y] = $z;
  # $y += 1; 
  # push (@daftarBigramSkipDua, @katabigramSkipDuas);
  # %frekuensiBigramSkipDua = "";
  # @katabigramSkipDuas = "";
# }
# close(BIGRAMSKIPDUA);

# for ($i = 0 ; $i <= $#daftarBigramSkipDua; $i++) {
    # #print "$daftarBigramSkipDua[$i]\n";
    # if (!exists($daftarBigramSkipDua[$i]))
      # {
        # $fBigramSkipDua{$daftarBigramSkipDua[$i]} = 1;
      # }
    # else
      # {
        # $fBigramSkipDua{$daftarBigramSkipDua[$i]}++;
      # }
# }
# $i=0;
# foreach $daftarBigramSkipDua (sort{$a cmp $b}keys %fBigramSkipDua){
    # $sortdaftarBigramSkipDua[$i] = $daftarBigramSkipDua;
    # $i++;
# }

# for($i=0;$i<=$#sortdaftarBigramSkipDua;$i++)
# {
 # # print "$sortdaftarBigramSkipDua[$i]\n";
# }
# for ($i=0;$i<=$#IsiDokumen;$i++)
# {
  # $csbigramskipdua += $batasKataBigramSkipDua[$i];
  # $dldbigramskipdua[$i] += $batasKataBigramSkipDua[$i]; # JUMLAH TOKEN DI SELURUH DOKUMEN
# }

# open(BIGRAMSKIPDUA, 'bigramSkipDua.txt') or die "error";
# while(<BIGRAMSKIPDUA>)
# {
    # chomp;
    # push(@kataBigramSkipDua,$_);
# }
# close(BIGRAMSKIPDUA);
# for($i=0;$i<=$#kataBigramSkipDua;$i++)
# {
    # @kataBigramsSkipDua = split/,/, $kataBigramSkipDua[$i];
    # $KataBigramSkipDua[$i] = $kataBigramsSkipDua[0];
    # $fKataBigramSkipDua[$i] = $kataBigramsSkipDua[1];
    # #print "$KataBigramSkipDua[$i] $fKataBigramSkipDua[$i]\n";
    
# }

# # print $#sortdaftarBigramSkipDua;
# # print "\n";
# # print $#KataBigramSkipDua;
# $z=0;
# for ($i = 0 ;$i <= $#batasBigramSkipDuaSorted;$i++)
# {     
      # # print "$batasKataBigramSkipDua[$i]\n";
      # $batas = $batasBigramSkipDuaSorted[$i] if ($i == 0);
      # $batas = $batas + $batasBigramSkipDuaSorted[$i] if ($i != 0);
      # #print "$z\n";
      # for ($z; $z< $batas ; $z++)
      # {
          # # print "$KataBigramSkipDua[$z] KataBigramSkipDua[$z]\n";
          # #print "$KataBigramSkipDua[$z]\n";
          # for ($y=0 ; $y <= $#sortdaftarBigramSkipDua ; $y++)
          # {
              # #print "$sortdaftarBigramSkipDua[$y]==========$KataBigramSkipDua[$z] \n";
              # if($sortdaftarBigramSkipDua[$y] eq $KataBigramSkipDua[$z])
              # {
               # # print "$fKataBigramSkipDua[$z]\n";
                
                # $daftarBigramsSkipDua[$i][$y] = $fKataBigramSkipDua[$z];
                # #print "daftarBigramsSkipDua[$i][$y] = $fKataBigramSkipDua[$z]\n";
                # last;
              # } 
          # } 
          # #print "$sortdaftarBigramSkipDua[$z] $daftar[$i][$z]\n";
      # }
      # $z=$batas;
# }

# # $total = $#sortdaftarBigramSkipDua + $#sortdaftarUnigram;
# for ($i =0; $i<= $#IsiDokumen;$i++)
# {
      # for($j=0;$j<= $#sortdaftarBigramSkipDua;$j++)
      # {
            # if ($daftarBigramsSkipDua[$i][$j] == "")
            # {
              # $daftarBigramsSkipDua[$i][$j] =0;
            # }
             # #print "$sortdaftarBigramSkipDua[$j] $daftarBigramsSkipDua[$i][$j] [$i][$j]\n";
      # }
     # #print "-----------------\n";
# }
# @KataBigramSkipDua = ();
# @fKataBigramSkipDua = ();
# @kataBigramsSkipDua = ();
# @kataBigramSkipDua = ();






#-----------------------------TRIGRAMDUASKIPSATU------------------------------------------
$y=0;
$z=0;
$cstrigramduaskipsatu =0;
$dldtrigramduaskipsatu=0;
open(TRIGRAMDUASKIPSATU, '>trigramDuaSkipSatu.txt') or die "error ";
foreach my $trigramDuaSkipSatu (@IsiDokumen)		#ambil isi tiap dok
{
        $trigramDuaSkipSatu =~ tr/A-Z/a-z/;			#preproccesing
        $trigramDuaSkipSatu =~ tr/#$%^@&*|[].,:;!?"\/(){}<+>//d;
        $trigramDuaSkipSatu =~ tr/'\\'//d;
        $trigramDuaSkipSatu =~ tr/0-9//d;
        $trigramDuaSkipSatu =~ s/\n/ /gm;
        $trigramDuaSkipSatu =~ s/\s\s+/ /gm;
        @trigramsDuaSkipSatu = split(/\s+/, $trigramDuaSkipSatu );	#split by space
        #print "@trigramsDuaSkipSatu \n";

        for ($i=0; $i <= $#trigramsDuaSkipSatu; $i++)
        { 	
            if(  $trigramsDuaSkipSatu[$i] =~ m/\w\S+/ and $trigramsDuaSkipSatu[$i+1] =~ m/\w\S+/ and $trigramsDuaSkipSatu[$i+3] =~ m/\w\S+/  )		#cek apakah indeks i dan i+1 kosong
		  {
		  	$katatrigramsDuaSkipSatu[$i] = $trigramsDuaSkipSatu[$i] . "" . $trigramsDuaSkipSatu[$i+1]. "" . $trigramsDuaSkipSatu[$i+3];
		  	#print "$katatrigramsDuaSkipSatu[$i] \n";
		  	
		  }
            if (!exists($katatrigramsDuaSkipSatu[$i]))
	    {   
	      $frekuensiTrigramDuaSkipSatu{$katatrigramsDuaSkipSatu[$i]} = 1;
              #print  "$katatrigramsDuaSkipSatu[$i]   $frekuensiTrigramDuaSkipSatu{$katatrigramsDuaSkipSatu[$i]}\n";
              last;
            }
            else
	    {
	       $frekuensiTrigramDuaSkipSatu{$katatrigramsDuaSkipSatu[$i]}++;
               #print "$katatrigramsDuaSkipSatu[$i]   $frekuensiTrigramDuaSkipSatu{$katatrigramsDuaSkipSatu[$i]}\n";
            }
         }

$batasKataTrigramDuaSkipSatu[$y] = $i;               	        #batas kata perdokumen                                     #lopp array baras dokumen
# print "$batasKata[$y]\n";
# print "dld dokumen $y = $batasKata[$y]\n";    #dld total frekuensi per dokumen			 
$z = 0;                                        #batas loop array  

  foreach $katatrigramsDuaSkipSatu (sort{$a cmp $b}keys %frekuensiTrigramDuaSkipSatu)
  {
    if ($katatrigramsDuaSkipSatu  =~ /\w/ ){
      print TRIGRAMDUASKIPSATU"$katatrigramsDuaSkipSatu". "," ."$frekuensiTrigramDuaSkipSatu{$katatrigramsDuaSkipSatu[$i]}\n";
      $z += 1;
    }
  }
  $batasTrigramDuaSkipSatuSorted[$y] = $z;
  $y += 1; 
  push (@daftarTrigramDuaSkipSatu, @katatrigramsDuaSkipSatu);
  %frekuensiTrigramDuaSkipSatu = "";
  @katatrigramsDuaSkipSatu = "";
}
close(TRIGRAMDUASKIPSATU);

for ($i = 0 ; $i <= $#daftarTrigramDuaSkipSatu; $i++) {
    #print "$daftarTrigramDuaSkipSatu[$i]\n";
    if (!exists($daftarTrigramDuaSkipSatu[$i]))
      {
        $fTrigramDuaSkipSatu{$daftarTrigramDuaSkipSatu[$i]} = 1;
      }
    else
      {
        $fTrigramDuaSkipSatu{$daftarTrigramDuaSkipSatu[$i]}++;
      }
}
$i=0;
foreach $daftarTrigramDuaSkipSatu (sort{$a cmp $b}keys %fTrigramDuaSkipSatu){
    $sortdaftarTrigramDuaSkipSatu[$i] = $daftarTrigramDuaSkipSatu;
    $i++;
}


for ($i=0;$i<=$#IsiDokumen;$i++)
{
  $cstrigramduaskipsatu += $batasKataTrigramDuaSkipSatu[$i];
  $dldtrigramduaskipsatu[$i] += $batasKataTrigramDuaSkipSatu[$i]; # JUMLAH TOKEN DI SELURUH DOKUMEN
}


open(TRIGRAMDUASKIPSATU, 'trigramDuaSkipSatu.txt') or die "error";
while(<TRIGRAMDUASKIPSATU>)
{
    chomp;
    push(@kataTrigramDuaSkipSatu,$_);
}
close(TRIGRAMDUASKIPSATU);
for($i=0;$i<=$#kataTrigramDuaSkipSatu;$i++)
{
    @kataTrigramsDuaSkipSatu = split/,/, $kataTrigramDuaSkipSatu[$i];
    $KataTrigramDuaSkipSatu[$i] = $kataTrigramsDuaSkipSatu[0];
    $fKataTrigramDuaSkipSatu[$i] = $kataTrigramsDuaSkipSatu[1];
    #print "$KataTrigramDuaSkipSatu[$i] $fKataTrigramDuaSkipSatu[$i]\n";
    
}


# print $#sortdaftarTrigramDuaSkipSatu;
# print "\n";
# print $#KataTrigramDuaSkipSatu;
$z=0;
for ($i = 0 ;$i <= $#batasTrigramDuaSkipSatuSorted;$i++)
{     
      # print "$batasKataTrigramDuaSkipSatu[$i]\n";
      $batas = $batasTrigramDuaSkipSatuSorted[$i] if ($i == 0);
      $batas = $batas + $batasTrigramDuaSkipSatuSorted[$i] if ($i != 0);
      #print "$z\n";
      for ($z; $z< $batas ; $z++)
      {
          # print "$KataTrigramDuaSkipSatu[$z] KataTrigramDuaSkipSatu[$z]\n";
          #print "$KataTrigramDuaSkipSatu[$z]\n";
          for ($y=0 ; $y <= $#sortdaftarTrigramDuaSkipSatu ; $y++)
          {
              #print "$sortdaftarTrigramDuaSkipSatu[$y]==========$KataTrigramDuaSkipSatu[$z] \n";
              if($sortdaftarTrigramDuaSkipSatu[$y] eq $KataTrigramDuaSkipSatu[$z])
              {
               # print "$fKataTrigramDuaSkipSatu[$z]\n";
                
                $daftarTrigramsDuaSkipSatu[$i][$y] = $fKataTrigramDuaSkipSatu[$z];
                #print "daftarTrigramsDuaSkipSatu[$i][$y] = $fKataTrigramDuaSkipSatu[$z]\n";
                last;
              } 
          } 
          #print "$sortdaftarTrigramDuaSkipSatu[$z] $daftar[$i][$z]\n";
      }
      $z=$batas;
}

# $total = $#sortdaftarTrigramDuaSkipSatu + $#sortdaftarUnigram;
for ($i =0; $i<= $#IsiDokumen;$i++)
{
      for($j=0;$j<= $#sortdaftarTrigramDuaSkipSatu;$j++)
      {
            if ($daftarTrigramsDuaSkipSatu[$i][$j] == "")
            {
              $daftarTrigramsDuaSkipSatu[$i][$j] =0;
            }
            # print "$sortdaftarTrigramDuaSkipSatu[$j] $daftarTrigramsDuaSkipSatu[$i][$j] [$i][$j]\n";
      }
     #print "-----------------\n";
}
@KataTrigramDuaSkipSatu = ();
@kataTrigramsDuaSkipSatu = ();
@fKataTrigramDuaSkipSatu = ();
@KataTrigramDuaSkipSatu = ();




# #-----------------------------TRIGRAMDUASKIPDUA------------------------------------------
# $y=0;
# $z=0;
# $cstrigramduaskipdua =0;
# $dldtrigramduaskipdua =0;
# open(TRIGRAMDUASKIPDUA, '>trigramDuaSkipDua.txt') or die "error ";
# foreach my $trigramDuaSkipDua (@IsiDokumen)		#ambil isi tiap dok
# {
        # $trigramDuaSkipDua =~ tr/A-Z/a-z/;			#preproccesing
        # $trigramDuaSkipDua =~ tr/#$%^@&*|[].,:;!?"\/(){}<+>//d;
        # $trigramDuaSkipDua =~ tr/'\\'//d;
        # $trigramDuaSkipDua =~ tr/0-9//d;
        # $trigramDuaSkipDua =~ s/\n/ /gm;
        # $trigramDuaSkipDua =~ s/\s\s+/ /gm;
        # @trigramsDuaSkipDua = split(/\s+/, $trigramDuaSkipDua );	#split by space
        # #print "@trigramsDuaSkipDua \n";

        # for ($i=0; $i <= $#trigramsDuaSkipDua; $i++)
        # { 	
            # if(  $trigramsDuaSkipDua[$i] =~ m/\w\S+/ and $trigramsDuaSkipDua[$i+1] =~ m/\w\S+/ and $trigramsDuaSkipDua[$i+4] =~ m/\w\S+/ )		#cek apakah indeks i dan i+1 kosong
		  # {
		  	# $katatrigramsDuaSkipDua[$i] = $trigramsDuaSkipDua[$i] . "" . $trigramsDuaSkipDua[$i+1] . "" . $trigramsDuaSkipDua[$i+4];
		  	# #print "$katatrigramsDuaSkipDua[$i] \n";
		  	
		  # }
            # if (!exists($katatrigramsDuaSkipDua[$i]))
	    # {   
	      # $frekuensiTrigramDuaSkipDua{$katatrigramsDuaSkipDua[$i]} = 1;
              # #print  "$katatrigramsDuaSkipDua[$i]   $frekuensiTrigramDuaSkipDua{$katatrigramsDuaSkipDua[$i]}\n";
              # last;
            # }
            # else
	    # {
	       # $frekuensiTrigramDuaSkipDua{$katatrigramsDuaSkipDua[$i]}++;
               # #print "$katatrigramsDuaSkipDua[$i]   $frekuensiTrigramDuaSkipDua{$katatrigramsDuaSkipDua[$i]}\n";
            # }
         # }

# $batasKataTrigramDuaSkipDua[$y] = $i;               	        #batas kata perdokumen                                     #lopp array baras dokumen
# # print "$batasKata[$y]\n";
# # print "dld dokumen $y = $batasKata[$y]\n";    #dld total frekuensi per dokumen			 
# $z = 0;                                        #batas loop array  

  # foreach $katatrigramsDuaSkipDua (sort{$a cmp $b}keys %frekuensiTrigramDuaSkipDua)
  # {
    # if ($katatrigramsDuaSkipDua  =~ /\w/ ){
      # print TRIGRAMDUASKIPDUA"$katatrigramsDuaSkipDua". "," ."$frekuensiTrigramDuaSkipDua{$katatrigramsDuaSkipDua[$i]}\n";
      # $z += 1;
    # }
  # }
  # $batasTrigramDuaSkipDuaSorted[$y] = $z;
  # $y += 1; 
  # push (@daftarTrigramDuaSkipDua, @katatrigramsDuaSkipDua);
  # %frekuensiTrigramDuaSkipDua = "";
  # @katatrigramsDuaSkipDua = "";
# }
# close(TRIGRAMDUASKIPDUA);

# for ($i = 0 ; $i <= $#daftarTrigramDuaSkipDua; $i++) {
    # #print "$daftarTrigramDuaSkipDua[$i]\n";
    # if (!exists($daftarTrigramDuaSkipDua[$i]))
      # {
        # $fTrigramDuaSkipDua{$daftarTrigramDuaSkipDua[$i]} = 1;
      # }
    # else
      # {
        # $fTrigramDuaSkipDua{$daftarTrigramDuaSkipDua[$i]}++;
      # }
# }
# $i=0;
# foreach $daftarTrigramDuaSkipDua (sort{$a cmp $b}keys %fTrigramDuaSkipDua){
    # $sortdaftarTrigramDuaSkipDua[$i] = $daftarTrigramDuaSkipDua;
    # $i++;
# }

# for($i=0;$i<=$#sortdaftarTrigramDuaSkipDua;$i++)
# {
 # # print "$sortdaftarTrigramDuaSkipDua[$i]\n";
# }
# for ($i=0;$i<=$#IsiDokumen;$i++)
# {
  # $cstrigramduaskipdua += $batasKataTrigramDuaSkipDua[$i];
  # $dldtrigramduaskipdua[$i] += $batasKataTrigramDuaSkipDua[$i]; # JUMLAH TOKEN DI SELURUH DOKUMEN
# }


# open(TRIGRAMDUASKIPDUA, 'trigramDuaSkipDua.txt') or die "error";
# while(<TRIGRAMDUASKIPDUA>)
# {
    # chomp;
    # push(@kataTrigramDuaSkipDua,$_);
# }
# close(TRIGRAMDUASKIPDUA);
# for($i=0;$i<=$#kataTrigramDuaSkipDua;$i++)
# {
    # @kataTrigramsDuaSkipDua = split/,/, $kataTrigramDuaSkipDua[$i];
    # $KataTrigramDuaSkipDua[$i] = $kataTrigramsDuaSkipDua[0];
    # $fKataTrigramDuaSkipDua[$i] = $kataTrigramsDuaSkipDua[1];
    # #print "$KataTrigramDuaSkipDua[$i] $fKataTrigramDuaSkipDua[$i]\n";
    
# }


# # print $#sortdaftarTrigramDuaSkipDua;
# # print "\n";
# # print $#KataTrigramDuaSkipDua;
# $z=0;
# for ($i = 0 ;$i <= $#batasTrigramDuaSkipDuaSorted;$i++)
# {     
      # # print "$batasKataTrigramDuaSkipDua[$i]\n";
      # $batas = $batasTrigramDuaSkipDuaSorted[$i] if ($i == 0);
      # $batas = $batas + $batasTrigramDuaSkipDuaSorted[$i] if ($i != 0);
      # #print "$z\n";
      # for ($z; $z< $batas ; $z++)
      # {
          # # print "$KataTrigramDuaSkipDua[$z] KataTrigramDuaSkipDua[$z]\n";
          # #print "$KataTrigramDuaSkipDua[$z]\n";
          # for ($y=0 ; $y <= $#sortdaftarTrigramDuaSkipDua ; $y++)
          # {
              # #print "$sortdaftarTrigramDuaSkipDua[$y]==========$KataTrigramDuaSkipDua[$z] \n";
              # if($sortdaftarTrigramDuaSkipDua[$y] eq $KataTrigramDuaSkipDua[$z])
              # {
               # # print "$fKataTrigramDuaSkipDua[$z]\n";
                
                # $daftarTrigramsDuaSkipDua[$i][$y] = $fKataTrigramDuaSkipDua[$z];
                # #print "daftarTrigramsDuaSkipDua[$i][$y] = $fKataTrigramDuaSkipDua[$z]\n";
                # last;
              # } 
          # } 
          # #print "$sortdaftarTrigramDuaSkipDua[$z] $daftar[$i][$z]\n";
      # }
      # $z=$batas;
# }

# # $total = $#sortdaftarTrigramDuaSkipDua + $#sortdaftarUnigram;
# for ($i =0; $i<= $#IsiDokumen;$i++)
# {
      # for($j=0;$j<= $#sortdaftarTrigramDuaSkipDua;$j++)
      # {
            # if ($daftarTrigramsDuaSkipDua[$i][$j] == "")
            # {
              # $daftarTrigramsDuaSkipDua[$i][$j] =0;
            # }
             # #print "$sortdaftarTrigramDuaSkipDua[$j] $daftarTrigramsDuaSkipDua[$i][$j] [$i][$j]\n";
      # }
     # #print "-----------------\n";
# }
# @kataTrigramDuaSkipDua = ();
# @KataTrigramDuaSkipDua = ();
# @fKataTrigramDuaSkipDua = ();
# @kataTrigramsDuaSkipDua = ();



#-----------------------------TRIGRAMSATUSKIPSATU------------------------------------------
$y=0;
$z=0;
$cstrigramsatuskipsatu = 0;
open(TRIGRAMSATUSKIPSATU, '>trigramSatuSkipSatu.txt') or die "error ";
foreach my $trigramSatuSkipSatu (@IsiDokumen)		#ambil isi tiap dok
{
        $trigramSatuSkipSatu =~ tr/A-Z/a-z/;			#preproccesing
        $trigramSatuSkipSatu =~ tr/#$%^@&*|[].,:;!?"\/(){}<+>//d;
        $trigramSatuSkipSatu =~ tr/'\\'//d;
        $trigramSatuSkipSatu =~ tr/0-9//d;
        $trigramSatuSkipSatu =~ s/\n/ /gm;
        $trigramSatuSkipSatu =~ s/\s\s+/ /gm;
        @trigramsSatuSkipSatu = split(/\s+/, $trigramSatuSkipSatu );	#split by space
        #print "@trigramsSatuSkipSatu \n";

        for ($i=0; $i <= $#trigramsSatuSkipSatu; $i++)
        { 	
            if(  $trigramsSatuSkipSatu[$i] =~ m/\w\S+/ and $trigramsSatuSkipSatu[$i+2] =~ m/\w\S+/ and $trigramsSatuSkipSatu[$i+3] =~ m/\w\S+/  )		#cek apakah indeks i dan i+1 kosong
		  {
		  	$katatrigramsSatuSkipSatu[$i] = $trigramsSatuSkipSatu[$i] . "" . $trigramsSatuSkipSatu[$i+2]. "" . $trigramsSatuSkipSatu[$i+3];
		  	#print "$katatrigramsSatuSkipSatu[$i] \n";
		  	
		  }
            if (!exists($katatrigramsSatuSkipSatu[$i]))
	    {   
	      $frekuensiTrigramSatuSkipSatu{$katatrigramsSatuSkipSatu[$i]} = 1;
              #print  "$katatrigramsSatuSkipSatu[$i]   $frekuensiTrigramSatuSkipSatu{$katatrigramsSatuSkipSatu[$i]}\n";
              last;
            }
            else
	    {
	       $frekuensiTrigramSatuSkipSatu{$katatrigramsSatuSkipSatu[$i]}++;
               #print "$katatrigramsSatuSkipSatu[$i]   $frekuensiTrigramSatuSkipSatu{$katatrigramsSatuSkipSatu[$i]}\n";
            }
         }

$batasKataTrigramSatuSkipSatu[$y] = $i;               	        #batas kata perdokumen                                     #lopp array baras dokumen
# print "$batasKata[$y]\n";
# print "dld dokumen $y = $batasKata[$y]\n";    #dld total frekuensi per dokumen			 
$z = 0;                                        #batas loop array  

  foreach $katatrigramsSatuSkipSatu (sort{$a cmp $b}keys %frekuensiTrigramSatuSkipSatu)
  {
    if ($katatrigramsSatuSkipSatu  =~ /\w/ ){
      print TRIGRAMSATUSKIPSATU"$katatrigramsSatuSkipSatu". "," ."$frekuensiTrigramSatuSkipSatu{$katatrigramsSatuSkipSatu[$i]}\n";
      $z += 1;
    }
  }
  $batasTrigramSatuSkipSatuSorted[$y] = $z;
  $y += 1; 
  push (@daftarTrigramSatuSkipSatu, @katatrigramsSatuSkipSatu);
  %frekuensiTrigramSatuSkipSatu = "";
  @katatrigramsSatuSkipSatu = "";
}
close(TRIGRAMSATUSKIPSATU);

for ($i = 0 ; $i <= $#daftarTrigramSatuSkipSatu; $i++) {
    #print "$daftarTrigramSatuSkipSatu[$i]\n";
    if (!exists($daftarTrigramSatuSkipSatu[$i]))
      {
        $fTrigramSatuSkipSatu{$daftarTrigramSatuSkipSatu[$i]} = 1;
      }
    else
      {
        $fTrigramSatuSkipSatu{$daftarTrigramSatuSkipSatu[$i]}++;
      }
}
$i=0;
foreach $daftarTrigramSatuSkipSatu (sort{$a cmp $b}keys %fTrigramSatuSkipSatu){
    $sortdaftarTrigramSatuSkipSatu[$i] = $daftarTrigramSatuSkipSatu;
    $i++;
}


for ($i=0;$i<=$#IsiDokumen;$i++)
{
  $cstrigramsatuskipsatu += $batasKataTrigramSatuSkipSatu[$i];
  $dldtrigramsatuskipsatu[$i] += $batasKataTrigramSatuSkipSatu[$i]; # JUMLAH TOKEN DI SELURUH DOKUMEN
}


open(TRIGRAMSATUSKIPSATU, 'trigramSatuSkipSatu.txt') or die "error";
while(<TRIGRAMSATUSKIPSATU>)
{
    chomp;
    push(@kataTrigramSatuSkipSatu,$_);
}
close(TRIGRAMSATUSKIPSATU);
for($i=0;$i<=$#kataTrigramSatuSkipSatu;$i++)
{
    @kataTrigramsSatuSkipSatu = split/,/, $kataTrigramSatuSkipSatu[$i];
    $KataTrigramSatuSkipSatu[$i] = $kataTrigramsSatuSkipSatu[0];
    $fKataTrigramSatuSkipSatu[$i] = $kataTrigramsSatuSkipSatu[1];
    #print "$KataTrigramSatuSkipSatu[$i] $fKataTrigramSatuSkipSatu[$i]\n";
    
}


# print $#sortdaftarTrigramSatuSkipSatu;
# print "\n";
# print $#KataTrigramSatuSkipSatu;
$z=0;
for ($i = 0 ;$i <= $#batasTrigramSatuSkipSatuSorted;$i++)
{     
      # print "$batasKataTrigramSatuSkipSatu[$i]\n";
      $batas = $batasTrigramSatuSkipSatuSorted[$i] if ($i == 0);
      $batas = $batas + $batasTrigramSatuSkipSatuSorted[$i] if ($i != 0);
      #print "$z\n";
      for ($z; $z< $batas ; $z++)
      {
          # print "$KataTrigramSatuSkipSatu[$z] KataTrigramSatuSkipSatu[$z]\n";
          #print "$KataTrigramSatuSkipSatu[$z]\n";
          for ($y=0 ; $y <= $#sortdaftarTrigramSatuSkipSatu ; $y++)
          {
              #print "$sortdaftarTrigramSatuSkipSatu[$y]==========$KataTrigramSatuSkipSatu[$z] \n";
              if($sortdaftarTrigramSatuSkipSatu[$y] eq $KataTrigramSatuSkipSatu[$z])
              {
               # print "$fKataTrigramSatuSkipSatu[$z]\n";
                
                $daftarTrigramsSatuSkipSatu[$i][$y] = $fKataTrigramSatuSkipSatu[$z];
                #print "daftarTrigramsSatuSkipSatu[$i][$y] = $fKataTrigramSatuSkipSatu[$z]\n";
                last;
              } 
          } 
          #print "$sortdaftarTrigramSatuSkipSatu[$z] $daftar[$i][$z]\n";
      }
      $z=$batas;
}

# $total = $#sortdaftarTrigramSatuSkipSatu + $#sortdaftarUnigram;
for ($i =0; $i<= $#IsiDokumen;$i++)
{
      for($j=0;$j<= $#sortdaftarTrigramSatuSkipSatu;$j++)
      {
            if ($daftarTrigramsSatuSkipSatu[$i][$j] == "")
            {
              $daftarTrigramsSatuSkipSatu[$i][$j] =0;
            }
             #print "$sortdaftarTrigramSatuSkipSatu[$j] $daftarTrigramsSatuSkipSatu[$i][$j] [$i][$j]\n";
      }
     #print "-----------------\n";
}
@kataTrigramSatuSkipSatu = ();
@kataTrigramsSatuSkipSatu = ();
@fKataTrigramSatuSkipSatu = ();
@KataTrigramSatuSkipSatu = ();


# #-----------------------------TRIGRAMSATUSKIPDUA------------------------------------------
# $y=0;
# $z=0;
# $cstrigramsatuskipdua = 0;
# open(TRIGRAMSATUSKIPDUA, '>trigramSatuSkipDua.txt') or die "error ";
# foreach my $trigramSatuSkipDua (@IsiDokumen)		#ambil isi tiap dok
# {
        # $trigramSatuSkipDua =~ tr/A-Z/a-z/;			#preproccesing
        # $trigramSatuSkipDua =~ tr/#$%^@&*|[].,:;!?"\/(){}<+>//d;
        # $trigramSatuSkipDua =~ tr/'\\'//d;
        # $trigramSatuSkipDua =~ tr/0-9//d;
        # $trigramSatuSkipDua =~ s/\n/ /gm;
        # $trigramSatuSkipDua =~ s/\s\s+/ /gm;
        # @trigramsSatuSkipDua = split(/\s+/, $trigramSatuSkipDua );	#split by space
        # #print "@trigramsSatuSkipDua \n";

        # for ($i=0; $i <= $#trigramsSatuSkipDua; $i++)
        # { 	
            # if(  $trigramsSatuSkipDua[$i] =~ m/\w\S+/ and $trigramsSatuSkipDua[$i+3] =~ m/\w\S+/  and $trigramsSatuSkipDua[$i+4] =~ m/\w\S+/ )		#cek apakah indeks i dan i+1 kosong
		  # {
		  	# $katatrigramsSatuSkipDua[$i] = $trigramsSatuSkipDua[$i] . "" . $trigramsSatuSkipDua[$i+3]. "" . $trigramsSatuSkipDua[$i+4];
		  	# #print "$katatrigramsSatuSkipDua[$i] \n";
		  	
		  # }
            # if (!exists($katatrigramsSatuSkipDua[$i]))
	    # {   
	      # $frekuensiTrigramSatuSkipDua{$katatrigramsSatuSkipDua[$i]} = 1;
              # #print  "$katatrigramsSatuSkipDua[$i]   $frekuensiTrigramSatuSkipDua{$katatrigramsSatuSkipDua[$i]}\n";
              # last;
            # }
            # else
	    # {
	       # $frekuensiTrigramSatuSkipDua{$katatrigramsSatuSkipDua[$i]}++;
               # #print "$katatrigramsSatuSkipDua[$i]   $frekuensiTrigramSatuSkipDua{$katatrigramsSatuSkipDua[$i]}\n";
            # }
         # }

# $batasKataTrigramSatuSkipDua[$y] = $i;               	        #batas kata perdokumen                                     #lopp array baras dokumen
# # print "$batasKata[$y]\n";
# # print "dld dokumen $y = $batasKata[$y]\n";    #dld total frekuensi per dokumen			 
# $z = 0;                                        #batas loop array  

  # foreach $katatrigramsSatuSkipDua (sort{$a cmp $b}keys %frekuensiTrigramSatuSkipDua)
  # {
    # if ($katatrigramsSatuSkipDua  =~ /\w/ ){
      # print TRIGRAMSATUSKIPDUA"$katatrigramsSatuSkipDua". "," ."$frekuensiTrigramSatuSkipDua{$katatrigramsSatuSkipDua[$i]}\n";
      # $z += 1;
    # }
  # }
  # $batasTrigramSatuSkipDuaSorted[$y] = $z;
  # $y += 1; 
  # push (@daftarTrigramSatuSkipDua, @katatrigramsSatuSkipDua);
  # %frekuensiTrigramSatuSkipDua = "";
  # @katatrigramsSatuSkipDua = "";
# }
# close(TRIGRAMSATUSKIPDUA);

# for ($i = 0 ; $i <= $#daftarTrigramSatuSkipDua; $i++) {
    # #print "$daftarTrigramSatuSkipDua[$i]\n";
    # if (!exists($daftarTrigramSatuSkipDua[$i]))
      # {
        # $fTrigramSatuSkipDua{$daftarTrigramSatuSkipDua[$i]} = 1;
      # }
    # else
      # {
        # $fTrigramSatuSkipDua{$daftarTrigramSatuSkipDua[$i]}++;
      # }
# }
# $i=0;
# foreach $daftarTrigramSatuSkipDua (sort{$a cmp $b}keys %fTrigramSatuSkipDua){
    # $sortdaftarTrigramSatuSkipDua[$i] = $daftarTrigramSatuSkipDua;
    # $i++;
# }

# for($i=0;$i<=$#sortdaftarTrigramSatuSkipDua;$i++)
# {
 # # print "$sortdaftarTrigramSatuSkipDua[$i]\n";
# }
# for ($i=0;$i<=$#IsiDokumen;$i++)
# {
  # $cstrigramsatuskipdua += $batasKataTrigramSatuSkipDua[$i];
  # $dld[$i] += $batasKataTrigramSatuSkipDua[$i]; # JUMLAH TOKEN DI SELURUH DOKUMEN
# }


# open(TRIGRAMSATUSKIPDUA, 'trigramSatuSkipDua.txt') or die "error";
# while(<TRIGRAMSATUSKIPDUA>)
# {
    # chomp;
    # push(@kataTrigramSatuSkipDua,$_);
# }
# close(TRIGRAMSATUSKIPDUA);
# for($i=0;$i<=$#kataTrigramSatuSkipDua;$i++)
# {
    # @kataTrigramsSatuSkipDua = split/,/, $kataTrigramSatuSkipDua[$i];
    # $KataTrigramSatuSkipDua[$i] = $kataTrigramsSatuSkipDua[0];
    # $fKataTrigramSatuSkipDua[$i] = $kataTrigramsSatuSkipDua[1];
    # #print "$KataTrigramSatuSkipDua[$i] $fKataTrigramSatuSkipDua[$i]\n";
    
# }


# # print $#sortdaftarTrigramSatuSkipDua;
# # print "\n";
# # print $#KataTrigramSatuSkipDua;
# $z=0;
# for ($i = 0 ;$i <= $#batasTrigramSatuSkipDuaSorted;$i++)
# {     
      # # print "$batasKataTrigramSatuSkipDua[$i]\n";
      # $batas = $batasTrigramSatuSkipDuaSorted[$i] if ($i == 0);
      # $batas = $batas + $batasTrigramSatuSkipDuaSorted[$i] if ($i != 0);
      # #print "$z\n";
      # for ($z; $z< $batas ; $z++)
      # {
          # # print "$KataTrigramSatuSkipDua[$z] KataTrigramSatuSkipDua[$z]\n";
          # #print "$KataTrigramSatuSkipDua[$z]\n";
          # for ($y=0 ; $y <= $#sortdaftarTrigramSatuSkipDua ; $y++)
          # {
              # #print "$sortdaftarTrigramSatuSkipDua[$y]==========$KataTrigramSatuSkipDua[$z] \n";
              # if($sortdaftarTrigramSatuSkipDua[$y] eq $KataTrigramSatuSkipDua[$z])
              # {
               # # print "$fKataTrigramSatuSkipDua[$z]\n";
                
                # $daftarTrigramsSatuSkipDua[$i][$y] = $fKataTrigramSatuSkipDua[$z];
                # #print "daftarTrigramsSatuSkipDua[$i][$y] = $fKataTrigramSatuSkipDua[$z]\n";
                # last;
              # } 
          # } 
          # #print "$sortdaftarTrigramSatuSkipDua[$z] $daftar[$i][$z]\n";
      # }
      # $z=$batas;
# }

# # $total = $#sortdaftarTrigramSatuSkipDua + $#sortdaftarUnigram;
# for ($i =0; $i<= $#IsiDokumen;$i++)
# {
      # for($j=0;$j<= $#sortdaftarTrigramSatuSkipDua;$j++)
      # {
            # if ($daftarTrigramsSatuSkipDua[$i][$j] == "")
            # {
              # $daftarTrigramsSatuSkipDua[$i][$j] =0;
            # }
            # # print "$sortdaftarTrigramSatuSkipDua[$j] $daftarTrigramsSatuSkipDua[$i][$j] [$i][$j]\n";
      # }
     # #print "-----------------\n";
# }
# @kataTrigramSatuSkipDua = ();
# @kataTrigramsSatuSkipDua = ();
# @fKataTrigramSatuSkipDua = ();
# @KataTrigramSatuSkipDua = ();


open(SEMUA, '>semua.txt') or die "error";
$x=0;
$z = 0;
$y=0;
$v=0;
$w=0;
$u=0;
$t=0;
$s=0;
# $a = $#sortdaftarUnigram;
# $b = $#sortdaftarBigram;
# $total = $#sortdaftarUnigram+$#sortdaftarBigram+1;
# $totall = $total+$#sortdaftarTrigram+1;
# $ttotall = $totall+$#sortdaftarBigramSkipSatu+1;
# $ttotalll = $ttotall+$#sortdaftarBigramSkipDua+1;
# $tttotalll = $ttotalll+$#sortdaftarTrigramDuaSkipSatu+1;
# $tttotallll = $tttotalll+$#sortdaftarTrigramDuaSkipDua+1;
# $ttttotallll = $tttotallll + $#sortdaftarTrigramSatuSkipSatu+1;
# $semua = $ttotall + $#sortdaftarTrigramDuaSkipSatu + $#sortdaftarTrigramDuaSkipDua;
$a = $#sortdaftarUnigram;
$b = $#sortdaftarBigram;
$total = $#sortdaftarUnigram+$#sortdaftarBigram+1;
$totall = $total+$#sortdaftarTrigram+1;
$ttotall = $totall+$#sortdaftarBigramSkipSatu+1;

$ttotalll = $ttotall+$#sortdaftarTrigramDuaSkipSatu+1;

$semua = $ttotalll + $#sortdaftarTrigramSatuSkipSatu+1;


for ($i =0; $i<= $#IsiDokumen;$i++)
{
  for($j=0;$j<= $semua;$j++)
  {
    #print "$daftarBigrams[$i][$j]\n";
    if ($j <= $a)
    {
    $daftarftotal[$i][$j] = $daftarUnigrams[$i][$j];
    $daftarkata[$j] = $sortdaftarUnigram[$j];
    }
    if ($j > $a and $j<=$total)
    {
    $daftarftotal[$i][$j] = $daftarBigrams[$i][$x];
    $daftarkata[$j] = $sortdaftarBigram[$x];
    $x++;
    }
    if ($j > $total and $j<=$totall)
    {
    $daftarftotal[$i][$j] = $daftarTrigrams[$i][$z];
    $daftarkata[$j] = $sortdaftarTrigram[$z];
    $z++;
    }   
    if ($j >$totall and $j<=$ttotall)
    {
      $daftarftotal[$i][$j] = $daftarBigramsSkipSatu[$i][$y];
      $daftarkata[$j] = $sortdaftarBigramSkipSatu[$y];
      $y++;
    }  
    # if ($j >$ttotall and $j<=$ttotalll)
    # {
      # $daftarftotal[$i][$j] = $daftarBigramsSkipDua[$i][$v];
      # $daftarkata[$j] = $sortdaftarBigramSkipDua[$v];
      # $v++;
    # }  
    if ($j >$ttotall and $j<=$ttotalll)
    {
      $daftarftotal[$i][$j] = $daftarTrigramsDuaSkipSatu[$i][$w];
      $daftarkata[$j] = $sortdaftarTrigramDuaSkipSatu[$w];
      $w++;
    }  
    # if ($j >$tttotalll and $j<=$tttotallll)
    # {
      # $daftarftotal[$i][$j] = $daftarTrigramsDuaSkipDua[$i][$u];
      # $daftarkata[$j] = $sortdaftarTrigramDuaSkipDua[$u];
      # $u++;
    # }  
    if ($j >$ttotalll and $j<=$semua)
    {
      $daftarftotal[$i][$j] = $daftarTrigramsSatuSkipSatu[$i][$t];
      $daftarkata[$j] = $sortdaftarTrigramSatuSkipSatu[$t];
      $t++;
    }   
    # if ($j >$ttttotallll and $j<=$semua)
    # {
      # $daftarftotal[$i][$j] = $daftarTrigramsSatuSkipDua[$i][$s];
      # $daftarkata[$j] = $sortdaftarTrigramSatuSkipDua[$s];
      # $s++;
    # }  
     print SEMUA"$daftarkata[$j] $daftarftotal[$i][$j]\n";
  }
 # print"-----------------------------------------------------------\n";
  $x=0;
  $z=0;
  $y=0;
  $v=0;
  $w=0;
  $u=0;
  $t=0;
  $s=0;
}
close(SEMUA);
@daftarUnigrams = ();
@sortdaftarUnigram = ();
@daftarBigrams = ();
@sortdaftarBigram = ();
@daftarBigramsSkipSatu = ();
@sortdaftarBigramSkipSatu = ();
@daftarTrigrams = ();
@sortdaftarTrigramSkipSatu = ();
@sortdaftarBigramSkipSatu= ();
@daftarTrigramsDuaSkipSatu = ();
@sortdaftarTrigramDuaSkipSatu =();
@daftarTrigramsSatuSkipSatu = ();
@sortdaftarTrigramSatuSkipSatu =();


$counter=0;

#------------------------------dft & cft---------------------------
for($j=0;$j<= $semua;$j++)
{
      for ($i =0; $i<= $#IsiDokumen;$i++)
      {
        if ($daftarftotal[$i][$j] ne 0 )
        {
        $dft[$j] += 1;
        } 
        $cft[$j] += $daftarftotal[$i][$j];
      }
      #print "$daftarkata[$j] $dft[$j]\n";
      #print "$daftarkata[$j] $cft[$j]\n";
      
}


#------------------------------dld & smoothing---------------------------
for ($i =0; $i<= $#IsiDokumen;$i++)
{
  for($j=0;$j<= $semua;$j++)
  {
    #print "$daftarBigrams[$i][$j]\n";
    if ($j <= $a)
    {
    $smoothing[$j] = $cft[$j]/$csunigram;
    $dld[$i][$j] = $dldunigram[$i];
    }
    if ($j > $a and $j<=$total)
    {
    $smoothing[$j] = $cft[$j]/$csbigram;
    $dld[$i][$j] = $dldbigram[$i];
    }
    if ($j > $total and $j<=$totall)
    {
    $smoothing[$j] = $cft[$j]/$cstrigram; 
    $dld[$i][$j] = $dldtrigram[$i]; 
    }   
    if ($j >$totall and $j<=$ttotall)
    {
    $smoothing[$j] = $cft[$j]/$csbigramskip; 
    $dld[$i][$j] = $dldbigramskip[$i];
    }  
    # if ($j >$ttotall and $j<=$ttotalll)
    # {
    # $smoothing[$j] = $cft[$j]/$csbigramskipdua; 
    # $dld[$i][$j] = $dldbigramskipdua[$i];
    # }  
    if ($j >$ttotall and $j<=$ttotalll)
    {
    $smoothing[$j] = $cft[$j]/$cstrigramduaskipsatu;
    $dld[$i][$j] = $dldtrigramduaskipsatu[$i]; 
    }  
    # if ($j >$tttotalll and $j<=$tttotallll)
    # {
    # $smoothing[$j] = $cft[$j]/$cstrigramduaskipdua; 
    # $dld[$i][$j] = $dldtrigramduaskipdua[$i];
    # }  
    if ($j >$ttotalll and $j<=$semua)
    {
    $smoothing[$j] = $cft[$j]/$cstrigramsatuskipsatu; 
    $dld[$i][$j] = $dldtrigramsatuskipsatu[$i];
    }   
    # if ($j >$ttttotallll and $j<=$semua)
    # {
    # $smoothing[$j] = $cft[$j]/$cstrigramduaskipdua; 
    # $dld[$i][$j] = $dldtrigramduaskipdua[$i];
    # }  
    #print "$daftarkata[$j] $dld[$i][$j] $j\n";
    
    }
    # print"-----------------------------------------------------------\n";
}
@cft = ();

#-------------------------------PML-------------------------------
for ($i =0; $i<= $#IsiDokumen;$i++)
{
  for($j=0;$j<= $semua;$j++)
  {
        $pml[$i][$j] = $daftarftotal[$i][$j]/$dld[$i][$j];
        #print "$daftarkata[$j] $pml[$i][$j]\n";
  }
  #print "------------------------------------------\n";
  
}

#--------------------------PAVG----------------------
for($j=0;$j<= $semua;$j++)
{
      for ($i =0; $i<= $#IsiDokumen;$i++)
      {
       $totalpml[$j] += $pml[$i][$j];
        
    
       #print "$daftarkata[$j] $pavg[$j] = $totalpml[$j]/$dft[$j]\n";
      }
      $pavg[$j] = $totalpml[$j] / $dft[$j];
     #print "$daftarkata[$j] $pavg[$j]  \n";
     # print "------------------------------------------\n";
}
@dft = ();


#-----------------------FT-------------------------
for ($i =0; $i<= $#IsiDokumen;$i++)
{
  for($j=0;$j<= $semua;$j++)
  {
    $ft[$i][$j] = $pavg[$j] * $dld[$i][$j];
    #print "$daftarkata[$j] $ft[$i][$j]\n";
  }
  #print "------------------------------------------\n";
}
@dld = ();

#-----------------------RTD-------------------------
for ($i =0; $i<= $#IsiDokumen;$i++)
{
  for($j=0;$j<= $semua;$j++)
  {
    $rtd[$i][$j] = (1/(1+$ft[$i][$j]))*(($ft[$i][$j]/(1+$ft[$i][$j]))**$daftarftotal[$i][$j]);
    #print "$daftarkata[$j] $rtd[$i][$j]\n";
  }
    #print "------------------------------------------\n";
}
@ft=();
@daftarftotal = ();

#-----------------------PTMD-------------------------
for ($i =0; $i<= $#IsiDokumen;$i++)
{
  for($j=0;$j<= $semua;$j++)
  {
    $ptmd[$i][$j] =($pml[$i][$j]**(1-$rtd[$i][$j]))*($pavg[$j]**$rtd[$i][$j]);
    if ($ptmd[$i][$j] == "")
    {
        $ptmd[$i][$j] = $smoothing[$j];
    }
    $notptmd[$i][$j] = 1-$ptmd[$i][$j];
     #print "$daftarkata[$j] $ptmd[$i][$j] \n";
    #print "$daftarkata[$j] $notptmd[$i][$j] \n";
  }
  #print "---------------------------------------------\n";
}
@rtd = ();
@pavg= ();
@smoothing = ();
@pml = ();

#-----------------------TOTALPTMD-------------------------

$x=0;
for ($i =0; $i<= $#IsiDokumen;$i++)
{
  $hasilptmd[$i] = 1;
  $hasilnotptmd[$i] =1;
  for($j=0;$j<= $semua;$j++)
  {
      for($y=0;$y<=$#pertanyaan;$y++)
      {
         #print "$daftarkata[$j] eq $pertanyaan[$y]";
        if ($daftarkata[$j] eq $pertanyaan[$y])
        {
           # print "$daftarkata[$j] eq $pertanyaan[$y]\n";
            $hasilptmd[$i] = $hasilptmd[$i]*$ptmd[$i][$j];
             # print "$hasilptmd[$i]= $hasilptmd[$i]*$ptmd[$i][$j]\n";
             # last;
        }
         if ($daftarkata[$j] ne $pertanyaan[$y])
        {
          $x=1;
            # print "$daftarkata[$j] ------ $pertanyaa n[$y]\n";
            # $hasilnotptmd[$i] = $hasilnotptmd[$i]*$notptmd[$i][$j];
             # print "$hasilnotptmd[$i] = $hasilnotptmd[$i]*$notptmd[$i][$j]\n";
             # last;
        }
        
      } 
      if ($x == 1){
        $hasilnotptmd[$i] = $hasilnotptmd[$i]*$notptmd[$i][$j];
        }
      $x =0;
      
  }
  # print "------\n";
# print "Dok $i $hasilnotptmd[$i]\n";
$hhasilnotptmd[$i] = $hasilnotptmd[$i];
$hhasilptmd[$i] = $hasilptmd[$i];
}
@hasilnotptmd = ();
@hasilptmd = ();
@daftarkata = ();

for ($i = 0; $i <= $#juduldok ; $i++) {
  # chomp;
  $juduldok[$i] =~ s/Tematik1\///;
  $juduldok[$i] =~ s/.txt//;
}  




$z = 0;
for ($i =0; $i<= $#isiDokumen;$i++)
{
   # $dokkk[$i] = "dokumen"." ".$i;
   $hasil[$i] = $hhasilnotptmd[$i] * $hhasilptmd[$i];
   $akhir{$juduldok[$i]} = $hasil[$i];
   $isii{$juduldok[$i]} = $IsiDokumen[$i];
   $judull{$juduldok[$i]} = $JudulDokumen[$i];
   # print "$isidokumenca[$i]\n";
   # print "caca $i = $hhasilptmd[$i] \n";
   # print "cacaaaaa $i $hasil[$i]\n";
  }
  
    foreach $juduldok (sort{$akhir{$b}<=>$akhir{$a}}keys %akhir)
    {
      {
        if ($z <=44){
          $tampjudul[$z] = $juduldok ;
          print "DOK   : $juduldok  , RELEVANCE : $akhir{$juduldok}\n";
          print "Judul : $judull{$juduldok}\n";         
          print "Isi   : $isii{$juduldok}\n";   
          print "-----------------------------------------------------------------------------\n";
         
          $tampisi[$z] = $isii{$juduldok};
          $tempjudul[$z] = $judull{$juduldok};
          $z += 1;      
        }
      }
    }
    
    
    
    
deldir("hasiltematikLM"); # or deldir($ARGV[0]) to make it commandline
 
sub deldir {
  my $dirtodel = pop;
  my $sep = '\\'; #change this line to "/" on linux.
  opendir(DIR, $dirtodel);
  my @files = readdir(DIR);
  closedir(DIR);
 
  @files = grep { !/^\.{1,2}/ } @files;
  @files = map { $_ = "$dirtodel$sep$_"} @files;
 
  @files = map { (-d $_)?deldir($_):unlink($_) } @files;
 
  rmdir($dirtodel);
}

mkdir 'hasiltematikLM';
    

for($i=0; $i<=$#tampjudul;$i++) {
        
          $file = $tampjudul[$i]. "." ."txt";
          #print "$file\n";
          open output,">hasiltematikLM/$file" or die "Can't open the output file!"; 
          print output "<judul>$tampjudul[$i]</judul>\n";
          print output "<isi>$tampisi[$i]</isi>\n";
}
close (output);




