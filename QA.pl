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
      # print "$katatanyaunigram $frekuensitanyaunigram{$katatanyaunigram}\n";
       $y++;
       $xy++;
      }
    }
}

my $dir = 'hasiltematikLM';
foreach my $fp (glob("$dir/*.txt")) {
# print "$fp\n";
push(@namadokVSM, $fp);
open my $fh, "<", $fp or die "can't read open '$fp': $OS_ERROR";
while (<$fh>) {
	chomp;   
        push(@judulVSM, $_);
        push(@isiVSM,$_);
	}
	  close $fh or die "can't read close '$fp': $OS_ERROR";
}


$paTemp = scalar(@judulVSM);
for ($i = 0; $i < $paTemp; $i++)
{
	if ($judulVSM[$i] =~ /^<judul>/)
	{
		$sJudulVSM[$i] = $judulVSM[$i];
	}
	
}
open (JUDUL , ">judulVSM.txt") or die "error";
for ($i = 0; $i < $paTemp ; $i++) {
  print JUDUL "$sJudulVSM[$i]\n" if ($sJudulVSM[$i] =~ /\w/);
}
close(JUDUL);
open (JUDUL , "judulVSM.txt") or die "error";
while(<JUDUL>)
{
         chomp;
         s/<judul>/ /gi;
         s/<\/judul>/ /gi;
         push(@jVSM,$_);
         s/[\.!,?"\/><)(';:\-]//gi;     #Menghilangkan tanda baca, ganti spasi
         s/^\s+//gi;
         s/\s+$//gi;
         s/\s+/ /gi; 
         s/\s+/ /gi;   
         s/\n+//gi;
         s/ô//gi;
         s/ö//gi;
         s/$char_1/$char_1_r/;
         s/$char_2/$char_2_r/;
	 s/$char_3/$char_3_r/;
	 s/$char_4/$char_4_r/;
	 s/$char_5/$char_5_r/;
         push(@JudulDokumenVSM, $_);
}
close(JUDUL);


for ($i = 0; $i <= $#isiVSM; $i++)
{
	if ($isiVSM[$i] =~ /^<isi>/)
	{
		$sIsiVSM[$i] = $isiVSM[$i];
	}
}	


open (ISI , ">isiVSM.txt") or die "error";
for ($i = 0; $i <= $#isiVSM ; $i++) {
  print ISI "$sIsiVSM[$i]\n" if ($sIsiVSM[$i] =~ /\w/);
}
close(ISI);

open (ISI , "isiVSM.txt") or die "error";
while(<ISI>)
{
         chomp;
         s/<isi>/ /gi;
         s/<\/isi>/ /gi;
         push(@iVSM,$_);
         s/[\.!,?"\/><)(';:\-]//gi;     #Menghilangkan tanda baca, ganti spasi
         s/^\s+//gi;
         s/\s+$//gi; 
         s/\n+//gi;
         s/ö//gi;
         s/ô//gi;
         s/$char_1/$char_1_r/;
	 s/$char_2/$char_2_r/;
	 s/$char_3/$char_3_r/;
	 s/$char_4/$char_4_r/;
	 s/$char_5/$char_5_r/;
         push(@IsiDokumenVSM, $_);
}
close(ISI);
for($i=0;$i<=$#IsiDokumenVSM;$i++)
{

 # print "$IsiDokumenVSM[$i]\n";
  
}	

$y = 0;
$z=0;
$csVSM=0;

open(VSM, '>VSM.txt') or die "error ";
foreach my $VSM (@IsiDokumenVSM)		#ambil isi tiap dok
{
        @VSMs = "";
        $VSM =~ tr/A-Z/a-z/;			#preproccesing
        $VSM =~ tr/#$%^@&*|[].,:;!?"\/(){}<+>//d;
        $VSM =~ tr/'\\'//d;
        $VSM =~ tr/0-9//d;
        $VSM =~ s/\n/ /gm;
        $VSM =~ s/\s\s+/ /gm;
        @VSMs = split(/\s+/, $VSM );	#split by space
        # print "@VSMs \n";
        
        for ($i=0; $i <= $#VSMs; $i++)
        { 
            #print "$VSMs[$i]\n";
            if (!exists($VSMs[$i]))
              {
                $frekuensiVSM{$VSMs[$i]}= 1;
              }
            else
              {
                $frekuensiVSM{$VSMs[$i]}++;
              }
         }

$batasKataVSM[$y] = $i;               	        #batas kata perdokumen
                                        #lopp array baras dokumen
# print "$batasKata[$y]\n";
# print "dld dokumen $y = $batasKata[$y]\n";    #dld total frekuensi per dokumen			 
$z = 0;                                        #batas loop array  

  foreach $VSMs (sort{$a cmp $b}keys %frekuensiVSM)
  {
    if ($VSMs  =~ /\w/ ){
      print VSM "$VSMs". "," ."$frekuensiVSM{$VSMs}\n";
      $z += 1;
    }
  }
$batasVSMSorted[$y] = $z;
$y += 1;
  push (@daftarVSM , @VSMs);
  @VSMs = "";
  %frekuensiVSM = "";
}


for ($i=0;$i<=$#IsiDokumenVSM;$i++)
{
  $csVSM += $batasKataVSM[$i];
  $dldVSM[$i] += $batasKataVSM[$i]; # JUMLAH TOKEN DI SELURUH DOKUMEN
}
close(VSM);

for ($i = 0 ; $i <= $#daftarVSM; $i++) {
    #print "$daftarVSM[$i]\n";
    if (!exists($daftarVSM[$i]))
      {
        $fVSM{$daftarVSM[$i]} = 1;
      }
    else
      {
        $fVSM{$daftarVSM[$i]}++;
      }
}
$i=0;
foreach $daftarVSM (sort{$a cmp $b}keys %fVSM){
    $sortdaftarVSM[$i] = $daftarVSM;
    $i++; 
}




open(VSM, 'VSM.txt') or die "error ";
while(<VSM>)
{
    chomp;
    push(@kataVSM, $_);
}
close(VSM);
for ($i = 0; $i <= $#kataVSM; $i++)
{
	@kataVSMs = split /,/, $kataVSM[$i];              #split by koma
	$KataVSM[$i] = $kataVSMs[0];                      #indeks 0 kata
	$fKataVSM[$i] = $kataVSMs[1];
       #print "$KataVSM[$i] $fKataVSM[$i] \n";
}
@kataVSMs= ();
@kataVSM = ();

$z =0;

for ($i = 0 ;$i <= $#batasVSMSorted;$i++)
{     
      # print "$batasKataVSM[$i]\n";
      $batas = $batasVSMSorted[$i] if ($i == 0);
      $batas = $batas + $batasVSMSorted[$i] if ($i != 0);
      #print "$z\n";
      for ($z; $z< $batas ; $z++)
      {
          # print "$KataVSM[$z] KataVSM[$z]\n";
          #print "$KataVSM[$z]\n";
          for ($y=0 ; $y <= $#sortdaftarVSM ; $y++)
          {
             #print "$sortdaftarVSM[$y]==========$KataVSM[$z] \n";
              if($sortdaftarVSM[$y] eq $KataVSM[$z])
              {
                $daftarVSMs[$i][$y] = $fKataVSM[$z];
                last;
              }              
          }
      #print "$sortdaftarVSM[$z] $daftarVSMs[$i][$y]\n"; 
     
      }
       $z=$batas;
}
@fKataVSM = ();
@KataVSM = ();

for ($y=0 ; $y <= $#sortdaftarVSM ; $y++)
{
      for ($xyx=0 ; $xyx <= $#pertanyaan ; $xyx++)
              { 
                #print "($sortdaftarVSM[$y] eq $pertanyaan[$xyx])\n";
                         if($sortdaftarVSM[$y] eq $pertanyaan[$xyx])
                    {
                        $KueriVSM[$y] = $frekuensitanyaunigram{$sortdaftarVSM[$y]};
                       #print "($sortdaftarVSM[$y] eq $pertanyaan[$xyx] $KueriVSM[$y] = $frekuensitanyaunigram{$sortdaftarVSM[$y]}\n;";
                    }
              }
      #print "$sortdaftarVSM[$y] $KueriVSM[$y]\n";
}



for ($i =0; $i<= $#IsiDokumenVSM;$i++)
{
      for($j = 0;$j<= $#sortdaftarVSM;$j++)
      {
            if ($daftarVSMs[$i][$j] == "")
            {
              $daftarVSMs[$i][$j] =0;
            }
            #print "$sortdaftarVSM[$j] $daftarVSMs[$i][$j] \n";
            if ($KueriVSM[$j] == "")
            {
              $KueriVSM[$j] = 0;
            }
           # print "$sortdaftarVSM[$j] $KueriVSM[$j]\n";
            
      }
      #print "-----------------\n";
}

#-----------------------------term VSM-----------------------
for ($i =0; $i<= $#IsiDokumenVSM;$i++)
{
  for($j=0;$j<= $#sortdaftarVSM;$j++)
  {
    $daftarfVSMtotal[$i][$j] = $daftarVSMs[$i][$j];
    $daftarkataVSM[$j] = $sortdaftarVSM[$j];
   #print "$daftarkataVSM[$j] $daftarfVSMtotal[$i][$j]\n";
  }
#print "--------------------\n";
}


#------------------------dft VSM-------------------
for($j=0;$j<= $#sortdaftarVSM;$j++)
{
      for ($i =0; $i<= $#IsiDokumenVSM;$i++)
      {
        if ($daftarVSMs[$i][$j] ne 0)
        {
        $dftVSM[$j] += 1;
        $idf[$j] = -1*log2((($dftVSM[$j]+1)/($#IsiDokumenVSM+1)));
        #$idf[$j] = -1*log2((($dftVSM[$j]+1)/(4)));
        } 
        }
      #print "$daftarkataVSM[$j] $dft[$j]\n";
      #print "$daftarkataVSM[$j] $idf[$j]\n";  
}
@dftVSM = ();

#-------------------BOBOT VSM( tf idf )-----------------
$jumlahdokkueri = 0;
for ($i =0; $i<= $#IsiDokumenVSM;$i++)
{
  for($j=0;$j<= $#sortdaftarVSM;$j++)
  {
    $bobotVSM[$i][$j] =   $daftarfVSMtotal[$i][$j]*$idf[$j];   
    #print "$daftarkataVSM[$j] $bobotVSM[$i][$j]\n";
    $wkuadrat[$i] += ($bobotVSM[$i][$j]**2);
    $hasilwkuadrat[$i] = sqrt($wkuadrat[$i]);
    
    if ($KueriVSM[$j] != 0 )
    {
	$spectVSM[$i][$j] = $bobotVSM[$i][$j] * $idf[$j];
	 $variabelVSM[$i][$j] = 2.71828+$spectVSM[$i][$j];
	$WT[$i][$j] = 1-(1/(ln($variabelVSM[$i][$j])));
	$WTOTAL[$i] += $WT[$i][$j];
      #print "$daftarkataVSM[$j] $WT[$i]\n";
    }
   
  
  }
  #print "$hasilwkuadrat[$i] \n";
   print "--------------\n";
   
}
@daftarfVSMtotal = ();


$jumlahdokkueri = 0;
for($kkk = 0;$kkk<=$jumlahdokkueri;$kkk++)
{
for($j=0;$j<= $#sortdaftarVSM;$j++)
{
    $bobotKueriVSM[$j] = $KueriVSM[$j]*$idf[$j];
    $wkuadratkueri[$kkk] +=($bobotKueriVSM[$j]**2) ;
    $hasilwkuadratkueri[$kkk] = sqrt($wkuadratkueri[$kkk]);  
    
}
}
@idf = ();
@KueriVSM = ();



 #print "$hasilwkuadratkueri[$jumlahdokkueri]\n";
#------------------NORMALISASI COSINE------------------------
for ($i =0; $i<= $#IsiDokumenVSM;$i++)
{
  for($j=0;$j<= $#sortdaftarVSM;$j++)
  {
    $normalisasicosine[$i][$j] = $bobotVSM[$i][$j] /$hasilwkuadrat[$i];
    $normalisasikuadrat[$i]+= ($normalisasicosine[$i][$j] **2);
    $pjgvektor[$i] = sqrt($normalisasikuadrat[$i]);
    #print "$daftarkataVSM[$j] $normalisasicosine[$i][$j]\n";
    #print "$daftarkataVSM[$j] $normalisasikuadrat[$i][$j]\n";
    #print "$pjgvektor[$i] = sqrt($normalisasikuadrat[$i][$j])\n";
  }
  #print "$pjgvektor[$i]\n";
}
@bobotVSM = ();
@hasilwkuadrat= ();
for($kkk = 0;$kkk<=$jumlahdokkueri;$kkk++)
{
for($j=0;$j<= $#sortdaftarVSM;$j++)
{
    $normalisasikueri[$j] = $bobotKueriVSM[$j] / $hasilwkuadratkueri[$kkk];
    $normalisasikuerikuadrat[$kkk] += ($normalisasikueri[$j]**2);
    $pjgvektorkueri [$kkk] = sqrt($normalisasikuerikuadrat[$kkk]); 
}
}
#print "$pjgvektorkueri[$jumlahdokkueri]\n";


#-----------------------------Similarity----------------------------
for ($i =0; $i<= $#IsiDokumenVSM;$i++)
{
  for($j=0;$j<= $#sortdaftarVSM;$j++)
{
      if ($normalisasikueri[$j] != 0)
      {
            $sim[$i][$j] = $normalisasicosine[$i][$j] * $normalisasikueri[$j];
            #print "$daftarkataVSM[$j] $sim[$i][$j]\n";
            $simii[$i]+= $sim[$i][$j];
      }
      
     
     
      
}
$relevanceVSM[$i] = $simii[$i] / ($pjgvektor[$i]*$pjgvektorkueri[$jumlahdokkueri]);
# print "\n";
# print " $simii[$i]\n";
#print " $relevanceVSM[$i]\n";
}



#-------------------------------------------------------------------------------GEO---------------------------------------------------------------------------------------

print "--------------------------------\n";


my $dir = 'Geo';
foreach my $fp (glob("$dir/*.txt")) {
# print "$fp\n";
push(@namadokGEO, $fp);
open my $fh, "<", $fp or die "can't read open '$fp': $OS_ERROR";
while (<$fh>) {
	chomp;   
        push(@judulGEO, $_);
        push(@isiGEO,$_);
	}
	  close $fh or die "can't read close '$fp': $OS_ERROR";
}


$paTemp = scalar(@judulGEO);
for ($i = 0; $i < $paTemp; $i++)
{
	if ($judulGEO[$i] =~ /^<judul>/)
	{
		$sJudulGEO[$i] = $judulGEO[$i+1];
	}
	
}
open (JUDUL , ">judulGEO.txt") or die "error";
for ($i = 0; $i < $paTemp ; $i++) {
  print JUDUL "$sJudulGEO[$i]\n" if ($sJudulGEO[$i] =~ /\w/);
}
close(JUDUL);

open (JUDUL , "judulGEO.txt") or die "error";
while(<JUDUL>)
{
         chomp;
         s/<judul>/ /gi;
         s/<\/judul>/ /gi;
         push(@jGEO, $_);
         s/[\.!,?"\/><)(';:\-]//gi;     #Menghilangkan tanda baca, ganti spasi
         s/^\s+//gi;
         s/\s+$//gi;
         s/\s+/ /gi; 
         s/\s+/ /gi;   
         s/\n+//gi;
         s/ô//gi;
         s/ö//gi;
         s/$char_1/$char_1_r/;
         s/$char_2/$char_2_r/;
	 s/$char_3/$char_3_r/;
	 s/$char_4/$char_4_r/;
	 s/$char_5/$char_5_r/;
         push(@JudulDokumenGEO, $_);
}
close(JUDUL);

for ($i = 0; $i <= $#isiGEO; $i++)
{
	if ($isiGEO[$i] =~ /^<isi>/)
	{
		$sIsiGEO[$i] = $isiGEO[$i+1];
	}
}	


open (ISI , ">isiGEO.txt") or die "error";
for ($i = 0; $i <= $#isiGEO ; $i++) {
  print ISI "$sIsiGEO[$i]\n" if ($sIsiGEO[$i] =~ /\w/);
}
close(ISI);

open (ISI , "isiGEO.txt") or die "error";
while(<ISI>)
{
         chomp;
         s/<isi>/ /gi;
         s/<\/isi>/ /gi;
         push(@iGEO,$_);
         s/[\.!,?"\/><)(';:\-]//gi;     #Menghilangkan tanda baca, ganti spasi
         s/^\s+//gi;
         s/\s+$//gi; 
         s/\n+//gi;
         
         s/ö//gi;
         s/ô//gi;
         s/$char_1/$char_1_r/;
	 s/$char_2/$char_2_r/;
	 s/$char_3/$char_3_r/;
	 s/$char_4/$char_4_r/;
	 s/$char_5/$char_5_r/;
         push(@IsiDokumenGEO, $_);
}
close(ISI);

for($i=0;$i<=$#IsiDokumenGEO;$i++)
{

  #print "$IsiDokumenGEO[$i]\n";
  
}	

$y = 0;
$z=0;
$csGEO=0;

open(GEO, '>GEO.txt') or die "error ";
foreach my $GEO (@IsiDokumenGEO)		#ambil isi tiap dok
{
        @GEOs = "";
        $GEO =~ tr/A-Z/a-z/;			#preproccesing
        $GEO =~ tr/#$%^@&*|[].,:;!?"\/(){}<+>//d;
        $GEO =~ tr/'\\'//d;
        $GEO =~ tr/0-9//d;
        $GEO =~ s/\n/ /gm;
        $GEO =~ s/\s\s+/ /gm;
        @GEOs = split(/\s+/, $GEO );	#split by space
        # print "@GEOs \n";
        
        for ($i=0; $i <= $#GEOs; $i++)
        { 
            #print "$GEOs[$i]\n";
            if (!exists($GEOs[$i]))
              {
                $frekuensiGEO{$GEOs[$i]}= 1;
              }
            else
              {
                $frekuensiGEO{$GEOs[$i]}++;
              }
         }

$batasKataGEO[$y] = $i;               	        #batas kata perdokumen
                                        #lopp array baras dokumen
# print "$batasKata[$y]\n";
# print "dld dokumen $y = $batasKata[$y]\n";    #dld total frekuensi per dokumen			 
$z = 0;                                        #batas loop array  

  foreach $GEOs (sort{$a cmp $b}keys %frekuensiGEO)
  {
    if ($GEOs  =~ /\w/ ){
      print GEO "$GEOs". "," ."$frekuensiGEO{$GEOs}\n";
      $z += 1;
    }
  }
$batasGEOSorted[$y] = $z;
$y += 1;
  push (@daftarGEO , @GEOs);
  @GEOs = "";
  %frekuensiGEO = "";
}



for ($i=0;$i<=$#IsiDokumenGEO;$i++)
{
  $csGEO += $batasKataGEO[$i];
  $dldGEO[$i] += $batasKataGEO[$i]; # JUMLAH TOKEN DI SELURUH DOKUMEN
}
close(GEO);

for ($i = 0 ; $i <= $#daftarGEO; $i++) {
    #print "$daftarGEO[$i]\n";
    if (!exists($daftarGEO[$i]))
      {
        $fGEO{$daftarGEO[$i]} = 1;
      }
    else
      {
        $fGEO{$daftarGEO[$i]}++;
      }
}
$i=0;
foreach $daftarGEO (sort{$a cmp $b}keys %fGEO){
    $sortdaftarGEO[$i] = $daftarGEO;
    $i++; 
}




open(GEO, 'GEO.txt') or die "error ";
while(<GEO>)
{
    chomp;
    push(@kataGEO, $_);
}
close(GEO);
for ($i = 0; $i <= $#kataGEO; $i++)
{
	@kataGEOs = split /,/, $kataGEO[$i];              #split by koma
	$KataGEO[$i] = $kataGEOs[0];                      #indeks 0 kata
	$fKataGEO[$i] = $kataGEOs[1];
       # print "$KataGEO[$i] $fKataGEO[$i] \n";
}
@kataGEOs= ();
@kataGEO = ();

$z =0;

for ($i = 0 ;$i <= $#batasGEOSorted;$i++)
{     
      # print "$batasKataGEO[$i]\n";
      $batas = $batasGEOSorted[$i] if ($i == 0);
      $batas = $batas + $batasGEOSorted[$i] if ($i != 0);
      #print "$z\n";
      for ($z; $z< $batas ; $z++)
      {
          # print "$KataGEO[$z] KataGEO[$z]\n";
          #print "$KataGEO[$z]\n";
          for ($y=0 ; $y <= $#sortdaftarGEO ; $y++)
          {
             #print "$sortdaftarGEO[$y]==========$KataGEO[$z] \n";
              if($sortdaftarGEO[$y] eq $KataGEO[$z])
              {
                $daftarGEOs[$i][$y] = $fKataGEO[$z];
                last;
              }              
          }
      #print "$sortdaftarGEO[$z] $daftarGEOs[$i][$y]\n"; 
     
      }
       $z=$batas;
}
@fKataGEO = ();
@KataGEO = ();

for ($y=0 ; $y <= $#sortdaftarGEO ; $y++)
{
  # print "$sortdaftarGEO[$y]\n";
      for ($xyx=0 ; $xyx <= $#pertanyaan ; $xyx++)
              { 
               # print "($sortdaftarGEO[$y] eq $pertanyaan[$xyx]) $frekuensitanyaunigram{$sortdaftarGEO[$y]}\n";
                         if($sortdaftarGEO[$y] eq $pertanyaan[$xyx])
                    {
                        $KueriGEO[$y] = $frekuensitanyaunigram{$pertanyaan[$xyx]};
                      # print "$sortdaftarGEO[$y] eq $pertanyaan[$xyx] = $frekuensitanyaunigram{$pertanyaan[$xyx]}\n;";
                    }
              }
     # print "$sortdaftarGEO[$y] $KueriGEO[$y]\n";
}
%frekuensitanyaunigram = ();


for ($i =0; $i<= $#IsiDokumenGEO;$i++)
{
      for($j = 0;$j<= $#sortdaftarGEO;$j++)
      {
            if ($daftarGEOs[$i][$j] == "")
            {
              $daftarGEOs[$i][$j] =0;
            }
            #print "$sortdaftarGEO[$j] $daftarGEOs[$i][$j] \n";
            if ($KueriGEO[$j] == "")
            {
              $KueriGEO[$j] = 0;
            }
           #print "$sortdaftarGEO[$j] $KueriGEO[$j]\n";
            
      }
     # print "-----------------\n";
}

#-----------------------------term GEO-----------------------
for ($i =0; $i<= $#IsiDokumenGEO;$i++)
{
  for($j=0;$j<= $#sortdaftarGEO;$j++)
  {
    $daftarfGEOtotal[$i][$j] = $daftarGEOs[$i][$j];
    $daftarkataGEO[$j] = $sortdaftarGEO[$j];
   #print "$daftarkataGEO[$j] $daftarfGEOtotal[$i][$j]\n";
  }
#print "--------------------\n";
}

$cs = 0;
#------------------------dft GEO-------------------
for($j=0;$j<= $#sortdaftarGEO;$j++)
{
      for ($i =0; $i<= $#IsiDokumenGEO;$i++)
      {
        if ($daftarGEOs[$i][$j] ne 0)
        {
        $dftGEO[$j] += 1;
         $idf[$j] = -1*log2((($dftGEO[$j]+1)/($#IsiDokumenGEO+1)));
        # #$idf[$j] = -1*log2((($dftGEO[$j]+1)/(4)));
        $cs += $dftGEO[$j];
        } 
        }
      #print "$daftarkataGEO[$j] $dftGEO[$j]\n";
      #print "$daftarkataGEO[$j] $idf[$j]\n";  
}
@dft = ();
@wkuadrat = ();

for ($i =0; $i<= $#IsiDokumenGEO;$i++)
{
  for($j=0;$j<= $#sortdaftarGEO;$j++)
  {
        if($KueriGEO[$j] != 0 )
        {
        $specg[$i][$j] = -1*(log2(($KueriGEO[$j]/$#IsiDokumenGEO))); 
         $variabelG[$i][$j] = 2.71828+$spectg[$i][$j];
        $WG[$i][$j] =1-(1/(ln($variabelG[$i][$j])));
        $WGTOTAL[$i] += $WG[$i][$j]; 
       #print "$daftarkataGEO[$j] $specg[$i][$j]\n";
	}
	
      }
      #print "$WGTOTAL[$i]\n";
     print "-----------------\n";
}

#-------------------BOBOT GEO( tf idf )-----------------
for ($i =0; $i<= $#IsiDokumenGEO;$i++)
{
  for($j=0;$j<= $#sortdaftarGEO;$j++)
  {
    $bobotGEO[$i][$j] =   $daftarfGEOtotal[$i][$j]*$idf[$j];   
    #print "$daftarkataGEO[$j] $bobotGEO[$i][$j]\n";
    $wkuadrat[$i] += ($bobotGEO[$i][$j]**2);
    $hasilwkuadratGEO[$i] = sqrt($wkuadrat[$i]);
  
  }
  #print "$hasilwkuadratGEO[$i] \n";
   #print "--------------\n";
}
@daftarfGEOtotal = ();


$jumlahdokkueri = 0;
for($kkk = 0;$kkk<=$jumlahdokkueri;$kkk++)
{
for($j=0;$j<= $#sortdaftarGEO;$j++)
{
    $bobotKueriGEO[$j] = $KueriGEO[$j]*$idf[$j];
    $wkuadratkueriGEO[$kkk] +=($bobotKueriGEO[$j]**2) ;
    $hasilwkuadratkueriGEO[$kkk] = sqrt($wkuadratkueriGEO[$kkk]);  
    
   
}
#print $hasilwkuadratkueriGEO[$kkk];
}



 #print "$hasilwkuadratGEOkueri[$jumlahdokkueri]\n";
#------------------NORMALISASI COSINE------------------------
for ($i =0; $i<= $#IsiDokumenGEO;$i++)
{
  #print "-----------------\n";
  for($j=0;$j<= $#sortdaftarGEO;$j++)
  {
    $normalisasicosineGEO[$i][$j] = $bobotGEO[$i][$j] /$hasilwkuadratGEO[$i];
    $normalisasikuadratGEO[$i] += ($normalisasicosineGEO[$i][$j] **2);
    $pjgvektorGEO[$i] = sqrt($normalisasikuadratGEO[$i]);
    
    # print "$daftarkataGEO[$j] $normalisasicosineGEO[$i][$j]\n";
   # print "$daftarkataGEO[$j] $normalisasikuadratGEO[$i]\n";
    #print "$pjgvektorGEO[$i] = sqrt($normalisasikuadratGEO[$i][$j])\n";
  }
  #print "$normalisasikuadratGEO[$i]\n";
  #print "$pjgvektorGEO[$i]\n";
}
@bobotGEO = ();
@hasilwkuadratGEO= ();

for($kkk = 0;$kkk<=$jumlahdokkueri;$kkk++)
{
for($j=0;$j<= $#sortdaftarVSM;$j++)
{
    $normalisasikueriGEO[$j] = $bobotKueriGEO[$j] / $hasilwkuadratkueriGEO[$kkk];
    $normalisasikuerikuadratGEO[$kkk] += ($normalisasikueriGEO[$j]**2);
    $pjgvektorkueriGEO [$kkk] = sqrt($normalisasikuerikuadratGEO[$kkk]); 
}
}
#-----------------------------Similarity----------------------------
for ($i =0; $i<= $#IsiDokumenGEO;$i++)
{
  for($j=0;$j<= $#sortdaftarGEO;$j++)
{
	# print "$daftarkataGEO[$j] $normalisasikueriGEO[$j]\n";
      if ($normalisasikueriGEO[$j] != 0)
      {
            $sim[$i][$j] = $normalisasicosineGEO[$i][$j] * $normalisasikueriGEO[$j];
            #print "$daftarkataGEO[$j] $sim[$i][$j]\n";
            $simiiGEO[$i]+= $sim[$i][$j];
      }
     
  
}
$relevanceGEO[$i] =  $simiiGEO[$i]/ ($pjgvektorGEO[$i]*$pjgvektorkueri[$jumlahdokkueri]);
# print "\n";
# print " $simiiGEO[$i]\n";
#print " $relevanceGEO[$i]\n";
}

if ($#IsiDokumenGEO >= $#IsiDokumenVSM)
{$loop = $#IsiDokumenGEO;
}
else
{
$loop = $#IsiDokumenVSM;
}



for ($i = 0;$i<=$#namadokVSM;$i++)
{
   $namadokVSM[$i] =~ s/hasiltematikLM\///;
   $namadokVSM[$i] =~ s/.txt//;
   #print "$namadokVSM[$i]\n";
}
for ($i = 0;$i<=$#namadokGEO;$i++)
{
   $namadokGEO[$i] =~ s/Geo\///;
   $namadokGEO[$i] =~ s/.txt//;
   #print "$namadokGEO[$i]\n";
}


    
deldir("hasiltematik"); # or deldir($ARGV[0]) to make it commandline
mkdir 'hasiltematik';

deldir("hasilgeo"); # or deldir($ARGV[0]) to make it commandline
mkdir 'hasilgeo';

if ($#IsiDokumenGEO >= $#IsiDokumenVSM)
{
 $loop = $#IsiDokumenGEO;
 $loop2 = $#IsiDokumenVSM;
}
else
{
 $loop = $#IsiDokumenVSM;
 $loop2 = $#IsiDokumenGEO;
}
$countercek = 0;
$minim1 = 0;
$minim2 = 0;
$minim3 = 0;
$minim4 = 0;
$minim5 = 0;
for ($i = 0; $i<= $#IsiDokumenVSM;$i++)
{
  for ($j = 0; $j<=$#IsiDokumenGEO;$j++)
  {
   #print "($namadokVSM[$i] eq $namadokGEO[$j])\n";
  if($namadokVSM[$i] eq $namadokGEO[$j])
  {
        
	$dok = $i+1;
	$relevanceakhir[$i] = $WTOTAL[$i] * $relevanceVSM[$i] + $WGTOTAL[$i] * $relevanceGEO[$i];
	
	
	
	
	
	
	#print "$relevanceakhir[$i] = $WTOTAL[$i] * $relevanceVSM[$i] + $WGTOTAL[$i] * $relevanceGEO[$i]\n";
	#print "$namadokVSM[$i] $relevanceakhir[$i]\n";
	
	if($relevanceakhir[$i] != 0)
	{
	# print "$file $relevanceakhir[$i] \n";
	
	

	#$cekgeo[$countercek] = $namadokGEO[$j];
	
	$countercek++;
	last;
	}
	}
  }
}
for ($i=0;$i<=$#relevanceakhir;$i++)
{
        if ($relevanceakhir[$i] > $minim1 && $relevanceakhir[$i] !=0 )
	{
          $relevance1 = $i;
          $minim1 = $relevanceakhir[$i];
	}
}
for ($i=0;$i<=$#relevanceakhir;$i++)
{
        if ($relevanceakhir[$i] > $minim2 && $i != $relevance1 && $relevanceakhir[$i] !=0 )
	{
          $relevance2 = $i;
          $minim2 = $relevanceakhir[$i];
	}
}
for ($i=0;$i<=$#relevanceakhir;$i++)
{
        if ($relevanceakhir[$i] > $minim3 && $i != $relevance1 && $i != $relevance2 && $relevanceakhir[$i] !=0 )
	{
          $relevance3 = $i;
          $minim3 = $relevanceakhir[$i];
	}
}
for ($i=0;$i<=$#relevanceakhir;$i++)
{
        if ($relevanceakhir[$i] > $minim4 && $i != $relevance1 && $i != $relevance2 && $i != $relevance3 && $relevanceakhir[$i] !=0 )
	{
          $relevance4 = $i;
          $minim4 = $relevanceakhir[$i];
	}
}
for ($i=0;$i<=$#relevanceakhir;$i++)
{
        if ($relevanceakhir[$i] > $minim5 && $i != $relevance1 && $i != $relevance2 && $i != $relevance3 && $i != $relevance4  && $relevanceakhir[$i] !=0 )
	{
          $relevance5 = $i;
          $minim5 = $relevanceakhir[$i];
	}
}

for ($i = 0;$i<5;$i++)
{
  if ($i == 0)
  {
      $namafile[$i] = $namadokVSM[$relevance1];
      $judulfileVSM[$i] = $jVSM[$relevance1];
      $isifileVSM[$i] = $iVSM[$relevance1];
      
      $judulfileGEO[$i] = $jGEO[$relevance1];
      $isifileGEO[$i] = $iGEO[$relevance1];
      
  }
  if ($i == 1)
  {
       $namafile[$i] = $namadokVSM[$relevance2];
       $judulfileVSM[$i] = $jVSM[$relevance2];
       $isifileVSM[$i] = $iVSM[$relevance2];
             
      $judulfileGEO[$i] = $jGEO[$relevance2];
      $isifileGEO[$i] = $iGEO[$relevance2];
  }
   if ($i == 2)
  {
       $namafile[$i] = $namadokVSM[$relevance3];
       $judulfileVSM[$i] = $jVSM[$relevance3];
       $isifileVSM[$i] = $iVSM[$relevance3];
             
      $judulfileGEO[$i] = $jGEO[$relevance3];
      $isifileGEO[$i] = $iGEO[$relevance3];
  }
   if ($i == 3)
  {
       $namafile[$i] = $namadokVSM[$relevance4];
       $judulfileVSM[$i] = $jVSM[$relevance4];
       $isifileVSM[$i] = $iVSM[$relevance4];
             
      $judulfileGEO[$i] = $jGEO[$relevance4];
      $isifileGEO[$i] = $iGEO[$relevance4];
  }
   if ($i == 4)
  {
       $namafile[$i] = $namadokVSM[$relevance5];
       $judulfileVSM[$i] = $jVSM[$relevance5];
       $isifileVSM[$i] = $iVSM[$relevance5];
      
       $judulfileGEO[$i] = $jGEO[$relevance5];
       $isifileGEO[$i] = $iGEO[$relevance5];
  }
}

print "============================================\n";
for($i=0;$i<=$#namafile;$i++)
{
    $cekgeo[$i] = $namafile[$i];
    print "=====$cekgeo[$i]=====\n";
    
    $file = $namafile[$i]. "." ."txt";
    open output,">hasiltematik/$file" or die "Can't open the output file!";
    print output "$judulfileVSM[$i]\n\n";
    print output "$isifileVSM[$i]\n";
    close(output);
    $filegeo = $namafile[$i]. "." . "txt";
    open output,">hasilgeo/$filegeo" or die "Can't open the output file!";
    print output "$judulfileGEO[$i]\n\n";
    print output "$isifileGEO[$i]\n";
    close(output);
}
 

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

sub log2 {
   my $n = shift;
   return log($n)/log(2);
}

sub ln{
   my $n = shift;
   return log($n)/log(2.71828);
}









  @noword=('berapa','apa','dimana');
open(DOC,"kueri.txt") or die "can't open";   
while(<DOC>)
{	
  	
  	for ($xb=0; $xb<=$#noword; $xb++)
	{
	tr/A-Z/a-z/;
	s/@noword[$xb]//gi;
	}
	push (@kandidatjwbn, $_);
}
close(DOC);   
#print @kandidatjwbn;
  
open(TIPE, "tipe.txt") or die "can't open";
while($tipep=<TIPE>)
{
  $tipe = $tipep;
}
close(TIPE);
print "$tipe\n\n\n";
if ($tipe eq "")
{
open(HASIL, ">hasilQA.txt") or die "can't open";
print HASIL "";	
close (HASIL);
}

else{

$pertanyaan = "<$tipe>"; 
print $pertanyaan;
$kandidat = "";

for($i=0;$i<=$#kandidatjwbn;$i++)
{
	$kandidat = $kandidat. "".$kandidatjwbn[$i];
}
print "$kandidat\n";
  
@jumlahkandidat = split(/\s+/, $kandidat );
$totalkandidat = $#jumlahkandidat +1;
# print $totalkandidat;

for ($i = 0; $i <=$#jumlahkandidat;$i++)
{
#print "$jumlahkandidat[$i]\n";
}

my $directory = 'NERQA';
foreach my $fp2 (glob("$directory/*.txt")) {
  #print "$fp2\n";
  push(@dokkueri, $fp2);
  open my $fh2, "<", $fp2 or die "can't read open '$fp': $OS_ERROR";
	while (<$fh2>) {
	  chomp;
	s/[\!,?"\)(';:\-]//gi;     #Menghilangkan tanda baca, ganti spasi
        s/^\s+//gi;
        s/\s+$//gi;
        s/\s+/ /gi;   
	
        #Split berdasarkan spasi bisa menggunakan seperti baris ini selain /s
        push(@isiNer, $_);

        

	    #print "$_ \n";
	}
	  # print "\n";
	  close $fh2 or die "can't read close '$fp': $OS_ERROR";
}




# print @isiner;
$paTemp = scalar(@isiNer);
for ($i = 0; $i < $paTemp; $i++)
{
	
	if ($isiNer[$i] =~ /^<isi>/ and $isiNer[$i] ne /\n/)
	{
		$isiNER[$i] =  $isiNer [$i+1];
		#print "$isiNER[$i]\n";
	}
}

open(JWBN, ">isiner.txt") or die "can't open";	
for ($i=0;$i<=$#isiNER;$i++)
{
	print JWBN "$isiNER[$i]\n" if ($isiNER[$i] =~ /\w/);
}
close(JWBN);

open(JWBN, "isiner.txt") or die "can't open";
while(<JWBN>)
{
	chomp;
	push (@ISINER, $_);
}
close(JWBN);

for ($i = 0; $i <= $#dokkueri; $i++)
{
    $namafileQA[$i] = $dokkueri[$i];
    $namafileQA[$i] =~ s/NERQA\///;
    $namafileQA[$i] =~ s/.txt//;
   #print "$namafileQA[$i]\n";
}
$cxcx= 0;
for($i=0;$i<=$#cekgeo;$i++)
{
  for($y=0;$y<=$#namafileQA;$y++)
  {
    if ($cekgeo[$i] eq $namafileQA[$y])
    {
     $isiner[$cxcx] = $ISINER[$y];
     $cxcx++;
    }
  }
}

for ($i = 0; $i <= $#isiner ; $i++) {
  chomp;
  @xner = 0;
  #print "$isiner[$i]\n\n";
  $isiner[$i] =~ tr/A-Z/a-z/;
   # print "$isiner[$i]\n\n";
  @passage = split(/\./, $isiner[$i]);
    for ($j = 0;$j <=$#passage;$j++)
  {
   if (($j+1) <=$#passage) {
   $passagener[$i][$xner[$i]] = $passage[$j].$passage[$j+1];
   $cacaa += 1;
   }
   else {
   $passagener[$i][$xner[$i]] = $passage[$j];
   $cacaa += 1;
   }

   #print "$passagener[$i][$xner[$i]]\n\n\n";
   $xner[$i] += 1 if(($j%2) == 0);
    $j++;
  }
  #@print "passagener[$i][$xner[$i]]\n";
  $caca[$i] =  $xner[$i];
  #print "$caca[$i]\n";
  }

open (PASSAGE, ">passage.txt") or "error";
for ($i = 0; $i <= $#isiner ; $i++) {
#print $caca[$i];
$max = 0;

for ($m = 0; $m < $caca[$i] ; $m++) {
        $penghitung = 0;
        $ckandidat = 0;
#        print "$passagener[$i][$m]\n";
        @kataca = split(/\s+/, $passagener[$i][$m]);
        for ($j = 0;$j <$#kataca;$j++)
        {

         $katacaa[$i][$m][$j] =  $kataca[$j];
#        print "$katacaa[$i][$m][$j] \n";
         $kataca[$j] = $katapen [$j];
         if ($katacaa[$i][$m][$j]  =~ /$pertanyaan/ )
         {
         $penghitung += 1;
         $hash1[$i][$m] = 5;
         #print "$kataca[$j]  =~ /<ORGANISASI>/../<\/ORGANISASI>/ $hash1[$i][$m]\n";

         }
         for ($ss = 0; $ss <=$#jumlahkandidat;$ss++)
{
         if ($jumlahkandidat[$ss] eq $katacaa[$i][$m][$j] and $katacaa[$i][$m][$j]=~ /\w/)
         {
#             print "$jumlahkandidat[$ss] =~ $katacaa[$i][$m][$j]\n ";
              $ckandidat += 1;
         }
}
        }

        if ($penghitung >1)
        {
             $hash2[$i][$m] =0.5;
        }


        if ($hash1[$i][$m] eq "" ) {
         $hash1[$i][$m] = 0;

        }
        if ( $hash2[$i][$m] eq "" ){
         $hash2[$i][$m] =0;
        }
        $hash3[$i][$m] =$ckandidat/$totalkandidat;
        $hashtolal[$i][$m] = $hash1[$i][$m] + $hash2[$i][$m] + $hash3[$i][$m];
#        print "H1 hash1[$i][$m] : $hash1[$i][$m]\n";
#        print "H2 hash2[$i][$m] : $hash2[$i][$m]\n";
#        print "H3 hash3[$i][$m] : $hash3[$i][$m]\n";
#        print "hashtolal[$i][$m] : $hashtolal[$i][$m]\n";

        if ( $hashtolal[$i][$m]>$max)
        {
         $max = $hashtolal[$i][$m];
         $tampi = $i;
         $tampm = $m;
        }
        @hash1 = 0;
        $batasca[$i][$m] = $#kataca;
#        print "batasca[$i][$m] = $batasca[$i][$m]\n";
#        print "-------------\n";

  }
  if ($max > 0){
#  print "$tampi $tampm $max\n";
#  print "$passagener[$tampi][$tampm]\n";
  print PASSAGE "$passagener[$tampi][$tampm] asdfgh";
  }
}
close (PASSAGE);


$punc = "</";

open(DOK, "passage.txt") or die "Tidak bisa membuka file.";
while(<DOK>)
{
        chomp;
	push (@aDok, $_);
}
close DOK;

foreach $var_1 (@aDok)
{
	@aTempp = split / /, $var_1;
	foreach $var_2 (@aTempp)
	{
		push (@aTemp, $var_2);
	}
}
@aDok = [];


$sTemp = "";
$a = 0;
$paTemp = scalar(@aTemp);
for ($i = 0; $i < $paTemp; $i++)
{
	if ($aTemp[$i] =~ /^</)
	{
		for ($j = $i; $j < $paTemp; $j++)
		{

			if ($aTemp[$j] =~ m/$punc/)
			{
				$sTemp = $sTemp . ' ' . $aTemp[$j];
				$aHasil[$a] = $sTemp;
				$aHasil[$a] =~ s/[~\!\@\#\$\%\^\&\*\(\)\_\+\=\{\}\[\]\;\:\'\"\,\.\\\?\--\...\|]/ /gi;
				$aHasil[$a] =~ s/^\s+|\s+$//g;
				$sTemp = "";
				#print "$aHasil[$a]\n";
				$a++;
				last;
			}
			else
			{
				if ($j == $i)
				{
					$sTemp = $aTemp[$j];
				}
				else
				{
					$sTemp = $sTemp . ' ' . $aTemp[$j];
				}
			}
		}
		$i = $j;
	}
	else
	{
		$aHasil[$a] = $aTemp[$i];
		$aHasil[$a] =~ s/[~\!\@\#\$\%\^\&\*\(\)\_\+\=\{\}\[\]\;\:\'\"\,\.\\\?\--\...\|]/ /gi;
		$aHasil[$a] =~ s/^\s+|\s+$//g;
		#print "$aHasil[$a]\n";
		$a++;
	}
}

$a=0;
for ($i=0;$i<=$#aHasil;$i++)
{
 #print "$aHasil[$i]\n";
 if ($aHasil[$i] eq "asdfgh")
 {
  $batas[$a] = $i;

 #print "$batas[$a]\n";
  $a++;
 }

}
for ($i=0;$i<=$#aHasil;$i++)
{
    $aHasil[$i] =~ s/asdfgh//gi;
}

$i = 0;
$j = 0;
$a = 0;
$min = 99999999999999999999999;
$aTemp = [];
$sTemp = "";
$i = 0;
$komala = 0;

for ($d=0; $d<=$#batas; $d++)
{
  $min = 99999999999999999999999;
  #print "$batas[$d]\n";
for($i;$i<=$batas[$d];$i++)
{

#print "$aHasil[$i]\n";
    for ($xas = 0; $xas <=$#jumlahkandidat;$xas++)
     {
 if ($aHasil[$i] =~ /$jumlahkandidat[$xas]/ and $aHasil[$i] =~ /\w/)
  {
#print "$aHasil[$i] ---- $jumlahkandidat[$xas]\n";
  for($j=0;$j<=$batas[$d];$j++)
  {
  if ($aHasil[$j] =~ /$pertanyaan/)
  {
  $x = $j- $i;
  $x = 9999999999 if($x<0);
 #print "$aHasil[$i] $x\n";
   if ($x < $min)
   {
    $min = $x;
    $index =  $j;
    $array[$komala] = $index;
   }
  }
  }
  #print "$i\n";
 }
 }
 #print "$aHasil[$i] $i\n";
}
$i = $batas[$d]+1;
#print $min;
$ii = $d+1;
#print "JAWABAN DOKUMEN $ii :$aHasil[$index]\n";     //jawabaaaaaaaaaaaaaaaaaaan
#print "$index\n";
# print "--------------\n";
$komala++;
}

$minimal = 99999999999999;
for($i = 0;$i <=$#array;$i++)
{

	if ($array[$i] < $minimal and $array[$i] >0)
	{
		$minimal = $array[$i];
	}

}

$minimal1 = 99999999999999;
for($i = 0;$i <=$#array;$i++)
{	
	
	if ($array[$i] < $minimal1 and $array[$i] != $minimal and $array[$i] >0)
	{
		$minimal1 = $array[$i];
	}

}


$minimal2 = 99999999999999;
for($i = 0;$i <=$#array;$i++)
{	
	
	if ($array[$i] < $minimal2 and $array[$i] != $minimal and $array[$i] != $minimal1 and $array[$i] >0)
	{
		$minimal2 = $array[$i];
	}

}
$minimal3 = 99999999999999;
for($i = 0;$i <=$#array;$i++)
{	
	
	if ($array[$i] < $minimal3 and $array[$i] != $minimal and $array[$i] != $minimal1 and $array[$i] != $minimal2 and $array[$i] >0)
	{
		$minimal3 = $array[$i];
	}

}

$minimal4 = 99999999999999;
for($i = 0;$i <=$#array;$i++)
{	
	
	if ($array[$i] < $minimal4 and $array[$i] != $minimal and $array[$i] != $minimal1 and $array[$i] != $minimal2 and $array[$i] != $minimal3 and $array[$i] >0)
	{
		$minimal4 = $array[$i];
	}

}
$minimal5 = 99999999999999;
for($i = 0;$i <=$#array;$i++)
{	
	
	if ($array[$i] < $minimal5 and $array[$i] != $minimal and $array[$i] != $minimal1 and $array[$i] != $minimal2 and $array[$i] != $minimal3 and $array[$i] != $minimal4 and $array[$i] >0)
	{
		$minimal5 = $array[$i];
	}

}
$minimal6 = 99999999999999;
for($i = 0;$i <=$#array;$i++)
{	
	
	if ($array[$i] < $minimal6 and $array[$i] != $minimal and $array[$i] != $minimal1 and $array[$i] != $minimal2 and $array[$i] != $minimal3 and $array[$i] != $minimal4 and $array[$i] != $minimal5 and $array[$i] >0)
	{
		$minimal6 = $array[$i];
	}

}

$minimal7 = 99999999999999;
for($i = 0;$i <=$#array;$i++)
{	
	
	if ($array[$i] < $minimal7 and $array[$i] != $minimal and $array[$i] != $minimal1 and $array[$i] != $minimal2 and $array[$i] != $minimal3 and $array[$i] != $minimal4 and $array[$i] != $minimal5 and $array[$i] != $minimal6 and $array[$i] >0)
	{
		$minimal7 = $array[$i];
	}

}

$minimal8 = 99999999999999;
for($i = 0;$i <=$#array;$i++)
{	
	
	if ($array[$i] < $minimal8 and $array[$i] != $minimal and $array[$i] != $minimal1 and $array[$i] != $minimal2 and $array[$i] != $minimal3 and 
	$array[$i] != $minimal4 and $array[$i] != $minimal5 and $array[$i] != $minimal6 and $array[$i] != $minimal7 and $array[$i] >0)
	{
		$minimal8 = $array[$i];
	}

}

$minimal9 = 99999999999999;
for($i = 0;$i <=$#array;$i++)
{	
	
	if ($array[$i] < $minimal9 and $array[$i] != $minimal and $array[$i] != $minimal1 and $array[$i] != $minimal2 and $array[$i] != $minimal3 and 
	$array[$i] != $minimal4 and $array[$i] != $minimal5 and $array[$i] != $minimal6 and $array[$i] != $minimal7 and $array[$i] != $minimal8 and $array[$i] >0)
	{
		$minimal9 = $array[$i];
	}

}



# $pertanyaan =~ s/<//gi;
# $pertanyaan =~ s/>//gi;

# $aHasil[$minimal] =~ s/<$pertanyaan>//gi;
# $aHasil[$minimal] =~ s/<\/$pertanyaan>//gi;
# $aHasil[$minimal1] =~ s/<$pertanyaan>//gi;
# $aHasil[$minimal1] =~ s/<\/$pertanyaan>//gi;
# $aHasil[$minimal2] =~ s/<$pertanyaan>//gi;
# $aHasil[$minimal2] =~ s/<\/$pertanyaan>//gi;
# $aHasil[$minimal3] =~ s/<$pertanyaan>//gi;
# $aHasil[$minimal3] =~ s/<\/$pertanyaan>//gi;
# $aHasil[$minimal4] =~ s/<$pertanyaan>//gi;
# $aHasil[$minimal4] =~ s/<\/$pertanyaan>//gi;
# $aHasil[$minimal5] =~ s/<$pertanyaan>//gi;
# $aHasil[$minimal5] =~ s/<\/$pertanyaan>//gi;
# $aHasil[$minimal6] =~ s/<$pertanyaan>//gi;
# $aHasil[$minimal6] =~ s/<\/$pertanyaan>//gi;
# $aHasil[$minimal7] =~ s/<$pertanyaan>//gi;
# $aHasil[$minimal7] =~ s/<\/$pertanyaan>//gi;
# $aHasil[$minimal8] =~ s/<$pertanyaan>//gi;
# $aHasil[$minimal8] =~ s/<\/$pertanyaan>//gi;
# $aHasil[$minimal9] =~ s/<$pertanyaan>//gi;
# $aHasil[$minimal9] =~ s/<\/$pertanyaan>//gi;


open(QA, ">hasilsemiQA.txt") or die "Tidak bisa membuka file.";
print "1. $aHasil[$minimal]\n";
print "2. $aHasil[$minimal1]\n";
print "3. $aHasil[$minimal2]\n";
print "4. $aHasil[$minimal3]\n";
print "5. $aHasil[$minimal4]\n";
print "6. $aHasil[$minimal5]\n";
print "7. $aHasil[$minimal6]\n";
print "8. $aHasil[$minimal7]\n";
print "9. $aHasil[$minimal8]\n";
print "10. $aHasil[$minimal9]\n";
# print  HASIL"1. $aHasil[$minimal]\n";
# print  HASIL"2. $aHasil[$minimal1]\n";
# print  HASIL"3. $aHasil[$minimal2]\n";
# print  HASIL"4. $aHasil[$minimal3]\n";
# print  HASIL"5. $aHasil[$minimal4]\n";
# print  HASIL"6. $aHasil[$minimal5]\n";
# print  HASIL"7. $aHasil[$minimal6]\n";
# print  HASIL"8. $aHasil[$minimal7]\n";
# print  HASIL"9. $aHasil[$minimal8]\n";
# print  HASIL"10. $aHasil[$minimal9]";
print QA "$aHasil[$minimal]";

close(QAB);
}

open(QA, ">hasilQA.txt") or die "Tidak bisa membuka file.";
open(semiQA, "hasilsemiQA.txt") or die "Tidak bisa membuka file.";
while($jawabanQA=<semiQA>)
{
$jwbnQA = $jawabanQA;
}

$jwbnQA =~ s/\///gi;
$jwbnQA =~ s/$pertanyaan//gi;


print QA "$jwbnQA";

open(KATAKATA, ">proses.txt") or die;
print KATAKATA "Sedang memproses kueri";
close KATAKATA;
#$selisih = 0;
#$countca = 1;
#for ($i = 0; $i <= $#isiner ; $i++) {
#  for ($m = 0; $m < $caca[$i] ; $m++) {

#        for ($j = 0;$j <= $batasca[$i][$m]; $j++) {

#        print "$katacaa[$i][$m][$j]\n";
#        if ( $katacaa[$i][$m][$j] =~ /^\</ and $katacaa[$i][$m][$j] =~ /\w$/)
#        {
#        #print "$katacaa[$i][$m][$j]\n";
#             $kataawal = $j;
#        }

#        if ( $katacaa[$i][$m][$j] =~ /\>$/ and $katacaa[$i][$m][$j] =~ /^\w/){
#              $kataakhir = $j;
#              #print "$katacaa[$i][$m][$j]\n";
#        }
#        $selisih = $kataawal - $kataakhir;
#        for ($kataawal; $kataawal <= $kataakhir;$kataawal++)
#        {
#        if ($kataawal ne ""){
#        @asdfg = $katacaa[$i][$m][$kataawal];

#         print "$katacaa[$i][$m][$kataawal] " ;
#         print @asdfg;
#         }
#         $katacaa[$i][$m][$kataawal] = "";
#         }

#         #$j += $selisih;
#         #$selisih = 0;
#          #print "\n";
##         print "$kataconcate[$i][$m][$j] ";
#          }
#           print "\n";
#           print "-------------\n";
#        }


#}


