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
				echo "<mensagem tipo=\"f\">O diretório especificado já existe e contém arquivos</mensagem>";
			} else {
				echo "<mensagem tipo=\"a\">O diretório especificado já existe mas está vazio</mensagem>";
			}
		} else {
			exec("touch " . $_SERVER["DOCUMENT_ROOT"] . "/cosasi666");
			if(file_exists($_SERVER["DOCUMENT_ROOT"] . "/cosasi666")){
				echo "<mensagem tipo=\"s\">O usuário do Apache HTTP Server possui permissão para a criação do diretório dos sistemas</mensagem>";
				exec("rm " . $_SERVER["DOCUMENT_ROOT"] . "/cosasi666");
			} else {
				echo "<mensagem tipo=\"f\">O usuário do Apache HTTP Server não possui permissão para a criação do diretório dos sistemas</mensagem>";	
			}
		}
		if($_POST["boRemoto"] == "true"){
			echo "<mensagem tipo=\"a\">O servidor de banco de dados PostgreSQL foi especificado como remoto, isso impede o instalador de verificar a existência do arquivo " . $_POST["stPathPlpgsqlPostgresql"] . "</mensagem>";
		} else {
			if(file_exists($_POST["stPathPlpgsqlPostgresql"])){
				echo "<mensagem tipo=\"s\">O arquivo " . $_POST["stPathPlpgsqlPostgresql"] . " foi encontrado no caminho especificado</mensagem>";
			} else {
				echo "<mensagem tipo=\"f\">O arquivo " . $_POST["stPathPlpgsqlPostgresql"] . " não foi encontrado no caminho especificado</mensagem>";
			}
		}
		$stConexao = "host=" . $_POST["stServidorPostgres"] . " port=" . $_POST["stPortaPostgres"] . " dbname=" . $_POST["stBdPostgres"] . " user=" . $_POST["stUsarioPostgres"] . " password=" . $_POST["stSenhaPostgres"];
		$obConexao = @pg_connect($stConexao);
		if(is_resource($obConexao)){
			echo "<mensagem tipo=\"s\">A conexão com o banco de dados foi realizada com sucesso</mensagem>";
		} else {
			echo "<mensagem tipo=\"f\">A conexão com o banco de dados não foi realizada com sucesso</mensagem>";
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
		/*Criação do diretório dos sistemas*/
		if(file_exists($stPathCompletoInstalacao)){
			exec("exec ls " . $stPathCompletoInstalacao, $arRetorno);
			if(count($arRetorno) > 0){
				echo "<mensagem tipo=\"f\">O diretório especificado já existe e contém arquivos</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			} else {
				echo "<mensagem tipo=\"a\">O diretório especificado já existe mas está vazio</mensagem>";
			}
		} else {
			exec("mkdir -p " . $stPathCompletoInstalacao);
			if(file_exists($stPathCompletoInstalacao)){
				echo "<mensagem tipo=\"s\">O diretório especificado para os sitemas foi criado com sucesso</mensagem>";
			} else {
				echo "<mensagem tipo=\"f\">O usuário do Apache HTTP Server não possui permissão para a criação do diretório dos sistemas</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		}
		/*Criação da linguagem plpgsql.so*/
		if(file_exists("arquivos/cria-linguagem.sql")){
			$fh = fopen("arquivos/cria-linguagem.sql", "r");
			if(is_resource($fh)){
				$stSQL = fread($fh, filesize("arquivos/cria-linguagem.sql"));
				$stSQL = str_replace("<PLPGSQL>", $_POST["stPathPlpgsqlPostgresql"], $stSQL);
				pg_query($obConexao, $stSQL);
				if(pg_last_error($obConexao)){
					if($_POST["boRemoto"] == "true"){
						echo "<mensagem tipo=\"f\">O servidor de banco de dados PostgreSQL foi informado como remoto (não está instalado na máquina local), verifique se o caminho para a plpgsql.so (" . $_POST["stPathPlpgsqlPostgresql"] . ") está correto no servidor especificado e se o usuário utilizado para a conexão é um superusuário do PostgreSQL (privilégio necessário para a instalação). Erro: " . pg_last_error($obConexao) . "</mensagem>";
						echo "</mensagens>";
						echo "</instalador>";
						exit();
					} else {
						echo "<mensagem tipo=\"f\">Verifique se o usuário utilizado para a conexão é um superusuário do PostgreSQL (privilégio necessário para a instalação). Erro: " . pg_last_error($obConexao) . "</mensagem>";
						echo "</mensagens>";
						echo "</instalador>";
						exit();
					}
				} else{
					echo "<mensagem tipo=\"s\">O handler PLPGSQL foi criado com sucesso</mensagem>";
				}
			} else {	
				echo "<mensagem tipo=\"f\">O arquivo que cria o handler PLPGSQL não pode ser aberto, verfique as permissões do usuário usado pelo Apache HTTP Server para a execução de scripts</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else {
			echo "<mensagem tipo=\"f\">O arquivo cria-linguagem.sql (arquivos/cria-linguagem.sql) não foi encontrado</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		}
		/*Criação do banco de dados e inserção dos dados básicos*/
		if(file_exists("arquivos/contra-saci-sisau.sql")){
			$fh = fopen("arquivos/contra-saci-sisau.sql", "r");
			if(is_resource($fh)){
				$stSQL = fread($fh, filesize("arquivos/contra-saci-sisau.sql"));
				fclose($fh);
				pg_query($obConexao, $stSQL);
				if(pg_last_error($obConexao)){
					echo "<mensagem tipo=\"f\">Um erro ocorreu durante a execução do script de criação da estrutura e inserção de dados básicos necessários, certifique-se que o arquivo não foi alterado. Erro: " . pg_last_error($obConexao) . "</mensagem>";
					echo "</mensagens>";
					echo "</instalador>";
					exit();
				} else{
					echo "<mensagem tipo=\"s\">A estrutura do banco de dados e a inserção de dados básicos necessários foram executados com sucesso</mensagem>";
				}
			} else {	
				echo "<mensagem tipo=\"f\">O arquivo de criação de estrutura de banco de dados e inserção de dados básicos necessários não pode ser aberto, verfique as permissões do usuário usado pelo Apache HTTP Server para execução de scripts</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else {
			echo "<mensagem tipo=\"f\">O arquivo contra-saci-sisau.sql (arquivos/contra-saci-sisau.sql) não foi encontrado</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		}
		/*Criação da unidade inicial da instalação*/
		$stSQL = "insert into und (undnome, undsigla, undresp, undend ) values ( '" . $_POST["stInstituicaoAdministrador"] . "', '" . strtoupper(substr($_POST["stInstituicaoAdministrador"], 0, 10)) . "', '" . $_POST["stNomeAdministrador"] . "', 'Nenhum')"; 
		pg_query($obConexao, $stSQL);
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Um erro ocorreu durante a inserção da Instituição do administrador dos Sistemas, certifique-se que os dados estão corretos. Erro: " . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();			
		} else {
			echo "<mensagem tipo=\"s\">A Instituição do administrador dos Sistemas foi inserida com sucesso</mensagem>";
		}
		/*Criação do usuário da intranet administrador do sistemas*/
		$stSQL = "insert into urd (urdlogin, urdnome, urdundid, urdsenha, urdsts, urddtinc, urddtaltsen) values ('" . $_POST["stLoginAdministradorSistemas"] . "', '" . $_POST["stNomeAdministrador"] . "', 1, '" . md5($_POST["stSenhaAdministradorSistemas"]) . "', 'AT', now(), now())";
		pg_query($obConexao, $stSQL);
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Um erro ocorreu durante a inserção do usuário de intranet do administrador dos Sistemas, certifique-se que os dados estão corretos. Erro: " . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();			
		} else {
			echo "<mensagem tipo=\"s\">O usuário de intranet do administrador dos Sistemas foi inserido com sucesso</mensagem>";
		}
		/*Criação do usuário dos sistemas*/
		$stSQL = "insert into usr (usrurdid, usrlogin, usrsenha) values (1, '" . $_POST["stLoginAdministradorSistemas"] . "', '" . md5($_POST["stSenhaAdministradorSistemas"]) . "')";
		pg_query($obConexao, $stSQL);
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Um erro ocorreu durante a inserção do usuário de sistemas do administrador, certifique-se que os dados estão corretos. Erro: " . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();			
		} else {
			echo "<mensagem tipo=\"s\">O usuário de sistemas do administrador foi inserido com sucesso</mensagem>";
		}
		/*Inserção de permissões de acesso iniciais*/
		$stSQL = "insert into acs (acsusrid, acsmenid, acsadic, acsalt, acsexc) select 1, menid, 't', 't', 't' from men";
		pg_query($obConexao, $stSQL);
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Um erro ocorreu durante a inserção das permissões de acesso iniciais do administrador dos Sistemas, certifique-se que o script de intalação não foi previamente modificado. Erro: " . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();			
		} else {
			echo "<mensagem tipo=\"s\">As permissões de acesso iniciais do administrador foram inseridas com sucesso</mensagem>";
		}
		/*Criação de perfis básicos do sistema*/
		if(file_exists("arquivos/perfis-contra-saci-sisau.sql")){
			$fh = fopen("arquivos/perfis-contra-saci-sisau.sql", "r");
			if(is_resource($fh)){
				$stSQL = fread($fh, filesize("arquivos/perfis-contra-saci-sisau.sql"));
				fclose($fh);
				pg_query($obConexao, $stSQL);
				if(pg_last_error($obConexao)){
					echo "<mensagem tipo=\"f\">Um erro ocorreu durante a execução do script de insercção de perfis básicos necessários, certifique-se que o arquivo não foi alterado. Erro: " . pg_last_error($obConexao) . "</mensagem>";
					echo "</mensagens>";
					echo "</instalador>";
					exit();
				} else{
					echo "<mensagem tipo=\"s\">A inserção dos perfis básicos necessários foi executada com sucesso</mensagem>";
				}
			} else {	
				echo "<mensagem tipo=\"f\">O arquivo de criação de perfis básicos necessários não pode ser aberto, verfique as permissões do usuário usado pelo Apache HTTP Server para execução de scripts</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else {
			echo "<mensagem tipo=\"f\">O arquivo perfis-contra-saci-sisau.sql (arquivos/perfis-contra-saci-sisau.sql) não foi encontrado</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		}
		/*Criando atendente*/
		$stSQL = "insert into atd (atdurdid, atddvsid) values (1, 1)";
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Um erro ocorreu durante a inserção do atendente dos Sistemas, certifique-se que o script de instalação não foi previamente modificado. Erro: " . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();			
		} else {
			echo "<mensagem tipo=\"s\">O usuário atendente do sistema foi definido com sucesso</mensagem>";
		}
		/*Criando arquivos de configuração config.php*/
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
						echo "<mensagem tipo=\"s\">As novas configurações foram gravadas no arquivo config.php (arquivos/config.php) com sucesso</mensagem>";
					} else {
						echo "<mensagem tipo=\"f\">As novas configurações não puderam ser gravadas no arquivo config.php (arquivos/config.php), verfique as permissões do usuário usado pelo Apache HTTP Server para execução de scripts</mensagem>";
						echo "</mensagens>";
						echo "</instalador>";
						exit();
					}
				} else {
					echo "<mensagem tipo=\"f\">O arquivo de configuração não pode ser criado, verfique as permissões do usuário usado pelo Apache HTTP Server para execução de scripts</mensagem>";
					echo "</mensagens>";
					echo "</instalador>";
					exit();	
				}
			} else {	
				echo "<mensagem tipo=\"f\">O arquivo de criação de perfis básicos necessários não pode ser aberto, verfique as permissões do usuário usado pelo Apache HTTP Server para execução de scripts</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else {
			echo "<mensagem tipo=\"f\">O arquivo config.php.base (arquivos/config.php.base) não foi encontrado</mensagem>";
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
						echo "<mensagem tipo=\"s\">As novas configurações foram gravadas no arquivo index.php (arquivos/index.php) com sucesso</mensagem>";
					} else {
						echo "<mensagem tipo=\"f\">As novas configurações não puderam ser gravadas no arquivo index.php (arquivos/index.ini), verfique as permissões do usuário usado pelo Apache HTTP Server para execução de scripts</mensagem>";
						echo "</mensagens>";
						echo "</instalador>";
						exit();
					}
				} else {
					echo "<mensagem tipo=\"f\">O arquivo index.php não pode ser criado, verfique as permissões do usuário usado pelo Apache HTTP Server para execução de scripts</mensagem>";
					echo "</mensagens>";
					echo "</instalador>";
					exit();	
				}
			} else {
				echo "<mensagem tipo=\"f\">O arquivo de criação página index.php necessários não pode ser aberto, verfique as permissões do usuário usado pelo Apache HTTP Server para execução de scripts</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else {
			echo "<mensagem tipo=\"f\">O arquivo config.php.base (arquivos/config.php.base) não foi encontrado</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		}
		/*Atualizando informações do dominio inicial*/
		$stSQL =  "update dmn set dmnurl='http://" . $_SERVER["SERVER_NAME"] . $_POST["stDiretorioSistemas"] . "/intranet',dmnraiz='" . $stPathCompletoInstalacao . "/intranet'";
		pg_query($obConexao, $stSQL);
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Um erro ocorreu durante a atualização do domínio da intranet dos Sistemas, certifique-se que o script de instalação não foi previamente modificado. Erro: " . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		} else {
			echo "<mensagem tipo=\"s\">As informações do doimínio da intranet foram alteradas com sucesso</mensagem>";
		}
		/*Atualizando o valora da variavel vloctemplate*/
		$stSQL = "update var set varvalor='" . $_POST["stDiretorioSistemas"] . "/modelos' where varnome='vloctemplate'";
		if(pg_last_error($obConexao)){
			echo "<mensagem tipo=\"f\">Um erro ocorreu durante a atualização do valor da variável de ambiente (vloctemplate) dos Sistemas, certifique-se que o script de instalação não foi previamente modificado. Erro: " . pg_last_error($obConexao) . "</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		} else {
			echo "<mensagem tipo=\"s\">O valor da variável de ambiente (vloctemplate) foi alterada com sucesso</mensagem>";
		}
		/*Descompactando os arquivos do sistema*/
		if(file_exists("arquivos/contra-saci-sisau.tar.gz")){
			exec("tar -zxvf arquivos/contra-saci-sisau.tar.gz -C " . $stPathCompletoInstalacao, $arRetorno);
			if(count($arRetorno) > 0){
				echo "<mensagem tipo=\"s\">Os arquivos do sistema foram extraidos com sucesso</mensagem>";
			} else {
				echo "<mensagem tipo=\"f\">Um erro ocorreu durante a extração dos arquivos dos sistemas (contra-saci-sisau.tar.gz), verfique as permissões do usuário usado pelo Apache HTTP Server para a execução de scripts</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else{
			echo "<mensagem tipo=\"f\">O arquivo contra-saci-sisau.tar.gz (arquivos/contra-saci-sisau.tar.gz) não foi encontrado</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();
		}
		/*Movendo arquivos de configuração dos sistemas*/
		if(file_exists("arquivos/config.php")){
			exec("cp arquivos/config.php " . $stPathCompletoInstalacao, $arRetorno);
			if(file_exists($stPathCompletoInstalacao . "/config.php")){
				echo "<mensagem tipo=\"s\">O arquivo de configuração do sistema (arquivos/config.php) foi movido com sucesso para " . $stPathCompletoInstalacao . "</mensagem>"; 
			} else {
				echo "<mensagem tipo=\"f\">O arquivo de configuração (arquivos/config.php) não pode ser movido para " . $stPathCompletoInstalacao . "</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else {
			echo "<mensagem tipo=\"f\">O arquivo config.php (arquivos/config.php) não foi encontrado</mensagem>";
			echo "</mensagens>";
			echo "</instalador>";
			exit();	
		}
		if(file_exists("arquivos/index.php")){
			exec("cp arquivos/index.php " . $stPathCompletoInstalacao . "/classes/saci", $arRetorno);
			if(file_exists($stPathCompletoInstalacao . "/classes/saci/index.php")){
				echo "<mensagem tipo=\"s\">O arquivo index.php do sistema (arquivos/index.php) foi movido com sucesso para " . $stPathCompletoInstalacao . "/classes/saci</mensagem>"; 
			} else {
				echo "<mensagem tipo=\"f\">O arquivo index.php do sistema (arquivos/index.php) não pode ser movido para " . $stPathCompletoInstalacao . "/classes/saci</mensagem>";
				echo "</mensagens>";
				echo "</instalador>";
				exit();
			}
		} else {
			echo "<mensagem tipo=\"f\">O arquivo index.php (arquivos/index.php) não foi encontrado</mensagem>";
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