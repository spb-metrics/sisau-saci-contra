INSERT INTO pac VALUES (1, 1, 2);
INSERT INTO pac VALUES (2, 1, 1);
INSERT INTO pac VALUES (3, 1, 3);

--
-- Data for TOC entry 548 (OID 962524)
-- Name: cgr; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO cgr VALUES (1, 1, 'Coordenação Geral de Informática', 'INFO');

--
-- Data for TOC entry 539 (OID 962447)
-- Name: dvs; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO dvs VALUES (1, 1, 'Suporte ao Usuário', 1);
INSERT INTO dvs VALUES (2, 1, 'Gerência de Redes', 1);
INSERT INTO dvs VALUES (3, 1, 'Desenvolvimento de Sistemas', 1);

--
-- Data for TOC entry 549 (OID 962529)
-- Name: cld; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO cld VALUES (2, 'Problemas / Serviços no Computador ou Impressora', 'Identificação de problemas em estações de trabalho e impressoras.', 1);
INSERT INTO cld VALUES (3, 'Aquisição e empréstimos de Equipamentos e Serviços', 'Aquisição, locação e empréstimo de equipamentos e Serviços de Informática', 1);
INSERT INTO cld VALUES (4, 'Correio Eletrônico - Webmail - Agenda on-line ', 'Inclusão / alteração de senhas, contas de correio e procedimentos de agenda on-line', 1);
INSERT INTO cld VALUES (6, 'Outros Serviços de Informática', 'Serviços de informática', 1);
INSERT INTO cld VALUES (7, 'Sistema Operacional e Programas de Escritório', 'Solução de problemas em SO e Programas', 1);
INSERT INTO cld VALUES (5, 'Rede - Internet - SIAF - Rede Serpro', 'Configurações de Rede e Internet', 1);
INSERT INTO cld VALUES (1, 'Sistemas Internos e Outros Sistemas', 'Identificação dos serviços referentes ao departamento de desenvolvimento e manutenção de sistemas próprios e outros sistemas.', 1);

--
-- Data for TOC entry 538 (OID 962439)
-- Name: dgn; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO dgn VALUES (25, 'Reportação de erros, sugestões ou críticas na utilização dos sistemas. É necessário indicar o sistema.', 'Erros, sugestões e críticas', 1, NULL, 6, true, '1');
INSERT INTO dgn VALUES (32, 'Instalação de software na estação de trabalho do usuário.', 'Instalação de software', 1, NULL, 1, true, '1');
INSERT INTO dgn VALUES (27, 'Alterar a senha do usuário no servidor de autenticação.', 'Alteração de senha de acesso a rede.', 2, NULL, 4, true, '1');
INSERT INTO dgn VALUES (26, 'Alterar senha de correio de usuário no servidor de email.', 'Alteração de senha de correio.', 2, NULL, 4, true, '1');
INSERT INTO dgn VALUES (23, 'Adicionar ou remover usuários ou alterar propriedades de alias de correio.', 'Alterar configuração de alias de correio', 2, NULL, 4, true, '1');
INSERT INTO dgn VALUES (7, 'Apresentação da ferramenta solicitada pelo usuário.', 'Apresentação de Sistemas', 3, NULL, 1, true, '1');
INSERT INTO dgn VALUES (17, 'Configuração da conta de e-mail no Outlook Express Mudança da pasta de armazenamento Configuração do catalago de endereços', 'Configuração de e-mail', 1, NULL, 4, true, '1');
INSERT INTO dgn VALUES (3, 'Compartilhar uma mesma agenda entre usuários diferentes.', 'Compartilhamento de agenda.', 1, NULL, 4, true, '1');
INSERT INTO dgn VALUES (18, 'Ligar os cabos de energia e de comunicação Instalar o driver da impressora Imprimir uma pagina de teste', 'Configuração de impressora', 1, NULL, 2, true, '1');
INSERT INTO dgn VALUES (9, 'Configurar acesso de servidor hospedado na sala de rede.', 'Configurar acesso de servidor hospedado na sala de rede.', 2, NULL, 5, true, '1');
INSERT INTO dgn VALUES (36, 'Criar conta corporativa', 'Criar conta corporativa', 2, NULL, 4, true, '1');
INSERT INTO dgn VALUES (13, 'Empréstimo de equipamentos', 'Empréstimo de equipamentos', 1, NULL, 3, true, '1');
INSERT INTO dgn VALUES (21, 'Esclarecimento sobre utilização dos sistemas', 'Esclarecimento sobre sistemas', 3, NULL, 1, true, '1');
INSERT INTO dgn VALUES (22, 'Excluir usuários da rede.', 'Excluir usuários da rede.', 2, NULL, 5, true, '1');
INSERT INTO dgn VALUES (12, 'Inclusão e definição dos acessos conforme as necessidades de cada usuário.', 'Inclusão de usuário na rede', 2, NULL, 5, true, '1');
INSERT INTO dgn VALUES (20, 'Desenvolvimento de ferramentas corporativas. É necessário uma breve descrição sobre a  necessidade do sistema.', 'Desenvolvimento de Sistema', 3, NULL, 1, true, '1');
INSERT INTO dgn VALUES (19, 'Solicitação de informações sobre os sistemas disponibilizados ou mantidos pela CGMI. É necessário um breve relato da dificuldade na utilização do sistema e a indicação do sistema. ', 'Informações de utilização de sistemas', 3, NULL, 1, true, '1');
INSERT INTO dgn VALUES (33, 'Alterar a configuração de rede de estação', 'Mudança na configuração de rede de estação', 1, NULL, 5, true, '1');
INSERT INTO dgn VALUES (16, 'Outros Serviços', 'Outros Serviços', 1, NULL, 6, true, '1');
INSERT INTO dgn VALUES (30, 'Reconfiguração de software.', 'Reconfiguração de software', 1, NULL, 1, true, '1');
INSERT INTO dgn VALUES (28, 'Reinstalação de sistema operacional.', 'Reinstalação de sistema operacional.', 1, NULL, 1, true, '1');

--
-- Data for TOC entry 543 (OID 962478)
-- Name: tsv; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO tsv VALUES (24, 32, 'Instalação de software', 'Instalação de software na estação de trabalho do usuário.');
INSERT INTO tsv VALUES (25, 27, 'Alteração de senha de acesso a rede.', 'Alterar a senha do usuário no servidor de autenticação.');
INSERT INTO tsv VALUES (26, 26, 'Alteração de senha de correio.', 'Alterar senha de correio de usuário no servidor de email.');
INSERT INTO tsv VALUES (27, 23, 'Alterar configuração de alias de correio', 'Adicionar ou remover usuários ou alterar propriedades de alias de correio.');
INSERT INTO tsv VALUES (28, 7, 'Apresentação de Sistemas', 'Apresentação da ferramenta solicitada pelo usuário.');
INSERT INTO tsv VALUES (29, 17, 'Configuração de e-mail', 'Configuração da conta de e-mail no Outlook Express Mudança da pasta de armazenamento Configuração do catalago de endereços');
INSERT INTO tsv VALUES (30, 3, 'Compartilhamento de agenda.', 'Compartilhar uma mesma agenda entre usuários diferentes.');
INSERT INTO tsv VALUES (31, 18, 'Configuração de impressora', 'Ligar os cabos de energia e de comunicação Instalar o driver da impressora Imprimir uma pagina de teste');
INSERT INTO tsv VALUES (32, 9, 'Configurar acesso de servidor hospedado na sala de rede.', 'Configurar acesso de servidor hospedado na sala de rede.');
INSERT INTO tsv VALUES (33, 36, 'Criar conta corporativa', 'Criar conta corporativa');
INSERT INTO tsv VALUES (34, 13, 'Empréstimo de equipamentos', 'Empréstimo de equipamentos');
INSERT INTO tsv VALUES (36, 21, 'Esclarecimento sobre sistemas', 'Esclarecimento sobre utilização dos sistemas');
INSERT INTO tsv VALUES (37, 22, 'Excluir usuários da rede.', 'Excluir usuários da rede.');
INSERT INTO tsv VALUES (38, 12, 'Inclusão de usuário na rede', 'Inclusão e definição dos acessos conforme as necessidades de cada usuário.');
INSERT INTO tsv VALUES (39, 20, 'Desenvolvimento de Sistema', 'Desenvolvimento de ferramentas corporativas. É necessário uma breve descrição sobre a  necessidade do sistema.');
INSERT INTO tsv VALUES (40, 19, 'Informações de utilização de sistemas', 'Solicitação de informações sobre os sistemas disponibilizados ou mantidos pela CGMI. É necessário um breve relato da dificuldade na utilização do sistema e a indicação do sistema. ');
INSERT INTO tsv VALUES (41, 33, 'Mudança na configuração de rede de estação', 'Alterar a configuração de rede de estação');
INSERT INTO tsv VALUES (42, 16, 'Outros Serviços', 'Outros Serviços');
INSERT INTO tsv VALUES (43, 30, 'Reconfiguração de software', 'Reconfiguração de software.');
INSERT INTO tsv VALUES (44, 28, 'Reinstalação de sistema operacional.', 'Reinstalação de sistema operacional.');
INSERT INTO tsv VALUES (35, 25, 'Erros, sugestões e críticas', 'Reportação de erros, sugestões ou críticas na utilização dos sistemas. É necessário indicar o sistema.');

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
