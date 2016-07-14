<?php
require_once dirname(__FILE__) . '/Classes/PHPExcel/IOFactory.php';
set_time_limit(0);

include 'conexion.php';

class MyReadFilter implements PHPExcel_Reader_IReadFilter
{
    public function __construct($Columns,$rowIni=0,$rowFin=0) {
        $this->columns = $Columns;
        $this->rowIni=$rowIni;
        $this->rowFin=$rowFin;
    }

	public function readCell($column, $row, $worksheetName = '') {

		// Read title row and rows 0 - 30
		if($this->rowIni>0 && $this->rowFin>0){
			if ($row >= $this->rowIni && $row <= $this->rowFin) {
				//Read Columns $columns[]
			 	if (in_array($column, $this->columns)) {
              		return true;
          		}
			}

		}else if($this->rowIni>0){

			if ($row >= $this->rowIni) {
				//Read Columns $columns[]
			 	if (in_array($column, $this->columns)) {
              		return true;
          		}
			}

		}else if($this->rowFin>0){
			if ($row <= $this->rowFin) {
				//Read Columns $columns[]
			 	if (in_array($column, $this->columns)) {
              		return true;
          		}
			}


		}else{
			if (in_array($column, $this->columns)) {
          		return true;
      		}
		}

		return false;
	}
}
function is_Date($str){ 
        
        $str = str_replace('/', '-', $str);     
        $stamp = strtotime($str);
        if (is_numeric($stamp)){  
            
            $month = date( 'm', $stamp ); 
            $day   = date( 'd', $stamp ); 
            $year  = date( 'Y', $stamp ); 
            
            return checkdate($month, $day, $year); 
                
        }  
        return false; 
 }
function excelExec($archivoExcel,$hoja,$columnas,$base,$division){
	//$objReader = new PHPExcel_Reader_Excel5();
	//$objReader = PHPExcel_IOFactory::createReader('Excel5');
	//$objReader->setLoadSheetsOnly("Detalle 7K´S"); 																																					
	/*$objReader = PHPExcel_IOFactory::createReader('Excel5');															
	$objReader->setReadDataOnly(true);
	$objReader->setReadFilter( new MyReadFilter($columnas,2 ,null) );

	$objPHPExcel = $objReader->load($archivoExcel);*/


	$inputFileType = PHPExcel_IOFactory::identify($archivoExcel);
    $objReader = PHPExcel_IOFactory::createReader($inputFileType);
    $objPHPExcel = $objReader->load($archivoExcel);


    $sheet = $objPHPExcel->getSheet(0); 
	$highestRow = $sheet->getHighestRow(); 
	$highestColumn = $sheet->getHighestColumn();

	if(file_exists("sisa_cap.sql"))
	{
		unlink("sisa_cap.sql");
	}
	$fp=fopen("sisa_cap.sql","a");
	$lineaInsert='';

	//  Loop through each row of the worksheet in turn
	for ($row = 1; $row <= $highestRow; $row++){ 
	    //  Read a row of data into an array
	    if($row<3){
	    	continue;
	    }
	    $rowData = $sheet->rangeToArray('A' . $row . ':' . $highestColumn . $row,
	                                    NULL,
	                                    TRUE,
	                                    FALSE);
	    //print_r($rowData);

	    if($row>3){
		 	fputs($fp,"\n");
		 }

		if($rowData[0][6]!=0){
			$d = DateTime::createFromFormat("d/m/Y",$rowData[0][6]);
			$rowData[0][6]= $d->format('Y-m-d');
		}
		else
		{
			$rowData[0][6]="1969-01-01";
		}

		if($rowData[0][7]!=0){
			$d = DateTime::createFromFormat("d/m/Y",$rowData[0][7]);
			$rowData[0][7]= $d->format('Y-m-d');
		}
		else
		{
			$rowData[0][7]="1969-01-01";
		}

	    $lineaInsert=$rowData[0][0]."\t".$rowData[0][1]."\t".$rowData[0][2]."\t".$rowData[0][3]."\t".$rowData[0][4]."\t".$rowData[0][5]."\t".$rowData[0][6]."\t".$rowData[0][7]."\t".$rowData[0][8]."\t".$rowData[0][9]."\t".$rowData[0][10]."\t".$rowData[0][11]."\t".$rowData[0][12]."\t".$rowData[0][13]."\t".$rowData[0][14]."\t".$rowData[0][15]."\t".$rowData[0][16]."\t".$rowData[0][17]."\t".$rowData[0][18]."\t".$rowData[0][19]."\t".$rowData[0][20]."\t".$rowData[0][21]."\t".$rowData[0][22]."\t".$rowData[0][23]."\t".$rowData[0][24]."\t".$rowData[0][25]."\t".$rowData[0][26]."\t".$division."\t1969-01-01 00:00:00\t1969-01-01 00:00:00";
			fputs($fp,$lineaInsert);
	    //  Insert row data array into your database of choice here
	}
	fclose($fp);

	$query="LOAD DATA LOCAL INFILE '/var/www/html/case_sisa/sisa_cap.sql' REPLACE INTO TABLE sisa_cap";
	$result =conexion("bgpt",$base,$query);
	if($result[0]['evento']=='error'){
		echo($result[0]['msg']);

	}else{
		unlink($archivoExcel);
	}

/*
	

	//$objPHPExcel = PHPExcel_IOFactory::load($archivoExcel);
	$objWorksheet = $objPHPExcel->getActiveSheet();

	$i=0;
	$tuplas=array();
	$fecha_consulta=date("Y-m-d H:i:s");
	if(file_exists("sisa_cap.sql"))
	{
		unlink("sisa_cap.sql");
	}
	$fp=fopen("sisa_cap.sql","a");
	$lineaInsert='';

	foreach ($objWorksheet->getRowIterator() as $row) {
	  $cellIterator = $row->getCellIterator();
	  $cellIterator->setIterateOnlyExistingCells(false); // This loops all cells,
	                                                     // even if it is not set.
	                                                     // By default, only cells
	                                                     // that are set will be
	                                                     // iterated.
	  if($i==0){
	  	$i++;
	  	continue;
	  }
	  $j=0;
	  $row=array();
	  foreach ($cellIterator as $cell) {
	    $rowData[0][]=preg_replace("/'/", "", $cell->getValue());
	    $j++;

	    if($j==count($columnas)){
	    	break;
	    }
	  }
	  if(count($row)>0){

		  	if($lineaInsert!=''){
		  		fputs($fp,"\n");
		  	}
	  		$lineaInsert=$rowData[0][0]."\t".$rowData[0][1]."\t".$rowData[0][2]."\t".$rowData[0][3]."\t".$rowData[0][4]."\t".$rowData[0][5]."\t".$rowData[0][6]."\t".$rowData[0][7]."\t".$rowData[0][8]."\t".$rowData[0][9]."\t".$rowData[0][10]."\t".$rowData[0][11]."\t".$rowData[0][12]."\t".$rowData[0][13]."\t".$rowData[0][14]."\t".$rowData[0][15]."\t".$rowData[0][16]."\t".$rowData[0][17]."\t".$rowData[0][18]."\t".$rowData[0][19]."\t".$rowData[0][20]."\t".$rowData[0][21]."\t".$rowData[0][22]."\t".$rowData[0][23]."\t".$rowData[0][24]."\t".$rowData[0][25]."\t".$rowData[0][26];
			fputs($fp,$lineaInsert);
		}
		$i++;
	}

	fclose($fp);
	/*
	$query="LOAD DATA LOCAL INFILE '/var/www/html/excel_formatos/LOG_PROCESS.sql' INTO TABLE eventos";
	$result =conexion("bgpt",$base,$query);
	if($result[0]['evento']=='error'){
		echo($result[0]['msg']);

	}
	*/
	
	/*$query="LOAD DATA LOCAL INFILE '/var/www/html/case_sisa/sisa_cap.sql' INTO TABLE sisa_cap";
	$result =conexion("bgpt",$base,$query);
	if($result[0]['evento']=='error'){
		echo($result[0]['msg']);

	}*/
}

while (true) {

	if($arch= opendir("cap/")){


		while(($file = readdir($arch))!==false){

			if( ($file!=".") && ($file!="..") ){
				//echo $file;

				$division = strtoupper(preg_replace("/_/"," ",preg_replace("/.xls/","",(preg_replace("/CAP_/", "", $file)))));

				//echo $division."\n";

				excelExec("cap/".$file,"Hoja1",['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','AA'],'infinitum',$division);
				echo("Termino sisa_cap\n");

				
			}
		}
	}

	sleep(20);
}
?>