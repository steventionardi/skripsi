use Text::Tabs;
use POSIX;
open(UNIGRAM, '>1. unigram.txt') or die "error ";
  open(QUERY, '>query.txt') or die "error ";
#open directory
my $dir = 'cthh';
foreach my $fp (glob("$dir/*.txt")) {
  # print "$fp\n";
  push(@dok, $fp);
  open my $fh, "<", $fp or die "can't read open '$fp': $OS_ERROR";
	while (<$fh>) {
	  chomp;
	  if($_ =~ /<isi>/../<\/isi>/) {
		   s/<*isi>/ /gi;
        s/[\.!,?"\/><)(';:\-]//gi;     #Menghilangkan tanda baca, ganti spasi
        s/[0-9]/ /gi;                   #Menghilangkan angka, ganti spasi
        s/^\s+//gi;
        s/\s+$//gi;
        s/\s+/ /gi;                     #Menghilangkan spasi yang lebih dari 1

        #Split berdasarkan spasi bisa menggunakan seperti baris ini selain /s
        push(@isi, $_);
       # print "@isi \n";
        }

	    #print "$_ \n";
	}
	  # print "\n";
	  close $fh or die "can't read close '$fp': $OS_ERROR";
}

for ($i = 0; $i <= $#isi ; $i++) {
  # chomp;
  $dok[$i] =~ s/directory1//;		#hilangin path directory1
  }
  

#unigram
@unigram = ();		#variabel
$c = 0;		# lopp array baras dokumen
$z =0;
$count = 0;

foreach my $unigram (@isi)		#ambil isi tiap dok
{

# print "$unigram \n";
$unigram =~ tr/A-Z/a-z/;			#preproccesing
$unigram =~ tr/#$%^@&*|[].,:;!?"\/(){}<+>//d;
$unigram =~ tr/'\\'//d;
$unigram =~ tr/0-9//d;
$unigram =~ s/\n/ /gm;
$unigram =~ s/\s\s+/ /gm;
@unigrams = split(/\s+/, $unigram );	#split by space
# print "@unigrams \n";



for ($m=0; $m <= $#unigrams; $m++) { 		#itung frekuensi
    # print "$unigrams[$m] \n";
   
    if (!exists($unigrams[$m]))
      {
        $frequency{$unigrams[$m]} = 1;
      }
    else
      {
        $frequency{$unigrams[$m]}++;
       }
    }

$batas[$c] = $m;               	  #batas kata perdokumen
# print "$batas[$c]\n";
# print "dld dokumen $c = $batas[$c]\n";             #dld total frekuensi per dokumen
$c += 1;			  # lopp array baras dokumen

$z = "";                          #batas loop array

#print kata dan frekuensike file txt

foreach $unigrams (sort{$a cmp $b}keys %frequency){
  if ($unigrams  =~ /\w/ ){
    print UNIGRAM "$unigrams". " " ."$frequency{$unigrams}\n";
    $z += 1;
  }
}



$batas1[$count] = $z ;          #batas perdokumen setela di sort untuk term frekuensi
#print "$batas1[$count] \n";
$count += 1;
%frequency = "";
 push (@lines, @unigrams) ;

}
for ($i = 0 ; $i <= $#lines; $i++) {
  # print "$lines[$i]\n";
       if (!exists($lines[$i]))
      {
        $frekuensi{$lines[$i]} = 1;
      }
    else
      {
        $frekuensi{$lines[$i]}++;
       }
}


open(CFT, '>CFT.txt') or die "error ";
foreach $lines (sort{$a cmp $b}keys %frekuensi){
    # print "$lines $frekuensi{$lines}\n";
    print CFT "$lines $frekuensi{$lines}\n";
}
close (CFT);

close (UNIGRAM);



print "Masukkan kueri : ";
$kueri = <>;
$kueri =~ tr/A-Z/a-z/;
@queri = $kueri;
foreach my $tanya(@queri)
{
@katatanya = split(/\s+/, $tanya );

$tanya =~ tr/A-Z/a-z/;			#preproccesing
$tanya =~ tr/#$%^@&*|[].,:;!?"\/(){}<+>//d;
$tanya =~ tr/'\\'//d;
$tanya =~ tr/0-9//d;
$tanya =~ s/\n/ /gm;
$tanya =~ s/\s\s+/ /gm;
@tanyaq = split(/\s+/, $tanya );	#split by space

for ($m=0; $m <= $#tanyaq; $m++) { 		#itung frekuensi
    # print "$tanyaq[$m] \n";

    if (!exists($tanyaq[$m]))
      {
        $frequencytanya{$tanyaq[$m]} = 1;
      }
    else
      {
        $frequencytanya{$tanyaq[$m]}++;
       }
    }

foreach $tanyaq (sort{$a cmp $b}keys %frequencytanya){
  if ($tanyaq  =~ /\w/ ){
    print QUERY "$tanyaq". " " ."$frequencytanya{$tanyaq}\n";
  }
  }
}
close(QUERY);
for($i= 0; $i <=$#katatanya; $i++)
{
   #print "$katatanya[$i]\n";
}

#print "$kueri$tipe\n";



open(UNIGRAMM, '1. unigram.txt') or die "error "; #buka file unigram
open(PML, '>PML.txt') or die "error ";            #untuk simpan hasil pml dan katanya per dokumen


while(<UNIGRAMM>)
{
	chomp;
	push(@Dokumen, $_);
}
close (UNIGRAMM);


open(KUERI, 'query.txt' )  or die "error ";
while(<KUERI>)
{
chomp;
push(@ktny, $_);
}
close(KUERI);

for($i=0;$i<=$#ktny;$i++)
{
@isiktny = split/ /,$ktny[$i];
$fktny[$i] = $isiktny[1];
$kataktny[$i] = $isiktny[0];
# print "$kataktny[$i] $fktny[$i]\n";
}


#digunakan untuk menghitung p.avg pada proses selanjutnya
$total = 0;
for ($i = 0; $i <= $#Dokumen; $i++)   
{
	@kataaa = split / /, $Dokumen[$i];
	$kataa[$i] = $kataaa[0];                            #term  
        $fkataa{$kataaa[0]} = $kataaa[1];                   #frekuensi term
        $fkataa1[$i] = $kataaa[1]; 
        $total += $fkataa1[$i];
        # print "$kataa[$i]\n";
        

    }



$x = 0;                           #counter
foreach $kataa(sort {$a cmp $b} keys %fkataa){
$katad[$x] = $kataa;              #daftar kata pada seluruh dokumen
$x += 1;
}

#ambil data pada file per dokumen
$count3 = 0;    #counter untuk array dan hash dari file txt
$m = 0;         #counter untuk array baru
$t = 0;         #counter untuk array pml
for ($i = 0; $i <= $#batas ; $i++)
{
	@kata1 = "";
	%fkata1 = "";
       # print "$batas[$i]\n";
	for ($m ; $m < $batas1[$i] ; $m++)
	{
		
                @dkata = split / /, $Dokumen[$m];
                $kata[$m] = $dkata[0];                           #term 
                $fkata{ $dkata [$m]} = $dkata[1];                #frekuensi term
		$kata1[$m] = $kata[$count3];                     #tampung ke array
		$fkata1{$kata1[$m]} = $fkata{$dkata[$count3]};
		$count3 += 1;
                # print "$kata[$m] $fkata{$dkata [$m]}\n";      #cek isi array dan hash
		# print "$kata1[$m] = $fkata1{$kata1[$m]}\n";   #cek isi array dan hash
		
	}
	
	#hitung pml
	foreach $kata1 (sort {$a cmp $b} keys %fkata1){
		if ($kata1 =~ /\w/){
			$pml[$t] = $fkata1{$kata1}/ $batas[$i] ;
			# print  "$kata1  $fkata1{$kata1}/ $batas[$i]= $pml[$t]\n";           #tampilkan hasil pml
			print  PML "$kata1 $pml[$t]\n";         #print hasil pml dan katanya per dokumen
			$t += 1;
		}
	}
	$batas1[$i+1] +=$batas1[$i];
	# print "-----------------------------------------------\n";
}
  # print "@batas\n";


close (PML);


open(PMLL, 'PML.txt') or die "error ";  #buka file PML.txt

while(<PMLL>)
{
	chomp;
	push(@Datapml, $_);                     #masukan isi txt ke array @Datapml
}
close(PMLL);


for ($i = 0; $i <= $#Datapml; $i++)
{
	@isipml = split / /, $Datapml[$i];              #split by space
	$fpml[$i] = $isipml[1];                         #indeks 1 frekuensi
	$katapml[$i] = $isipml[0];                      #indeks 0 kata
	# print "$katapml[$i] $fpml[$i]\n";               #cek isi array katapml dan fpml
}


#hitung dft dan p.avg
for ($m = 0; $m <= $#katad ; $m++)
{
  # print "$katad[$m]\n";
  for ($i = 0; $i <= $#katapml ; $i++)
  {
    # print "$lines[$i]\n";

      if ($katad[$m] eq $katapml[$i] ) {                #mengecek daftar kata dengan kata pada setiap dok
        $pavg += $fpml[$i];                             #sum dari pml
        if (!exists($katapml[$i]))
        {
          $jumlah[$m] = 1;                              #jumlah frekuensi kata pada semua dokumen (dft)   
        }
        else
        {
        $jumlah[$m]++;                                  #jumlah frekuensi kata pada semua dokumen (dft)
        }          
    
      }
        
        
  }

  $pavg1[$m] = $pavg/ $jumlah[$m];                      #hitung p.avg
 # print "$katad[$m]  $pavg1[$m] \n";                     #cek hasil p.avg
  $pavg = 0;
  
}


open(FT, '>FT.txt') or die "error ";
# hitung ft
$a = 0;
for ($i=0 ; $i <= $#batas; $i++) {
  # print "$batas[$i]\n";
  for ($m=0; $m <= $#pavg1; $m++) {
    $fterm[$a] =  $batas[$i]*$pavg1[$m];        #itung fterm       
    # print "$katad[$m]  $fterm[$a]\n";            #tampilin fterm
    print FT "$katad[$m] $fterm[$a] \n"; 
    $kata2[$a] = $katad[$m];
    # print "$kata2[$a]\n";
    $a += 1;
    }
     # print "-----------------------------------------------\n";
  
  }


#hitung rtd
 close(FT);
 
open(FTT, 'FT.txt') or die "error ";
open(RTD, '>RTD.txt') or die "error "; 
 while(<FTT>)
{
	chomp;
	push(@Dataft, $_);                     #masukan isi txt ke array @Datapml
}
close(FTT);


for ($i = 0; $i <= $#Dataft; $i++)
{
	@isift = split / /, $Dataft[$i];              #split by space
	$fft[$i] = $isift[1];                         #indeks 1 frekuensi
	$kataft[$i] = $isift[0];                      #indeks 0 kata
	# print "$kataft[$i] $fft[$i]\n";               #cek isi array katapml dan fpml
	
}

$x = 0;
$m =0;
$sdff1[0] = $#katad;
for ($i=0 ; $i <= $#batas1; $i++) {
  $sdf[$i] = ($#Dataft-($#pavg1*($#batas1-$i-1)));
   for ($m; $m <= $batas1[$i]; $m++) {
	   #print "$kataa[$m]\n";
 	for ($x ; $x <= $sdff1[$i]; $x++){
		 # print "$kataft[$x]\n";
	  if ($kataa[$m] eq $kataft[$x]) {
            $rtd[$x] = (1/(1+$fft[$x]))*(($fft[$x]/(1+$fft[$x]))**$fkataa1[$m]);
            # print "$kataft[$x] $rtd[$x] \n";
            last;
            }
            else {
             if ($rtd[$x] == ""){
            $rtd[$x] = (1/(1+$fft[$x]))*(($fft[$x]/(1+$fft[$x]))**0);
            #print "$kataft[$x] $rtd[$x] \n";
          }
          }
          
  
		  
           #print "$kataft[$x] $rtd[$x] \n";
          
          print RTD "$kataft[$x] $rtd[$x]\n";
	}
	$sdff1[$i+1] = $sdff1[$i] + $#katad ;

}
}

close(RTD);




#hitung ptmd
open(RTDD, 'RTD.txt') or die "error "; 
 while(<RTDD>)
{
	chomp;
	push(@Datartd, $_);                     #masukan isi txt ke array
}
close(RTDD);


for ($i = 0; $i <= $#Datartd; $i++)
{
	@isirdt = split / /, $Datartd[$i];              #split by space
	$frdt[$i] = $isirdt[1];                         #indeks 1 frekuensi
	$katardt[$i] = $isirdt[0];                      #indeks 0 kata
	# print "$katardt[$i] \n";               #cek isi array katapml dan fpml
	
}


open(CFTT, 'CFT.txt') or die "error ";                  #buka file CFT

while(<CFTT>)
{
	chomp;
	push(@Datacft, $_);
}
close (CFTT);


for ($i = 0; $i <= $#Datacft; $i++)   
{
	@isicft = split / /, $Datacft[$i];
	$katacft[$i] = $isicft[0];             
        $fcft{$isicft[0]} = $isicft[1];                   
        # print "$katacft[$i] $fcft{$katacft[$i]}\n";
        

    }


open(PTMD, '>PTMD.txt') or die "error "; 
open(NOTPTMD, '>notPTMD.txt') or die"error";
$x = 0;
$m =0;
$sdff1[0] = $#katad;
for ($i=0 ; $i <= $#batas1; $i++) {
#print "$batas1[$i]\n";
   for ($m; $m < $batas1[$i]; $m++) {
#  print  "$batas1[$i]\n";
	 #print "$kataa[$m]\n";
 	for ($x ; $x <=$sdff1[$i]; $x++){
# print "$sdf[$i]\n";
	  if ($kataa[$m] eq $katardt[$x] ) {
		  for ($z= 0; $z <= $#pavg1; $z++) {
		   if ($kataa[$m] eq $katad[$z] ) {
		  $ptmd[$x] = ($fpml[$m]**(1-$rtd[$x]))*($pavg1[$z]**$rtd[$x]);
		  last;
		  }
		  }
            # print "$katardt[$x] $ptmd[$x] = ($fpml[$m]**(1-$rtd[$x]))*($pavg1[$z]**$rtd[$x])\n";
            last;
            }
            else {
             if ($ptmd[$x] == ""){
            $ptmd[$x] = $fcft{$katardt[$x]}/$total; 
            #print "$kataft[$x] $rtd[$x] \n";
          }
            $notptmd[$x] = 1 - $ptmd[$x];

          }
          #print "$katardt[$x] $ptmd[$x] \n";
          print NOTPTMD"$katardt[$x] $notptmd[$x]\n";
          print PTMD "$katardt[$x] $ptmd[$x]\n";
          	}
          	$sdff1[$i+1] = $sdff1[$i] + $#katad ;

}
# $m +=1;
}

close (PTMD);
close (NOTPTMD);

open(nPTMD, 'PTMD.txt') or die "error ";


while(<nPTMD>)
{
	chomp;
	push(@ptttmd, $_);
}
close (nPTMD);

$m =0;
for ($i = 0; $i <= $#ptttmd; $i++)
{
	@isiptmd = split / /, $ptttmd[$i];
	$kataptmd[$i] = $isiptmd[0];
        $fcptmd[$i] = $isiptmd[1];
#     print "$kataptmd[$i] $fcptmd[$i]\n";
}
$tsimptmd = 1;
$sdff1[0] = $#katad;
for ($i=0 ; $i < $#batas1; $i++) {
         for ($m; $m <= $sdff1[$i]; $m++) {
#        print "$kataptmd[$m]\n";
        for($x= 0; $x <=$#katatanya; $x++)
                {
#                         print "$kataptmd[$m] $katatanya[$x]\n";
                        #print "$katatanya[$i]\n";
                        if ($kataptmd[$m] eq $katatanya[$x]) {
                        $tsimptmd *=  $fcptmd[$m];
                        }
                }

        }
        $sdff1[$i+1] = $sdff1[$i] + $#katad ;
        $arrPTMD[$i] = $tsimptmd;
       # print "$tsimptmd \n";
        $tsimptmd = 1;
}



open(bukanPTMD, 'notPTMD.txt') or die "error ";


while(<bukanPTMD>)
{
	chomp;
	push(@nootptmd, $_);
}
close (bukanPTMD);

$m =0;
for ($i = 0; $i <= $#nootptmd; $i++)
{
	@isinotptmd = split / /, $nootptmd[$i];
	$katanotptmd[$i] = $isinotptmd[0];
        $fcnotptmd[$i] = $isinotptmd[1];
#     print "$kataptmd[$i] $fcptmd[$i]\n";
}
$tsimnotptmd = 1;
$sdff1[$i] =  $#katad;
for ($i=0 ; $i < $#batas1; $i++) {
  #print "$sdff1[$i]\n";
         for ($m; $m <= $sdff1[$i] ; $m++) {

#        for($x= 0; $x <=$#katatanya; $x++)
#                {
                        # if ($katanotptmd[$m] ne~ $kueri) {
                        $tsimnotptmd *=  $fcnotptmd[$m];
                        for($x= 0; $x <=$#katatanya; $x++)
                        {
                          if ($katanotptmd[$m] eq $katatanya[$x]) {
                            #print "$katanotptmd[$m] --- $katatanya[$x]) \n";
                            $tsimnotptmd /=  $fcnotptmd[$m];
                            last;
                            }
                        }
                      # print"$katanotptmd[$m] $fcnotptmd[$m]\n";
#                }

        }
        $sdff1[$i+1] = $sdff1[$i] + $#katad ;
        $arrnotptmd[$i] = $tsimnotptmd;
      # print "\n$tsimnotptmd \n";
      #print "---------------\n";
      
        $tsimnotptmd = 1;

}

for($i= 0 ; $i <= $#arrnotptmd;$i++)
{
        $lasthasil[$i] = $arrPTMD[$i] * $arrnotptmd[$i];
        $k = $i+1;
       #print "$lasthasil[$i] = $arrPTMD[$i] * $arrnotptmd[$i];\n";
       print "Dokumen $k: $lasthasil[$i]\n";
}



# print "------------------------------------------------\n";




#VSM
open(UNIGRAMVSM, '1. unigram.txt') or die "error "; #buka file unigram
open(SPECT, '>specT.txt' )  or die "error ";
while(<UNIGRAMVSM>)
{
	chomp;
	push(@vsm, $_);                     #masukan isi txt ke array @Datapml
}
close(UNIGRAMVSM);


for ($i = 0; $i <= $#vsm; $i++)
{
	@isivsm = split / /, $vsm[$i];              #split by space
	$fvsm[$i] = $isivsm[1];                         #indeks 1 frekuensi
	$katavsm[$i] = $isivsm[0];                     #indeks 0 kata
       # print "$katavsm[$i] $fvsm[$i] $i\n";
}


  for ($i = 0; $i <= $#katavsm; $i++)
  {
        if (!exists($katavsm[$i]))
        {
          $jumlahvsm{$katavsm[$i]} = 1;                              #jumlah frekuensi kata pada semua dokumen (dft)
        }
        else
        {
        $jumlahvsm{$katavsm[$i]}++;                                  #jumlah frekuensi kata pada semua dokumen (dft)
        }
   }

$z = 0;
foreach $katavsm  (sort{$a cmp $b}keys %jumlahvsm)
{
$variabel = ($jumlahvsm{$katavsm}+1)/($#isi+1);
$specT{$katavsm[$z]} = -1*log2($variabel) ;
print SPECT "$katavsm $specT{$katavsm[$z]} \n";                                     #specT
# print "$katavsm $jumlahvsm{$katavsm} \n";
$daftar[$z] = $katavsm;
# print "$daftar[$z]\n";
# print "$katavsm $specT\n";
$z++;
}
close(SPECT);

# print @batas1;

open(FSPECT, 'specT.txt' )  or die "error ";
while(<FSPECT>)
{
	chomp;
	push(@spectt, $_);                     #masukan isi txt ke array @Datapml
}
close(FSPECT);


for ($i = 0; $i <= $#spectt; $i++)
{
	@isispect = split / /, $spectt[$i];              #split by spac
	$kataspect[$i] = $isispect[0];
        $fspect{$kataspect[$i]} = $isispect[1];                      #indeks 0 kata
     # print "$kataspect[$i] $fspect{$kataspect[$i]}\n";
}

open(WWW, '>W.txt' )  or die "error ";
open(WWQ, '>Wque.txt' )  or die "error ";
$xx =0;
$zx = 0;
$zy= 0;
$xy=0;
@totaltsim = 0;
for ($i=0;$i<=$#batas;$i++)
{
for ($m = 0; $m<= $#daftar; $m++) {

  for($xx; $xx < $batas1[$i]; $xx++)
  {
            $tamm{$katavsm[$zx]} = ($fvsm[$xx] * $fspect{$katavsm[$xx]}) ;     # W = tf*idf

            $zx++;

  }
  
  
     for($xy; $xy <= $#kataktny; $xy++)
  {
     $tfidf{$kataktny[$xy]} = ($fktny[$xy] * $fspect{$kataktny[$xy]}) ;     # W = tf*idf
     # print "$fktny[$xy] * $fspect{$kataktny[$xy]}\n";
     # print "$kataktny[$xy] $tfidf{$kataktny[$zy]}\n";
     $zy++;
  }



        if ($tamm{$daftar[$m]} == ""){
          $arrw[$i][$m] = 0;
          #print "$daftar[$m]  $arrw[$i][$m]\n";
          print WWW "$daftar[$m] 0\n";
        }
        else {
        $arrw[$i][$m] = $tamm{$daftar[$m]};
        #print "$daftar[$m] $arrw[$i][$m] \n";
        print WWW "$daftar[$m] $arrw[$i][$m]\n";
      }
      
      
      
  $wdt[$i][$m] = $arrw[$i][$m] **2;             # WDT^2


  $akar[$i] += $wdt[$i][$m];
  $pjgvektor[$i] = sqrt($akar[$i]);      # PANJANG VEKTOR
#  print   "$pjgvektor[$i]\n";




#queryy
  if ($i == 0) {
    if ($tfidf{$daftar[$m]} == ""){
            $arrque[$i][$m] = 0;
            # print "$daftar[$m]  $arrque[$i][$m]\n";
            print WWQ "$daftar[$m]  $arrque[$i][$m]\n";
          }
          else {
          $arrque[$i][$m] = $tfidf{$daftar[$m]};
          # print "$daftar[$m] $arrque[$i][$m] \n";
          print WWQ "$daftar[$m] $arrque[$i][$m] \n";
        }
          $wdtque[$i][$m] = $arrque[$i][$m] **2;             # WDT^2
          # print  "$daftar[$m] $wdtque[$i][$m]\n";

          $akarque[$i] += $wdtque[$i][$m];
          $pjgvektorque[$i] = sqrt($akarque[$i]);      # PANJANG VEKTOR\
#           print   "$pjgvektorque[$i]\n";
    }
    
    
    

        
        # print "$daftar[$m] $tsim[$i][$m]\n";
       
        

  }
## NORMALISASI W
  for ($s = 0; $s<= $#daftar; $s++) {
       $norman[$i][$s] = $arrw[$i][$s]/$pjgvektor[$i];
      # print "$norman[$i][$s]\n";
  
       $wdtnorman[$i][$s] = $norman[$i][$s] **2;             # WDT^2


       $akarnorman[$i] += $wdtnorman[$i][$s];
       $pjgvektornorman[$i] = sqrt($akarnorman[$i]);      # PANJANG VEKTOR
      # print "$pjgvektornorman[$i] = sqrt($akarnorman[$i])\n";
       
        if ($i == 0)  {
          if ($pjgvektorque[$i] == 0)
          {
            $normanque[$i][$s] = 0;
           }
           else{
       $normanque[$i][$s] = $arrque[$i][$s] / $pjgvektorque[$i];
       $wdtnormanque[$i][$s] = $normanque[$i][$s] **2;             # WDT^2
        }

       $akarnormanque[$i] += $wdtnormanque[$i][$s];
       $pjgvektornormanque[$i] = sqrt($akarnormanque[$i]);      # PANJANG VEKTOR\
#   print   "$pjgvektornormanque[$i] = sqrt($akarnormanque[$i]); \n";
}

     # similarity
        $tsim[$i][$s] = $wdtnorman[$i][$s]  * $wdtnormanque[0][$s];
        $totaltsim[$i] += $tsim[$i][$s];
       
  }
  # print "---------\n";
  # print "$totaltsim[$i]\n";
  #print  "$akar[$i]\n";
#  print "$pjgvektor[$i]\n";
  #print "$pjgvektornorman[$i] \n";
  #print   "$pjgvektornormanque[0]\n";
  %tamm = "";
  if ( ($pjgvektornorman[$i]*$pjgvektornormanque[0]) == 0)
  {
  $cosine[$i] = 0;
  }
  else
  {
  $cosine[$i] =  $totaltsim[$i]/($pjgvektornorman[$i]*$pjgvektornormanque[0]);
  }
  # print "cosine[$i] =  $totaltsim[$i]/($pjgvektornorman[$i]*$pjgvektornormanque[0])\n";
  $aa = $i+1;
  print "Dokumen $aa = $cosine[$i]\n";

}
close(WWW);
close(WWQ);

sub log2 {
   my $n = shift;
   return log($n)/log(2);
}


# for ($i=0;$i<=$#batas;$i++) {
  # for ($m = 0; $m<= $#daftar; $m++) {
      # print "$daftar[$m] $arrw[$i][$m]\n";
  # }
# }

