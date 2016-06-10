function validaFormulario(stIdFormulario, stAcao){
	obFormulario = document.getElementById(stIdFormulario);
	stSend = '';
	
	for(i = 0; i < obFormulario.elements.length; i++){
		obElemento = obFormulario.elements[i];
		if(obElemento.hasAttribute("requerido") && obElemento.value == ""){
			alert(obElemento.getAttribute("requerido"));
			obElemento.focus();
			return false;
		}
		if(obElemento.hasAttribute("validacao") && obElemento.value != ""){
			stFuncao  = obElemento.getAttribute("validacao") + "(\"" + obElemento.value + "\")";
			boRetorno =  eval(stFuncao);
			if(!boRetorno){
				obElemento.focus();
				return boRetorno
			}
		}
		if(obElemento.type == "checkbox"){
			stSend += obElemento.name +  "=" + obElemento.checked + "&";
		} else {
			stSend += obElemento.name +  "=" + obElemento.value + "&";
		}
		
	}
	enviaInformacoes(stAcao, stSend);
}

function createRequestObject() {
	var ro;
	var browser = navigator.appName;
	if(browser == "Microsoft Internet Explorer"){
		ro = new ActiveXObject("Microsoft.XMLHTTP");
	}else{
		ro = new XMLHttpRequest();
	}
	return ro;
}

var http = createRequestObject();

function enviaInformacoes(stAcao, stSend) {
	switch(stAcao){
		case 'verficaInstalacao':
			document.getElementById('divTestando').style.display = '';
		break;
		case 'instalaSistemas':
			document.getElementById('divInstalando').style.display = '';
		break;
	}
	http.open('post', 'instalador.php', true);
	http.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
	http.send('stAcao=' + stAcao + '&' + stSend);
	http.onreadystatechange = processaInformacoes;
}

function processaInformacoes() {
	if(http.readyState == 4){
		//alert(http.responseText);
		var XML = http.responseXML;
		instalador = XML.getElementsByTagName('instalador').item(0);
		
		stAcao  = instalador.childNodes.item(0).getAttribute('acao');

		switch(stAcao){
			case 'verficaInstalacao':
				
				resultados = document.getElementById('resultados');				
				divInstalacao = document.getElementById('divResultadosInstalacao');
				btTestar = document.getElementById('btTestar');
				btTestar.disabled = true;
				document.getElementById('divTestando').style.display = 'none';
				
				/*Substitui tabela de resultados do teste*/
				obTableResultados = document.createElement('table');
				obTableResultados.setAttribute('id', 'resultados');
				document.getElementById('divResultados').replaceChild(obTableResultados, resultados);
				resultados = obTableResultados;
				
				mensagens = instalador.childNodes.item(1).childNodes;
				
				testeOk = true;
				for(i = 0; i < mensagens.length; i++){
					obTr = document.createElement('tr');
					obTr.setAttribute('id', 't' + i);
					obTdTexto = document.createElement('td');
					obTdTexto.appendChild(document.createTextNode(mensagens.item(i).childNodes.item(0).data));
					if(mensagens.item(i).getAttribute('tipo') == 's'){
						img = document.createElement('img');
						img.setAttribute('src', 'imagens/gtk-ok.png');
					} 
					if(mensagens.item(i).getAttribute('tipo') == 'a'){
						img = document.createElement('img');
						img.setAttribute('src', 'imagens/gtk-warning.png');
					}
					if(mensagens.item(i).getAttribute('tipo') == 'f'){
						testeOk = false;
						img = document.createElement('img');
						img.setAttribute('src', 'imagens/gtk-no.png');
					}
					
					obTdImagem = document.createElement('td');
					obTdImagem.appendChild(img);
					btTestar.disabled = false;
					
					obTr.appendChild(obTdTexto);
					obTr.appendChild(obTdImagem);
					resultados.appendChild(obTr);
				}
				if(testeOk){
					divInstalacao.style.display = '';
				} else {
					divInstalacao.style.display = 'none';
				}
			break;
			
			case 'instalaSistemas':
				
				resultados = document.getElementById('resultadosinstalacao');
				btInstalar = document.getElementById('btInstalar');
				btInstalar.disabled = true;
				document.getElementById('divInstalando').style.display = 'none';
				
				/*Substitui tabela de resultados do teste*/
				obTableResultados = document.createElement('table');
				obTableResultados.setAttribute('id', 'resultadosinstalacao');
				document.getElementById('divResultadosInstalacao').replaceChild(obTableResultados, resultados);
				resultados = obTableResultados;
				
				mensagens = instalador.childNodes.item(1).childNodes;
				
				instalacaoOk = true;
				for(i = 0; i < mensagens.length; i++){
					obTr = document.createElement('tr');
					obTr.setAttribute('id', 'i' + i);
					obTdTexto = document.createElement('td');
					obTdTexto.appendChild(document.createTextNode(mensagens.item(i).childNodes.item(0).data));
					if(mensagens.item(i).getAttribute('tipo') == 's'){
						img = document.createElement('img');
						img.setAttribute('src', 'imagens/gtk-ok.png');
					} 
					if(mensagens.item(i).getAttribute('tipo') == 'a'){
						img = document.createElement('img');
						img.setAttribute('src', 'imagens/gtk-warning.png');
					}
					if(mensagens.item(i).getAttribute('tipo') == 'f'){
						instalacaoOk = false;
						img = document.createElement('img');
						img.setAttribute('src', 'imagens/gtk-no.png');
					}
					
					obTdImagem = document.createElement('td');
					obTdImagem.appendChild(img);
					
					obTr.appendChild(obTdTexto);
					obTr.appendChild(obTdImagem);
					resultados.appendChild(obTr);
					btInstalar.disabled = false;
				}
				if(!instalacaoOk && document.getElementById('instalador').boApagarFalha.checked){
					validaFormulario('instalador', 'limpaBanco');
				} else {
					document.getElementById('divSucessoInstalacao').style.display = '';
					btInstalar.value = 'Sistemas instalados com sucesso...';
					btInstalar.disabled = true;
				}
			break;
		}
	}
}

/* Verificacoes JavaScript*/
function verificaCaracteres(stValor){
	re = "\ ";
	if(stValor.match(re)){
		alert("O diretório de instalação do sistema não pode conter espaços!");
		return false;
	} else {
		return true;
	}
}
/* Verifica confirmação de senha */
function verificaConfirmacaoSenha(){
	instalador = document.getElementById('instalador');
	if(instalador.stSenhaAdministradorSistemas.value != instalador.stSenhaConfirmacaoAdministradorSistemas.value){
		alert("As senhas escolhidas para o administrador de sistemas não conferem.");
		instalador.stSenhaAdministradorSistemas.value = '';
		instalador.stSenhaConfirmacaoAdministradorSistemas.value = '';
		instalador.stSenhaAdministradorSistemas.focus();
		return false
	} else {
		return true;
	}
}