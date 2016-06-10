<?php
error_reporting(E_NONE);
/*
 * Created on Aug 8, 2006
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
header("Content-type: text/xml; charset=ISO-8859-1");
/*Trata erros de path*/
$_POST["stDiretorioSistemas"] = "/" . $_POST["stDiretorioSistemas"];
$_POST["stDiretorioSistemas"] = preg_replace('/[^\w\/\.\-]/','',$_POST["stDiretorioSistemas"]); 
$_POST["stDiretorioSistemas"] = preg_replace('/[\/]+/','/',$_POST["stDiretorioSistemas"]); 
$_POST["stPathPlpgsqlPostgresql"] = preg_replace('/[^\w\/\.\-]/','',$_POST["stPathPlpgsqlPostgresql"]);
$_POST["stPathPlpgsqlPostgresql"] = preg_replace('/[\/]+/','/',$_POST["stPathPlpgsqlPostgresql"]);
$stPathCompletoInstalacao = $_SERVER["DOCUMENT_ROOT"] . $_POST["stDiretorioSistemas"];
$stPathCompletoInstalacao = preg_replace('/[^\w\/]/', '', $stPathCompletoInstalacao);
$stPathCompletoInstalacao = preg_replace('/[\/]+/', '/', $stPathCompletoInstalacao);
switch ($_POST["stAcao"]) {
	case "verficaInstalacao":
		echo "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>";
		echo "<instalador>";
		echo "<guia acao=\"" . $_POST["stAcao"] . "\"/>";
		echo "<mensagens>";
		if(file_exists($stPathCompletoInstalacao)){
			exec("exec ls " . $stPathCompletoInstalacao, $arRetorno);
			if(count($arRetorno) > 0){
				echo "<mensagem tipo=\"f\">O diret�rio especificado j� existe e cont�m arquivos</mensagem>";
			} else {
				echo "<mensagem tipo=\"a\">O diret�rio especificado j� existe mas est� vazio</mensagem>";
			}
		} else {
			exec("touch " . $_SERVER["DOCUMENT_ROOT"] . "/cosasi666");
			if(file_exists($_SERVER["DOCUMENT_ROOT"] . "/cosasi666")){
				echo "<mensagem tipo=\"s\">O usu�rio do Apache HTTP Server possui permiss�o para a cria��o do diret�rio dos sistemas</mensagem>";
				exec("rm " . $_SERVER["DOCUMENT_ROOT"] . "/cosasi666");
			} else {
				echo "<mensagem tipo=\"f\">O usu�rio do Apache HTTP Server n�o possui permiss�o para a cria��o do diret�rio dos sistemas</mensagem>";	
			}
		}
		if($_POST["boRemoto"] == "true"){
			echo "<mensagem tipo=\"a\">O servidor de banco de dados PostgreSQL foi especificado como remoto, isso impede o instalador de verificar a exist�ncia do arquivo " . $_POST["stPathPlpgsqlPostgresql"] . "</mensagem>";
		} else {
			if(file_exists($_POST["stPathPlpgsqlPostgresql"])){
				echo "<mensagem tipo=\"s\">O arquivo " . $_POST["stPathPlpgsqlPostgresql"] . " foi encontrado no caminho especificado</mensagem>";
			} else {
				echo "<mensagem tipo=\"f\">O arquivo " . $_POST["stPathPlpgsqlPostgresql"] . " n�o foi encontrado no caminho especificado</mensagem>";
			}
		}
		$stConexao = "host=" . $_POST["stServidorPostgres"] . " port=" . $_POST["stPortaPostgres"] . " dbname=" . $_POST["stBdPostgres"] . " user=" . $_POST["stUsarioPostgres"] . " password=" . $_POST["stSenhaPostgres"];
		$obConexao = @pg_connect($stConexao);
		if(is_resource($obConexao)){
			echo "<mensagem tipo=\"s\">A conex�o com o banco de dados foi realizada com sucesso</mensagem>";
		} else {
			echo "<mensagem tipo=\"f\">A conex�o com o banco de dados n�o foi realizada com sucesso</mensagem>";
		}
		echo "</mensagens>";
		echo "</instalador>";
	break;
	
	case "instalaSistemas":
		echo "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>";
		echo "<instalador>";
		echo "<guia acao=\"" . $_POST["stAcao"] . "\"/>";
		echo "<mensagens>";
		$stConexao = "host=" . $_POST["stServidorPostgres"] . " port=" . $_POST["stPortaPostgres"] . " dbname=" . $_POST["stBdPostgres"] . " user=" . $_POST["stUsarioPostgres"] . " password=" . $_POST["stSenhaPostgres"];
		$obConexao = @pg_connect($stConexao);
		/*Cria��o do diret�rio dos sistemas*/
		if(file_exists($stPathCompletoInstalacao)){
			exec("exec ls " . $stPathCompletoInstalacao, $arRetorno);
			if(count($arRetorno) > 0){
				echo "<mensagem tipo=\"f\">O diret�rio especificado j� existe e cont�m arquivos</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			} else {
				echo "<mensagem tipo=\"a\">O diret�rio especificado j� existe mas est� vazio</mensagem>";
			}
		} else {
			exec("mkdir -p " . $stPathCompletoInstalacao);
			if(file_exists($stPathCompletoInstalacao)){
				echo "<mensagem tipo=\"s\">O diret�rio especificado para os sitemas foi criado com sucesso</mensagem>";
			} else {
				echo "<mensagem tipo=\"f\">O usu�rio do Apache HTTP Server n�o possui permiss�o para a cria��o do diret�rio dos sistemas</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		}
		/*Cria��o da linguagem plpgsql.so*/
		if(file_exists("arquivos/cria-linguagem.sql")){
			$fh = fopen("arquivos/cria-linguagem.sql", "r");
			if(is_resource($fh)){
				$stSQL = fread($fh, filesize("arquivos/cria-linguagem.sql"));
				$stSQL = str_replace("<PLPGSQL>", $_POST["stPathPlpgsqlPostgresql"], $stSQL);
				pg_query($obConexao, $stSQL);
				if(pg_last_error($obConexao)){
					if($_POST["boRemoto"] == "true"){
						echo "<mensagem tipo=\"f\">O servidor de banco de dados PostgreSQL foi informado como remoto (n�o est� instalado na m�quina local), verifique se o caminho para a plpgsql.so (" . $_POST["stPathPlpgsqlPostgresql"] . ") est� correto no servidor especificado e se o usu�rio utilizado para a conex�o � um superusu�rio do PostgreSQL (privil�gio necess�rio para a instala��o). Erro: " . pg_last_error($obConexao) . "</mensagem>";
						echo "</mensagens>";
						echo "</instalador>";
						exit();
					} else {
						echo "<mensagem tipo=\"f\">Verifique se o usu�rio utilizado para a conex�o � um superusu�rio do PostgreSQL (privil�gio necess�rio para a instala��o). Erro: " . pg_last_error($obConexao) . "</mensagem>";
						echo "</mensagens>";
						echo "</instalador>";
						exit();
					}
				} else{
					echo "<mensagem tipo=\"s\">O handler PLPGSQL foi criado com sucesso</mensagem>";
				}
			} else {	
				echo "<mensagem tipo=\"f\">O arquivo que cria o handler PLPGSQL n�o pode ser aberto, verfique as permiss�es do usu�rio usado pelo Apache HTTP Server para a execu��o de scripts</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else {
			echo "<mensagem tipo=\"f\">O arquivo cria-linguagem.sql (arquivos/cria-linguagem.sql) n�o foi encontrado</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		}
		/*Cria��o do banco de dados e inser��o dos dados b�sicos*/
		if(file_exists("arquivos/contra-saci-sisau.sql")){
			$fh = fopen("arquivos/contra-saci-sisau.sql", "r");
			if(is_resource($fh)){
				$stSQL = fread($fh, filesize("arquivos/contra-saci-sisau.sql"));
				fclose($fh);
				pg_query($obConexao, $stSQL);
				if(pg_last_error($obConexao)){
					echo "<mensagem tipo=\"f\">Um erro ocorreu durante a execu��o do script de cria��o da estrutura e inser��o de dados b�sicos necess�rios, certifique-se que o arquivo n�o foi alterado. Erro: " . pg_last_error($obConexao) . "</mensagem>";
					echo "</mensagens>";
					echo "</instalador>";
					exit();
				} else{
					echo "<mensagem tipo=\"s\">A estrutura do banco de dados e a inser��o de dados b�sicos necess�rios foram executados com sucesso</mensagem>";
				}
			} else {	
				echo "<mensagem tipo=\"f\">O arquivo de cria��o de estrutura de banco de dados e inser��o de dados b�sicos necess�rios n�o pode ser aberto, verfique as permiss�es do usu�rio usado pelo Apache HTTP Server para execu��o de scripts</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else {
			echo "<mensagem tipo=\"f\">O arquivo contra-saci-sisau.sql (arquivos/contra-saci-sisau.sql) n�o foi encontrado</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		}
		/*Cria��o da unidade inicial da instala��o*/
		$stSQL = "insert into und (undnome, undsigla, undresp, undend ) values ( '" . $_POST["stInstituicaoAdministrador"] . "', '" . strtoupper(substr($_POST["stInstituicaoAdministrador"], 0, 10)) . "', '" . $_POST["stNomeAdministrador"] . "', 'Nenhum')"; 
		pg_query($obConexao, $stSQL);
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Um erro ocorreu durante a inser��o da Institui��o do administrador dos Sistemas, certifique-se que os dados est�o corretos. Erro: " . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();			
		} else {
			echo "<mensagem tipo=\"s\">A Institui��o do administrador dos Sistemas foi inserida com sucesso</mensagem>";
		}
		/*Cria��o do usu�rio da intranet administrador do sistemas*/
		$stSQL = "insert into urd (urdlogin, urdnome, urdundid, urdsenha, urdsts, urddtinc, urddtaltsen) values ('" . $_POST["stLoginAdministradorSistemas"] . "', '" . $_POST["stNomeAdministrador"] . "', 1, '" . md5($_POST["stSenhaAdministradorSistemas"]) . "', 'AT', now(), now())";
		pg_query($obConexao, $stSQL);
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Um erro ocorreu durante a inser��o do usu�rio de intranet do administrador dos Sistemas, certifique-se que os dados est�o corretos. Erro: " . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();			
		} else {
			echo "<mensagem tipo=\"s\">O usu�rio de intranet do administrador dos Sistemas foi inserido com sucesso</mensagem>";
		}
		/*Cria��o do usu�rio dos sistemas*/
		$stSQL = "insert into usr (usrurdid, usrlogin, usrsenha) values (1, '" . $_POST["stLoginAdministradorSistemas"] . "', '" . md5($_POST["stSenhaAdministradorSistemas"]) . "')";
		pg_query($obConexao, $stSQL);
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Um erro ocorreu durante a inser��o do usu�rio de sistemas do administrador, certifique-se que os dados est�o corretos. Erro: " . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();			
		} else {
			echo "<mensagem tipo=\"s\">O usu�rio de sistemas do administrador foi inserido com sucesso</mensagem>";
		}
		/*Inser��o de permiss�es de acesso iniciais*/
		$stSQL = "insert into acs (acsusrid, acsmenid, acsadic, acsalt, acsexc) select 1, menid, 't', 't', 't' from men";
		pg_query($obConexao, $stSQL);
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Um erro ocorreu durante a inser��o das permiss�es de acesso iniciais do administrador dos Sistemas, certifique-se que o script de intala��o n�o foi previamente modificado. Erro: " . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();			
		} else {
			echo "<mensagem tipo=\"s\">As permiss�es de acesso iniciais do administrador foram inseridas com sucesso</mensagem>";
		}
		/*Cria��o de perfis b�sicos do sistema*/
		if(file_exists("arquivos/perfis-contra-saci-sisau.sql")){
			$fh = fopen("arquivos/perfis-contra-saci-sisau.sql", "r");
			if(is_resource($fh)){
				$stSQL = fread($fh, filesize("arquivos/perfis-contra-saci-sisau.sql"));
				fclose($fh);
				pg_query($obConexao, $stSQL);
				if(pg_last_error($obConexao)){
					echo "<mensagem tipo=\"f\">Um erro ocorreu durante a execu��o do script de inserc��o de perfis b�sicos necess�rios, certifique-se que o arquivo n�o foi alterado. Erro: " . pg_last_error($obConexao) . "</mensagem>";
					echo "</mensagens>";
					echo "</instalador>";
					exit();
				} else{
					echo "<mensagem tipo=\"s\">A inser��o dos perfis b�sicos necess�rios foi executada com sucesso</mensagem>";
				}
			} else {	
				echo "<mensagem tipo=\"f\">O arquivo de cria��o de perfis b�sicos necess�rios n�o pode ser aberto, verfique as permiss�es do usu�rio usado pelo Apache HTTP Server para execu��o de scripts</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else {
			echo "<mensagem tipo=\"f\">O arquivo perfis-contra-saci-sisau.sql (arquivos/perfis-contra-saci-sisau.sql) n�o foi encontrado</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		}
		/*Criando atendente*/
		$stSQL = "insert into atd (atdurdid, atddvsid) values (1, 1)";
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Um erro ocorreu durante a inser��o do atendente dos Sistemas, certifique-se que o script de instala��o n�o foi previamente modificado. Erro: " . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();			
		} else {
			echo "<mensagem tipo=\"s\">O usu�rio atendente do sistema foi definido com sucesso</mensagem>";
		}
		/*Criando arquivos de configura��o config.php*/
		if(file_exists("arquivos/config.php.base")){
			$fh = fopen("arquivos/config.php.base", "r");
			if(is_resource($fh)){
				$stConfigBase = fread($fh, filesize("arquivos/config.php.base"));
				fclose($fh);
				$arSubstituicoes = array("<DIRRAIZ>" => $_SERVER["DOCUMENT_ROOT"], "<DIRSIS>" => $_POST["stDiretorioSistemas"], "<BDHOST>" => $_POST["stServidorPostgres"], "<BDPORT>" => $_POST["stPortaPostgres"], "<BDNAME>" => $_POST["stBdPostgres"], "<BDUSER>" => $_POST["stUsarioPostgres"], "<BDPWD>" => $_POST["stSenhaPostgres"]);
				$arSubstituir = array_keys($arSubstituicoes);
				for($i = 0; $i < count($arSubstituicoes); $i++){
					$stConfigBase = str_replace($arSubstituir[$i], $arSubstituicoes[$arSubstituir[$i]], $stConfigBase);
				}
				$fh = fopen("arquivos/config.php", "w");
				if(is_resource($fh)){
					if(fwrite($fh, $stConfigBase)){
						fclose($fh);
						echo "<mensagem tipo=\"s\">As novas configura��es foram gravadas no arquivo config.php (arquivos/config.php) com sucesso</mensagem>";
					} else {
						echo "<mensagem tipo=\"f\">As novas configura��es n�o puderam ser gravadas no arquivo config.php (arquivos/config.php), verfique as permiss�es do usu�rio usado pelo Apache HTTP Server para execu��o de scripts</mensagem>";
						echo "</mensagens>";
						echo "</instalador>";
						exit();
					}
				} else {
					echo "<mensagem tipo=\"f\">O arquivo de configura��o n�o pode ser criado, verfique as permiss�es do usu�rio usado pelo Apache HTTP Server para execu��o de scripts</mensagem>";
					echo "</mensagens>";
					echo "</instalador>";
					exit();	
				}
			} else {	
				echo "<mensagem tipo=\"f\">O arquivo de cria��o de perfis b�sicos necess�rios n�o pode ser aberto, verfique as permiss�es do usu�rio usado pelo Apache HTTP Server para execu��o de scripts</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else {
			echo "<mensagem tipo=\"f\">O arquivo config.php.base (arquivos/config.php.base) n�o foi encontrado</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();	
		}
		/*Criando o arquivo index.php*/
		if(file_exists("arquivos/index.php.base")){
			$fh = fopen("arquivos/index.php.base", "r");
			if(is_resource($fh)){
				$stIndexBase = fread($fh, filesize("arquivos/index.php.base"));
				$stIndexBase = str_replace("<DIRSIS>", $stPathCompletoInstalacao, $stIndexBase);
				$fh = fopen("arquivos/index.php", "w");
				if(is_resource($fh)){
					if(fwrite($fh, $stIndexBase)){
						fclose($fh);
						echo "<mensagem tipo=\"s\">As novas configura��es foram gravadas no arquivo index.php (arquivos/index.php) com sucesso</mensagem>";
					} else {
						echo "<mensagem tipo=\"f\">As novas configura��es n�o puderam ser gravadas no arquivo index.php (arquivos/index.ini), verfique as permiss�es do usu�rio usado pelo Apache HTTP Server para execu��o de scripts</mensagem>";
						echo "</mensagens>";
						echo "</instalador>";
						exit();
					}
				} else {
					echo "<mensagem tipo=\"f\">O arquivo index.php n�o pode ser criado, verfique as permiss�es do usu�rio usado pelo Apache HTTP Server para execu��o de scripts</mensagem>";
					echo "</mensagens>";
					echo "</instalador>";
					exit();	
				}
			} else {
				echo "<mensagem tipo=\"f\">O arquivo de cria��o p�gina index.php necess�rios n�o pode ser aberto, verfique as permiss�es do usu�rio usado pelo Apache HTTP Server para execu��o de scripts</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else {
			echo "<mensagem tipo=\"f\">O arquivo config.php.base (arquivos/config.php.base) n�o foi encontrado</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		}
		/*Atualizando informa��es do dominio inicial*/
		$stSQL =  "update dmn set dmnurl='http://" . $_SERVER["SERVER_NAME"] . $_POST["stDiretorioSistemas"] . "/intranet',dmnraiz='" . $stPathCompletoInstalacao . "/intranet'";
		pg_query($obConexao, $stSQL);
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Um erro ocorreu durante a atualiza��o do dom�nio da intranet dos Sistemas, certifique-se que o script de instala��o n�o foi previamente modificado. Erro: " . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		} else {
			echo "<mensagem tipo=\"s\">As informa��es do doim�nio da intranet foram alteradas com sucesso</mensagem>";
		}
		/*Atualizando o valora da variavel vloctemplate*/
		$stSQL = "update var set varvalor='" . $_POST["stDiretorioSistemas"] . "/modelos' where varnome='vloctemplate'";
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Um erro ocorreu durante a atualiza��o do valor da vari�vel de ambiente (vloctemplate) dos Sistemas, certifique-se que o script de instala��o n�o foi previamente modificado. Erro: " . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		} else {
			echo "<mensagem tipo=\"s\">O valor da vari�vel de ambiente (vloctemplate) foi alterada com sucesso</mensagem>";
		}
		/*Descompactando os arquivos do sistema*/
		if(file_exists("arquivos/contra-saci-sisau.tar.gz")){
			exec("tar -zxvf arquivos/contra-saci-sisau.tar.gz -C " . $stPathCompletoInstalacao, $arRetorno);
			if(count($arRetorno) > 0){
				echo "<mensagem tipo=\"s\">Os arquivos do sistema foram extraidos com sucesso</mensagem>";
			} else {
				echo "<mensagem tipo=\"f\">Um erro ocorreu durante a extra��o dos arquivos dos sistemas (contra-saci-sisau.tar.gz), verfique as permiss�es do usu�rio usado pelo Apache HTTP Server para a execu��o de scripts</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else{
			echo "<mensagem tipo=\"f\">O arquivo contra-saci-sisau.tar.gz (arquivos/contra-saci-sisau.tar.gz) n�o foi encontrado</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		}
		/*Movendo arquivos de configura��o dos sistemas*/
		if(file_exists("arquivos/config.php")){
			exec("cp arquivos/config.php " . $stPathCompletoInstalacao, $arRetorno);
			if(file_exists($stPathCompletoInstalacao . "/config.php")){
				echo "<mensagem tipo=\"s\">O arquivo de configura��o do sistema (arquivos/config.php) foi movido com sucesso para " . $stPathCompletoInstalacao . "</mensagem>"; 
			} else {
				echo "<mensagem tipo=\"f\">O arquivo de configura��o (arquivos/config.php) n�o pode ser movido para " . $stPathCompletoInstalacao . "</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else {
			echo "<mensagem tipo=\"f\">O arquivo config.php (arquivos/config.php) n�o foi encontrado</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();	
		}
		if(file_exists("arquivos/index.php")){
			exec("cp arquivos/index.php " . $stPathCompletoInstalacao . "/classes/saci", $arRetorno);
			if(file_exists($stPathCompletoInstalacao . "/classes/saci/index.php")){
				echo "<mensagem tipo=\"s\">O arquivo index.php do sistema (arquivos/index.php) foi movido com sucesso para " . $stPathCompletoInstalacao . "/classes/saci</mensagem>"; 
			} else {
				echo "<mensagem tipo=\"f\">O arquivo index.php do sistema (arquivos/index.php) n�o pode ser movido para " . $stPathCompletoInstalacao . "/classes/saci</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else {
			echo "<mensagem tipo=\"f\">O arquivo index.php (arquivos/index.php) n�o foi encontrado</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();	
		}
		echo "</mensagens>";
		echo "</instalador>";
	break;
	
	case "limpaBanco":
		echo "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>";
		echo "<instalador>";
		echo "<guia acao=\"" . $_POST["stAcao"] . "\"/>";
		echo "<mensagens>";
		$stConexao = "host=" . $_POST["stServidorPostgres"] . " port=" . $_POST["stPortaPostgres"] . " dbname=" . $_POST["stBdPostgres"] . " user=" . $_POST["stUsarioPostgres"] . " password=" . $_POST["stSenhaPostgres"];
		$obConexao = @pg_connect($stConexao);
		pg_query($obConexao, "drop schema public cascade");
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Erro ao apagar o schema public do banco de dados selecionado. Erro:" . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		} else {
			echo "<mensagem tipo=\"s\">Schema public apagado com sucess. Erro:" . pg_last_error($obConexao) . "</mensagem>";	
		}
		pg_query($obConexao, "create schema public");
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Erro ao criar o schema public no banco de dados selecionado. Erro:" . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		} else {
			echo "<mensagem tipo=\"s\">Schema public criado com sucess. Erro:" . pg_last_error($obConexao) . "</mensagem>";	
		}
		echo "</mensagens>";
		echo "</instalador>";
	break;
}
?>