<?php
/* Caso esteja vendo as linhas de código seu PHP não está funcionando */
$verificaPHP = "<img src=\"imagens/gtk-ok.png\">";
session_start();
@include_once("Smarty.class.php");
$ok = true;
if(substr($_SERVER["SERVER_SOFTWARE"], 0, 6) == "Apache"){
	$verificaServerApache = "<img src=\"imagens/gtk-ok.png\">";
} else {
	$verificaServerApache = "<img src=\"imagens/gtk-no.png\">";
	$arErros[] = " - O servidor HTTP não satisfaz o quesito de ambiente.";
	$ok = false;
}
@exec("touch arquivos/teste666");
if(file_exists("arquivos/teste666")){
	$verificaPermissaoPastaInstalacao = "<img src=\"imagens/gtk-ok.png\">";
	exec("rm arquivos/teste666");
} else {
	$verificaPermissaoPastaInstalacao = "<img src=\"imagens/gtk-no.png\">";
	$arErros[] = " - O usuário do Apache HTTP Server precisa ter permissões de leitura e gravação na pasta do instalador e suas subpastas.";
	$ok = false;
}
if (function_exists("pg_connect") ) { 
	$verificaSuportePostgres = "<img src=\"imagens/gtk-ok.png\">";
} else {
	$verificaServerPostgres = "<img src=\"imagens/gtk-no.png\">";
	$arErros[] = " - O PHP instaldo não dá suporte a conexões com bancos de dados PostgreSQL.";
	$ok = false;
}
if(class_exists('Smarty')){
	$verificaSuporteSmarty = "<img src=\"imagens/gtk-ok.png\">";
} else {
	$verificaSuporteSmarty = "<img src=\"imagens/gtk-no.png\">";
	$arErros[] = " - O sistema de templates Smarty não foi encontrado (verificar a variável <b>include_path</b> do arquivo de configuração do PHP <b>php.ini</b>).";
	$ok = false;
}
exec("pidof postgres", $arPidPostMaster);
if(str_replace( " ", "", $arPidPostMaster[0] ) > 0){
	$verificaServerPostgres = "<img src=\"imagens/gtk-ok.png\">";
	$okServerPostgres = "";
	$mensgemPostgres = "Marque esta caixa caso o banco de dados não esteja instalado na mesma máquina que os sistemas serão instalados.";
} else {
	$verificaServerPostgres = "<img src=\"imagens/gtk-warning.png\">";
	$okServerPostgres = "checked";
	$readOnly = "disabled";
	$mensgemPostgres = "O serviço de banco de dados postgres não foi detectado nesta máquina, a instalação irá considerar o banco de dados como remoto.";
}
?>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta name="author" content="Apoena Machado Cunha/ Paulo Eduardo Ferreira" />
		<meta name="language" content="pt-br" />	
		<link href="css/instalador.css" rel="stylesheet" type="text/css">
		<script src="js/instalador.js"></script>
		<title>Instalação dos Sitemas Contra, Saci e Sisau</title>
	</head>
	<body>
		<form id="instalador">
			<div id="geral">
				<div class="bloco" style="height: 58px; padding-top: 0px;">
					<h1><img src="imagens/install.png" align="absmiddle">Intalador dos Sistemas Contra, Saci Livre e Sisau</h1>
				</div>
				<br>
				<div class="bloco">
					<table border="0" cellpadding="1" cellspacing="0" width="100%">	  
						<tr>
						  <td colspan="2"><h4><img src="imagens/ambiente.png" align="absmiddle">&nbsp;Ambiente de Instalação</img></h4></td>	  
						<tr>
							<td>Apache HTTP Server</td>
							<td><?=$verificaServerApache?></td>
						</tr>
						<tr>
							<td>Permissão do do usuário do Apache HTTP Server na pasta do instalador</td>
							<td><?=$verificaPermissaoPastaInstalacao?></td>
						</tr>
						<tr>
							<td>PHP Hypertext Processor</td> 
							<td><?=$verificaPHP?></td>
						</tr>
						<tr>
							<td>Suporte ao banco de dados PostgreSQL</td> 
							<td><?=$verificaSuportePostgres?></td>
						</tr>
						<tr>
							<td>Suporte ao Sistemas de Templates Smarty</td> 
							<td><?=$verificaSuporteSmarty?></td>
						</tr>
						<tr>
							<td>PostgreSQL local ou remoto</td>
							<td><?=$verificaServerPostgres?></td>
						</tr>
					</table>
					</p>
				</div>
				<?php
				if(!$ok){
				?>
				<br>
				<div class="bloco">
					<table border="0" cellpadding="1" cellspacing="0" width="100%">	  
						<tr>
						  <td><h4><img src="imagens/gtk-no.png" align="absmiddle">&nbsp;A Intalação Foi Abortada</img></h4></td>	  
						</tr>
						<?php
						for($i = 0; $i < count($arErros); $i++){
						?>
						<tr>
						  <td class="er"><?=$arErros[$i]?></td>	  
						</tr>
						<?php
						}
						?>
					</table>
				</div>
				<?php
				} else {
				?>
				<br>
				<div class="bloco">
					<table border="0" cellpadding="1" cellspacing="0" width="100%">	  
						<tr>
							<td colspan="2"><h4><img src="imagens/diretorios.png" align="absmiddle">&nbsp;Diretórios da Instalação</img></h4></td>	  
						</tr>
						<tr>
							<td width="32%">Diretório Raiz</td>
							<td width="75%" class="detalhes"><?php echo $_SERVER['DOCUMENT_ROOT']?></td>
						</tr>
						<tr> 
							<td width="32%">Diretório do Sistema</td>
							<td width="75%" class="detalhes"><?php echo $_SERVER['DOCUMENT_ROOT']?><input size="30" type="text" requerido="Favor informar o nome do diretório onde deseja instalar os Sistemas." name="stDiretorioSistemas"></td>
						</tr>
						<tr>
							<td width="32%">Diretório de Classes</td>
							<td width="75%" class="detalhes">/classes</td>
						</tr>
						<tr>
							<td width="32%">Diretório de Bibliotecas</td>
							<td width="75%" class="detalhes">/bibliotecas/php</td>
						</tr>
						<tr>
							<td width="32%">Diretório de JavaScripts</td>
							<td width="75%" class="detalhes">/bibliotecas/js</td>
						</tr>
						<tr>
							<td width="32%">Diretório de CSSs</td>
							<td width="75%" class="detalhes">/bibliotecas/css</td>
						</tr>
						<tr>
							<td width="32%">Diretório de Imagens</td>
							<td width="75%" class="detalhes">/bibliotecas/img</td>
						</tr>	
						<tr>
							<td width="32%">Diretório de Templates</td>
							<td width="75%" class="detalhes">/modelos</td>
						</tr>
					</table>
				</div>
				<br>
				<div class="bloco">
					<table border="0" cellpadding="1" cellspacing="0" width="100%">
						<tr>
							<td colspan="3"><h4><img src="imagens/banco.png" align="absmiddle">&nbsp;Variáveis de Conexão com Banco de Dados</img></h4></td>	  
						</tr>
						<tr> 
							<td width="32%">Endereço do Servidor</td>
							<td width="45%" class="detalhes"><input type="text" requerido="Favor informar o endereço do servidor de banco de dados PostgreSQL." name="stServidorPostgres"></td>
							<td class="detalhes"><?php if($readOnly){?><input type="hidden" name="boRemoto" value="true"><?}?><input <?=$readOnly?> type="checkbox" name="boRemoto" <?=$okServerPostgres?>>Remoto<br>
							<font style="font-size: 9px"><?=$mensgemPostgres?></font>
							</td>
						</tr>
						<tr> 
		  					<td width="32%">Porta de Conexão</td>
		  					<td width="45%" class="detalhes"><input type="text" requerido="Favor informar a porta do servidor de banco de dados PostgreSQL." name="stPortaPostgres" value="5432"></td>
							<td>&nbsp;</td>
						</tr>
						<tr> 
		  					<td width="32%">Nome do Banco</td>
		  					<td width="45%" class="detalhes"><input type="text" requerido="Favor informa o nome do banco de dados previamente criado no servidor de banco de dados PostgreSQL." name="stBdPostgres"></td>
							<td>&nbsp;</td>
						</tr>	
						<tr> 
		  					<td width="32%">Usuário de Acesso</td>
		  					<td width="45%" class="detalhes"><input type="text" requerido="Favor informar o nome do usuário do servidor de banco de dados PostgreSQL." name="stUsarioPostgres"></td>
							<td>&nbsp;</td>
						</tr>
						<tr> 
		  					<td width="32%">Senha de Acesso</td>
		  					<td width="45" class="detalhes">	<input type="password" requerido="Favor informar a senha do usuário do servidor de banco de dados PostgreSQL." name="stSenhaPostgres"></td>
							<td>&nbsp;</td>
						</tr>
						<tr> 
		  					<td width="32%">Local do arquivo (plpgsql.so)</td>
		  					<td width="45" class="detalhes">	<input type="text" requerido="Favor informar o caminho completo para o arquivo plpgsql.so do  servidor de banco de dados PostgreSQL." name="stPathPlpgsqlPostgresql"></td>
							<td>&nbsp;</td>
						</tr>
						<tr> 
		  					<td width="32%">Limpar banco de dados em caso de falha na instalação?</td>
		  					<td width="45" class="detalhes">	<input onclick="if(this.checked){alert('Marcando está opção, em caso de falha na instalação, o instalador removerá todas as entradas prévias do banco de dados selecionado!')}" type="checkbox" name="boApagarFalha">Sim</td>
							<td>&nbsp;</td>
						</tr>
					</table>
				</div>
				<br>
				<div class="bloco">
					<table border="0" cellpadding="1" cellspacing="0" width="100%">
						<tr>
		  					<td colspan="2"><h4><img src="imagens/usuario.png" align="absmiddle">&nbsp;Administrador dos Sistemas</img></h4></td>	  
						</tr>
						<tr> 
		  					<td width="32%">Instituição</td>
		  					<td width="75%" class="detalhes"><input type="text" requerido="Favor informar o nome da Instituição do usuário administrador dos Sistemas." name="stInstituicaoAdministrador"></td>
						</tr>
						<tr> 
		  					<td width="32%">Nome do Usuário</td>
		  					<td width="75%" class="detalhes"><input type="text" requerido="Favor informar o nome do usuário administrador dos Sistemas." name="stNomeAdministrador"></td>
						</tr>
						<tr> 
		  					<td width="32%">Login do Usuário</td>
		  					<td width="75%" class="detalhes"><input type="text" requerido="Favor informar o login do usuário administrador dos Sistemas." name="stLoginAdministradorSistemas"></td>
						</tr>
						<tr> 
		  					<td width="32%">Senha de Acesso</td>
		  					<td width="75%" class="detalhes"><input type="password" validacao="verificaConfirmacaoSenha" requerido="Favor informar a senha do usuário administrador dos Sistemas." name="stSenhaAdministradorSistemas"></td>
						</tr>	
						<tr> 
		  					<td width="32%">Confirmação de Senha</td>
		  					<td width="75%" class="detalhes"><input type="password" requerido="Favor confirmar a senha do usuário administrador dos Sistemas." name="stSenhaConfirmacaoAdministradorSistemas">	</td>
						</tr>
						<tr> 
		  					<td align="center" colspan="2"></td>
						</tr>
					</table>
				</div>
				<br>
				<div id="divResultados" class="bloco">
					<table border="0" cellpadding="1" cellspacing="0" width="100%">	  
						<tr>
							<td><h4>Resultado do Teste de Configuração do Servidor</h4></td>	  
						</tr>
					</table>
					<div id="divTestando" style="display:none">
						<table width="100%">
							<tr>
								<td align="center"><img src="imagens/loading.gif"></td>
							</tr>
							<tr>
								<td align="center">Aguarde, realizando testes...</td>
							</tr>
						</table>						
					</div>
					<table id="resultados" border="0" cellpadding="1" cellspacing="0" width="100%">
					</table>
					<br>
					<table border="0" cellpadding="1" cellspacing="0" width="100%">
						<tr>
							<td align="center"><input id="btTestar" type="button" value="Testar Configurações" onclick="validaFormulario('instalador', 'verficaInstalacao')"></td>
						</tr>
					</table>
				</div>
				<br>
				<div id="divResultadosInstalacao" style="display:none" class="bloco">
					<table border="0" cellpadding="1" cellspacing="0" width="100%">	  
						<tr>
							<td><h4>Resultado da Instalação do Sistema</h4></td>	  
						</tr>
					</table>
					<div id="divInstalando" style="display:none">
						<table width="100%">
							<tr>
								<td align="center"><img src="imagens/loading.gif"></td>
							</tr>
							<tr>
								<td align="center">Aguarde, instalando sistemas...</td>
							</tr>
						</table>						
					</div>
					<table id="resultadosinstalacao" border="0" cellpadding="1" cellspacing="0" width="100%">
					</table>
					<br>
					<table border="0" cellpadding="1" cellspacing="0" width="100%">
						<tr>
							<td align="center"><input id="btInstalar" type="button" value="Instalar Sistema" onclick="validaFormulario('instalador', 'instalaSistemas')"></td>
						</tr>
					</table>
				</div>
				<br>
				<div id="divSucessoInstalacao" style="display:none;" class="bloco">
					<table border="0" cellpadding="1" cellspacing="0" width="100%">	  
						<tr>
							<td><h4>Instalação completa</h4></td>	  
						</tr>
						<tr>
							<td>Todos os sistemas foram instalados com sucesso para acessá-los basta acessar a pasta escolhida durante a instalação.</td>	  
						</tr>
					</table>
				</div>
				<br>
				<div class="bloco">
					<font color="red">Contra</font> - Sistema de Controle de Acessos e Modularização de Sistemas<br>
					<font color="red">Sisau</font> - Sistema de Atendimento ao Usuário<br>
					<font color="red">Saci Livre</font> - Sistema de Administração de Conteúdos Institucionais na Internet 
				</div>
			</div>	
			<?php
			}
			?>
		</form>
	</body>
</html>