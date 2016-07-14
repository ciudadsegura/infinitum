<?php	
	function conexion($serv,$dbname,$query){
		$conexiones= array(
		"bgpt"=>array('server' => "192.168.1.72",'user' => "rec1",'pass' => "Nextengo"),
		"bgpr"=>array('server' => "192.168.125.105",'user' => "usuario",'pass' => "Nextengo"),
		"logs"=>array('server' => "192.168.125.184",'user' => "rec3",'pass' => "Nextengo")
		);
		$servidor=$conexiones[$serv];
			$con=new mysqli($servidor['server'],$servidor['user'],$servidor['pass'],$dbname);

			if($con->connect_errno){
				$resultados[]=array('evento' =>"error",'msg' =>" >>>> ".$con->connect_error."\n");
				return $resultados;
			}

			$result= $con->query($query);

			$resultados= array();

				if (isset($result->num_rows)){
					$resultados[]=array('evento' =>"correcto",'msg' =>"Consulta ejecutada correctamente\n",'numRegs' =>$result->num_rows);
					$resultados=array_merge($resultados,$result->fetch_all(MYSQLI_ASSOC));
					$result->free_result();
				}else{
				
					if ($result == 1){
						$resultados[]=array('evento' =>"correcto",'msg' =>"Consulta ejecutada correctamente\n",'numRegs' =>$con->affected_rows,'id' =>$con->insert_id);
					}
					else{
						$resultados[]=array('evento' =>"error",'msg' =>"$query >>>> ".$con->error."\n");
					}
				}
			$con->close();
			$con=NULL;
			$result=NULL;
			return $resultados;
	}
	/*$query="LOAD DATA LOCAL INFILE '/var/www/html/logs_arch/LOGS7KMAYO2016_R.sql' INTO TABLE log";
	$result =conexion("bgpr",'logs_7kr',$query);
	if($result[0]['evento']=='error'){
		echo($result[0]['msg']);
	}*/
?>