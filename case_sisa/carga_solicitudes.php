<?php
set_time_limit(0);
include 'conexion.php';

while (true) {

if($arch= opendir("sisa/")){


	while(($file = readdir($arch))!==false){

		if( ($file!=".") && ($file!="..") ){

			$fp=fopen("sisa_principal.sql","w");
			fputs($fp,"");
			fclose($fp);

			$fc=fopen("sisa_complemento.sql","w");
			fputs($fc,"");
			fclose($fc);

			$fp=fopen("sisa_principal.sql","a");
			$fc=fopen("sisa_complemento.sql","a");

			$name=explode(".", $file);
			$nomfile = $name[0];

			$fs=fopen("sisa/".$file,"r");
			$datos=fread($fs,filesize("sisa/".$file));
			fclose($fs);

			$lineas = explode("\n", $datos);

			foreach ($lineas as $key => $value) {
				if($key==0 || $value==""){
					continue;
				}
				if($key>1){
					fputs($fp,"\n");
					fputs($fc,"\n");
				}
				$campos= explode('|', $value);
				
				if(trim($campos[27])==""){
					$f_h_ini_mes="1969-01-01 00:00:00";
				}
				else{
					$fecha = $campos[27];
					$d = DateTime::createFromFormat("d/m/y",$fecha);
					$f_ini= $d->format('Y-m-d');
					$f_h_ini_mes=$f_ini." ".$campos[28];
				}

				
				if(trim($campos[29])==""){
					$f_h_liq_mes="1969-01-01 00:00:00";
				}
				else{
					$fecha = $campos[29];
					$d = DateTime::createFromFormat("d/m/y",$fecha);
					$f_liq= $d->format('Y-m-d');
					$f_h_liq_mes=$f_liq." ".$campos[30];
				}

				if(trim($campos[31])==""){
					$f_h_real_liq_mes="1969-01-01 00:00:00";
				}
				else{
					$fecha = $campos[31];
					$d = DateTime::createFromFormat("d/m/y",$fecha);
					$f_real_liq= $d->format('Y-m-d');
					$f_h_real_liq_mes=$f_real_liq." ".$campos[32];
				}

				if(trim($campos[36])==""){
					$f_h_ini_efa="1969-01-01 00:00:00";
				}
				else{
					$fecha = $campos[36];
					$d = DateTime::createFromFormat("d/m/y",$fecha);
					$f_ini_efa= $d->format('Y-m-d');
					$f_h_ini_efa=$f_ini_efa." ".$campos[37];
				}

				if(trim($campos[38])==""){
					$f_h_liq_efa="1969-01-01 00:00:00";
				}
				else{
					$fecha = $campos[38];
					$d = DateTime::createFromFormat("d/m/y",$fecha);
					$f_liq_efa= $d->format('Y-m-d');
					$f_h_liq_efa=$f_liq_efa." ".$campos[39];
				}


				$lineaprin= $campos[0]."\t".$campos[4]."\t".$campos[5]."\t".$f_h_ini_mes."\t".$f_h_liq_mes."\t".$f_h_real_liq_mes."\t".($campos[33]!=""?$campos[33]:0)."\t".$f_h_ini_efa."\t".$f_h_liq_efa."\t".($campos[40]!=""?$campos[40]:0)."\t".($campos[41]!=""?$campos[41]:0)."\t1969-01-01 00:00:00\t1969-01-01 00:00:00";
				fputs($fp,$lineaprin);



				$lineacom= $campos[0]."\t".$campos[1]."\t".$campos[2]."\t".$campos[3]."\t".$campos[6]."\t".$campos[7]."\t".$campos[8]."\t".$campos[9]."\t".$campos[10]."\t".$campos[11]."\t".$campos[12]."\t".$campos[13]."\t".$campos[14]."\t".$campos[15]."\t".$campos[16]."\t".$campos[17]."\t".$campos[18]."\t".$campos[19]."\t".($campos[20]!=""?$campos[20]:0)."\t".$campos[21]."\t".($campos[22]!=""?$campos[22]:0)."\t".$campos[23]."\t".($campos[24]!=""?$campos[24]:0)."\t".$campos[25]."\t".$campos[26]."\t".($campos[34]!=""?$campos[34]:0)."\t".$campos[35]."\t".$campos[42]."\t".$campos[43]."\t".$campos[44]."\t".$campos[45]."\t".$campos[46]."\t".$campos[47]."\t".$campos[48]."\t".$campos[49]."\t".$campos[50]."\t".$campos[51]."\t".$campos[52]."\t".($campos[53]!=""?$campos[53]:0)."\t".$campos[54]."\t".$campos[55]."\t".$campos[56]."\t".$campos[57];
				$lineacom = preg_replace('/"/',"",$lineacom);
				$lineacom = preg_replace('/[\*]/',"",$lineacom);
				fputs($fc,$lineacom);
				//break;
			}

			

			fclose($fp);
			fclose($fc);

			$query="LOAD DATA LOCAL INFILE '/var/www/html/case_sisa/sisa_principal.sql' REPLACE INTO TABLE sisa_principal";
			$result=conexion('bgpt',"infinitum",$query);

			if($result[0]["evento"]=="correcto"){
				echo "archivo procesado sisa_principal.sql\n".$result[0]['msg'];
				unlink("sisa/".$file);
				continue;
			}
			else{
				echo "error al procesar sisa_principal.sql\n".$result[0]['msg'];
			}

			$query="LOAD DATA LOCAL INFILE '/var/www/html/case_sisa/sisa_complemento.sql' REPLACE INTO TABLE sisa_complemento";
			$result=conexion('bgpt',"infinitum",$query);

			if($result[0]["evento"]=="correcto"){
				echo "archivo procesado sisa_complemento.sql\n".$result[0]['msg'];
			}
			else{
				echo "error al procesar sisa_complemento.sql\n".$result[0]['msg'];
			}
			
		}

	}

}
sleep(20);
}

?>