INSERT INTO pac VALUES (1, 1, 2);
INSERT INTO pac VALUES (2, 1, 1);
INSERT INTO pac VALUES (3, 1, 3);

--
-- Data for TOC entry 548 (OID 962524)
-- Name: cgr; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO cgr VALUES (1, 1, 'Coordena��o Geral de Inform�tica', 'INFO');

--
-- Data for TOC entry 539 (OID 962447)
-- Name: dvs; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO dvs VALUES (1, 1, 'Suporte ao Usu�rio', 1);
INSERT INTO dvs VALUES (2, 1, 'Ger�ncia de Redes', 1);
INSERT INTO dvs VALUES (3, 1, 'Desenvolvimento de Sistemas', 1);

--
-- Data for TOC entry 549 (OID 962529)
-- Name: cld; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO cld VALUES (2, 'Problemas / Servi�os no Computador ou Impressora', 'Identifica��o de problemas em esta��es de trabalho e impressoras.', 1);
INSERT INTO cld VALUES (3, 'Aquisi��o e empr�stimos de Equipamentos e Servi�os', 'Aquisi��o, loca��o e empr�stimo de equipamentos e Servi�os de Inform�tica', 1);
INSERT INTO cld VALUES (4, 'Correio Eletr�nico - Webmail - Agenda on-line ', 'Inclus�o / altera��o de senhas, contas de correio e procedimentos de agenda on-line', 1);
INSERT INTO cld VALUES (6, 'Outros Servi�os de Inform�tica', 'Servi�os de inform�tica', 1);
INSERT INTO cld VALUES (7, 'Sistema Operacional e Programas de Escrit�rio', 'Solu��o de problemas em SO e Programas', 1);
INSERT INTO cld VALUES (5, 'Rede - Internet - SIAF - Rede Serpro', 'Configura��es de Rede e Internet', 1);
INSERT INTO cld VALUES (1, 'Sistemas Internos e Outros Sistemas', 'Identifica��o dos servi�os referentes ao departamento de desenvolvimento e manuten��o de sistemas pr�prios e outros sistemas.', 1);

--
-- Data for TOC entry 538 (OID 962439)
-- Name: dgn; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO dgn VALUES (25, 'Reporta��o de erros, sugest�es ou cr�ticas na utiliza��o dos sistemas. � necess�rio indicar o sistema.', 'Erros, sugest�es e cr�ticas', 1, NULL, 6, true, '1');
INSERT INTO dgn VALUES (32, 'Instala��o de software na esta��o de trabalho do usu�rio.', 'Instala��o de software', 1, NULL, 1, true, '1');
INSERT INTO dgn VALUES (27, 'Alterar a senha do usu�rio no servidor de autentica��o.', 'Altera��o de senha de acesso a rede.', 2, NULL, 4, true, '1');
INSERT INTO dgn VALUES (26, 'Alterar senha de correio de usu�rio no servidor de email.', 'Altera��o de senha de correio.', 2, NULL, 4, true, '1');
INSERT INTO dgn VALUES (23, 'Adicionar ou remover usu�rios ou alterar propriedades de alias de correio.', 'Alterar configura��o de alias de correio', 2, NULL, 4, true, '1');
INSERT INTO dgn VALUES (7, 'Apresenta��o da ferramenta solicitada pelo usu�rio.', 'Apresenta��o de Sistemas', 3, NULL, 1, true, '1');
INSERT INTO dgn VALUES (17, 'Configura��o da conta de e-mail no Outlook Express Mudan�a da pasta de armazenamento Configura��o do catalago de endere�os', 'Configura��o de e-mail', 1, NULL, 4, true, '1');
INSERT INTO dgn VALUES (3, 'Compartilhar uma mesma agenda entre usu�rios diferentes.', 'Compartilhamento de agenda.', 1, NULL, 4, true, '1');
INSERT INTO dgn VALUES (18, 'Ligar os cabos de energia e de comunica��o Instalar o driver da impressora Imprimir uma pagina de teste', 'Configura��o de impressora', 1, NULL, 2, true, '1');
INSERT INTO dgn VALUES (9, 'Configurar acesso de servidor hospedado na sala de rede.', 'Configurar acesso de servidor hospedado na sala de rede.', 2, NULL, 5, true, '1');
INSERT INTO dgn VALUES (36, 'Criar conta corporativa', 'Criar conta corporativa', 2, NULL, 4, true, '1');
INSERT INTO dgn VALUES (13, 'Empr�stimo de equipamentos', 'Empr�stimo de equipamentos', 1, NULL, 3, true, '1');
INSERT INTO dgn VALUES (21, 'Esclarecimento sobre utiliza��o dos sistemas', 'Esclarecimento sobre sistemas', 3, NULL, 1, true, '1');
INSERT INTO dgn VALUES (22, 'Excluir usu�rios da rede.', 'Excluir usu�rios da rede.', 2, NULL, 5, true, '1');
INSERT INTO dgn VALUES (12, 'Inclus�o e defini��o dos acessos conforme as necessidades de cada usu�rio.', 'Inclus�o de usu�rio na rede', 2, NULL, 5, true, '1');
INSERT INTO dgn VALUES (20, 'Desenvolvimento de ferramentas corporativas. � necess�rio uma breve descri��o sobre a  necessidade do sistema.', 'Desenvolvimento de Sistema', 3, NULL, 1, true, '1');
INSERT INTO dgn VALUES (19, 'Solicita��o de informa��es sobre os sistemas disponibilizados ou mantidos pela CGMI. � necess�rio um breve relato da dificuldade na utiliza��o do sistema e a indica��o do sistema. ', 'Informa��es de utiliza��o de sistemas', 3, NULL, 1, true, '1');
INSERT INTO dgn VALUES (33, 'Alterar a configura��o de rede de esta��o', 'Mudan�a na configura��o de rede de esta��o', 1, NULL, 5, true, '1');
INSERT INTO dgn VALUES (16, 'Outros Servi�os', 'Outros Servi�os', 1, NULL, 6, true, '1');
INSERT INTO dgn VALUES (30, 'Reconfigura��o de software.', 'Reconfigura��o de software', 1, NULL, 1, true, '1');
INSERT INTO dgn VALUES (28, 'Reinstala��o de sistema operacional.', 'Reinstala��o de sistema operacional.', 1, NULL, 1, true, '1');

--
-- Data for TOC entry 543 (OID 962478)
-- Name: tsv; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO tsv VALUES (24, 32, 'Instala��o de software', 'Instala��o de software na esta��o de trabalho do usu�rio.');
INSERT INTO tsv VALUES (25, 27, 'Altera��o de senha de acesso a rede.', 'Alterar a senha do usu�rio no servidor de autentica��o.');
INSERT INTO tsv VALUES (26, 26, 'Altera��o de senha de correio.', 'Alterar senha de correio de usu�rio no servidor de email.');
INSERT INTO tsv VALUES (27, 23, 'Alterar configura��o de alias de correio', 'Adicionar ou remover usu�rios ou alterar propriedades de alias de correio.');
INSERT INTO tsv VALUES (28, 7, 'Apresenta��o de Sistemas', 'Apresenta��o da ferramenta solicitada pelo usu�rio.');
INSERT INTO tsv VALUES (29, 17, 'Configura��o de e-mail', 'Configura��o da conta de e-mail no Outlook Express Mudan�a da pasta de armazenamento Configura��o do catalago de endere�os');
INSERT INTO tsv VALUES (30, 3, 'Compartilhamento de agenda.', 'Compartilhar uma mesma agenda entre usu�rios diferentes.');
INSERT INTO tsv VALUES (31, 18, 'Configura��o de impressora', 'Ligar os cabos de energia e de comunica��o Instalar o driver da impressora Imprimir uma pagina de teste');
INSERT INTO tsv VALUES (32, 9, 'Configurar acesso de servidor hospedado na sala de rede.', 'Configurar acesso de servidor hospedado na sala de rede.');
INSERT INTO tsv VALUES (33, 36, 'Criar conta corporativa', 'Criar conta corporativa');
INSERT INTO tsv VALUES (34, 13, 'Empr�stimo de equipamentos', 'Empr�stimo de equipamentos');
INSERT INTO tsv VALUES (36, 21, 'Esclarecimento sobre sistemas', 'Esclarecimento sobre utiliza��o dos sistemas');
INSERT INTO tsv VALUES (37, 22, 'Excluir usu�rios da rede.', 'Excluir usu�rios da rede.');
INSERT INTO tsv VALUES (38, 12, 'Inclus�o de usu�rio na rede', 'Inclus�o e defini��o dos acessos conforme as necessidades de cada usu�rio.');
INSERT INTO tsv VALUES (39, 20, 'Desenvolvimento de Sistema', 'Desenvolvimento de ferramentas corporativas. � necess�rio uma breve descri��o sobre a  necessidade do sistema.');
INSERT INTO tsv VALUES (40, 19, 'Informa��es de utiliza��o de sistemas', 'Solicita��o de informa��es sobre os sistemas disponibilizados ou mantidos pela CGMI. � necess�rio um breve relato da dificuldade na utiliza��o do sistema e a indica��o do sistema. ');
INSERT INTO tsv VALUES (41, 33, 'Mudan�a na configura��o de rede de esta��o', 'Alterar a configura��o de rede de esta��o');
INSERT INTO tsv VALUES (42, 16, 'Outros Servi�os', 'Outros Servi�os');
INSERT INTO tsv VALUES (43, 30, 'Reconfigura��o de software', 'Reconfigura��o de software.');
INSERT INTO tsv VALUES (44, 28, 'Reinstala��o de sistema operacional.', 'Reinstala��o de sistema operacional.');
INSERT INTO tsv VALUES (35, 25, 'Erros, sugest�es e cr�ticas', 'Reporta��o de erros, sugest�es ou cr�ticas na utiliza��o dos sistemas. � necess�rio indicar o sistema.');

INSERT INTO atd VALUES (1, 1, 1);

INSERT INTO abp ( abpsccid, abpusrid ) SELECT sccid,1 FROM scc;

SELECT pg_catalog.setval('dgn_dgnid_seq', ( select max( dgnid ) from dgn ), true);

SELECT pg_catalog.setval('dvs_dvsid_seq', ( select max( dvsid ) from dvs ), true);

SELECT pg_catalog.setval('tsv_tsvid_seq', ( select max( tsvid ) from tsv ), true);

SELECT pg_catalog.setval('cgr_cgrid_seq', ( select max( cgrid ) from cgr ), true);

SELECT pg_catalog.setval('cld_cldid_seq', ( select max( cldid ) from cld ), true);

SELECT pg_catalog.setval('ctu_ctuid_seq', ( select max( ctuid ) from ctu ), true);

SELECT pg_catalog.setval('cts_ctsid_seq', ( select max( ctsid ) from cts ), true);

SELECT pg_catalog.setval('atd_atdid_seq', ( select max( atdid ) from atd ), true);
