--
-- PostgreSQL database dump
--

SET client_encoding = 'SQL_ASCII';
SET check_function_bodies = false;

SET search_path = public, pg_catalog;

--
-- TOC entry 4 (OID 2200)
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 19 (OID 962328)
-- Name: acs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE acs (
    acsid serial NOT NULL,
    acsmenid integer NOT NULL,
    acsusrid integer NOT NULL,
    acsadic boolean NOT NULL,
    acsalt boolean NOT NULL,
    acsexc boolean NOT NULL,
    acscns boolean
);


--
-- TOC entry 28 (OID 962333)
-- Name: log; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE log (
    logid serial NOT NULL,
    logobs text,
    logsisid integer NOT NULL,
    logusrid integer NOT NULL,
    logdthr timestamp without time zone NOT NULL,
    logacao smallint,
    logtab character varying(5),
    logschema character varying(20),
    CONSTRAINT ckc_logacao_log CHECK (((((logacao = 1) OR (logacao = 2)) OR (logacao = 3)) OR (logacao = 4)))
);


--
-- TOC entry 36 (OID 962342)
-- Name: men; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE men (
    menid serial NOT NULL,
    mensisid integer NOT NULL,
    menpai integer NOT NULL,
    menlink character varying(40) NOT NULL,
    menquadro character varying(7),
    menobs text NOT NULL,
    menordem smallint DEFAULT 0 NOT NULL,
    menopcao text NOT NULL,
    menclass character varying(80),
    menimg character varying(30)
);


--
-- TOC entry 47 (OID 962351)
-- Name: sis; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE sis (
    sisid serial NOT NULL,
    sisnome character varying(40) NOT NULL,
    sisdesc character varying(80) NOT NULL,
    sisversao character varying(7) NOT NULL,
    sisdircls character varying(40) NOT NULL,
    sisdirimg character varying(40) NOT NULL,
    sismenid integer,
    sissts character varying(2) NOT NULL,
    sisdirbb character varying(40),
    sissobre text,
    CONSTRAINT ckc_sissts_sis CHECK ((((sissts)::text = ('AT'::character varying)::text) OR ((sissts)::text = ('IN'::character varying)::text)))
);


--
-- TOC entry 58 (OID 962360)
-- Name: usr; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE usr (
    usrid serial NOT NULL,
    usrsenha character varying(100) NOT NULL,
    usrurdid integer,
    usrlogin character varying(40) NOT NULL
);


--
-- TOC entry 62 (OID 962363)
-- Name: pga_graphs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pga_graphs (
    graphname character varying(64) NOT NULL,
    graphsource text,
    graphcode text
);


--
-- TOC entry 63 (OID 962368)
-- Name: pga_layout; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pga_layout (
    tablename character varying(64) NOT NULL,
    nrcols smallint,
    colnames text,
    colwidth text
);


--
-- TOC entry 64 (OID 962373)
-- Name: pga_images; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pga_images (
    imagename character varying(64) NOT NULL,
    imagesource text
);


--
-- TOC entry 65 (OID 962378)
-- Name: pga_queries; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pga_queries (
    queryname character varying(64) NOT NULL,
    querytype character(1),
    querycommand text,
    querytables text,
    querylinks text,
    queryresults text,
    querycomments text
);


--
-- TOC entry 66 (OID 962383)
-- Name: pga_reports; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pga_reports (
    reportname character varying(64) NOT NULL,
    reportsource text,
    reportbody text,
    reportprocs text,
    reportoptions text
);


--
-- TOC entry 67 (OID 962388)
-- Name: pga_forms; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pga_forms (
    formname character varying(64) NOT NULL,
    formsource text
);


--
-- TOC entry 68 (OID 962393)
-- Name: pga_diagrams; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pga_diagrams (
    diagramname character varying(64) NOT NULL,
    diagramtables text,
    diagramlinks text
);


--
-- TOC entry 69 (OID 962398)
-- Name: pga_scripts; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pga_scripts (
    scriptname character varying(64) NOT NULL,
    scriptsource text
);


--
-- TOC entry 70 (OID 962405)
-- Name: mun; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE mun (
    munid serial NOT NULL,
    munuf character(2),
    munufibge character(2),
    muncodibge character(5),
    munnome character varying(80) NOT NULL
);


--
-- TOC entry 75 (OID 962410)
-- Name: und; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE und (
    undid serial NOT NULL,
    undnome character varying(80) NOT NULL,
    undsigla character varying(10) NOT NULL,
    undresp character varying(60) NOT NULL,
    undend character varying(100),
    undmunid integer,
    undundidvch integer
);


--
-- TOC entry 84 (OID 962415)
-- Name: var; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE var (
    varid serial NOT NULL,
    varnome character varying(20) NOT NULL,
    varvalor text NOT NULL,
    varsisid integer NOT NULL,
    vardesc text NOT NULL
);


--
-- TOC entry 500 (OID 962421)
-- Name: cnf_aval_cmp(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cnf_aval_cmp() RETURNS "trigger"
    AS '
    BEGIN
        UPDATE CMP SET CMPSTS=''AV'',CMPUSRID=NEW.AVMUSRID WHERE CMPID IN (SELECT CMPID FROM CMP JOIN PLO ON PLOID=CMPPLOID
	AND CMPMESREF=NEW.AVMMESREF JOIN MTS ON MTSID=PLOMTSID AND MTSACOID=NEW.AVMACOID);
	RETURN NEW;
    END;    
'
    LANGUAGE pgsql;


--
-- TOC entry 91 (OID 962424)
-- Name: atd; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE atd (
    atdid serial NOT NULL,
    atddvsid integer NOT NULL,
    atdurdid integer NOT NULL
);


--
-- TOC entry 96 (OID 962429)
-- Name: ate; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE ate (
    ateid serial NOT NULL,
    atedthrab timestamp without time zone NOT NULL,
    atetipo character(1) NOT NULL,
    ateatdid integer NOT NULL,
    atesatid integer NOT NULL,
    ateobs text,
    atests character(2) DEFAULT 'NR'::bpchar NOT NULL,
    atedthrfc timestamp without time zone,
    atenivsat character(1),
    ateobsurd text,
    atedgnid integer,
    atedgnobs text,
    atepriori character(1),
    CONSTRAINT ckc_atests_ate CHECK ((((((((atests = 'NR'::bpchar) OR (atests = 'EA'::bpchar)) OR (atests = 'FN'::bpchar)) OR (atests = 'TE'::bpchar)) OR (atests = 'PE'::bpchar)) OR (atests = 'NE'::bpchar)) OR (atests = 'CN'::bpchar)))
);


--
-- TOC entry 107 (OID 962439)
-- Name: dgn; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE dgn (
    dgnid serial NOT NULL,
    dgndesc text NOT NULL,
    dgnnome character varying(80),
    dgndvsid integer,
    dgntsvid integer,
    dgncldid integer NOT NULL,
    dgnsts boolean,
    dgnpriori character(1)
);


--
-- TOC entry 115 (OID 962447)
-- Name: dvs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE dvs (
    dvsid serial NOT NULL,
    dvsurdid integer NOT NULL,
    dvsnome character varying(40) NOT NULL,
    dvscgrid integer NOT NULL
);


--
-- TOC entry 121 (OID 962452)
-- Name: hat; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE hat (
    hatid serial NOT NULL,
    hatateid integer NOT NULL,
    hatatdid integer NOT NULL,
    hatsts character(2) NOT NULL,
    hatobs text,
    hatdthr timestamp without time zone NOT NULL
);


--
-- TOC entry 129 (OID 962460)
-- Name: sat; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE sat (
    satid serial NOT NULL,
    satdthr timestamp without time zone NOT NULL,
    satpriori character(1) NOT NULL,
    satsts character(2) DEFAULT 'PE'::bpchar NOT NULL,
    satdesc text NOT NULL,
    saturdid integer NOT NULL,
    satdgnid integer NOT NULL,
    CONSTRAINT ckc_satsts_sat CHECK (((((satsts = 'PE'::bpchar) OR (satsts = 'DA'::bpchar)) OR (satsts = 'SL'::bpchar)) OR (satsts = 'DU'::bpchar)))
);


--
-- TOC entry 138 (OID 962470)
-- Name: sre; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE sre (
    sreid serial NOT NULL,
    sretsvid integer NOT NULL,
    sreateid integer NOT NULL,
    sreatdid integer NOT NULL,
    sredesc text,
    sredthr timestamp without time zone NOT NULL
);


--
-- TOC entry 146 (OID 962478)
-- Name: tsv; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE tsv (
    tsvid serial NOT NULL,
    tsvdgnid integer NOT NULL,
    tsvnome character varying(60) NOT NULL,
    tsvdesc text NOT NULL
);


--
-- TOC entry 152 (OID 962486)
-- Name: urd; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE urd (
    urdid serial NOT NULL,
    urdnome text,
    urdmunid integer,
    urdundid integer,
    urdcargo character varying(60),
    urdramal character varying(20),
    urdemail character varying(60),
    urdend text,
    urdsexo boolean,
    urdlogin text,
    urddepto character varying(80),
    urdsenha character varying(100),
    urdobs text,
    urddtinc date,
    urddtaltsen date,
    urdsts character(2) DEFAULT 'AT'::bpchar NOT NULL,
    urdsala character varying(5),
    CONSTRAINT ckc_urdsts_urd CHECK (((urdsts = 'AT'::bpchar) OR (urdsts = 'IN'::bpchar)))
);


--
-- TOC entry 502 (OID 962494)
-- Name: atlz_hist_ate(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION atlz_hist_ate() RETURNS "trigger"
    AS '
    BEGIN
        INSERT INTO HAT (HATATEID,HATATDID,HATSTS,HATOBS,HATDTHR) VALUES (NEW.ATEID,NEW.ATEATDID,
	NEW.ATESTS,NEW.ATEOBS,NOW());
	RETURN NEW;
    END;    
'
    LANGUAGE pgsql;


--
-- TOC entry 5 (OID 962495)
-- Name: vch_vchnumreq_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE vch_vchnumreq_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 504 (OID 962497)
-- Name: atlz_hist_cev(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION atlz_hist_cev() RETURNS "trigger"
    AS '
    BEGIN    
        INSERT INTO HCE (HCEUSRID,HCECEVID,HCESTS,HCEDTHR,HCEOBS) VALUES (NEW.CEVUSRID,NEW.CEVID,NEW.CEVSTS,NOW(),NEW.CEVOBS);
	    RETURN NEW;
    END;
'
    LANGUAGE pgsql;


--
-- TOC entry 506 (OID 962498)
-- Name: atlz_hist_dce(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION atlz_hist_dce() RETURNS "trigger"
    AS '
    BEGIN    
        INSERT INTO HDE (HDEUSRID,HDEDCEID,HDESTS,HDEDTHR,HDEOBS) VALUES (NEW.DCEUSRID,NEW.DCEID,NEW.DCESTS,NOW(),NEW.DCEOBS);
	    RETURN NEW;
    END;
'
    LANGUAGE pgsql;


--
-- TOC entry 169 (OID 962501)
-- Name: pas; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pas (
    pasid serial NOT NULL,
    pastsvid integer NOT NULL,
    pasnome character varying(40) NOT NULL,
    pasdesc text NOT NULL,
    passeq integer NOT NULL
);


--
-- TOC entry 176 (OID 962509)
-- Name: pgi; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pgi (
    pgiid serial NOT NULL,
    pgisisid integer NOT NULL,
    pgiusrid integer NOT NULL,
    pgimenid integer NOT NULL
);


--
-- TOC entry 182 (OID 962514)
-- Name: msg; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE msg (
    msgid serial NOT NULL,
    msgtitulo character varying(40) NOT NULL,
    msgtipo character(2) NOT NULL,
    msgcorpo text NOT NULL,
    msgorig text NOT NULL,
    CONSTRAINT ckc_msgtipo_msg CHECK (((((msgtipo = 'AV'::bpchar) OR (msgtipo = 'ER'::bpchar)) OR (msgtipo = 'CF'::bpchar)) OR (msgtipo = 'NT'::bpchar)))
);


--
-- TOC entry 508 (OID 962521)
-- Name: atlz_hist_cmp(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION atlz_hist_cmp() RETURNS "trigger"
    AS '
       begin
            insert into hcm ( hcmcmpid, hcmusrid, hcmsts, hcmdthr ) values ( new.cmpid, new.cmpusrid,
	        new.cmpsts,now() );
	        return new;
       end;    
    '
    LANGUAGE pgsql;


--
-- TOC entry 189 (OID 962524)
-- Name: cgr; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE cgr (
    cgrid serial NOT NULL,
    cgrurdid integer,
    cgrnome character varying(60) NOT NULL,
    cgrsigla character varying(10) NOT NULL
);


--
-- TOC entry 195 (OID 962529)
-- Name: cld; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE cld (
    cldid serial NOT NULL,
    cldnome character varying(50) NOT NULL,
    clddesc text NOT NULL,
    cldcgrid integer
);


--
-- TOC entry 201 (OID 962537)
-- Name: pse; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pse (
    pseid serial NOT NULL,
    psepasid integer NOT NULL,
    psesreid integer NOT NULL
);


--
-- TOC entry 206 (OID 962542)
-- Name: pfu; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pfu (
    pfuid serial NOT NULL,
    pfusisid integer,
    pfunome character varying(60) NOT NULL,
    pfudesc text NOT NULL
);


--
-- TOC entry 212 (OID 962550)
-- Name: dap; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE dap (
    dapid serial NOT NULL,
    dappfuid integer NOT NULL,
    dapmenid integer NOT NULL
);


--
-- TOC entry 217 (OID 962555)
-- Name: pac; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pac (
    pacid serial NOT NULL,
    pacusrid integer NOT NULL,
    pacpfuid integer NOT NULL
);


--
-- TOC entry 222 (OID 962560)
-- Name: msa; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE msa (
    msaid serial NOT NULL,
    msaateid integer NOT NULL,
    msacnt text NOT NULL,
    msaassunto character varying(40) NOT NULL,
    msadthr timestamp without time zone NOT NULL,
    msasts character(2),
    msaurdidrem integer,
    msaurdiddes integer,
    msatipo character varying(2),
    CONSTRAINT ckc_msasts_msa CHECK ((((msasts = 'LD'::bpchar) OR (msasts = 'NL'::bpchar)) OR (msasts = 'EX'::bpchar))),
    CONSTRAINT ckc_msatipo_msa CHECK (((msatipo IS NULL) OR ((((msatipo)::text = 'AS'::text) OR ((msatipo)::text = 'AR'::text)) OR ((msatipo)::text = 'AL'::text))))
);


--
-- TOC entry 233 (OID 962570)
-- Name: anc; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE anc (
    ancid serial NOT NULL,
    ancctuid integer NOT NULL,
    anctamid integer NOT NULL,
    ancarq character varying(80) NOT NULL,
    anclegenda text,
    anccredito character varying(80),
    ancordem smallint,
    anctpacss boolean NOT NULL,
    ancprincipal boolean NOT NULL,
    anctitulo character varying(256)
);


--
-- TOC entry 245 (OID 962578)
-- Name: css; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE css (
    cssid serial NOT NULL,
    cssnome character varying(60) NOT NULL,
    cssarq character varying(80) NOT NULL,
    cssmidia character(2) NOT NULL,
    cssdesc text,
    CONSTRAINT ckc_cssmidia_css CHECK ((((cssmidia = 'IM'::bpchar) OR (cssmidia = 'TL'::bpchar)) OR (cssmidia = 'TD'::bpchar)))
);


--
-- TOC entry 252 (OID 962587)
-- Name: ctu; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE ctu (
    ctuid serial NOT NULL,
    ctutpcid integer NOT NULL,
    ctudthrpub timestamp without time zone NOT NULL,
    ctudthrexp timestamp without time zone,
    ctutitulo text NOT NULL,
    ctuautor character varying(80),
    cturesumo text,
    ctutexto text NOT NULL,
    ctutpacss boolean NOT NULL,
    ctuprpferr boolean NOT NULL,
    ctuprprelac boolean NOT NULL,
    ctusts character(2) NOT NULL,
    ctudthr timestamp without time zone NOT NULL,
    ctudestaque smallint,
    CONSTRAINT ckc_ctusts_ctu CHECK (((ctusts = 'AT'::bpchar) OR (ctusts = 'IN'::bpchar)))
);


--
-- TOC entry 268 (OID 962596)
-- Name: dmn; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE dmn (
    dmnid serial NOT NULL,
    dmndmnid integer,
    dmnsccid integer,
    dmnnome character varying(60) NOT NULL,
    dmndesc text NOT NULL,
    dmnurl character varying(60) NOT NULL,
    dmnsts boolean NOT NULL,
    dmnnivel text,
    dmnlocup character varying(50),
    dmnraiz character varying(256)
);


--
-- TOC entry 280 (OID 962604)
-- Name: grm; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE grm (
    grmid serial NOT NULL,
    grmnome character varying(40) NOT NULL,
    grmdesc text
);


--
-- TOC entry 285 (OID 962612)
-- Name: lpc; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE lpc (
    lpcid serial NOT NULL,
    lpcctuid integer,
    lpcplcid integer
);


--
-- TOC entry 290 (OID 962617)
-- Name: mlg; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE mlg (
    mlgid serial NOT NULL,
    mlggrmid integer NOT NULL,
    mlgnome character varying(60),
    mlgemail character varying(60) NOT NULL,
    mlginst character varying(60),
    mlgbol boolean NOT NULL,
    mlgnot boolean NOT NULL
);


--
-- TOC entry 299 (OID 962622)
-- Name: mop; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE mop (
    mopid serial NOT NULL,
    mopnome character varying(60) NOT NULL,
    mopdesc text,
    moparq character varying(60) NOT NULL,
    mopcssidimp integer,
    mopcssidtl integer,
    mopscript character varying(60) NOT NULL
);


--
-- TOC entry 308 (OID 962630)
-- Name: plc; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE plc (
    plcid serial NOT NULL,
    plcdesc character varying(30) NOT NULL
);


--
-- TOC entry 312 (OID 962635)
-- Name: scc; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE scc (
    sccid serial NOT NULL,
    sccdmnid integer NOT NULL,
    sccsccid integer,
    sccpfuid integer,
    sccmopidvis integer,
    sccmopidenv integer,
    sccdesc text,
    sccsts boolean NOT NULL,
    sccnome character varying(100) NOT NULL,
    sccurl character varying(256),
    scctpcid integer,
    sccnivel text,
    sccframe text
);


--
-- TOC entry 326 (OID 962643)
-- Name: tam; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE tam (
    tamid serial NOT NULL,
    tamnome character varying(60) NOT NULL,
    tamext character varying(5),
    tamtipo character(2) NOT NULL,
    tamdesc text NOT NULL,
    tamimg character varying(80),
    CONSTRAINT ckc_tamtipo_tam CHECK ((((((tamtipo = 'AU'::bpchar) OR (tamtipo = 'VD'::bpchar)) OR (tamtipo = 'TX'::bpchar)) OR (tamtipo = 'AR'::bpchar)) OR (tamtipo = 'AI'::bpchar)))
);


--
-- TOC entry 334 (OID 962652)
-- Name: tpc; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE tpc (
    tpcid serial NOT NULL,
    tpcnome character varying(40) NOT NULL,
    tpcsigla character varying(3) NOT NULL
);


--
-- TOC entry 518 (OID 962655)
-- Name: scc_prx_nivel(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION scc_prx_nivel() RETURNS "trigger"
    AS 'BEGIN
	UPDATE SCC SET SCCNIVEL = (
		SELECT ( SELECT sccnivel FROM scc WHERE sccid=COALESCE( NEW.SCCSCCID, 0 ) )||''.''||TRIM( 
		TO_CHAR( ( SELECT COUNT(*) FROM SCC WHERE SCCSCCID=NEW.SCCSCCID ), ''0000'' ) ) AS nivel FROM scc 
		WHERE sccsccid=COALESCE( NEW.SCCSCCID, 0 ) UNION SELECT CASE WHEN COALESCE( NEW.SCCSCCID, 0 ) = 0 
		THEN ( SELECT TEXT( COALESCE( MAX ( INT4( sccnivel ) ), 0 ) + 1 ) FROM scc WHERE sccdmnid=NEW.SCCDMNID 
		AND sccsccid IS NULL LIMIT 1 ) END AS prxnivel FROM scc LIMIT 1 ) WHERE SCCID=NEW.SCCID; 
	RETURN NEW; 
   END;'
    LANGUAGE pgsql;


--
-- TOC entry 7 (OID 962656)
-- Name: cev_cevnum_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE cev_cevnum_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 9 (OID 962658)
-- Name: cmd_cmdnumero_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE cmd_cmdnumero_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 11 (OID 962660)
-- Name: dsp_dspnumero_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE dsp_dspnumero_seq
    START WITH 4999
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 13 (OID 962662)
-- Name: mem_memnumero_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE mem_memnumero_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 15 (OID 962664)
-- Name: ofc_ofcnumero_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE ofc_ofcnumero_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 510 (OID 962666)
-- Name: dce_prx_num(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dce_prx_num() RETURNS "trigger"
    AS '    BEGIN
	IF NEW.DCENUM IS NULL THEN
		UPDATE DCE SET DCENUM=(SELECT TO_CHAR(NEXTVAL(''DCE_DCENUM_SEQ''),''00000'')||''/''||
		DATE_PART(''YEAR'',CAST(NOW() AS DATE))||''-MDA/CRM-''||(SELECT UNDSIGLA FROM USR JOIN URD ON 
		USRURDID=URDID JOIN CEV ON CEVUSRID=USRID JOIN DCE ON DCECEVID=CEVID AND DCEID=NEW.DCEID 
		JOIN UND ON UNDID=URDUNDID)) WHERE DCEID=NEW.DCEID;
	END IF;
	RETURN NEW;
    END;'
    LANGUAGE pgsql;


--
-- TOC entry 17 (OID 962667)
-- Name: dce_dcenum_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE dce_dcenum_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 339 (OID 962671)
-- Name: cts; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE cts (
    ctsid serial NOT NULL,
    ctssccid integer NOT NULL,
    ctsctuid integer NOT NULL,
    ctsmopidvis integer,
    ctsmopidenv integer,
    ctsordem smallint
);


--
-- TOC entry 347 (OID 962676)
-- Name: abp; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE abp (
    abpid serial NOT NULL,
    abpusrid integer NOT NULL,
    abpsccid integer NOT NULL
);


--
-- TOC entry 352 (OID 962681)
-- Name: bnn; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE bnn (
    bnnid serial NOT NULL,
    bnndmnid integer,
    bnnarq character varying(40) NOT NULL,
    bnnnome character varying(60) NOT NULL,
    bnnlink character varying(100) NOT NULL,
    bnnsts boolean NOT NULL
);


--
-- TOC entry 360 (OID 962686)
-- Name: bns; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE bns (
    bnsid serial NOT NULL,
    bnsbnnid integer NOT NULL,
    bnssccid integer NOT NULL
);


--
-- TOC entry 512 (OID 962689)
-- Name: cts_prx_ordem(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cts_prx_ordem() RETURNS "trigger"
    AS '    BEGIN
	UPDATE CTS SET CTSORDEM=( SELECT CASE WHEN MAX( CTSORDEM ) > 0 THEN ( MAX( CTSORDEM ) + 1 ) ELSE 1 END
	FROM CTS ) WHERE CTSID=NEW.CTSID;
	RETURN NEW;
    END;'
    LANGUAGE pgsql;


--
-- TOC entry 514 (OID 962690)
-- Name: dmn_prx_nivel(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dmn_prx_nivel() RETURNS "trigger"
    AS '    BEGIN
	UPDATE DMN SET DMNNIVEL = ( SELECT CASE WHEN dmnnivel IS NULL THEN '''' ELSE ( 
	SELECT dmnnivel 
	FROM dmn WHERE COALESCE( dmnid, 0 )=COALESCE( NEW.DMNDMNID, 0 ) 
	)||''.''||TRIM( TO_CHAR( MAX( INT4( COALESCE( SUBSTR( dmnnivel, LENGTH( ( 
		SELECT dmnnivel 
		FROM dmn 
		WHERE COALESCE( dmnid, 0 )=COALESCE( NEW.DMNDMNID, 0 ) ) ) + 2, LENGTH( dmnnivel ) ), ''0'' ) ) ) + 1, ''0000'' ) ) 
	  END AS prxnivel 
	  FROM dmn 
	  WHERE DMNDMNID=NEW.DMNDMNID 
	  GROUP BY dmnnivel 
	  UNION 
	  SELECT CASE WHEN dmnnivel IS NULL THEN '''' ELSE dmnnivel||''.0001'' END AS prxnivel 
	  FROM dmn 
	  WHERE COALESCE( dmnid, 0 )=COALESCE( NEW.DMNDMNID, 0 ) 
	  UNION 
	  SELECT CASE WHEN DMNDMNID IS NULL THEN TEXT( INT4( COALESCE( MAX( dmnnivel ), ''0'' ) ) + 1 ) 
	  ELSE '''' END AS prxnivel 
	  FROM dmn
	  WHERE COALESCE( DMNDMNID, 0 )=COALESCE( NEW.DMNDMNID, 0 ) 
	  GROUP BY DMNDMNID 
	  ORDER BY prxnivel DESC
	  LIMIT 1
	) WHERE DMNID=NEW.DMNID;
	RETURN NEW;
    END;'
    LANGUAGE pgsql;


--
-- TOC entry 516 (OID 962691)
-- Name: anc_prx_ordem(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION anc_prx_ordem() RETURNS "trigger"
    AS '    BEGIN
	UPDATE ANC SET ANCORDEM=( SELECT CASE WHEN MAX( ANCORDEM ) > 0 THEN ( MAX( ANCORDEM ) + 1 ) ELSE 1 END
	FROM ANC ) WHERE ANCID=NEW.ANCID;
	RETURN NEW;
    END;'
    LANGUAGE pgsql;


--
-- TOC entry 365 (OID 962694)
-- Name: ppb; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE ppb (
    ppbid serial NOT NULL,
    ppbtpcid integer NOT NULL,
    ppburdidorg integer NOT NULL,
    ppburdidrep integer NOT NULL
);


--
-- TOC entry 371 (OID 962697)
-- Name: aju; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE aju (
    ajumenid integer,
    ajudesc text
) WITHOUT OIDS;


--
-- TOC entry 373 (OID 962704)
-- Name: mss; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE mss (
    mssid serial NOT NULL,
    msscnt text NOT NULL,
    mssassunto character varying(40) NOT NULL,
    mssdthr timestamp without time zone NOT NULL,
    msssts character(2) NOT NULL,
    mssurdidrem integer NOT NULL,
    mssurdiddes integer NOT NULL,
    msstipo character varying(2) NOT NULL,
    mssoid integer NOT NULL,
    CONSTRAINT ckc_msssts_mss CHECK ((((msssts = 'LD'::bpchar) OR (msssts = 'NL'::bpchar)) OR (msssts = 'EX'::bpchar))),
    CONSTRAINT ckc_msstipo_mss CHECK (((((msstipo)::text = 'AS'::text) OR ((msstipo)::text = 'AR'::text)) OR ((msstipo)::text = 'AL'::text)))
);


--
-- Data for TOC entry 522 (OID 962342)
-- Name: men; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO men VALUES (183, 11, 221, 'abrangencia.php', NULL, 'Definir as permissões de publicação aos usuários do sistema', 3, 'Permissões de publicação', NULL, NULL);
INSERT INTO men VALUES (9, 1, 8, 'frmfiltlog.php', '', 'Clique aqui para ver a relação de logs dos usuários', 0, 'Logs de usuários', NULL, NULL);
INSERT INTO men VALUES (32, 3, 0, '', '_self', 'Cadastros', 0, 'Cadastros', NULL, NULL);
INSERT INTO men VALUES (261, 1, 0, '', NULL, 'Cadastro de módulos de sistema', 0, 'Módulos', NULL, NULL);
INSERT INTO men VALUES (192, 11, 0, '', NULL, '', 2, 'Publicações', NULL, NULL);
INSERT INTO men VALUES (195, 11, 221, 'liberacaoconteudo.php', NULL, 'Liberar os conteúdos cadastrados para visualização no site externo', 4, 'Publicação de conteúdos', NULL, NULL);
INSERT INTO men VALUES (74, 3, 32, 'municipios.php', '', 'Clique aqui para cadastrar os municípios', 0, 'Municípios', NULL, NULL);
INSERT INTO men VALUES (78, 3, 32, 'atendentes.php', '', 'Clique aqui para cadastrar atendentes', 0, 'Atendentes', NULL, NULL);
INSERT INTO men VALUES (99, 3, 101, 'gerencia.php', '', 'Vizualização de todos os atendimentos', 0, 'Gerência de atendimentos', NULL, NULL);
INSERT INTO men VALUES (101, 3, 0, '', '', 'Movimentações', 0, 'Movimentações', NULL, NULL);
INSERT INTO men VALUES (81, 3, 101, 'direcionamento.php', '', 'Atendimentos direcionados ao usuário logado', 0, 'Atendimentos direcionados', NULL, NULL);
INSERT INTO men VALUES (166, 3, 150, 'relcruzado.php', NULL, 'Relatórios cruzados', 0, 'Relatórios cruzados', NULL, NULL);
INSERT INTO men VALUES (150, 3, 0, '', '', 'Relatórios', 0, 'Relatórios', NULL, NULL);
INSERT INTO men VALUES (147, 3, 150, 'pesquisa_atendimento.php', '', 'Relatório de atendimentos', 0, 'Relatório de atendimentos', NULL, NULL);
INSERT INTO men VALUES (148, 3, 101, 'atendimento_rapido.php', '', 'Registro de atendimentos já realizados', 0, 'Atendimento rápido', NULL, NULL);
INSERT INTO men VALUES (190, 11, 220, 'arquivomidia.php', NULL, 'Cadastrar os tipos de mídia acessíveis pelo sistema', 2, 'Arquivos de mídia', NULL, NULL);
INSERT INTO men VALUES (162, 3, 32, 'clsdiagnostico.php', NULL, 'Define a classificação para os diversos tipos de diagnósticos do sistema', 0, 'Classificação de diagnósticos', NULL, NULL);
INSERT INTO men VALUES (38, 3, 32, 'divisao.php', '', 'Clique aqui para cadastrar as divisões de atendimento', 0, 'Divisões de atendimento', NULL, NULL);
INSERT INTO men VALUES (219, 11, 221, 'banner.php', NULL, 'Cadastro de banners dos domínios', 5, 'Editor de banners', NULL, NULL);
INSERT INTO men VALUES (149, 3, 101, 'chefe_divisao.php', '', 'Clique aqui para visualizar as pendência direcionadas para esta divisão', 0, 'Pendências da divisão', NULL, NULL);
INSERT INTO men VALUES (71, 3, 32, 'diagnostico.php', '', 'Clique aqui para cadastrar os diagnósticos', 0, 'Diagnósticos', NULL, NULL);
INSERT INTO men VALUES (220, 11, 0, '', NULL, '', 0, 'Cadastros', NULL, NULL);
INSERT INTO men VALUES (221, 11, 0, '', NULL, '', 1, 'Gerenciamento', NULL, NULL);
INSERT INTO men VALUES (198, 11, 220, 'contatos.php', NULL, 'Cadastro da lista de contatos do mailling', 6, 'Contatos', NULL, NULL);
INSERT INTO men VALUES (191, 11, 220, 'cadplvchave.php', NULL, 'Cadastrar as palavras-chave para visualização de conteúdos relacionados', 3, 'Palavras-chave', NULL, NULL);
INSERT INTO men VALUES (163, 3, 32, 'coordenacao.php', NULL, 'Define as coordenações responsáveis pelo gerenciamento das diversas divisões de atendimento', 1, 'Coordenações gerais', NULL, NULL);
INSERT INTO men VALUES (193, 11, 221, 'cadconteudo.php', NULL, 'Cadastro de conteúdos para publicação', 2, 'Editor de conteúdos', NULL, NULL);
INSERT INTO men VALUES (2, 1, 261, 'menus.php', '', 'Cadastrar os itens de menu dos sistemas', 1, 'Menus', NULL, NULL);
INSERT INTO men VALUES (185, 11, 221, 'dominios.php', NULL, 'Cadastrar os domínios existentes', 0, 'Editor de domínios', NULL, NULL);
INSERT INTO men VALUES (197, 11, 220, 'grupos.php', NULL, 'Cadastro de grupos de email', 5, 'Grupos de email', NULL, NULL);
INSERT INTO men VALUES (28, 1, 261, 'mensagens.php', '', 'Cadastrar as mensagens padronizadas para os sistemas', 3, 'Mensagens', NULL, NULL);
INSERT INTO men VALUES (334, 1, 261, 'ajuda.php', NULL, 'Cadastros de ajuda dos menus de sistema', 2, 'Ajudas', NULL, NULL);
INSERT INTO men VALUES (5, 1, 1, 'usuarios.php', '', 'Cadastrar usuários dos sistemas', 0, 'Usuários de sistema', NULL, NULL);
INSERT INTO men VALUES (4, 1, 1, 'acessos.php', '', 'Definir as permissões de acesso aos usuários dos sistemas', 2, 'Permissões', NULL, NULL);
INSERT INTO men VALUES (262, 1, 1, 'caduser.php', NULL, 'Cadastro geral dos usuários da rede', 0, 'Usuários da rede', NULL, NULL);
INSERT INTO men VALUES (164, 1, 1, 'perfis.php', NULL, 'Cadastro de perfis de usuários', 1, 'Perfis de usuário', NULL, NULL);
INSERT INTO men VALUES (170, 1, 1, 'alterasenha.php', NULL, 'Alteração de senha do usuário logado', 3, 'Alteração de senha', NULL, NULL);
INSERT INTO men VALUES (186, 11, 221, 'secoes.php', NULL, 'Cadastrar as seções de conteúdo dos domínios', 1, 'Editor de seções', NULL, NULL);
INSERT INTO men VALUES (189, 11, 220, 'modelos.php', NULL, 'Cadastrar os modelos de páginas para visualização e envio de email', 0, 'Modelos de páginas', NULL, NULL);
INSERT INTO men VALUES (151, 3, 150, 'consolidados.php', '', 'Relatórios consolidados', 0, 'Relatórios consolidados', NULL, NULL);
INSERT INTO men VALUES (207, 11, 220, 'tpconteudo.php', NULL, 'Cadastro de tipos de conteúdos', 4, 'Tipos de conteúdo', NULL, NULL);
INSERT INTO men VALUES (73, 3, 32, 'unidades.php', '', 'Cadastrar as unidades administrativas', 0, 'Unidades administrativas', NULL, NULL);
INSERT INTO men VALUES (72, 3, 32, 'tpserv.php', '', 'Clique aqui para cadastrar os tipos de serviço', 0, 'Tipos de serviço', NULL, NULL);
INSERT INTO men VALUES (30, 1, 261, 'variaveis.php', '', 'Cadastrar variáveis de ambiente dos sistemas', 4, 'Variáveis de ambiente', NULL, NULL);
INSERT INTO men VALUES (1, 1, 0, '', '', 'Acessos', 1, 'Acessos', NULL, NULL);
INSERT INTO men VALUES (8, 1, 0, '', '', 'Relatórios', 2, 'Relatórios', NULL, NULL);
INSERT INTO men VALUES (3, 1, 261, 'sistemas.php', '', 'Cadastrar os sistemas desenvolvidos', 0, 'Sistemas', NULL, NULL);


--
-- Data for TOC entry 523 (OID 962351)
-- Name: sis; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO sis VALUES (3, 'Sisau®', 'Sistema de Atendimento ao Usuário', '1.1.0', '/classes/sisau', '/classes/sisau/img', 81, 'AT', '/sys/includes/sisau/lib', '
<b>Equipe de Projeto<br /><hr /></b><p><b>Paulo Ricardo Carvalho de Oliveira</b><br />Coordenação Geral<br /></p><p><b>Ederson Szulczewski</b><br />Análise e Gerência de Projeto</p><p><b>Fábio Pili Palácios</b><br />Design e Arquitetura de Informação</p><p><b>Bruno Alves Teixeira</b><br /><b>Pedro Kiyoshi Nakano</b><br /><b>Rodrigo Otávio Moraes</b><br />Desenvolvedores</p><br />');
INSERT INTO sis VALUES (11, 'Saci Livre®', 'Sistema de Administração de Conteúdos Institucionais na Internet', '1.0.0', '/classes/saci', '/classes/saci/imgs', 185, 'AT', NULL, '
<b>Equipe de Projeto<br /><hr /></b><p><b>Paulo Ricardo Carvalho de Oliveira</b><br />Coordenação Geral<br /></p><p><b>Ederson Szulczewski</b><br />Análise e Gerência de Projeto</p><p><b>Fábio Pili Palácios</b><br />Design e Arquitetura de Informação</p><p><b>Bruno Alves Teixeira</b><br /><b>Pedro Kiyoshi Nakano</b><br /><b>Rodrigo Otávio Moraes</b><br />Desenvolvedores</p><br /><br /><br /><br />');
INSERT INTO sis VALUES (1, 'Contra®', 'Sistema de Controle de Acessos e Modularização de Sistemas', '1.2.0', '/classes/contra', '/classes/contra/img', 3, 'AT', NULL, '
<b>Equipe de Projeto<br /><hr /></b><p><b>Paulo Ricardo Carvalho de Oliveira</b><br />Coordenação Geral<br /></p><p><b>Ederson Szulczewski</b><br />Análise e Gerência de Projeto</p><p><b>Fábio Pili Palácios</b><br />Design e Arquitetura de Informação</p><p><b>Bruno Alves Teixeira</b><br /><b>Pedro Kiyoshi Nakano</b><br /><b>Rodrigo Otávio Moraes</b><br />Desenvolvedores</p><br /><br /><br />');


--
-- Data for TOC entry 533 (OID 962405)
-- Name: mun; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO mun VALUES (3301, 'RJ', '33', '06305', 'Volta Redonda');
INSERT INTO mun VALUES (3943, 'SP', '35', '57006', 'Votorantim');
INSERT INTO mun VALUES (3944, 'SP', '35', '57105', 'Votuporanga');
INSERT INTO mun VALUES (2272, 'BA', '29', '33406', 'Wagner');
INSERT INTO mun VALUES (915, 'PI', '22', '11704', 'Wall Ferraz');
INSERT INTO mun VALUES (473, 'TO', '17', '22081', 'Wanderlandia');
INSERT INTO mun VALUES (2273, 'BA', '29', '33455', 'Wanderley');
INSERT INTO mun VALUES (4339, 'PR', '41', '28500', 'Wenceslau Braz');
INSERT INTO mun VALUES (3129, 'MG', '31', '72202', 'Wenceslau Braz');
INSERT INTO mun VALUES (2274, 'BA', '29', '33505', 'Wenceslau Guimarães');
INSERT INTO mun VALUES (5138, 'RS', '43', '23770', 'Westfalia');
INSERT INTO mun VALUES (4637, 'SC', '42', '19408', 'Witmarsum');
INSERT INTO mun VALUES (474, 'TO', '17', '22107', 'Xambioa');
INSERT INTO mun VALUES (4347, 'PR', '41', '28807', 'Xambre');
INSERT INTO mun VALUES (5139, 'RS', '43', '23804', 'Xangri-la');
INSERT INTO mun VALUES (4638, 'SC', '42', '19507', 'Xanxere');
INSERT INTO mun VALUES (93, 'AC', '12', '00708', 'Xapuri');
INSERT INTO mun VALUES (4639, 'SC', '42', '19606', 'Xavantina');
INSERT INTO mun VALUES (4640, 'SC', '42', '19705', 'Xaxim');
INSERT INTO mun VALUES (1678, 'PE', '26', '16506', 'Xexeu');
INSERT INTO mun VALUES (317, 'PA', '15', '08407', 'Xinguara');
INSERT INTO mun VALUES (2275, 'BA', '29', '33604', 'Xique-xique');
INSERT INTO mun VALUES (1492, 'PB', '25', '17407', 'Zabele');
INSERT INTO mun VALUES (3945, 'SP', '35', '57154', 'Zacarias');
INSERT INTO mun VALUES (692, 'MA', '21', '14007', 'Ze Doca');
INSERT INTO mun VALUES (1742, 'AL', '27', '05903', 'Olho D''agua Grande');
INSERT INTO mun VALUES (11388, 'PB', '25', 'TR095', 'Zona da Mata PB');
INSERT INTO mun VALUES (11389, 'RS', '43', 'TR096', 'Zona Sul do Estado RS');
INSERT INTO mun VALUES (4641, 'SC', '42', '19853', 'Zortea');
INSERT INTO mun VALUES (1490, 'PB', '25', '17100', 'Varzea');
INSERT INTO mun VALUES (1099, 'CE', '23', '14003', 'Varzea Alegre');
INSERT INTO mun VALUES (911, 'PI', '22', '11357', 'Varzea Branca');
INSERT INTO mun VALUES (3112, 'MG', '31', '70800', 'Varzea Da Palma');
INSERT INTO mun VALUES (2265, 'BA', '29', '33059', 'Varzea Da Roça');
INSERT INTO mun VALUES (2266, 'BA', '29', '33109', 'Varzea Do Poço');
INSERT INTO mun VALUES (912, 'PI', '22', '11407', 'Varzea Grande');
INSERT INTO mun VALUES (5351, 'MT', '51', '08402', 'Varzea Grande');
INSERT INTO mun VALUES (2267, 'BA', '29', '33158', 'Varzea Nova');
INSERT INTO mun VALUES (3937, 'SP', '35', '56503', 'Varzea Paulista');
INSERT INTO mun VALUES (2268, 'BA', '29', '33174', 'Varzedo');
INSERT INTO mun VALUES (3113, 'MG', '31', '70909', 'Varzelandia');
INSERT INTO mun VALUES (3300, 'RJ', '33', '06206', 'Vassouras');
INSERT INTO mun VALUES (3114, 'MG', '31', '71006', 'Vazante');
INSERT INTO mun VALUES (5122, 'RS', '43', '22608', 'Venancio Aires');
INSERT INTO mun VALUES (3203, 'ES', '32', '05069', 'Venda Nova Do Imigrante');
INSERT INTO mun VALUES (1265, 'RN', '24', '14753', 'Venha-ver');
INSERT INTO mun VALUES (4340, 'PR', '41', '28534', 'Ventania');
INSERT INTO mun VALUES (1672, 'PE', '26', '16001', 'Venturosa');
INSERT INTO mun VALUES (5352, 'MT', '51', '08501', 'Vera');
INSERT INTO mun VALUES (3938, 'SP', '35', '56602', 'Vera Cruz');
INSERT INTO mun VALUES (2269, 'BA', '29', '33208', 'Vera Cruz');
INSERT INTO mun VALUES (1266, 'RN', '24', '14803', 'Vera Cruz');
INSERT INTO mun VALUES (5123, 'RS', '43', '22707', 'Vera Cruz');
INSERT INTO mun VALUES (4341, 'PR', '41', '28559', 'Vera Cruz Do Oeste');
INSERT INTO mun VALUES (913, 'PI', '22', '11506', 'Vera Mendes');
INSERT INTO mun VALUES (5124, 'RS', '43', '22806', 'Veranopolis');
INSERT INTO mun VALUES (1673, 'PE', '26', '16100', 'Verdejante');
INSERT INTO mun VALUES (3115, 'MG', '31', '71030', 'Verdelandia');
INSERT INTO mun VALUES (4342, 'PR', '41', '28609', 'Vere');
INSERT INTO mun VALUES (2270, 'BA', '29', '33257', 'Vereda');
INSERT INTO mun VALUES (3116, 'MG', '31', '71071', 'Veredinha');
INSERT INTO mun VALUES (3117, 'MG', '31', '71105', 'Verissimo');
INSERT INTO mun VALUES (3118, 'MG', '31', '71154', 'Vermelho Novo');
INSERT INTO mun VALUES (1674, 'PE', '26', '16183', 'Vertente Do Lerio');
INSERT INTO mun VALUES (1675, 'PE', '26', '16209', 'Vertentes');
INSERT INTO mun VALUES (3119, 'MG', '31', '71204', 'Vespasiano');
INSERT INTO mun VALUES (5125, 'RS', '43', '22855', 'Vespasiano Correa');
INSERT INTO mun VALUES (5126, 'RS', '43', '22905', 'Viadutos');
INSERT INTO mun VALUES (5127, 'RS', '43', '23002', 'Viamão');
INSERT INTO mun VALUES (688, 'MA', '21', '12803', 'Viana');
INSERT INTO mun VALUES (3204, 'ES', '32', '05101', 'Viana');
INSERT INTO mun VALUES (5601, 'GO', '52', '22005', 'Vianopolis');
INSERT INTO mun VALUES (1676, 'PE', '26', '16308', 'Vicencia');
INSERT INTO mun VALUES (5128, 'RS', '43', '23101', 'Vicente Dutra');
INSERT INTO mun VALUES (5217, 'MS', '50', '08404', 'Vicentina');
INSERT INTO mun VALUES (5602, 'GO', '52', '22054', 'Vicentinopolis');
INSERT INTO mun VALUES (5129, 'RS', '43', '23200', 'Victor Graeff');
INSERT INTO mun VALUES (4634, 'SC', '42', '19200', 'Vidal Ramos');
INSERT INTO mun VALUES (4635, 'SC', '42', '19309', 'Videira');
INSERT INTO mun VALUES (3121, 'MG', '31', '71402', 'Vieiras');
INSERT INTO mun VALUES (1491, 'PB', '25', '17209', 'Vieiropolis');
INSERT INTO mun VALUES (314, 'PA', '15', '08209', 'Vigia');
INSERT INTO mun VALUES (4343, 'PR', '41', '28625', 'Vila Alta');
INSERT INTO mun VALUES (5281, 'MT', '51', '05507', 'Vila Bela Da Santissima');
INSERT INTO mun VALUES (5603, 'GO', '52', '22203', 'Vila Boa');
INSERT INTO mun VALUES (1268, 'RN', '24', '15008', 'Vila Flor');
INSERT INTO mun VALUES (5130, 'RS', '43', '23309', 'Vila Flores');
INSERT INTO mun VALUES (5131, 'RS', '43', '23358', 'Vila Langaro');
INSERT INTO mun VALUES (5132, 'RS', '43', '23408', 'Vila Maria');
INSERT INTO mun VALUES (914, 'PI', '22', '11605', 'Vila Nova Do Piaui');
INSERT INTO mun VALUES (689, 'MA', '21', '12852', 'Vila Nova Dos Martirios');
INSERT INTO mun VALUES (5133, 'RS', '43', '23457', 'Vila Nova Do Sul');
INSERT INTO mun VALUES (3205, 'ES', '32', '05150', 'Vila Pavão');
INSERT INTO mun VALUES (5604, 'GO', '52', '22302', 'Vila Propicio');
INSERT INTO mun VALUES (5353, 'MT', '51', '08600', 'Vila Rica');
INSERT INTO mun VALUES (3206, 'ES', '32', '05176', 'Vila Valerio');
INSERT INTO mun VALUES (3207, 'ES', '32', '05200', 'Vila Velha');
INSERT INTO mun VALUES (41, 'RO', '11', '00304', 'Vilhena');
INSERT INTO mun VALUES (3939, 'SP', '35', '56701', 'Vinhedo');
INSERT INTO mun VALUES (1781, 'AL', '27', '09400', 'Viçosa');
INSERT INTO mun VALUES (1267, 'RN', '24', '14902', 'Viçosa');
INSERT INTO mun VALUES (3120, 'MG', '31', '71303', 'Viçosa');
INSERT INTO mun VALUES (1100, 'CE', '23', '14102', 'Viçosa Do Ceara');
INSERT INTO mun VALUES (3940, 'SP', '35', '56800', 'Viradouro');
INSERT INTO mun VALUES (3123, 'MG', '31', '71600', 'Virgem Da Lapa');
INSERT INTO mun VALUES (3124, 'MG', '31', '71709', 'Virginia');
INSERT INTO mun VALUES (3125, 'MG', '31', '71808', 'Virginopolis');
INSERT INTO mun VALUES (3126, 'MG', '31', '71907', 'Virgolandia');
INSERT INTO mun VALUES (4345, 'PR', '41', '28658', 'Virmond');
INSERT INTO mun VALUES (3127, 'MG', '31', '72004', 'Visconde Do Rio Branco');
INSERT INTO mun VALUES (315, 'PA', '15', '08308', 'Viseu');
INSERT INTO mun VALUES (5134, 'RS', '43', '23507', 'Vista Alegre');
INSERT INTO mun VALUES (3941, 'SP', '35', '56909', 'Vista Alegre Do Alto');
INSERT INTO mun VALUES (5135, 'RS', '43', '23606', 'Vista Alegre Do Prata');
INSERT INTO mun VALUES (5136, 'RS', '43', '23705', 'Vista Gaucha');
INSERT INTO mun VALUES (1344, 'PB', '25', '05501', 'Vista Serrana');
INSERT INTO mun VALUES (3208, 'ES', '32', '05309', 'Vitoria');
INSERT INTO mun VALUES (3942, 'SP', '35', '56958', 'Vitoria Brasil');
INSERT INTO mun VALUES (2271, 'BA', '29', '33307', 'Vitoria Da Conquista');
INSERT INTO mun VALUES (5137, 'RS', '43', '23754', 'Vitoria Das Missões');
INSERT INTO mun VALUES (1677, 'PE', '26', '16407', 'Vitoria De Santo Antão');
INSERT INTO mun VALUES (334, 'AP', '16', '00808', 'Vitoria Do Jari');
INSERT INTO mun VALUES (690, 'MA', '21', '12902', 'Vitoria Do Mearim');
INSERT INTO mun VALUES (316, 'PA', '15', '08357', 'Vitoria Do Xingu');
INSERT INTO mun VALUES (4346, 'PR', '41', '28708', 'Vitorino');
INSERT INTO mun VALUES (691, 'MA', '21', '13009', 'Vitorino Freire');
INSERT INTO mun VALUES (4636, 'SC', '42', '19358', 'Vitor Meireles');
INSERT INTO mun VALUES (3128, 'MG', '31', '72103', 'Volta Grande');
INSERT INTO mun VALUES (2255, 'BA', '29', '32200', 'Ubaitaba');
INSERT INTO mun VALUES (1093, 'CE', '23', '13609', 'Ubajara');
INSERT INTO mun VALUES (3098, 'MG', '31', '70057', 'Ubaporanga');
INSERT INTO mun VALUES (3923, 'SP', '35', '55356', 'Ubarana');
INSERT INTO mun VALUES (2256, 'BA', '29', '32309', 'Ubatã');
INSERT INTO mun VALUES (3924, 'SP', '35', '55406', 'Ubatuba');
INSERT INTO mun VALUES (3099, 'MG', '31', '70107', 'Uberaba');
INSERT INTO mun VALUES (3100, 'MG', '31', '70206', 'Uberlandia');
INSERT INTO mun VALUES (3925, 'SP', '35', '55505', 'Ubirajara');
INSERT INTO mun VALUES (4334, 'PR', '41', '28005', 'Ubiratã');
INSERT INTO mun VALUES (5113, 'RS', '43', '22343', 'Ubiretama');
INSERT INTO mun VALUES (3926, 'SP', '35', '55604', 'Uchoa');
INSERT INTO mun VALUES (2257, 'BA', '29', '32408', 'Uibai');
INSERT INTO mun VALUES (173, 'RR', '14', '00704', 'Uiramutã');
INSERT INTO mun VALUES (5595, 'GO', '52', '21577', 'Uirapuru');
INSERT INTO mun VALUES (1488, 'PB', '25', '16904', 'Uirauna');
INSERT INTO mun VALUES (312, 'PA', '15', '08126', 'Ulianopolis');
INSERT INTO mun VALUES (1094, 'CE', '23', '13708', 'Umari');
INSERT INTO mun VALUES (1262, 'RN', '24', '14506', 'Umarizal');
INSERT INTO mun VALUES (1857, 'SE', '28', '07600', 'Umbauba');
INSERT INTO mun VALUES (2258, 'BA', '29', '32457', 'Umburanas');
INSERT INTO mun VALUES (3101, 'MG', '31', '70305', 'Umburatiba');
INSERT INTO mun VALUES (1489, 'PB', '25', '17001', 'Umbuzeiro');
INSERT INTO mun VALUES (1095, 'CE', '23', '13757', 'Umirim');
INSERT INTO mun VALUES (4335, 'PR', '41', '28104', 'Umuarama');
INSERT INTO mun VALUES (2259, 'BA', '29', '32507', 'Una');
INSERT INTO mun VALUES (3102, 'MG', '31', '70404', 'Unai');
INSERT INTO mun VALUES (4337, 'PR', '41', '28302', 'Uniflor');
INSERT INTO mun VALUES (908, 'PI', '22', '11100', 'União');
INSERT INTO mun VALUES (5114, 'RS', '43', '22350', 'União Da Serra');
INSERT INTO mun VALUES (4336, 'PR', '41', '28203', 'União Da Vitoria');
INSERT INTO mun VALUES (3103, 'MG', '31', '70438', 'União De Minas');
INSERT INTO mun VALUES (4627, 'SC', '42', '18855', 'União Do Oeste');
INSERT INTO mun VALUES (1780, 'AL', '27', '09301', 'União Dos Palmares');
INSERT INTO mun VALUES (5349, 'MT', '51', '08303', 'União Do Sul');
INSERT INTO mun VALUES (3927, 'SP', '35', '55703', 'União Paulista');
INSERT INTO mun VALUES (5115, 'RS', '43', '22376', 'Unistalda');
INSERT INTO mun VALUES (1263, 'RN', '24', '14605', 'Upanema');
INSERT INTO mun VALUES (4338, 'PR', '41', '28401', 'Urai');
INSERT INTO mun VALUES (2260, 'BA', '29', '32606', 'Urandi');
INSERT INTO mun VALUES (3928, 'SP', '35', '55802', 'Urania');
INSERT INTO mun VALUES (686, 'MA', '21', '12605', 'Urbano Santos');
INSERT INTO mun VALUES (3929, 'SP', '35', '55901', 'Uru');
INSERT INTO mun VALUES (5597, 'GO', '52', '21700', 'Uruana');
INSERT INTO mun VALUES (3104, 'MG', '31', '70479', 'Uruana De Minas');
INSERT INTO mun VALUES (313, 'PA', '15', '08159', 'Uruara');
INSERT INTO mun VALUES (5596, 'GO', '52', '21601', 'Uruaçu');
INSERT INTO mun VALUES (4628, 'SC', '42', '18905', 'Urubici');
INSERT INTO mun VALUES (1096, 'CE', '23', '13807', 'Uruburetama');
INSERT INTO mun VALUES (3105, 'MG', '31', '70503', 'Urucania');
INSERT INTO mun VALUES (156, 'AM', '13', '04302', 'Urucara');
INSERT INTO mun VALUES (3106, 'MG', '31', '70529', 'Urucuia');
INSERT INTO mun VALUES (157, 'AM', '13', '04401', 'Urucurituba');
INSERT INTO mun VALUES (5116, 'RS', '43', '22400', 'Uruguaiana');
INSERT INTO mun VALUES (1097, 'CE', '23', '13906', 'Uruoca');
INSERT INTO mun VALUES (69, 'RO', '11', '01708', 'Urupa');
INSERT INTO mun VALUES (4629, 'SC', '42', '18954', 'Urupema');
INSERT INTO mun VALUES (3930, 'SP', '35', '56008', 'Urupes');
INSERT INTO mun VALUES (4630, 'SC', '42', '19002', 'Urussanga');
INSERT INTO mun VALUES (5598, 'GO', '52', '21809', 'Urutai');
INSERT INTO mun VALUES (2261, 'BA', '29', '32705', 'Uruçuca');
INSERT INTO mun VALUES (909, 'PI', '22', '11209', 'Uruçui');
INSERT INTO mun VALUES (2262, 'BA', '29', '32804', 'Utinga');
INSERT INTO mun VALUES (5117, 'RS', '43', '22509', 'Vacaria');
INSERT INTO mun VALUES (5350, 'MT', '51', '08352', 'Vale De São Domingos');
INSERT INTO mun VALUES (70, 'RO', '11', '01757', 'Vale Do Anari');
INSERT INTO mun VALUES (11383, 'PI', '22', 'TR090', 'Vale do Guaribas PI');
INSERT INTO mun VALUES (11384, 'MA', '21', 'TR091', 'Vale do Itapecuru MA');
INSERT INTO mun VALUES (11385, 'MG', '31', 'TR092', 'Vale do Mucuri MG');
INSERT INTO mun VALUES (71, 'RO', '11', '01807', 'Vale Do Paraiso');
INSERT INTO mun VALUES (11386, 'PR', '41', 'TR093', 'Vale do Ribeira  PR');
INSERT INTO mun VALUES (11387, 'SP', '35', 'TR094', 'Vale do Ribeira  SP');
INSERT INTO mun VALUES (5119, 'RS', '43', '22533', 'Vale Do Sol');
INSERT INTO mun VALUES (3298, 'RJ', '33', '06107', 'Valença');
INSERT INTO mun VALUES (2263, 'BA', '29', '32903', 'Valença');
INSERT INTO mun VALUES (910, 'PI', '22', '11308', 'Valença Do Piaui');
INSERT INTO mun VALUES (2264, 'BA', '29', '33000', 'Valente');
INSERT INTO mun VALUES (3931, 'SP', '35', '56107', 'Valentim Gentil');
INSERT INTO mun VALUES (5120, 'RS', '43', '22541', 'Vale Real');
INSERT INTO mun VALUES (5118, 'RS', '43', '22525', 'Vale Verde');
INSERT INTO mun VALUES (3932, 'SP', '35', '56206', 'Valinhos');
INSERT INTO mun VALUES (3933, 'SP', '35', '56305', 'Valparaiso');
INSERT INTO mun VALUES (5599, 'GO', '52', '21858', 'Valparaiso De Goias');
INSERT INTO mun VALUES (5121, 'RS', '43', '22558', 'Vanini');
INSERT INTO mun VALUES (3934, 'SP', '35', '56354', 'Vargem');
INSERT INTO mun VALUES (4632, 'SC', '42', '19150', 'Vargem');
INSERT INTO mun VALUES (3107, 'MG', '31', '70578', 'Vargem Alegre');
INSERT INTO mun VALUES (3202, 'ES', '32', '05036', 'Vargem Alta');
INSERT INTO mun VALUES (3108, 'MG', '31', '70602', 'Vargem Bonita');
INSERT INTO mun VALUES (4633, 'SC', '42', '19176', 'Vargem Bonita');
INSERT INTO mun VALUES (687, 'MA', '21', '12704', 'Vargem Grande');
INSERT INTO mun VALUES (3109, 'MG', '31', '70651', 'Vargem Grande Do Rio Par');
INSERT INTO mun VALUES (3935, 'SP', '35', '56404', 'Vargem Grande Do Sul');
INSERT INTO mun VALUES (3936, 'SP', '35', '56453', 'Vargem Grande Paulista');
INSERT INTO mun VALUES (4631, 'SC', '42', '19101', 'Vargeão');
INSERT INTO mun VALUES (3110, 'MG', '31', '70701', 'Varginha');
INSERT INTO mun VALUES (5600, 'GO', '52', '21908', 'Varjão');
INSERT INTO mun VALUES (3111, 'MG', '31', '70750', 'Varjão De Minas');
INSERT INTO mun VALUES (1098, 'CE', '23', '13955', 'Varjota');
INSERT INTO mun VALUES (3299, 'RJ', '33', '06156', 'Varre-sai');
INSERT INTO mun VALUES (1264, 'RN', '24', '14704', 'Varzea');
INSERT INTO mun VALUES (470, 'TO', '17', '21208', 'Tocantinopolis');
INSERT INTO mun VALUES (335, 'TO', '17', '00000', 'Tocantins');
INSERT INTO mun VALUES (3085, 'MG', '31', '69000', 'Tocantins');
INSERT INTO mun VALUES (3816, 'SP', '35', '45803', 'Santa Barbara D''oeste');
INSERT INTO mun VALUES (3086, 'MG', '31', '69059', 'Tocos Do Moji');
INSERT INTO mun VALUES (3818, 'SP', '35', '46108', 'Santa Clara D''oeste');
INSERT INTO mun VALUES (4327, 'PR', '41', '27700', 'Toledo');
INSERT INTO mun VALUES (3087, 'MG', '31', '69109', 'Toledo');
INSERT INTO mun VALUES (1856, 'SE', '28', '07501', 'Tomar Do Geru');
INSERT INTO mun VALUES (4328, 'PR', '41', '27809', 'Tomazina');
INSERT INTO mun VALUES (3088, 'MG', '31', '69208', 'Tombos');
INSERT INTO mun VALUES (307, 'PA', '15', '08001', 'Tome-açu');
INSERT INTO mun VALUES (154, 'AM', '13', '04237', 'Tonantins');
INSERT INTO mun VALUES (1666, 'PE', '26', '15409', 'Toritama');
INSERT INTO mun VALUES (5348, 'MT', '51', '08204', 'Torixoreu');
INSERT INTO mun VALUES (5093, 'RS', '43', '21493', 'Toropi');
INSERT INTO mun VALUES (3913, 'SP', '35', '54656', 'Torre De Pedra');
INSERT INTO mun VALUES (5094, 'RS', '43', '21501', 'Torres');
INSERT INTO mun VALUES (3832, 'SP', '35', '47403', 'Santa Rita D''oeste');
INSERT INTO mun VALUES (3914, 'SP', '35', '54706', 'Torrinha');
INSERT INTO mun VALUES (1260, 'RN', '24', '14407', 'Touros');
INSERT INTO mun VALUES (3915, 'SP', '35', '54755', 'Trabiju');
INSERT INTO mun VALUES (308, 'PA', '15', '08035', 'Tracuateua');
INSERT INTO mun VALUES (1667, 'PE', '26', '15508', 'Tracunhaem');
INSERT INTO mun VALUES (1779, 'AL', '27', '09202', 'Traipu');
INSERT INTO mun VALUES (1091, 'CE', '23', '13500', 'Trairi');
INSERT INTO mun VALUES (309, 'PA', '15', '08050', 'Trairão');
INSERT INTO mun VALUES (3296, 'RJ', '33', '05901', 'Trajano De Morais');
INSERT INTO mun VALUES (5095, 'RS', '43', '21600', 'Tramandai');
INSERT INTO mun VALUES (11382, 'PA', '15', 'TR089', 'Transamazônica PA');
INSERT INTO mun VALUES (5096, 'RS', '43', '21626', 'Travesseiro');
INSERT INTO mun VALUES (2251, 'BA', '29', '31806', 'Tremedal');
INSERT INTO mun VALUES (3916, 'SP', '35', '54805', 'Tremembe');
INSERT INTO mun VALUES (5097, 'RS', '43', '21634', 'Tres Arroios');
INSERT INTO mun VALUES (4619, 'SC', '42', '18301', 'Tres Barras');
INSERT INTO mun VALUES (4329, 'PR', '41', '27858', 'Tres Barras Do Parana');
INSERT INTO mun VALUES (5098, 'RS', '43', '21667', 'Tres Cachoeiras');
INSERT INTO mun VALUES (3089, 'MG', '31', '69307', 'Tres Corações');
INSERT INTO mun VALUES (5099, 'RS', '43', '21709', 'Tres Coroas');
INSERT INTO mun VALUES (5100, 'RS', '43', '21808', 'Tres De Maio');
INSERT INTO mun VALUES (5101, 'RS', '43', '21832', 'Tres Forquilhas');
INSERT INTO mun VALUES (3917, 'SP', '35', '54904', 'Tres Fronteiras');
INSERT INTO mun VALUES (5216, 'MS', '50', '08305', 'Tres Lagoas');
INSERT INTO mun VALUES (3090, 'MG', '31', '69356', 'Tres Marias');
INSERT INTO mun VALUES (5102, 'RS', '43', '21857', 'Tres Palmeiras');
INSERT INTO mun VALUES (5103, 'RS', '43', '21907', 'Tres Passos');
INSERT INTO mun VALUES (3091, 'MG', '31', '69406', 'Tres Pontas');
INSERT INTO mun VALUES (5590, 'GO', '52', '21304', 'Tres Ranchos');
INSERT INTO mun VALUES (3297, 'RJ', '33', '06008', 'Tres Rios');
INSERT INTO mun VALUES (4620, 'SC', '42', '18350', 'Treviso');
INSERT INTO mun VALUES (4621, 'SC', '42', '18400', 'Treze De Maio');
INSERT INTO mun VALUES (4622, 'SC', '42', '18509', 'Treze Tilias');
INSERT INTO mun VALUES (5591, 'GO', '52', '21403', 'Trindade');
INSERT INTO mun VALUES (1668, 'PE', '26', '15607', 'Trindade');
INSERT INTO mun VALUES (5104, 'RS', '43', '21956', 'Trindade Do Sul');
INSERT INTO mun VALUES (1487, 'PB', '25', '16805', 'Triunfo');
INSERT INTO mun VALUES (5105, 'RS', '43', '22004', 'Triunfo');
INSERT INTO mun VALUES (1669, 'PE', '26', '15706', 'Triunfo');
INSERT INTO mun VALUES (1261, 'RN', '24', '14456', 'Triunfo Potiguar');
INSERT INTO mun VALUES (680, 'MA', '21', '12233', 'Trizidela Do Vale');
INSERT INTO mun VALUES (5592, 'GO', '52', '21452', 'Trombas');
INSERT INTO mun VALUES (4623, 'SC', '42', '18608', 'Trombudo Central');
INSERT INTO mun VALUES (4624, 'SC', '42', '18707', 'Tubarão');
INSERT INTO mun VALUES (2252, 'BA', '29', '31905', 'Tucano');
INSERT INTO mun VALUES (310, 'PA', '15', '08084', 'Tucumã');
INSERT INTO mun VALUES (5106, 'RS', '43', '22103', 'Tucunduva');
INSERT INTO mun VALUES (311, 'PA', '15', '08100', 'Tucurui');
INSERT INTO mun VALUES (681, 'MA', '21', '12274', 'Tufilandia');
INSERT INTO mun VALUES (3918, 'SP', '35', '54953', 'Tuiuti');
INSERT INTO mun VALUES (3092, 'MG', '31', '69505', 'Tumiritinga');
INSERT INTO mun VALUES (4625, 'SC', '42', '18756', 'Tunapolis');
INSERT INTO mun VALUES (5107, 'RS', '43', '22152', 'Tunas');
INSERT INTO mun VALUES (4330, 'PR', '41', '27882', 'Tunas Do Parana');
INSERT INTO mun VALUES (4331, 'PR', '41', '27908', 'Tuneiras Do Oeste');
INSERT INTO mun VALUES (682, 'MA', '21', '12308', 'Tuntum');
INSERT INTO mun VALUES (3919, 'SP', '35', '55000', 'Tupã');
INSERT INTO mun VALUES (3093, 'MG', '31', '69604', 'Tupaciguara');
INSERT INTO mun VALUES (1670, 'PE', '26', '15805', 'Tupanatinga');
INSERT INTO mun VALUES (5108, 'RS', '43', '22186', 'Tupanci Do Sul');
INSERT INTO mun VALUES (5109, 'RS', '43', '22202', 'Tupanciretã');
INSERT INTO mun VALUES (5110, 'RS', '43', '22251', 'Tupandi');
INSERT INTO mun VALUES (5111, 'RS', '43', '22301', 'Tuparendi');
INSERT INTO mun VALUES (1671, 'PE', '26', '15904', 'Tuparetama');
INSERT INTO mun VALUES (3920, 'SP', '35', '55109', 'Tupi Paulista');
INSERT INTO mun VALUES (471, 'TO', '17', '21257', 'Tupirama');
INSERT INTO mun VALUES (472, 'TO', '17', '21307', 'Tupiratins');
INSERT INTO mun VALUES (4332, 'PR', '41', '27957', 'Tupãssi');
INSERT INTO mun VALUES (683, 'MA', '21', '12407', 'Turiaçu');
INSERT INTO mun VALUES (684, 'MA', '21', '12456', 'Turilandia');
INSERT INTO mun VALUES (3921, 'SP', '35', '55208', 'Turiuba');
INSERT INTO mun VALUES (3922, 'SP', '35', '55307', 'Turmalina');
INSERT INTO mun VALUES (3094, 'MG', '31', '69703', 'Turmalina');
INSERT INTO mun VALUES (1092, 'CE', '23', '13559', 'Tururu');
INSERT INTO mun VALUES (5112, 'RS', '43', '22327', 'Turuçu');
INSERT INTO mun VALUES (5593, 'GO', '52', '21502', 'Turvania');
INSERT INTO mun VALUES (5594, 'GO', '52', '21551', 'Turvelandia');
INSERT INTO mun VALUES (4626, 'SC', '42', '18806', 'Turvo');
INSERT INTO mun VALUES (4333, 'PR', '41', '27965', 'Turvo');
INSERT INTO mun VALUES (3095, 'MG', '31', '69802', 'Turvolandia');
INSERT INTO mun VALUES (685, 'MA', '21', '12506', 'Tutoia');
INSERT INTO mun VALUES (155, 'AM', '13', '04260', 'Uarini');
INSERT INTO mun VALUES (2253, 'BA', '29', '32002', 'Uaua');
INSERT INTO mun VALUES (3096, 'MG', '31', '69901', 'Uba');
INSERT INTO mun VALUES (3097, 'MG', '31', '70008', 'Ubai');
INSERT INTO mun VALUES (2254, 'BA', '29', '32101', 'Ubaira');
INSERT INTO mun VALUES (5081, 'RS', '43', '20909', 'Tapejara');
INSERT INTO mun VALUES (5082, 'RS', '43', '21006', 'Tapera');
INSERT INTO mun VALUES (1483, 'PB', '25', '16508', 'Taperoa');
INSERT INTO mun VALUES (2244, 'BA', '29', '31202', 'Taperoa');
INSERT INTO mun VALUES (5083, 'RS', '43', '21105', 'Tapes');
INSERT INTO mun VALUES (4319, 'PR', '41', '26900', 'Tapira');
INSERT INTO mun VALUES (3076, 'MG', '31', '68101', 'Tapira');
INSERT INTO mun VALUES (3898, 'SP', '35', '53500', 'Tapirai');
INSERT INTO mun VALUES (3077, 'MG', '31', '68200', 'Tapirai');
INSERT INTO mun VALUES (2245, 'BA', '29', '31301', 'Tapiramuta');
INSERT INTO mun VALUES (3899, 'SP', '35', '53609', 'Tapiratiba');
INSERT INTO mun VALUES (5345, 'MT', '51', '08006', 'Tapurah');
INSERT INTO mun VALUES (5084, 'RS', '43', '21204', 'Taquara');
INSERT INTO mun VALUES (3900, 'SP', '35', '53658', 'Taquaral');
INSERT INTO mun VALUES (5587, 'GO', '52', '21007', 'Taquaral De Goias');
INSERT INTO mun VALUES (1777, 'AL', '27', '09103', 'Taquarana');
INSERT INTO mun VALUES (3078, 'MG', '31', '68309', 'Taquaraçu De Minas');
INSERT INTO mun VALUES (5085, 'RS', '43', '21303', 'Taquari');
INSERT INTO mun VALUES (3901, 'SP', '35', '53708', 'Taquaritinga');
INSERT INTO mun VALUES (1662, 'PE', '26', '15003', 'Taquaritinga Do Norte');
INSERT INTO mun VALUES (3902, 'SP', '35', '53807', 'Taquarituba');
INSERT INTO mun VALUES (3903, 'SP', '35', '53856', 'Taquarivai');
INSERT INTO mun VALUES (5214, 'MS', '50', '07976', 'Taquarussu');
INSERT INTO mun VALUES (5086, 'RS', '43', '21329', 'Taquaruçu Do Sul');
INSERT INTO mun VALUES (3904, 'SP', '35', '53906', 'Tarabai');
INSERT INTO mun VALUES (92, 'AC', '12', '00609', 'Tarauaca');
INSERT INTO mun VALUES (1087, 'CE', '23', '13252', 'Tarrafas');
INSERT INTO mun VALUES (333, 'AP', '16', '00709', 'Tartarugalzinho');
INSERT INTO mun VALUES (3699, 'SP', '35', '35200', 'Palmeira D''oeste');
INSERT INTO mun VALUES (3905, 'SP', '35', '53955', 'Tarumã');
INSERT INTO mun VALUES (3079, 'MG', '31', '68408', 'Tarumirim');
INSERT INTO mun VALUES (677, 'MA', '21', '12001', 'Tasso Fragoso');
INSERT INTO mun VALUES (3906, 'SP', '35', '54003', 'Tatui');
INSERT INTO mun VALUES (1088, 'CE', '23', '13302', 'Taua');
INSERT INTO mun VALUES (3907, 'SP', '35', '54102', 'Taubate');
INSERT INTO mun VALUES (1484, 'PB', '25', '16607', 'Tavares');
INSERT INTO mun VALUES (5087, 'RS', '43', '21352', 'Tavares');
INSERT INTO mun VALUES (153, 'AM', '13', '04203', 'Tefe');
INSERT INTO mun VALUES (1485, 'PB', '25', '16706', 'Teixeira');
INSERT INTO mun VALUES (2246, 'BA', '29', '31350', 'Teixeira De Freitas');
INSERT INTO mun VALUES (3080, 'MG', '31', '68507', 'Teixeiras');
INSERT INTO mun VALUES (4320, 'PR', '41', '27007', 'Teixeira Soares');
INSERT INTO mun VALUES (67, 'RO', '11', '01559', 'Teixeiropolis');
INSERT INTO mun VALUES (3908, 'SP', '35', '54201', 'Tejupa');
INSERT INTO mun VALUES (1089, 'CE', '23', '13351', 'Tejuçuoca');
INSERT INTO mun VALUES (4321, 'PR', '41', '27106', 'Telemaco Borba');
INSERT INTO mun VALUES (1854, 'SE', '28', '07303', 'Telha');
INSERT INTO mun VALUES (1256, 'RN', '24', '14100', 'Tenente Ananias');
INSERT INTO mun VALUES (1257, 'RN', '24', '14159', 'Tenente Laurentino Cruz');
INSERT INTO mun VALUES (5088, 'RS', '43', '21402', 'Tenente Portela');
INSERT INTO mun VALUES (1486, 'PB', '25', '16755', 'Tenorio');
INSERT INTO mun VALUES (3909, 'SP', '35', '54300', 'Teodoro Sampaio');
INSERT INTO mun VALUES (2247, 'BA', '29', '31400', 'Teodoro Sampaio');
INSERT INTO mun VALUES (2248, 'BA', '29', '31509', 'Teofilandia');
INSERT INTO mun VALUES (3081, 'MG', '31', '68606', 'Teofilo Otoni');
INSERT INTO mun VALUES (2249, 'BA', '29', '31608', 'Teolandia');
INSERT INTO mun VALUES (1778, 'AL', '27', '09152', 'Teotonio Vilela');
INSERT INTO mun VALUES (5215, 'MS', '50', '08008', 'Terenos');
INSERT INTO mun VALUES (907, 'PI', '22', '11001', 'Teresina');
INSERT INTO mun VALUES (5588, 'GO', '52', '21080', 'Teresina De Goias');
INSERT INTO mun VALUES (3295, 'RJ', '33', '05802', 'Teresopolis');
INSERT INTO mun VALUES (1663, 'PE', '26', '15102', 'Terezinha');
INSERT INTO mun VALUES (5589, 'GO', '52', '21197', 'Terezopolis De Goias');
INSERT INTO mun VALUES (305, 'PA', '15', '07961', 'Terra Alta');
INSERT INTO mun VALUES (4322, 'PR', '41', '27205', 'Terra Boa');
INSERT INTO mun VALUES (5089, 'RS', '43', '21436', 'Terra De Areia');
INSERT INTO mun VALUES (2250, 'BA', '29', '31707', 'Terra Nova');
INSERT INTO mun VALUES (1664, 'PE', '26', '15201', 'Terra Nova');
INSERT INTO mun VALUES (5346, 'MT', '51', '08055', 'Terra Nova Do Norte');
INSERT INTO mun VALUES (4323, 'PR', '41', '27304', 'Terra Rica');
INSERT INTO mun VALUES (3910, 'SP', '35', '54409', 'Terra Roxa');
INSERT INTO mun VALUES (4324, 'PR', '41', '27403', 'Terra Roxa');
INSERT INTO mun VALUES (306, 'PA', '15', '07979', 'Terra Santa');
INSERT INTO mun VALUES (11380, 'AP', '16', 'TR087', 'Território 3 AP');
INSERT INTO mun VALUES (11381, 'DF', '53', 'TR088', 'Território Rural das Águas Emendadas  DF');
INSERT INTO mun VALUES (5347, 'MT', '51', '08105', 'Tesouro');
INSERT INTO mun VALUES (5090, 'RS', '43', '21451', 'Teutonia');
INSERT INTO mun VALUES (68, 'RO', '11', '01609', 'Theobroma');
INSERT INTO mun VALUES (1090, 'CE', '23', '13401', 'Tiangua');
INSERT INTO mun VALUES (4325, 'PR', '41', '27502', 'Tibagi');
INSERT INTO mun VALUES (1222, 'RN', '24', '11056', 'Tibau');
INSERT INTO mun VALUES (1258, 'RN', '24', '14209', 'Tibau Do Sul');
INSERT INTO mun VALUES (3911, 'SP', '35', '54508', 'Tiete');
INSERT INTO mun VALUES (4614, 'SC', '42', '17956', 'Tigrinhos');
INSERT INTO mun VALUES (4615, 'SC', '42', '18004', 'Tijucas');
INSERT INTO mun VALUES (4326, 'PR', '41', '27601', 'Tijucas Do Sul');
INSERT INTO mun VALUES (1665, 'PE', '26', '15300', 'Timbauba');
INSERT INTO mun VALUES (1259, 'RN', '24', '14308', 'Timbauba Dos Batistas');
INSERT INTO mun VALUES (4616, 'SC', '42', '18103', 'Timbe Do Sul');
INSERT INTO mun VALUES (678, 'MA', '21', '12100', 'Timbiras');
INSERT INTO mun VALUES (4617, 'SC', '42', '18202', 'Timbo');
INSERT INTO mun VALUES (4618, 'SC', '42', '18251', 'Timbo Grande');
INSERT INTO mun VALUES (3912, 'SP', '35', '54607', 'Timburi');
INSERT INTO mun VALUES (679, 'MA', '21', '12209', 'Timon');
INSERT INTO mun VALUES (3082, 'MG', '31', '68705', 'Timoteo');
INSERT INTO mun VALUES (5091, 'RS', '43', '21469', 'Tio Hugo');
INSERT INTO mun VALUES (3083, 'MG', '31', '68804', 'Tiradentes');
INSERT INTO mun VALUES (5092, 'RS', '43', '21477', 'Tiradentes Do Sul');
INSERT INTO mun VALUES (3084, 'MG', '31', '68903', 'Tiros');
INSERT INTO mun VALUES (1855, 'SE', '28', '07402', 'Tobias Barreto');
INSERT INTO mun VALUES (469, 'TO', '17', '21109', 'Tocantinia');
INSERT INTO mun VALUES (3870, 'SP', '35', '50803', 'São Sebastião Da Grama');
INSERT INTO mun VALUES (3032, 'MG', '31', '64431', 'São Sebastião Da Vargem');
INSERT INTO mun VALUES (1466, 'PB', '25', '15104', 'São Sebastião De Lagoa D');
INSERT INTO mun VALUES (3288, 'RJ', '33', '05307', 'São Sebastião Do Alto');
INSERT INTO mun VALUES (3033, 'MG', '31', '64472', 'São Sebastião Do Anta');
INSERT INTO mun VALUES (5054, 'RS', '43', '19505', 'São Sebastião Do Cai');
INSERT INTO mun VALUES (3034, 'MG', '31', '64506', 'São Sebastião Do Maranhã');
INSERT INTO mun VALUES (3035, 'MG', '31', '64605', 'São Sebastião Do Oeste');
INSERT INTO mun VALUES (3036, 'MG', '31', '64704', 'São Sebastião Do Paraiso');
INSERT INTO mun VALUES (2221, 'BA', '29', '29503', 'São Sebastião Do Passe');
INSERT INTO mun VALUES (3037, 'MG', '31', '64803', 'São Sebastião Do Rio Pre');
INSERT INTO mun VALUES (3038, 'MG', '31', '64902', 'São Sebastião Do Rio Ver');
INSERT INTO mun VALUES (460, 'TO', '17', '20309', 'São Sebastião Do Tocanti');
INSERT INTO mun VALUES (149, 'AM', '13', '03957', 'São Sebastião Do Uatumã');
INSERT INTO mun VALUES (1467, 'PB', '25', '15203', 'São Sebastião Do Umbuzei');
INSERT INTO mun VALUES (5055, 'RS', '43', '19604', 'São Sepe');
INSERT INTO mun VALUES (3871, 'SP', '35', '50902', 'São Simão');
INSERT INTO mun VALUES (5581, 'GO', '52', '20405', 'São Simão');
INSERT INTO mun VALUES (1479, 'PB', '25', '16151', 'Sossego');
INSERT INTO mun VALUES (3041, 'MG', '31', '65206', 'São Thome Das Letras');
INSERT INTO mun VALUES (3039, 'MG', '31', '65008', 'São Tiago');
INSERT INTO mun VALUES (3040, 'MG', '31', '65107', 'São Tomas De Aquino');
INSERT INTO mun VALUES (4306, 'PR', '41', '26108', 'São Tome');
INSERT INTO mun VALUES (1242, 'RN', '24', '12906', 'São Tome');
INSERT INTO mun VALUES (303, 'PA', '15', '07904', 'Soure');
INSERT INTO mun VALUES (1480, 'PB', '25', '16201', 'Sousa');
INSERT INTO mun VALUES (2239, 'BA', '29', '30808', 'Souto Soares');
INSERT INTO mun VALUES (5056, 'RS', '43', '19703', 'São Valentim');
INSERT INTO mun VALUES (5057, 'RS', '43', '19711', 'São Valentim Do Sul');
INSERT INTO mun VALUES (461, 'TO', '17', '20499', 'São Valerio Da Natividad');
INSERT INTO mun VALUES (5058, 'RS', '43', '19737', 'São Valerio Do Sul');
INSERT INTO mun VALUES (5059, 'RS', '43', '19752', 'São Vendelino');
INSERT INTO mun VALUES (3872, 'SP', '35', '51009', 'São Vicente');
INSERT INTO mun VALUES (1243, 'RN', '24', '13003', 'São Vicente');
INSERT INTO mun VALUES (3042, 'MG', '31', '65305', 'São Vicente De Minas');
INSERT INTO mun VALUES (5060, 'RS', '43', '19802', 'São Vicente Do Sul');
INSERT INTO mun VALUES (1650, 'PE', '26', '13800', 'São Vicente Ferrer');
INSERT INTO mun VALUES (669, 'MA', '21', '11706', 'São Vicente Ferrer');
INSERT INTO mun VALUES (464, 'TO', '17', '20853', 'Sucupira');
INSERT INTO mun VALUES (675, 'MA', '21', '11904', 'Sucupira Do Norte');
INSERT INTO mun VALUES (676, 'MA', '21', '11953', 'Sucupira Do Riachão');
INSERT INTO mun VALUES (3885, 'SP', '35', '52304', 'Sud Mennucci');
INSERT INTO mun VALUES (11376, 'SP', '35', 'TR083', 'Sudoeste SP');
INSERT INTO mun VALUES (4611, 'SC', '42', '17758', 'Sul Brasil');
INSERT INTO mun VALUES (11377, 'RR', '14', 'TR084', 'Sul de Roraima RR');
INSERT INTO mun VALUES (11378, 'PA', '15', 'TR085', 'Sul do Pará PA');
INSERT INTO mun VALUES (4315, 'PR', '41', '26652', 'Sulina');
INSERT INTO mun VALUES (3886, 'SP', '35', '52403', 'Sumare');
INSERT INTO mun VALUES (1481, 'PB', '25', '16300', 'Sume');
INSERT INTO mun VALUES (3293, 'RJ', '33', '05703', 'Sumidouro');
INSERT INTO mun VALUES (1657, 'PE', '26', '14501', 'Surubim');
INSERT INTO mun VALUES (904, 'PI', '22', '10938', 'Sussuapara');
INSERT INTO mun VALUES (3888, 'SP', '35', '52551', 'Suzanapolis');
INSERT INTO mun VALUES (3887, 'SP', '35', '52502', 'Suzano');
INSERT INTO mun VALUES (5080, 'RS', '43', '20859', 'Tabai');
INSERT INTO mun VALUES (5343, 'MT', '51', '07941', 'Tabaporã');
INSERT INTO mun VALUES (3889, 'SP', '35', '52601', 'Tabapuã');
INSERT INTO mun VALUES (3890, 'SP', '35', '52700', 'Tabatinga');
INSERT INTO mun VALUES (151, 'AM', '13', '04062', 'Tabatinga');
INSERT INTO mun VALUES (1658, 'PE', '26', '14600', 'Tabira');
INSERT INTO mun VALUES (2240, 'BA', '29', '30907', 'Tabocas Do Brejo Velho');
INSERT INTO mun VALUES (1253, 'RN', '24', '13805', 'Taboleiro Grande');
INSERT INTO mun VALUES (3891, 'SP', '35', '52809', 'Taboão Da Serra');
INSERT INTO mun VALUES (3073, 'MG', '31', '67905', 'Tabuleiro');
INSERT INTO mun VALUES (1085, 'CE', '23', '13104', 'Tabuleiro Do Norte');
INSERT INTO mun VALUES (11379, 'PI', '22', 'TR086', 'Tabuleiros do Alto Parnaíba PI');
INSERT INTO mun VALUES (1659, 'PE', '26', '14709', 'Tacaimbo');
INSERT INTO mun VALUES (1660, 'PE', '26', '14808', 'Tacaratu');
INSERT INTO mun VALUES (3892, 'SP', '35', '52908', 'Taciba');
INSERT INTO mun VALUES (5213, 'MS', '50', '07950', 'Tacuru');
INSERT INTO mun VALUES (3893, 'SP', '35', '53005', 'Taguai');
INSERT INTO mun VALUES (465, 'TO', '17', '20903', 'Taguatinga');
INSERT INTO mun VALUES (3894, 'SP', '35', '53104', 'Taiaçu');
INSERT INTO mun VALUES (304, 'PA', '15', '07953', 'Tailandia');
INSERT INTO mun VALUES (4612, 'SC', '42', '17808', 'Taio');
INSERT INTO mun VALUES (3074, 'MG', '31', '68002', 'Taiobeiras');
INSERT INTO mun VALUES (466, 'TO', '17', '20937', 'Taipas Do Tocantins');
INSERT INTO mun VALUES (1254, 'RN', '24', '13904', 'Taipu');
INSERT INTO mun VALUES (3895, 'SP', '35', '53203', 'Taiuva');
INSERT INTO mun VALUES (467, 'TO', '17', '20978', 'Talismã');
INSERT INTO mun VALUES (1661, 'PE', '26', '14857', 'Tamandare');
INSERT INTO mun VALUES (4316, 'PR', '41', '26678', 'Tamarana');
INSERT INTO mun VALUES (3896, 'SP', '35', '53302', 'Tambau');
INSERT INTO mun VALUES (4317, 'PR', '41', '26702', 'Tamboara');
INSERT INTO mun VALUES (1086, 'CE', '23', '13203', 'Tamboril');
INSERT INTO mun VALUES (905, 'PI', '22', '10953', 'Tamboril Do Piaui');
INSERT INTO mun VALUES (3897, 'SP', '35', '53401', 'Tanabi');
INSERT INTO mun VALUES (1255, 'RN', '24', '14001', 'Tangara');
INSERT INTO mun VALUES (4613, 'SC', '42', '17907', 'Tangara');
INSERT INTO mun VALUES (5344, 'MT', '51', '07958', 'Tangara Da Serra');
INSERT INTO mun VALUES (3294, 'RJ', '33', '05752', 'Tangua');
INSERT INTO mun VALUES (2241, 'BA', '29', '31004', 'Tanhaçu');
INSERT INTO mun VALUES (906, 'PI', '22', '10979', 'Tanque Do Piaui');
INSERT INTO mun VALUES (2242, 'BA', '29', '31053', 'Tanque Novo');
INSERT INTO mun VALUES (2243, 'BA', '29', '31103', 'Tanquinho');
INSERT INTO mun VALUES (3075, 'MG', '31', '68051', 'Taparuba');
INSERT INTO mun VALUES (152, 'AM', '13', '04104', 'Tapaua');
INSERT INTO mun VALUES (4318, 'PR', '41', '26801', 'Tapejara');
INSERT INTO mun VALUES (3861, 'SP', '35', '49953', 'São Lourenço Da Serra');
INSERT INTO mun VALUES (4599, 'SC', '42', '16909', 'São Lourenço Do Oeste');
INSERT INTO mun VALUES (891, 'PI', '22', '10359', 'São Lourenço Do Piaui');
INSERT INTO mun VALUES (5042, 'RS', '43', '18804', 'São Lourenço Do Sul');
INSERT INTO mun VALUES (4600, 'SC', '42', '17006', 'São Ludgero');
INSERT INTO mun VALUES (661, 'MA', '21', '11300', 'São Luis');
INSERT INTO mun VALUES (5576, 'GO', '52', '20108', 'São Luis De Montes Belos');
INSERT INTO mun VALUES (1080, 'CE', '23', '12601', 'São Luis Do Curu');
INSERT INTO mun VALUES (3862, 'SP', '35', '50001', 'São Luis Do Paraitinga');
INSERT INTO mun VALUES (3507, 'SP', '35', '18008', 'Guarani D''oeste');
INSERT INTO mun VALUES (892, 'PI', '22', '10375', 'São Luis Do Piaui');
INSERT INTO mun VALUES (1770, 'AL', '27', '08501', 'São Luis Do Quitunde');
INSERT INTO mun VALUES (662, 'MA', '21', '11409', 'São Luis Gonzaga Do Maranhão');
INSERT INTO mun VALUES (172, 'RR', '14', '00605', 'São Luiz');
INSERT INTO mun VALUES (5577, 'GO', '52', '20157', 'São Luiz Do Norte');
INSERT INTO mun VALUES (5043, 'RS', '43', '18903', 'São Luiz Gonzaga');
INSERT INTO mun VALUES (1464, 'PB', '25', '14909', 'São Mamede');
INSERT INTO mun VALUES (4299, 'PR', '41', '25555', 'São Manoel Do Parana');
INSERT INTO mun VALUES (3863, 'SP', '35', '50100', 'São Manuel');
INSERT INTO mun VALUES (5044, 'RS', '43', '19000', 'São Marcos');
INSERT INTO mun VALUES (4601, 'SC', '42', '17105', 'São Martinho');
INSERT INTO mun VALUES (5045, 'RS', '43', '19109', 'São Martinho');
INSERT INTO mun VALUES (5046, 'RS', '43', '19125', 'São Martinho Da Serra');
INSERT INTO mun VALUES (3198, 'ES', '32', '04906', 'São Mateus');
INSERT INTO mun VALUES (663, 'MA', '21', '11508', 'São Mateus Do Maranhão');
INSERT INTO mun VALUES (4300, 'PR', '41', '25605', 'São Mateus Do Sul');
INSERT INTO mun VALUES (4610, 'SC', '42', '17709', 'Sombrio');
INSERT INTO mun VALUES (1237, 'RN', '24', '12500', 'São Miguel');
INSERT INTO mun VALUES (3864, 'SP', '35', '50209', 'São Miguel Arcanjo');
INSERT INTO mun VALUES (893, 'PI', '22', '10383', 'São Miguel Da Baixa Gran');
INSERT INTO mun VALUES (4602, 'SC', '42', '17154', 'São Miguel Da Boa Vista');
INSERT INTO mun VALUES (2220, 'BA', '29', '29404', 'São Miguel Das Matas');
INSERT INTO mun VALUES (5047, 'RS', '43', '19158', 'São Miguel Das Missões');
INSERT INTO mun VALUES (1465, 'PB', '25', '15005', 'São Miguel De Taipu');
INSERT INTO mun VALUES (1238, 'RN', '24', '12559', 'São Miguel De Touros');
INSERT INTO mun VALUES (1851, 'SE', '28', '07006', 'São Miguel Do Aleixo');
INSERT INTO mun VALUES (3025, 'MG', '31', '63805', 'São Miguel Do Anta');
INSERT INTO mun VALUES (5578, 'GO', '52', '20207', 'São Miguel Do Araguaia');
INSERT INTO mun VALUES (894, 'PI', '22', '10391', 'São Miguel Do Fidalgo');
INSERT INTO mun VALUES (299, 'PA', '15', '07607', 'São Miguel Do Guama');
INSERT INTO mun VALUES (42, 'RO', '11', '00320', 'São Miguel Do Guapore');
INSERT INTO mun VALUES (4301, 'PR', '41', '25704', 'São Miguel Do Iguaçu');
INSERT INTO mun VALUES (4603, 'SC', '42', '17204', 'São Miguel Do Oeste');
INSERT INTO mun VALUES (5579, 'GO', '52', '20264', 'São Miguel Do Passa Quat');
INSERT INTO mun VALUES (1771, 'AL', '27', '08600', 'São Miguel Dos Campos');
INSERT INTO mun VALUES (1772, 'AL', '27', '08709', 'São Miguel Dos Milagres');
INSERT INTO mun VALUES (895, 'PI', '22', '10409', 'São Miguel Do Tapuio');
INSERT INTO mun VALUES (458, 'TO', '17', '20200', 'São Miguel Do Tocantins');
INSERT INTO mun VALUES (5048, 'RS', '43', '19208', 'São Nicolau');
INSERT INTO mun VALUES (5212, 'MS', '50', '07935', 'Sonora');
INSERT INTO mun VALUES (3201, 'ES', '32', '05010', 'Sooretama');
INSERT INTO mun VALUES (5580, 'GO', '52', '20280', 'São Patricio');
INSERT INTO mun VALUES (3865, 'SP', '35', '50308', 'São Paulo');
INSERT INTO mun VALUES (3302, 'SP', '35', '00000', 'São Paulo');
INSERT INTO mun VALUES (5049, 'RS', '43', '19307', 'São Paulo Das Missões');
INSERT INTO mun VALUES (148, 'AM', '13', '03908', 'São Paulo De Olivença');
INSERT INTO mun VALUES (1239, 'RN', '24', '12609', 'São Paulo Do Potengi');
INSERT INTO mun VALUES (3866, 'SP', '35', '50407', 'São Pedro');
INSERT INTO mun VALUES (1240, 'RN', '24', '12708', 'São Pedro');
INSERT INTO mun VALUES (664, 'MA', '21', '11532', 'São Pedro Da Agua Branca');
INSERT INTO mun VALUES (3287, 'RJ', '33', '05208', 'São Pedro Da Aldeia');
INSERT INTO mun VALUES (5328, 'MT', '51', '07404', 'São Pedro Da Cipa');
INSERT INTO mun VALUES (5050, 'RS', '43', '19356', 'São Pedro Da Serra');
INSERT INTO mun VALUES (5051, 'RS', '43', '19364', 'São Pedro Das Missões');
INSERT INTO mun VALUES (3026, 'MG', '31', '63904', 'São Pedro Da União');
INSERT INTO mun VALUES (4604, 'SC', '42', '17253', 'São Pedro De Alcantara');
INSERT INTO mun VALUES (5052, 'RS', '43', '19372', 'São Pedro Do Butia');
INSERT INTO mun VALUES (4302, 'PR', '41', '25753', 'São Pedro Do Iguaçu');
INSERT INTO mun VALUES (4303, 'PR', '41', '25803', 'São Pedro Do Ivai');
INSERT INTO mun VALUES (4304, 'PR', '41', '25902', 'São Pedro Do Parana');
INSERT INTO mun VALUES (896, 'PI', '22', '10508', 'São Pedro Do Piaui');
INSERT INTO mun VALUES (665, 'MA', '21', '11573', 'São Pedro Dos Crentes');
INSERT INTO mun VALUES (3027, 'MG', '31', '64001', 'São Pedro Dos Ferros');
INSERT INTO mun VALUES (3028, 'MG', '31', '64100', 'São Pedro Do Suaçui');
INSERT INTO mun VALUES (5053, 'RS', '43', '19406', 'São Pedro Do Sul');
INSERT INTO mun VALUES (3867, 'SP', '35', '50506', 'São Pedro Do Turvo');
INSERT INTO mun VALUES (1241, 'RN', '24', '12807', 'São Rafael');
INSERT INTO mun VALUES (666, 'MA', '21', '11607', 'São Raimundo Das Mangabe');
INSERT INTO mun VALUES (667, 'MA', '21', '11631', 'São Raimundo Do Doca Bez');
INSERT INTO mun VALUES (897, 'PI', '22', '10607', 'São Raimundo Nonato');
INSERT INTO mun VALUES (668, 'MA', '21', '11672', 'São Roberto');
INSERT INTO mun VALUES (3884, 'SP', '35', '52205', 'Sorocaba');
INSERT INTO mun VALUES (3029, 'MG', '31', '64209', 'São Romão');
INSERT INTO mun VALUES (3868, 'SP', '35', '50605', 'São Roque');
INSERT INTO mun VALUES (3030, 'MG', '31', '64308', 'São Roque De Minas');
INSERT INTO mun VALUES (3199, 'ES', '32', '04955', 'São Roque Do Canaã');
INSERT INTO mun VALUES (5342, 'MT', '51', '07925', 'Sorriso');
INSERT INTO mun VALUES (459, 'TO', '17', '20259', 'São Salvador Do Tocantin');
INSERT INTO mun VALUES (1773, 'AL', '27', '08808', 'São Sebastião');
INSERT INTO mun VALUES (3869, 'SP', '35', '50704', 'São Sebastião');
INSERT INTO mun VALUES (4305, 'PR', '41', '26009', 'São Sebastião Da Amoreir');
INSERT INTO mun VALUES (3031, 'MG', '31', '64407', 'São Sebastião Da Bela Vi');
INSERT INTO mun VALUES (300, 'PA', '15', '07706', 'São Sebastião Da Boa Vis');
INSERT INTO mun VALUES (1079, 'CE', '23', '12502', 'São João Do Jaguaribe');
INSERT INTO mun VALUES (3007, 'MG', '31', '62559', 'São João Do Manhuaçu');
INSERT INTO mun VALUES (3008, 'MG', '31', '62575', 'São João Do Manteninha');
INSERT INTO mun VALUES (4591, 'SC', '42', '16255', 'São João Do Oeste');
INSERT INTO mun VALUES (3009, 'MG', '31', '62609', 'São João Do Oriente');
INSERT INTO mun VALUES (3010, 'MG', '31', '62658', 'São João Do Pacui');
INSERT INTO mun VALUES (656, 'MA', '21', '11052', 'São João Do Paraiso');
INSERT INTO mun VALUES (3011, 'MG', '31', '62708', 'São João Do Paraiso');
INSERT INTO mun VALUES (886, 'PI', '22', '10003', 'São João Do Piaui');
INSERT INTO mun VALUES (5031, 'RS', '43', '18432', 'São João Do Polesine');
INSERT INTO mun VALUES (1278, 'PB', '25', '00700', 'São João Do Rio Do Peixe');
INSERT INTO mun VALUES (1233, 'RN', '24', '12104', 'São João Do Sabugi');
INSERT INTO mun VALUES (657, 'MA', '21', '11078', 'São João Do Soter');
INSERT INTO mun VALUES (658, 'MA', '21', '11102', 'São João Dos Patos');
INSERT INTO mun VALUES (4594, 'SC', '42', '16404', 'São João Do Sul');
INSERT INTO mun VALUES (1453, 'PB', '25', '14107', 'São João Do Tigre');
INSERT INTO mun VALUES (4292, 'PR', '41', '25100', 'São João Do Triunfo');
INSERT INTO mun VALUES (3012, 'MG', '31', '62807', 'São João Evangelista');
INSERT INTO mun VALUES (3013, 'MG', '31', '62906', 'São João Nepomuceno');
INSERT INTO mun VALUES (5032, 'RS', '43', '18440', 'São Jorge');
INSERT INTO mun VALUES (4294, 'PR', '41', '25308', 'São Jorge Do Ivai');
INSERT INTO mun VALUES (4295, 'PR', '41', '25357', 'São Jorge Do Patrocinio');
INSERT INTO mun VALUES (4596, 'SC', '42', '16602', 'São Jose');
INSERT INTO mun VALUES (3015, 'MG', '31', '62948', 'São Jose Da Barra');
INSERT INTO mun VALUES (3856, 'SP', '35', '49508', 'São Jose Da Bela Vista');
INSERT INTO mun VALUES (4296, 'PR', '41', '25407', 'São Jose Da Boa Vista');
INSERT INTO mun VALUES (1646, 'PE', '26', '13404', 'São Jose Da Coroa Grande');
INSERT INTO mun VALUES (1454, 'PB', '25', '14206', 'São Jose Da Lagoa Tapada');
INSERT INTO mun VALUES (1768, 'AL', '27', '08303', 'São Jose Da Laje');
INSERT INTO mun VALUES (3016, 'MG', '31', '62955', 'São Jose Da Lapa');
INSERT INTO mun VALUES (3017, 'MG', '31', '63003', 'São Jose Da Safira');
INSERT INTO mun VALUES (5033, 'RS', '43', '18457', 'São Jose Das Missões');
INSERT INTO mun VALUES (4297, 'PR', '41', '25456', 'São Jose Das Palmeiras');
INSERT INTO mun VALUES (1769, 'AL', '27', '08402', 'São Jose Da Tapera');
INSERT INTO mun VALUES (3018, 'MG', '31', '63102', 'São Jose Da Varginha');
INSERT INTO mun VALUES (2218, 'BA', '29', '29354', 'São Jose Da Vitoria');
INSERT INTO mun VALUES (1455, 'PB', '25', '14305', 'São Jose De Caiana');
INSERT INTO mun VALUES (1456, 'PB', '25', '14404', 'São Jose De Espinharas');
INSERT INTO mun VALUES (1234, 'RN', '24', '12203', 'São Jose De Mipibu');
INSERT INTO mun VALUES (1458, 'PB', '25', '14503', 'São Jose De Piranhas');
INSERT INTO mun VALUES (1459, 'PB', '25', '14552', 'São Jose De Princesa');
INSERT INTO mun VALUES (659, 'MA', '21', '11201', 'São Jose De Ribamar');
INSERT INTO mun VALUES (3285, 'RJ', '33', '05133', 'São Jose De Uba');
INSERT INTO mun VALUES (3019, 'MG', '31', '63201', 'São Jose Do Alegre');
INSERT INTO mun VALUES (3857, 'SP', '35', '49607', 'São Jose Do Barreiro');
INSERT INTO mun VALUES (1647, 'PE', '26', '13503', 'São Jose Do Belmonte');
INSERT INTO mun VALUES (1460, 'PB', '25', '14602', 'São Jose Do Bonfim');
INSERT INTO mun VALUES (1461, 'PB', '25', '14651', 'São Jose Do Brejo Do Cru');
INSERT INTO mun VALUES (3197, 'ES', '32', '04807', 'São Jose Do Calçado');
INSERT INTO mun VALUES (1235, 'RN', '24', '12302', 'São Jose Do Campestre');
INSERT INTO mun VALUES (4597, 'SC', '42', '16701', 'São Jose Do Cedro');
INSERT INTO mun VALUES (4598, 'SC', '42', '16800', 'São Jose Do Cerrito');
INSERT INTO mun VALUES (887, 'PI', '22', '10052', 'São Jose Do Divino');
INSERT INTO mun VALUES (3020, 'MG', '31', '63300', 'São Jose Do Divino');
INSERT INTO mun VALUES (1648, 'PE', '26', '13602', 'São Jose Do Egito');
INSERT INTO mun VALUES (3021, 'MG', '31', '63409', 'São Jose Do Goiabal');
INSERT INTO mun VALUES (5034, 'RS', '43', '18465', 'São Jose Do Herval');
INSERT INTO mun VALUES (3476, 'SP', '35', '15202', 'Estrela D''oeste');
INSERT INTO mun VALUES (5035, 'RS', '43', '18481', 'São Jose Do Hortencio');
INSERT INTO mun VALUES (5036, 'RS', '43', '18499', 'São Jose Do Inhacora');
INSERT INTO mun VALUES (2219, 'BA', '29', '29370', 'São Jose Do Jacuipe');
INSERT INTO mun VALUES (3022, 'MG', '31', '63508', 'São Jose Do Jacuri');
INSERT INTO mun VALUES (3023, 'MG', '31', '63607', 'São Jose Do Mantimento');
INSERT INTO mun VALUES (5037, 'RS', '43', '18507', 'São Jose Do Norte');
INSERT INTO mun VALUES (5038, 'RS', '43', '18606', 'São Jose Do Ouro');
INSERT INTO mun VALUES (888, 'PI', '22', '10102', 'São Jose Do Peixe');
INSERT INTO mun VALUES (889, 'PI', '22', '10201', 'São Jose Do Piaui');
INSERT INTO mun VALUES (5325, 'MT', '51', '07297', 'São Jose Do Povo');
INSERT INTO mun VALUES (5326, 'MT', '51', '07305', 'São Jose Do Rio Claro');
INSERT INTO mun VALUES (3858, 'SP', '35', '49706', 'São Jose Do Rio Pardo');
INSERT INTO mun VALUES (3859, 'SP', '35', '49805', 'São Jose Do Rio Preto');
INSERT INTO mun VALUES (1462, 'PB', '25', '14701', 'São Jose Do Sabugi');
INSERT INTO mun VALUES (5040, 'RS', '43', '18622', 'São Jose Dos Ausentes');
INSERT INTO mun VALUES (660, 'MA', '21', '11250', 'São Jose Dos Basilios');
INSERT INTO mun VALUES (3860, 'SP', '35', '49904', 'São Jose Dos Campos');
INSERT INTO mun VALUES (1463, 'PB', '25', '14800', 'São Jose Dos Cordeiros');
INSERT INTO mun VALUES (1236, 'RN', '24', '12401', 'São Jose Do Serido');
INSERT INTO mun VALUES (4298, 'PR', '41', '25506', 'São Jose Dos Pinhais');
INSERT INTO mun VALUES (5318, 'MT', '51', '07107', 'São Jose Dos Quatro Marc');
INSERT INTO mun VALUES (1457, 'PB', '25', '14453', 'São Jose Dos Ramos');
INSERT INTO mun VALUES (5039, 'RS', '43', '18614', 'São Jose Do Sul');
INSERT INTO mun VALUES (3286, 'RJ', '33', '05158', 'São Jose Do Vale Do Rio');
INSERT INTO mun VALUES (5327, 'MT', '51', '07354', 'São Jose Do Xingu');
INSERT INTO mun VALUES (890, 'PI', '22', '10300', 'São Julião');
INSERT INTO mun VALUES (1477, 'PB', '25', '16003', 'Solanea');
INSERT INTO mun VALUES (1478, 'PB', '25', '16102', 'Soledade');
INSERT INTO mun VALUES (3072, 'MG', '31', '67806', 'Soledade De Minas');
INSERT INTO mun VALUES (5041, 'RS', '43', '18705', 'São Leopoldo');
INSERT INTO mun VALUES (1656, 'PE', '26', '14402', 'Solidão');
INSERT INTO mun VALUES (1084, 'CE', '23', '13005', 'Solonopole');
INSERT INTO mun VALUES (3024, 'MG', '31', '63706', 'São Lourenço');
INSERT INTO mun VALUES (1649, 'PE', '26', '13701', 'São Lourenço Da Mata');
INSERT INTO mun VALUES (2987, 'MG', '31', '61007', 'São Domingos Do Prata');
INSERT INTO mun VALUES (5025, 'RS', '43', '18051', 'São Domingos Do Sul');
INSERT INTO mun VALUES (2214, 'BA', '29', '29107', 'São Felipe');
INSERT INTO mun VALUES (64, 'RO', '11', '01484', 'São Felipe Doeste');
INSERT INTO mun VALUES (2212, 'BA', '29', '29008', 'São Felix');
INSERT INTO mun VALUES (651, 'MA', '21', '10807', 'São Felix De Balsas');
INSERT INTO mun VALUES (2988, 'MG', '31', '61056', 'São Felix De Minas');
INSERT INTO mun VALUES (5338, 'MT', '51', '07859', 'São Felix Do Araguaia');
INSERT INTO mun VALUES (2213, 'BA', '29', '29057', 'São Felix Do Coribe');
INSERT INTO mun VALUES (876, 'PI', '22', '09609', 'São Felix Do Piaui');
INSERT INTO mun VALUES (457, 'TO', '17', '20150', 'São Felix Do Tocantins');
INSERT INTO mun VALUES (293, 'PA', '15', '07300', 'São Felix Do Xingu');
INSERT INTO mun VALUES (1230, 'RN', '24', '11809', 'São Fernando');
INSERT INTO mun VALUES (3281, 'RJ', '33', '04805', 'São Fidelis');
INSERT INTO mun VALUES (3850, 'SP', '35', '49003', 'São Francisco');
INSERT INTO mun VALUES (1850, 'SE', '28', '06909', 'São Francisco');
INSERT INTO mun VALUES (1451, 'PB', '25', '13984', 'São Francisco');
INSERT INTO mun VALUES (2989, 'MG', '31', '61106', 'São Francisco');
INSERT INTO mun VALUES (5026, 'RS', '43', '18101', 'São Francisco De Assis');
INSERT INTO mun VALUES (877, 'PI', '22', '09658', 'São Francisco De Assis D');
INSERT INTO mun VALUES (5573, 'GO', '52', '19902', 'São Francisco De Goias');
INSERT INTO mun VALUES (3280, 'RJ', '33', '04755', 'São Francisco De Itabapo');
INSERT INTO mun VALUES (5027, 'RS', '43', '18200', 'São Francisco De Paula');
INSERT INTO mun VALUES (2990, 'MG', '31', '61205', 'São Francisco De Paula');
INSERT INTO mun VALUES (2991, 'MG', '31', '61304', 'São Francisco De Sales');
INSERT INTO mun VALUES (652, 'MA', '21', '10856', 'São Francisco Do Brejão');
INSERT INTO mun VALUES (2215, 'BA', '29', '29206', 'São Francisco Do Conde');
INSERT INTO mun VALUES (2992, 'MG', '31', '61403', 'São Francisco Do Gloria');
INSERT INTO mun VALUES (65, 'RO', '11', '01492', 'São Francisco Do Guapore');
INSERT INTO mun VALUES (653, 'MA', '21', '10906', 'São Francisco Do Maranhã');
INSERT INTO mun VALUES (1231, 'RN', '24', '11908', 'São Francisco Do Oeste');
INSERT INTO mun VALUES (294, 'PA', '15', '07409', 'São Francisco Do Para');
INSERT INTO mun VALUES (878, 'PI', '22', '09708', 'São Francisco Do Piaui');
INSERT INTO mun VALUES (4590, 'SC', '42', '16206', 'São Francisco Do Sul');
INSERT INTO mun VALUES (5028, 'RS', '43', '18309', 'São Gabriel');
INSERT INTO mun VALUES (2216, 'BA', '29', '29255', 'São Gabriel');
INSERT INTO mun VALUES (147, 'AM', '13', '03809', 'São Gabriel Da Cachoeira');
INSERT INTO mun VALUES (3196, 'ES', '32', '04708', 'São Gabriel Da Palha');
INSERT INTO mun VALUES (5208, 'MS', '50', '07695', 'São Gabriel Do Oeste');
INSERT INTO mun VALUES (2993, 'MG', '31', '61502', 'São Geraldo');
INSERT INTO mun VALUES (2994, 'MG', '31', '61601', 'São Geraldo Da Piedade');
INSERT INTO mun VALUES (295, 'PA', '15', '07458', 'São Geraldo Do Araguaia');
INSERT INTO mun VALUES (2995, 'MG', '31', '61650', 'São Geraldo Do Baixio');
INSERT INTO mun VALUES (3282, 'RJ', '33', '04904', 'São Gonçalo');
INSERT INTO mun VALUES (2996, 'MG', '31', '61700', 'São Gonçalo Do Abaete');
INSERT INTO mun VALUES (1232, 'RN', '24', '12005', 'São Gonçalo Do Amarante');
INSERT INTO mun VALUES (1078, 'CE', '23', '12403', 'São Gonçalo Do Amarante');
INSERT INTO mun VALUES (879, 'PI', '22', '09757', 'São Gonçalo Do Gurgueia');
INSERT INTO mun VALUES (2997, 'MG', '31', '61809', 'São Gonçalo Do Para');
INSERT INTO mun VALUES (880, 'PI', '22', '09807', 'São Gonçalo Do Piaui');
INSERT INTO mun VALUES (2998, 'MG', '31', '61908', 'São Gonçalo Do Rio Abaix');
INSERT INTO mun VALUES (2560, 'MG', '31', '25507', 'São Gonçalo Do Rio Preto');
INSERT INTO mun VALUES (2999, 'MG', '31', '62005', 'São Gonçalo Do Sapucai');
INSERT INTO mun VALUES (2217, 'BA', '29', '29305', 'São Gonçalo Dos Campos');
INSERT INTO mun VALUES (3000, 'MG', '31', '62104', 'São Gotardo');
INSERT INTO mun VALUES (5029, 'RS', '43', '18408', 'São Jeronimo');
INSERT INTO mun VALUES (3331, 'SP', '35', '02606', 'Aparecida D''oeste');
INSERT INTO mun VALUES (4288, 'PR', '41', '24707', 'São Jeronimo Da Serra');
INSERT INTO mun VALUES (4595, 'SC', '42', '16503', 'São Joaquim');
INSERT INTO mun VALUES (3855, 'SP', '35', '49409', 'São Joaquim Da Barra');
INSERT INTO mun VALUES (3014, 'MG', '31', '62922', 'São Joaquim De Bicas');
INSERT INTO mun VALUES (1645, 'PE', '26', '13305', 'São Joaquim Do Monte');
INSERT INTO mun VALUES (1644, 'PE', '26', '13206', 'São João');
INSERT INTO mun VALUES (4289, 'PR', '41', '24806', 'São João');
INSERT INTO mun VALUES (4592, 'SC', '42', '16305', 'São João Batista');
INSERT INTO mun VALUES (654, 'MA', '21', '11003', 'São João Batista');
INSERT INTO mun VALUES (3001, 'MG', '31', '62203', 'São João Batista Do Glor');
INSERT INTO mun VALUES (171, 'RR', '14', '00506', 'São João Da Baliza');
INSERT INTO mun VALUES (3283, 'RJ', '33', '05000', 'São João Da Barra');
INSERT INTO mun VALUES (3851, 'SP', '35', '49102', 'São João Da Boa Vista');
INSERT INTO mun VALUES (881, 'PI', '22', '09856', 'São João Da Canabrava');
INSERT INTO mun VALUES (882, 'PI', '22', '09872', 'São João Da Fronteira');
INSERT INTO mun VALUES (3002, 'MG', '31', '62252', 'São João Da Lagoa');
INSERT INTO mun VALUES (3003, 'MG', '31', '62302', 'São João Da Mata');
INSERT INTO mun VALUES (5575, 'GO', '52', '20058', 'São João Da Parauna');
INSERT INTO mun VALUES (296, 'PA', '15', '07466', 'São João Da Ponta');
INSERT INTO mun VALUES (3004, 'MG', '31', '62401', 'São João Da Ponte');
INSERT INTO mun VALUES (3852, 'SP', '35', '49201', 'São João Das Duas Pontes');
INSERT INTO mun VALUES (883, 'PI', '22', '09906', 'São João Da Serra');
INSERT INTO mun VALUES (3005, 'MG', '31', '62450', 'São João Das Missões');
INSERT INTO mun VALUES (5030, 'RS', '43', '18424', 'São João Da Urtiga');
INSERT INTO mun VALUES (884, 'PI', '22', '09955', 'São João Da Varjota');
INSERT INTO mun VALUES (3853, 'SP', '35', '49250', 'São João De Iracema');
INSERT INTO mun VALUES (3006, 'MG', '31', '62500', 'São João Del Rei');
INSERT INTO mun VALUES (3284, 'RJ', '33', '05109', 'São João De Meriti');
INSERT INTO mun VALUES (297, 'PA', '15', '07474', 'São João De Pirabas');
INSERT INTO mun VALUES (298, 'PA', '15', '07508', 'São João Do Araguaia');
INSERT INTO mun VALUES (885, 'PI', '22', '09971', 'São João Do Arraial');
INSERT INTO mun VALUES (4290, 'PR', '41', '24905', 'São João Do Caiua');
INSERT INTO mun VALUES (1452, 'PB', '25', '14008', 'São João Do Cariri');
INSERT INTO mun VALUES (655, 'MA', '21', '11029', 'São João Do Caru');
INSERT INTO mun VALUES (4593, 'SC', '42', '16354', 'São João Do Itaperiu');
INSERT INTO mun VALUES (4291, 'PR', '41', '25001', 'São João Do Ivai');
INSERT INTO mun VALUES (2234, 'BA', '29', '30600', 'Serrolandia');
INSERT INTO mun VALUES (4312, 'PR', '41', '26405', 'Sertaneja');
INSERT INTO mun VALUES (1653, 'PE', '26', '14105', 'Sertania');
INSERT INTO mun VALUES (4313, 'PR', '41', '26504', 'Sertanopolis');
INSERT INTO mun VALUES (5072, 'RS', '43', '20503', 'Sertão');
INSERT INTO mun VALUES (11371, 'PE', '26', 'TR078', 'Sertão do São Francisco  PE');
INSERT INTO mun VALUES (11372, 'SE', '28', 'TR079', 'Sertão Ocidental SE');
INSERT INTO mun VALUES (5073, 'RS', '43', '20552', 'Sertão Santana');
INSERT INTO mun VALUES (3879, 'SP', '35', '51702', 'Sertãozinho');
INSERT INTO mun VALUES (1475, 'PB', '25', '15930', 'Sertãozinho');
INSERT INTO mun VALUES (3880, 'SP', '35', '51801', 'Sete Barras');
INSERT INTO mun VALUES (5074, 'RS', '43', '20578', 'Sete De Setembro');
INSERT INTO mun VALUES (3066, 'MG', '31', '67202', 'Sete Lagoas');
INSERT INTO mun VALUES (5209, 'MS', '50', '07703', 'Sete Quedas');
INSERT INTO mun VALUES (3046, 'MG', '31', '65552', 'Setubinha');
INSERT INTO mun VALUES (5075, 'RS', '43', '20602', 'Severiano De Almeida');
INSERT INTO mun VALUES (1251, 'RN', '24', '13607', 'Severiano Melo');
INSERT INTO mun VALUES (3881, 'SP', '35', '51900', 'Severinia');
INSERT INTO mun VALUES (4609, 'SC', '42', '17600', 'Sideropolis');
INSERT INTO mun VALUES (5211, 'MS', '50', '07901', 'Sidrolandia');
INSERT INTO mun VALUES (900, 'PI', '22', '10656', 'Sigefredo Pacheco');
INSERT INTO mun VALUES (3292, 'RJ', '33', '05604', 'Silva Jardim');
INSERT INTO mun VALUES (5584, 'GO', '52', '20603', 'Silvania');
INSERT INTO mun VALUES (462, 'TO', '17', '20655', 'Silvanopolis');
INSERT INTO mun VALUES (5076, 'RS', '43', '20651', 'Silveira Martins');
INSERT INTO mun VALUES (3067, 'MG', '31', '67301', 'Silveirania');
INSERT INTO mun VALUES (3882, 'SP', '35', '52007', 'Silveiras');
INSERT INTO mun VALUES (150, 'AM', '13', '04005', 'Silves');
INSERT INTO mun VALUES (3068, 'MG', '31', '67400', 'Silvianopolis');
INSERT INTO mun VALUES (901, 'PI', '22', '10706', 'Simões');
INSERT INTO mun VALUES (2235, 'BA', '29', '30709', 'Simões Filho');
INSERT INTO mun VALUES (1852, 'SE', '28', '07105', 'Simão Dias');
INSERT INTO mun VALUES (5585, 'GO', '52', '20686', 'Simolandia');
INSERT INTO mun VALUES (3070, 'MG', '31', '67608', 'Simonesia');
INSERT INTO mun VALUES (3069, 'MG', '31', '67509', 'Simão Pereira');
INSERT INTO mun VALUES (902, 'PI', '22', '10805', 'Simplicio Mendes');
INSERT INTO mun VALUES (5077, 'RS', '43', '20677', 'Sinimbu');
INSERT INTO mun VALUES (5341, 'MT', '51', '07909', 'Sinop');
INSERT INTO mun VALUES (4314, 'PR', '41', '26603', 'Siqueira Campos');
INSERT INTO mun VALUES (1654, 'PE', '26', '14204', 'Sirinhaem');
INSERT INTO mun VALUES (1853, 'SE', '28', '07204', 'Siriri');
INSERT INTO mun VALUES (2236, 'BA', '29', '30758', 'Sitio Do Mato');
INSERT INTO mun VALUES (2237, 'BA', '29', '30766', 'Sitio Do Quinto');
INSERT INTO mun VALUES (674, 'MA', '21', '11805', 'Sitio Novo');
INSERT INTO mun VALUES (1252, 'RN', '24', '13706', 'Sitio Novo');
INSERT INTO mun VALUES (463, 'TO', '17', '20804', 'Sitio Novo Do Tocantins');
INSERT INTO mun VALUES (1077, 'CE', '23', '12304', 'São Benedito');
INSERT INTO mun VALUES (646, 'MA', '21', '10401', 'São Benedito Do Rio Pret');
INSERT INTO mun VALUES (1641, 'PE', '26', '12901', 'São Benedito Do Sul');
INSERT INTO mun VALUES (1448, 'PB', '25', '13927', 'São Bentinho');
INSERT INTO mun VALUES (1447, 'PB', '25', '13901', 'São Bento');
INSERT INTO mun VALUES (647, 'MA', '21', '10500', 'São Bento');
INSERT INTO mun VALUES (2984, 'MG', '31', '60801', 'São Bento Abade');
INSERT INTO mun VALUES (1228, 'RN', '24', '11601', 'São Bento Do Norte');
INSERT INTO mun VALUES (3846, 'SP', '35', '48609', 'São Bento Do Sapucai');
INSERT INTO mun VALUES (4585, 'SC', '42', '15802', 'São Bento Do Sul');
INSERT INTO mun VALUES (456, 'TO', '17', '20101', 'São Bento Do Tocantins');
INSERT INTO mun VALUES (1229, 'RN', '24', '11700', 'São Bento Do Trairi');
INSERT INTO mun VALUES (1642, 'PE', '26', '13008', 'São Bento Do Una');
INSERT INTO mun VALUES (4584, 'SC', '42', '15752', 'São Bernardino');
INSERT INTO mun VALUES (648, 'MA', '21', '10609', 'São Bernardo');
INSERT INTO mun VALUES (3847, 'SP', '35', '48708', 'São Bernardo Do Campo');
INSERT INTO mun VALUES (4586, 'SC', '42', '15901', 'São Bonifacio');
INSERT INTO mun VALUES (5024, 'RS', '43', '18002', 'São Borja');
INSERT INTO mun VALUES (2238, 'BA', '29', '30774', 'Sobradinho');
INSERT INTO mun VALUES (5078, 'RS', '43', '20701', 'Sobradinho');
INSERT INTO mun VALUES (1476, 'PB', '25', '15971', 'Sobrado');
INSERT INTO mun VALUES (1083, 'CE', '23', '12908', 'Sobral');
INSERT INTO mun VALUES (11373, 'CE', '23', 'TR080', 'Sobral CE');
INSERT INTO mun VALUES (3071, 'MG', '31', '67707', 'Sobralia');
INSERT INTO mun VALUES (1767, 'AL', '27', '08204', 'São Bras');
INSERT INTO mun VALUES (2985, 'MG', '31', '60900', 'São Bras Do Suaçui');
INSERT INTO mun VALUES (875, 'PI', '22', '09559', 'São Braz Do Piaui');
INSERT INTO mun VALUES (290, 'PA', '15', '07102', 'São Caetano De Odivelas');
INSERT INTO mun VALUES (3848, 'SP', '35', '48807', 'São Caetano Do Sul');
INSERT INTO mun VALUES (5284, 'MT', '51', '05622', 'Mirassol D''oeste');
INSERT INTO mun VALUES (1643, 'PE', '26', '13107', 'São Caitano');
INSERT INTO mun VALUES (3849, 'SP', '35', '48906', 'São Carlos');
INSERT INTO mun VALUES (4587, 'SC', '42', '16008', 'São Carlos');
INSERT INTO mun VALUES (4287, 'PR', '41', '24608', 'São Carlos Do Ivai');
INSERT INTO mun VALUES (3883, 'SP', '35', '52106', 'Socorro');
INSERT INTO mun VALUES (903, 'PI', '22', '10904', 'Socorro Do Piaui');
INSERT INTO mun VALUES (1848, 'SE', '28', '06701', 'São Cristovão');
INSERT INTO mun VALUES (4588, 'SC', '42', '16057', 'São Cristovão Do Sul');
INSERT INTO mun VALUES (2210, 'BA', '29', '28901', 'São Desiderio');
INSERT INTO mun VALUES (2211, 'BA', '29', '28950', 'São Domingos');
INSERT INTO mun VALUES (1849, 'SE', '28', '06800', 'São Domingos');
INSERT INTO mun VALUES (5572, 'GO', '52', '19803', 'São Domingos');
INSERT INTO mun VALUES (4589, 'SC', '42', '16107', 'São Domingos');
INSERT INTO mun VALUES (2986, 'MG', '31', '60959', 'São Domingos Das Dores');
INSERT INTO mun VALUES (1450, 'PB', '25', '13968', 'São Domingos De Pombal');
INSERT INTO mun VALUES (291, 'PA', '15', '07151', 'São Domingos Do Araguaia');
INSERT INTO mun VALUES (649, 'MA', '21', '10658', 'São Domingos Do Azeitão');
INSERT INTO mun VALUES (292, 'PA', '15', '07201', 'São Domingos Do Capim');
INSERT INTO mun VALUES (1449, 'PB', '25', '13943', 'São Domingos Do Cariri');
INSERT INTO mun VALUES (650, 'MA', '21', '10708', 'São Domingos Do Maranhão');
INSERT INTO mun VALUES (3195, 'ES', '32', '04658', 'São Domingos Do Norte');
INSERT INTO mun VALUES (4307, 'PR', '41', '26207', 'Sapopema');
INSERT INTO mun VALUES (3289, 'RJ', '33', '05406', 'Sapucaia');
INSERT INTO mun VALUES (301, 'PA', '15', '07755', 'Sapucaia');
INSERT INTO mun VALUES (5062, 'RS', '43', '20008', 'Sapucaia Do Sul');
INSERT INTO mun VALUES (3043, 'MG', '31', '65404', 'Sapucai-mirim');
INSERT INTO mun VALUES (3290, 'RJ', '33', '05505', 'Saquarema');
INSERT INTO mun VALUES (4308, 'PR', '41', '26256', 'Sarandi');
INSERT INTO mun VALUES (5063, 'RS', '43', '20107', 'Sarandi');
INSERT INTO mun VALUES (3873, 'SP', '35', '51108', 'Sarapui');
INSERT INTO mun VALUES (3044, 'MG', '31', '65503', 'Sardoa');
INSERT INTO mun VALUES (3874, 'SP', '35', '51207', 'Sarutaia');
INSERT INTO mun VALUES (3045, 'MG', '31', '65537', 'Sarzedo');
INSERT INTO mun VALUES (2223, 'BA', '29', '29701', 'Satiro Dias');
INSERT INTO mun VALUES (1774, 'AL', '27', '08907', 'Satuba');
INSERT INTO mun VALUES (670, 'MA', '21', '11722', 'Satubinha');
INSERT INTO mun VALUES (2224, 'BA', '29', '29750', 'Saubara');
INSERT INTO mun VALUES (4309, 'PR', '41', '26272', 'Saudade Do Iguaçu');
INSERT INTO mun VALUES (4605, 'SC', '42', '17303', 'Saudades');
INSERT INTO mun VALUES (2225, 'BA', '29', '29800', 'Saude');
INSERT INTO mun VALUES (4606, 'SC', '42', '17402', 'Schroeder');
INSERT INTO mun VALUES (2226, 'BA', '29', '29909', 'Seabra');
INSERT INTO mun VALUES (4607, 'SC', '42', '17501', 'Seara');
INSERT INTO mun VALUES (3875, 'SP', '35', '51306', 'Sebastianopolis Do Sul');
INSERT INTO mun VALUES (898, 'PI', '22', '10623', 'Sebastião Barros');
INSERT INTO mun VALUES (2227, 'BA', '29', '30006', 'Sebastião Laranjeiras');
INSERT INTO mun VALUES (899, 'PI', '22', '10631', 'Sebastião Leal');
INSERT INTO mun VALUES (5064, 'RS', '43', '20206', 'Seberi');
INSERT INTO mun VALUES (5065, 'RS', '43', '20230', 'Sede Nova');
INSERT INTO mun VALUES (5066, 'RS', '43', '20263', 'Segredo');
INSERT INTO mun VALUES (5067, 'RS', '43', '20305', 'Selbach');
INSERT INTO mun VALUES (5210, 'MS', '50', '07802', 'Selviria');
INSERT INTO mun VALUES (3047, 'MG', '31', '65560', 'Sem-peixe');
INSERT INTO mun VALUES (671, 'MA', '21', '11748', 'Senador Alexandre Costa');
INSERT INTO mun VALUES (3048, 'MG', '31', '65578', 'Senador Amaral');
INSERT INTO mun VALUES (5582, 'GO', '52', '20454', 'Senador Canedo');
INSERT INTO mun VALUES (3049, 'MG', '31', '65602', 'Senador Cortes');
INSERT INTO mun VALUES (1244, 'RN', '24', '13102', 'Senador Eloi De Souza');
INSERT INTO mun VALUES (3050, 'MG', '31', '65701', 'Senador Firmino');
INSERT INTO mun VALUES (1245, 'RN', '24', '13201', 'Senador Georgino Avelino');
INSERT INTO mun VALUES (90, 'AC', '12', '00450', 'Senador Guiomard');
INSERT INTO mun VALUES (3051, 'MG', '31', '65800', 'Senador Jose Bento');
INSERT INTO mun VALUES (302, 'PA', '15', '07805', 'Senador Jose Porfirio');
INSERT INTO mun VALUES (672, 'MA', '21', '11763', 'Senador La Rocque');
INSERT INTO mun VALUES (3052, 'MG', '31', '65909', 'Senador Modestino Gonçal');
INSERT INTO mun VALUES (1081, 'CE', '23', '12700', 'Senador Pompeu');
INSERT INTO mun VALUES (1775, 'AL', '27', '08956', 'Senador Rui Palmeira');
INSERT INTO mun VALUES (1082, 'CE', '23', '12809', 'Senador Sa');
INSERT INTO mun VALUES (5068, 'RS', '43', '20321', 'Senador Salgado Filho');
INSERT INTO mun VALUES (91, 'AC', '12', '00500', 'Sena Madureira');
INSERT INTO mun VALUES (4310, 'PR', '41', '26306', 'Senges');
INSERT INTO mun VALUES (3053, 'MG', '31', '66006', 'Senhora De Oliveira');
INSERT INTO mun VALUES (3054, 'MG', '31', '66105', 'Senhora Do Porto');
INSERT INTO mun VALUES (3055, 'MG', '31', '66204', 'Senhora Dos Remedios');
INSERT INTO mun VALUES (2228, 'BA', '29', '30105', 'Senhor Do Bonfim');
INSERT INTO mun VALUES (5069, 'RS', '43', '20354', 'Sentinela Do Sul');
INSERT INTO mun VALUES (2230, 'BA', '29', '30204', 'Sento Se');
INSERT INTO mun VALUES (5070, 'RS', '43', '20404', 'Serafina Correa');
INSERT INTO mun VALUES (1782, 'SE', '28', '00000', 'Sergipe');
INSERT INTO mun VALUES (3056, 'MG', '31', '66303', 'Sericita');
INSERT INTO mun VALUES (1469, 'PB', '25', '15401', 'Serido');
INSERT INTO mun VALUES (66, 'RO', '11', '01500', 'Seringueiras');
INSERT INTO mun VALUES (5071, 'RS', '43', '20453', 'Serio');
INSERT INTO mun VALUES (3057, 'MG', '31', '66402', 'Seritinga');
INSERT INTO mun VALUES (3291, 'RJ', '33', '05554', 'Seropedica');
INSERT INTO mun VALUES (3200, 'ES', '32', '05002', 'Serra');
INSERT INTO mun VALUES (4608, 'SC', '42', '17550', 'Serra Alta');
INSERT INTO mun VALUES (3876, 'SP', '35', '51405', 'Serra Azul');
INSERT INTO mun VALUES (3058, 'MG', '31', '66501', 'Serra Azul De Minas');
INSERT INTO mun VALUES (1470, 'PB', '25', '15500', 'Serra Branca');
INSERT INTO mun VALUES (1471, 'PB', '25', '15609', 'Serra Da Raiz');
INSERT INTO mun VALUES (3059, 'MG', '31', '66600', 'Serra Da Saudade');
INSERT INTO mun VALUES (1246, 'RN', '24', '13300', 'Serra De São Bento');
INSERT INTO mun VALUES (1247, 'RN', '24', '13359', 'Serra Do Mel');
INSERT INTO mun VALUES (319, 'AP', '16', '00055', 'Serra Do Navio');
INSERT INTO mun VALUES (2229, 'BA', '29', '30154', 'Serra Do Ramalho');
INSERT INTO mun VALUES (3060, 'MG', '31', '66709', 'Serra Dos Aimores');
INSERT INTO mun VALUES (3061, 'MG', '31', '66808', 'Serra Do Salitre');
INSERT INTO mun VALUES (2231, 'BA', '29', '30303', 'Serra Dourada');
INSERT INTO mun VALUES (1472, 'PB', '25', '15708', 'Serra Grande');
INSERT INTO mun VALUES (3877, 'SP', '35', '51504', 'Serrana');
INSERT INTO mun VALUES (3878, 'SP', '35', '51603', 'Serra Negra');
INSERT INTO mun VALUES (1248, 'RN', '24', '13409', 'Serra Negra Do Norte');
INSERT INTO mun VALUES (3062, 'MG', '31', '66907', 'Serrania');
INSERT INTO mun VALUES (673, 'MA', '21', '11789', 'Serrano Do Maranhão');
INSERT INTO mun VALUES (5583, 'GO', '52', '20504', 'Serranopolis');
INSERT INTO mun VALUES (3063, 'MG', '31', '66956', 'Serranopolis De Minas');
INSERT INTO mun VALUES (4311, 'PR', '41', '26355', 'Serranopolis Do Iguaçu');
INSERT INTO mun VALUES (3064, 'MG', '31', '67004', 'Serranos');
INSERT INTO mun VALUES (5340, 'MT', '51', '07883', 'Serra Nova Dourada');
INSERT INTO mun VALUES (2232, 'BA', '29', '30402', 'Serra Preta');
INSERT INTO mun VALUES (1473, 'PB', '25', '15807', 'Serra Redonda');
INSERT INTO mun VALUES (1474, 'PB', '25', '15906', 'Serraria');
INSERT INTO mun VALUES (1651, 'PE', '26', '13909', 'Serra Talhada');
INSERT INTO mun VALUES (2233, 'BA', '29', '30501', 'Serrinha');
INSERT INTO mun VALUES (1249, 'RN', '24', '13508', 'Serrinha');
INSERT INTO mun VALUES (1250, 'RN', '24', '13557', 'Serrinha Dos Pintos');
INSERT INTO mun VALUES (1652, 'PE', '26', '14006', 'Serrita');
INSERT INTO mun VALUES (3065, 'MG', '31', '67103', 'Serro');
INSERT INTO mun VALUES (5207, 'MS', '50', '07554', 'Santa Rita Do Pardo');
INSERT INTO mun VALUES (3833, 'SP', '35', '47502', 'Santa Rita Do Passa Quat');
INSERT INTO mun VALUES (2971, 'MG', '31', '59605', 'Santa Rita Do Sapucai');
INSERT INTO mun VALUES (452, 'TO', '17', '18899', 'Santa Rita Do Tocantins');
INSERT INTO mun VALUES (5334, 'MT', '51', '07768', 'Santa Rita Do Trivelato');
INSERT INTO mun VALUES (5012, 'RS', '43', '17202', 'Santa Rosa');
INSERT INTO mun VALUES (2972, 'MG', '31', '59704', 'Santa Rosa Da Serra');
INSERT INTO mun VALUES (5566, 'GO', '52', '19506', 'Santa Rosa De Goias');
INSERT INTO mun VALUES (1846, 'SE', '28', '06503', 'Santa Rosa De Lima');
INSERT INTO mun VALUES (4578, 'SC', '42', '15604', 'Santa Rosa De Lima');
INSERT INTO mun VALUES (3834, 'SP', '35', '47601', 'Santa Rosa De Viterbo');
INSERT INTO mun VALUES (871, 'PI', '22', '09377', 'Santa Rosa Do Piaui');
INSERT INTO mun VALUES (89, 'AC', '12', '00435', 'Santa Rosa Do Purus');
INSERT INTO mun VALUES (4579, 'SC', '42', '15653', 'Santa Rosa Do Sul');
INSERT INTO mun VALUES (453, 'TO', '17', '18907', 'Santa Rosa Do Tocantins');
INSERT INTO mun VALUES (3835, 'SP', '35', '47650', 'Santa Salete');
INSERT INTO mun VALUES (3194, 'ES', '32', '04609', 'Santa Teresa');
INSERT INTO mun VALUES (2206, 'BA', '29', '28505', 'Santa Teresinha');
INSERT INTO mun VALUES (1445, 'PB', '25', '13802', 'Santa Teresinha');
INSERT INTO mun VALUES (5013, 'RS', '43', '17251', 'Santa Tereza');
INSERT INTO mun VALUES (5567, 'GO', '52', '19605', 'Santa Tereza De Goias');
INSERT INTO mun VALUES (4280, 'PR', '41', '24020', 'Santa Tereza Do Oeste');
INSERT INTO mun VALUES (454, 'TO', '17', '19004', 'Santa Tereza Do Tocantin');
INSERT INTO mun VALUES (4580, 'SC', '42', '15679', 'Santa Terezinha');
INSERT INTO mun VALUES (5335, 'MT', '51', '07776', 'Santa Terezinha');
INSERT INTO mun VALUES (1640, 'PE', '26', '12802', 'Santa Terezinha');
INSERT INTO mun VALUES (5568, 'GO', '52', '19704', 'Santa Terezinha De Goias');
INSERT INTO mun VALUES (4281, 'PR', '41', '24053', 'Santa Terezinha De Itaip');
INSERT INTO mun VALUES (4581, 'SC', '42', '15687', 'Santa Terezinha Do Progr');
INSERT INTO mun VALUES (455, 'TO', '17', '20002', 'Santa Terezinha Do Tocan');
INSERT INTO mun VALUES (2973, 'MG', '31', '59803', 'Santa Vitoria');
INSERT INTO mun VALUES (5014, 'RS', '43', '17301', 'Santa Vitoria Do Palmar');
INSERT INTO mun VALUES (5015, 'RS', '43', '17400', 'Santiago');
INSERT INTO mun VALUES (4582, 'SC', '42', '15695', 'Santiago Do Sul');
INSERT INTO mun VALUES (5324, 'MT', '51', '07263', 'Santo Afonso');
INSERT INTO mun VALUES (2207, 'BA', '29', '28604', 'Santo Amaro');
INSERT INTO mun VALUES (4583, 'SC', '42', '15703', 'Santo Amaro Da Imperatri');
INSERT INTO mun VALUES (1847, 'SE', '28', '06602', 'Santo Amaro Das Brotas');
INSERT INTO mun VALUES (644, 'MA', '21', '10278', 'Santo Amaro Do Maranhão');
INSERT INTO mun VALUES (3836, 'SP', '35', '47700', 'Santo Anastacio');
INSERT INTO mun VALUES (3837, 'SP', '35', '47809', 'Santo Andre');
INSERT INTO mun VALUES (1446, 'PB', '25', '13851', 'Santo Andre');
INSERT INTO mun VALUES (5016, 'RS', '43', '17509', 'Santo Angelo');
INSERT INTO mun VALUES (1227, 'RN', '24', '11502', 'Santo Antonio');
INSERT INTO mun VALUES (3838, 'SP', '35', '47908', 'Santo Antonio Da Alegria');
INSERT INTO mun VALUES (5569, 'GO', '52', '19712', 'Santo Antonio Da Barra');
INSERT INTO mun VALUES (5018, 'RS', '43', '17608', 'Santo Antonio Da Patrulh');
INSERT INTO mun VALUES (4282, 'PR', '41', '24103', 'Santo Antonio Da Platina');
INSERT INTO mun VALUES (5019, 'RS', '43', '17707', 'Santo Antonio Das Missõe');
INSERT INTO mun VALUES (5570, 'GO', '52', '19738', 'Santo Antonio De Goias');
INSERT INTO mun VALUES (2208, 'BA', '29', '28703', 'Santo Antonio De Jesus');
INSERT INTO mun VALUES (872, 'PI', '22', '09401', 'Santo Antonio De Lisboa');
INSERT INTO mun VALUES (3279, 'RJ', '33', '04706', 'Santo Antonio De Padua');
INSERT INTO mun VALUES (3839, 'SP', '35', '48005', 'Santo Antonio De Posse');
INSERT INTO mun VALUES (4348, 'SC', '42', '00000', 'Santa Catarina');
INSERT INTO mun VALUES (2974, 'MG', '31', '59902', 'Santo Antonio Do Amparo');
INSERT INTO mun VALUES (3840, 'SP', '35', '48054', 'Santo Antonio Do Aracang');
INSERT INTO mun VALUES (2975, 'MG', '31', '60009', 'Santo Antonio Do Aventur');
INSERT INTO mun VALUES (4283, 'PR', '41', '24202', 'Santo Antonio Do Caiua');
INSERT INTO mun VALUES (5571, 'GO', '52', '19753', 'Santo Antonio Do Descobe');
INSERT INTO mun VALUES (2976, 'MG', '31', '60108', 'Santo Antonio Do Grama');
INSERT INTO mun VALUES (146, 'AM', '13', '03700', 'Santo Antonio Do Iça');
INSERT INTO mun VALUES (2977, 'MG', '31', '60207', 'Santo Antonio Do Itambe');
INSERT INTO mun VALUES (2978, 'MG', '31', '60306', 'Santo Antonio Do Jacinto');
INSERT INTO mun VALUES (3841, 'SP', '35', '48104', 'Santo Antonio Do Jardim');
INSERT INTO mun VALUES (5336, 'MT', '51', '07792', 'Santo Antonio Do Leste');
INSERT INTO mun VALUES (5337, 'MT', '51', '07800', 'Santo Antonio Do Leverge');
INSERT INTO mun VALUES (2979, 'MG', '31', '60405', 'Santo Antonio Do Monte');
INSERT INTO mun VALUES (5017, 'RS', '43', '17558', 'Santo Antonio Do Palma');
INSERT INTO mun VALUES (4284, 'PR', '41', '24301', 'Santo Antonio Do Paraiso');
INSERT INTO mun VALUES (3842, 'SP', '35', '48203', 'Santo Antonio Do Pinhal');
INSERT INTO mun VALUES (5020, 'RS', '43', '17756', 'Santo Antonio Do Planalt');
INSERT INTO mun VALUES (2980, 'MG', '31', '60454', 'Santo Antonio Do Retiro');
INSERT INTO mun VALUES (2981, 'MG', '31', '60504', 'Santo Antonio Do Rio Aba');
INSERT INTO mun VALUES (645, 'MA', '21', '10302', 'Santo Antonio Dos Lopes');
INSERT INTO mun VALUES (873, 'PI', '22', '09450', 'Santo Antonio Dos Milagr');
INSERT INTO mun VALUES (4285, 'PR', '41', '24400', 'Santo Antonio Do Sudoest');
INSERT INTO mun VALUES (289, 'PA', '15', '07003', 'Santo Antonio Do Taua');
INSERT INTO mun VALUES (5021, 'RS', '43', '17806', 'Santo Augusto');
INSERT INTO mun VALUES (5022, 'RS', '43', '17905', 'Santo Cristo');
INSERT INTO mun VALUES (2209, 'BA', '29', '28802', 'Santo Estevão');
INSERT INTO mun VALUES (3843, 'SP', '35', '48302', 'Santo Expedito');
INSERT INTO mun VALUES (5023, 'RS', '43', '17954', 'Santo Expedito Do Sul');
INSERT INTO mun VALUES (2982, 'MG', '31', '60603', 'Santo Hipolito');
INSERT INTO mun VALUES (4286, 'PR', '41', '24509', 'Santo Inacio');
INSERT INTO mun VALUES (874, 'PI', '22', '09500', 'Santo Inacio Do Piaui');
INSERT INTO mun VALUES (3844, 'SP', '35', '48401', 'Santopolis Do Aguapei');
INSERT INTO mun VALUES (3845, 'SP', '35', '48500', 'Santos');
INSERT INTO mun VALUES (2983, 'MG', '31', '60702', 'Santos Dumont');
INSERT INTO mun VALUES (1468, 'PB', '25', '15302', 'Sape');
INSERT INTO mun VALUES (2222, 'BA', '29', '29602', 'Sapeaçu');
INSERT INTO mun VALUES (5339, 'MT', '51', '07875', 'Sapezal');
INSERT INTO mun VALUES (5061, 'RS', '43', '19901', 'Sapiranga');
INSERT INTO mun VALUES (5562, 'GO', '52', '19308', 'Santa Helena De Goias');
INSERT INTO mun VALUES (2949, 'MG', '31', '57658', 'Santa Helena De Minas');
INSERT INTO mun VALUES (2199, 'BA', '29', '27903', 'Santa Ines');
INSERT INTO mun VALUES (1439, 'PB', '25', '13356', 'Santa Ines');
INSERT INTO mun VALUES (638, 'MA', '21', '09908', 'Santa Ines');
INSERT INTO mun VALUES (4272, 'PR', '41', '23600', 'Santa Ines');
INSERT INTO mun VALUES (3826, 'SP', '35', '46801', 'Santa Isabel');
INSERT INTO mun VALUES (5563, 'GO', '52', '19357', 'Santa Isabel');
INSERT INTO mun VALUES (4273, 'PR', '41', '23709', 'Santa Isabel Do Ivai');
INSERT INTO mun VALUES (1978, 'BA', '29', '10057', 'Dias D''avila');
INSERT INTO mun VALUES (282, 'PA', '15', '06500', 'Santa Isabel Do Para');
INSERT INTO mun VALUES (145, 'AM', '13', '03601', 'Santa Isabel Do Rio Negr');
INSERT INTO mun VALUES (4274, 'PR', '41', '23808', 'Santa Izabel Do Oeste');
INSERT INTO mun VALUES (2950, 'MG', '31', '57708', 'Santa Juliana');
INSERT INTO mun VALUES (3192, 'ES', '32', '04500', 'Santa Leopoldina');
INSERT INTO mun VALUES (3827, 'SP', '35', '46900', 'Santa Lucia');
INSERT INTO mun VALUES (4275, 'PR', '41', '23824', 'Santa Lucia');
INSERT INTO mun VALUES (2200, 'BA', '29', '28000', 'Santaluz');
INSERT INTO mun VALUES (869, 'PI', '22', '09302', 'Santa Luz');
INSERT INTO mun VALUES (2951, 'MG', '31', '57807', 'Santa Luzia');
INSERT INTO mun VALUES (639, 'MA', '21', '10005', 'Santa Luzia');
INSERT INTO mun VALUES (1440, 'PB', '25', '13406', 'Santa Luzia');
INSERT INTO mun VALUES (2201, 'BA', '29', '28059', 'Santa Luzia');
INSERT INTO mun VALUES (40, 'RO', '11', '00296', 'Santa Luzia Doeste');
INSERT INTO mun VALUES (1844, 'SE', '28', '06305', 'Santa Luzia Do Itanhy');
INSERT INTO mun VALUES (1764, 'AL', '27', '07909', 'Santa Luzia Do Norte');
INSERT INTO mun VALUES (283, 'PA', '15', '06559', 'Santa Luzia Do Para');
INSERT INTO mun VALUES (640, 'MA', '21', '10039', 'Santa Luzia Do Parua');
INSERT INTO mun VALUES (2952, 'MG', '31', '57906', 'Santa Margarida');
INSERT INTO mun VALUES (5009, 'RS', '43', '16972', 'Santa Margarida Do Sul');
INSERT INTO mun VALUES (1203, 'RN', '24', '09332', 'Santa Maria');
INSERT INTO mun VALUES (5007, 'RS', '43', '16907', 'Santa Maria');
INSERT INTO mun VALUES (1638, 'PE', '26', '12604', 'Santa Maria Da Boa Vista');
INSERT INTO mun VALUES (284, 'PA', '15', '06583', 'Santa Maria Das Barreira');
INSERT INTO mun VALUES (3828, 'SP', '35', '47007', 'Santa Maria Da Serra');
INSERT INTO mun VALUES (2202, 'BA', '29', '28109', 'Santa Maria Da Vitoria');
INSERT INTO mun VALUES (2953, 'MG', '31', '58003', 'Santa Maria De Itabira');
INSERT INTO mun VALUES (3193, 'ES', '32', '04559', 'Santa Maria De Jetiba');
INSERT INTO mun VALUES (1639, 'PE', '26', '12703', 'Santa Maria Do Cambuca');
INSERT INTO mun VALUES (5008, 'RS', '43', '16956', 'Santa Maria Do Herval');
INSERT INTO mun VALUES (4276, 'PR', '41', '23857', 'Santa Maria Do Oeste');
INSERT INTO mun VALUES (285, 'PA', '15', '06609', 'Santa Maria Do Para');
INSERT INTO mun VALUES (2954, 'MG', '31', '58102', 'Santa Maria Do Salto');
INSERT INTO mun VALUES (2955, 'MG', '31', '58201', 'Santa Maria Do Suaçui');
INSERT INTO mun VALUES (451, 'TO', '17', '18881', 'Santa Maria Do Tocantins');
INSERT INTO mun VALUES (3278, 'RJ', '33', '04607', 'Santa Maria Madalena');
INSERT INTO mun VALUES (4277, 'PR', '41', '23907', 'Santa Mariana');
INSERT INTO mun VALUES (3829, 'SP', '35', '47106', 'Santa Mercedes');
INSERT INTO mun VALUES (4278, 'PR', '41', '23956', 'Santa Monica');
INSERT INTO mun VALUES (2203, 'BA', '29', '28208', 'Santana');
INSERT INTO mun VALUES (332, 'AP', '16', '00600', 'Santana');
INSERT INTO mun VALUES (5010, 'RS', '43', '17004', 'Santana Da Boa Vista');
INSERT INTO mun VALUES (3830, 'SP', '35', '47205', 'Santana Da Ponte Pensa');
INSERT INTO mun VALUES (2956, 'MG', '31', '58300', 'Santana Da Vargem');
INSERT INTO mun VALUES (1436, 'PB', '25', '13158', 'Santa Cecilia');
INSERT INTO mun VALUES (2957, 'MG', '31', '58409', 'Santana De Cataguases');
INSERT INTO mun VALUES (1441, 'PB', '25', '13505', 'Santana De Mangueira');
INSERT INTO mun VALUES (3831, 'SP', '35', '47304', 'Santana De Parnaiba');
INSERT INTO mun VALUES (2958, 'MG', '31', '58508', 'Santana De Pirapama');
INSERT INTO mun VALUES (5586, 'GO', '52', '20702', 'Sitio D''abadia');
INSERT INTO mun VALUES (1074, 'CE', '23', '12007', 'Santana Do Acarau');
INSERT INTO mun VALUES (286, 'PA', '15', '06708', 'Santana Do Araguaia');
INSERT INTO mun VALUES (1075, 'CE', '23', '12106', 'Santana Do Cariri');
INSERT INTO mun VALUES (2959, 'MG', '31', '58607', 'Santana Do Deserto');
INSERT INTO mun VALUES (2960, 'MG', '31', '58706', 'Santana Do Garambeu');
INSERT INTO mun VALUES (1765, 'AL', '27', '08006', 'Santana Do Ipanema');
INSERT INTO mun VALUES (4279, 'PR', '41', '24004', 'Santana Do Itarare');
INSERT INTO mun VALUES (2961, 'MG', '31', '58805', 'Santana Do Jacare');
INSERT INTO mun VALUES (5011, 'RS', '43', '17103', 'Santana Do Livramento');
INSERT INTO mun VALUES (2962, 'MG', '31', '58904', 'Santana Do Manhuaçu');
INSERT INTO mun VALUES (643, 'MA', '21', '10237', 'Santana Do Maranhão');
INSERT INTO mun VALUES (1225, 'RN', '24', '11403', 'Santana Do Matos');
INSERT INTO mun VALUES (1766, 'AL', '27', '08105', 'Santana Do Mundau');
INSERT INTO mun VALUES (2963, 'MG', '31', '58953', 'Santana Do Paraiso');
INSERT INTO mun VALUES (870, 'PI', '22', '09351', 'Santana Do Piaui');
INSERT INTO mun VALUES (2964, 'MG', '31', '59001', 'Santana Do Riacho');
INSERT INTO mun VALUES (1226, 'RN', '24', '11429', 'Santana Do Serido');
INSERT INTO mun VALUES (1442, 'PB', '25', '13604', 'Santana Dos Garrotes');
INSERT INTO mun VALUES (2965, 'MG', '31', '59100', 'Santana Dos Montes');
INSERT INTO mun VALUES (1845, 'SE', '28', '06404', 'Santana Do São Francisco');
INSERT INTO mun VALUES (2204, 'BA', '29', '28307', 'Santanopolis');
INSERT INTO mun VALUES (1812, 'SE', '28', '03203', 'Itaporanga D''ajuda');
INSERT INTO mun VALUES (1076, 'CE', '23', '12205', 'Santa Quiteria');
INSERT INTO mun VALUES (641, 'MA', '21', '10104', 'Santa Quiteria Do Maranh');
INSERT INTO mun VALUES (287, 'PA', '15', '06807', 'Santarem');
INSERT INTO mun VALUES (1443, 'PB', '25', '13653', 'Santarem');
INSERT INTO mun VALUES (288, 'PA', '15', '06906', 'Santarem Novo');
INSERT INTO mun VALUES (642, 'MA', '21', '10203', 'Santa Rita');
INSERT INTO mun VALUES (1444, 'PB', '25', '13703', 'Santa Rita');
INSERT INTO mun VALUES (2966, 'MG', '31', '59209', 'Santa Rita De Caldas');
INSERT INTO mun VALUES (2205, 'BA', '29', '28406', 'Santa Rita De Cassia');
INSERT INTO mun VALUES (2969, 'MG', '31', '59407', 'Santa Rita De Ibitipoca');
INSERT INTO mun VALUES (2967, 'MG', '31', '59308', 'Santa Rita De Jacutinga');
INSERT INTO mun VALUES (2968, 'MG', '31', '59357', 'Santa Rita De Minas');
INSERT INTO mun VALUES (5564, 'GO', '52', '19407', 'Santa Rita Do Araguaia');
INSERT INTO mun VALUES (2970, 'MG', '31', '59506', 'Santa Rita Do Itueto');
INSERT INTO mun VALUES (5565, 'GO', '52', '19456', 'Santa Rita Do Novo Desti');
INSERT INTO mun VALUES (4998, 'RS', '43', '16436', 'Saldanha Marinho');
INSERT INTO mun VALUES (3805, 'SP', '35', '44806', 'Sales');
INSERT INTO mun VALUES (3806, 'SP', '35', '44905', 'Sales Oliveira');
INSERT INTO mun VALUES (3807, 'SP', '35', '45001', 'Salesopolis');
INSERT INTO mun VALUES (4572, 'SC', '42', '15307', 'Salete');
INSERT INTO mun VALUES (1630, 'PE', '26', '12109', 'Salgadinho');
INSERT INTO mun VALUES (1434, 'PB', '25', '13000', 'Salgadinho');
INSERT INTO mun VALUES (1843, 'SE', '28', '06206', 'Salgado');
INSERT INTO mun VALUES (1435, 'PB', '25', '13109', 'Salgado De São Felix');
INSERT INTO mun VALUES (4264, 'PR', '41', '22800', 'Salgado Filho');
INSERT INTO mun VALUES (1631, 'PE', '26', '12208', 'Salgueiro');
INSERT INTO mun VALUES (2938, 'MG', '31', '57005', 'Salinas');
INSERT INTO mun VALUES (2193, 'BA', '29', '27309', 'Salinas Da Margarida');
INSERT INTO mun VALUES (278, 'PA', '15', '06203', 'Salinopolis');
INSERT INTO mun VALUES (1073, 'CE', '23', '11959', 'Salitre');
INSERT INTO mun VALUES (3808, 'SP', '35', '45100', 'Salmourão');
INSERT INTO mun VALUES (1632, 'PE', '26', '12307', 'Saloa');
INSERT INTO mun VALUES (3809, 'SP', '35', '45159', 'Saltinho');
INSERT INTO mun VALUES (4573, 'SC', '42', '15356', 'Saltinho');
INSERT INTO mun VALUES (3810, 'SP', '35', '45209', 'Salto');
INSERT INTO mun VALUES (2939, 'MG', '31', '57104', 'Salto Da Divisa');
INSERT INTO mun VALUES (3811, 'SP', '35', '45308', 'Salto De Pirapora');
INSERT INTO mun VALUES (5333, 'MT', '51', '07750', 'Salto Do Ceu');
INSERT INTO mun VALUES (4265, 'PR', '41', '22909', 'Salto Do Itarare');
INSERT INTO mun VALUES (4999, 'RS', '43', '16451', 'Salto Do Jacui');
INSERT INTO mun VALUES (4266, 'PR', '41', '23006', 'Salto Do Lontra');
INSERT INTO mun VALUES (3812, 'SP', '35', '45407', 'Salto Grande');
INSERT INTO mun VALUES (4574, 'SC', '42', '15406', 'Salto Veloso');
INSERT INTO mun VALUES (2194, 'BA', '29', '27408', 'Salvador');
INSERT INTO mun VALUES (5000, 'RS', '43', '16477', 'Salvador Das Missões');
INSERT INTO mun VALUES (5001, 'RS', '43', '16501', 'Salvador Do Sul');
INSERT INTO mun VALUES (279, 'PA', '15', '06302', 'Salvaterra');
INSERT INTO mun VALUES (635, 'MA', '21', '09700', 'Sambaiba');
INSERT INTO mun VALUES (448, 'TO', '17', '18808', 'Sampaio');
INSERT INTO mun VALUES (5002, 'RS', '43', '16600', 'Sananduva');
INSERT INTO mun VALUES (5558, 'GO', '52', '19001', 'Sanclerlandia');
INSERT INTO mun VALUES (449, 'TO', '17', '18840', 'Sandolandia');
INSERT INTO mun VALUES (3813, 'SP', '35', '45506', 'Sandovalina');
INSERT INTO mun VALUES (4575, 'SC', '42', '15455', 'Sangão');
INSERT INTO mun VALUES (1633, 'PE', '26', '12406', 'Sanharo');
INSERT INTO mun VALUES (3814, 'SP', '35', '45605', 'Santa Adelia');
INSERT INTO mun VALUES (3815, 'SP', '35', '45704', 'Santa Albertina');
INSERT INTO mun VALUES (4267, 'PR', '41', '23105', 'Santa Amelia');
INSERT INTO mun VALUES (2195, 'BA', '29', '27507', 'Santa Barbara');
INSERT INTO mun VALUES (2940, 'MG', '31', '57203', 'Santa Barbara');
INSERT INTO mun VALUES (5559, 'GO', '52', '19100', 'Santa Barbara De Goias');
INSERT INTO mun VALUES (2941, 'MG', '31', '57252', 'Santa Barbara Do Leste');
INSERT INTO mun VALUES (2942, 'MG', '31', '57278', 'Santa Barbara Do Monte V');
INSERT INTO mun VALUES (280, 'PA', '15', '06351', 'Santa Barbara Do Para');
INSERT INTO mun VALUES (5003, 'RS', '43', '16709', 'Santa Barbara Do Sul');
INSERT INTO mun VALUES (2943, 'MG', '31', '57302', 'Santa Barbara Do Tugurio');
INSERT INTO mun VALUES (3817, 'SP', '35', '46009', 'Santa Branca');
INSERT INTO mun VALUES (2196, 'BA', '29', '27606', 'Santa Brigida');
INSERT INTO mun VALUES (5323, 'MT', '51', '07248', 'Santa Carmem');
INSERT INTO mun VALUES (4576, 'SC', '42', '15505', 'Santa Cecilia');
INSERT INTO mun VALUES (4268, 'PR', '41', '23204', 'Santa Cecilia Do Pavão');
INSERT INTO mun VALUES (5004, 'RS', '43', '16733', 'Santa Cecilia Do Sul');
INSERT INTO mun VALUES (5005, 'RS', '43', '16758', 'Santa Clara Do Sul');
INSERT INTO mun VALUES (1437, 'PB', '25', '13208', 'Santa Cruz');
INSERT INTO mun VALUES (1634, 'PE', '26', '12455', 'Santa Cruz');
INSERT INTO mun VALUES (1224, 'RN', '24', '11205', 'Santa Cruz');
INSERT INTO mun VALUES (2197, 'BA', '29', '27705', 'Santa Cruz Cabralia');
INSERT INTO mun VALUES (1635, 'PE', '26', '12471', 'Santa Cruz Da Baixa Verd');
INSERT INTO mun VALUES (3819, 'SP', '35', '46207', 'Santa Cruz Da Conceição');
INSERT INTO mun VALUES (3820, 'SP', '35', '46256', 'Santa Cruz Da Esperança');
INSERT INTO mun VALUES (3821, 'SP', '35', '46306', 'Santa Cruz Das Palmeiras');
INSERT INTO mun VALUES (2198, 'BA', '29', '27804', 'Santa Cruz Da Vitoria');
INSERT INTO mun VALUES (5560, 'GO', '52', '19209', 'Santa Cruz De Goias');
INSERT INTO mun VALUES (2944, 'MG', '31', '57336', 'Santa Cruz De Minas');
INSERT INTO mun VALUES (4269, 'PR', '41', '23303', 'Santa Cruz De Monte Cast');
INSERT INTO mun VALUES (2945, 'MG', '31', '57377', 'Santa Cruz De Salinas');
INSERT INTO mun VALUES (281, 'PA', '15', '06401', 'Santa Cruz Do Arari');
INSERT INTO mun VALUES (1636, 'PE', '26', '12505', 'Santa Cruz Do Capibaribe');
INSERT INTO mun VALUES (2946, 'MG', '31', '57401', 'Santa Cruz Do Escalvado');
INSERT INTO mun VALUES (866, 'PI', '22', '09104', 'Santa Cruz Do Piaui');
INSERT INTO mun VALUES (3822, 'SP', '35', '46405', 'Santa Cruz Do Rio Pardo');
INSERT INTO mun VALUES (867, 'PI', '22', '09153', 'Santa Cruz Dos Milagres');
INSERT INTO mun VALUES (5006, 'RS', '43', '16808', 'Santa Cruz Do Sul');
INSERT INTO mun VALUES (5332, 'MT', '51', '07743', 'Santa Cruz Do Xingu');
INSERT INTO mun VALUES (2947, 'MG', '31', '57500', 'Santa Efigenia De Minas');
INSERT INTO mun VALUES (3823, 'SP', '35', '46504', 'Santa Ernestina');
INSERT INTO mun VALUES (4270, 'PR', '41', '23402', 'Santa Fe');
INSERT INTO mun VALUES (5561, 'GO', '52', '19258', 'Santa Fe De Goias');
INSERT INTO mun VALUES (2948, 'MG', '31', '57609', 'Santa Fe De Minas');
INSERT INTO mun VALUES (450, 'TO', '17', '18865', 'Santa Fe Do Araguaia');
INSERT INTO mun VALUES (3824, 'SP', '35', '46603', 'Santa Fe Do Sul');
INSERT INTO mun VALUES (868, 'PI', '22', '09203', 'Santa Filomena');
INSERT INTO mun VALUES (1637, 'PE', '26', '12554', 'Santa Filomena');
INSERT INTO mun VALUES (636, 'MA', '21', '09759', 'Santa Filomena Do Maranh');
INSERT INTO mun VALUES (3825, 'SP', '35', '46702', 'Santa Gertrudes');
INSERT INTO mun VALUES (1438, 'PB', '25', '13307', 'Santa Helena');
INSERT INTO mun VALUES (4577, 'SC', '42', '15554', 'Santa Helena');
INSERT INTO mun VALUES (637, 'MA', '21', '09809', 'Santa Helena');
INSERT INTO mun VALUES (4271, 'PR', '41', '23501', 'Santa Helena');
INSERT INTO mun VALUES (3209, 'RJ', '33', '00000', 'Rio De Janeiro');
INSERT INTO mun VALUES (2188, 'BA', '29', '26806', 'Rio Do Antonio');
INSERT INTO mun VALUES (4562, 'SC', '42', '14508', 'Rio Do Campo');
INSERT INTO mun VALUES (2917, 'MG', '31', '55009', 'Rio Doce');
INSERT INTO mun VALUES (1199, 'RN', '24', '08953', 'Rio Do Fogo');
INSERT INTO mun VALUES (1400, 'PB', '25', '10402', 'Olho D''agua');
INSERT INTO mun VALUES (4563, 'SC', '42', '14607', 'Rio Do Oeste');
INSERT INTO mun VALUES (2189, 'BA', '29', '26905', 'Rio Do Pires');
INSERT INTO mun VALUES (2918, 'MG', '31', '55108', 'Rio Do Prado');
INSERT INTO mun VALUES (446, 'TO', '17', '18709', 'Rio Dos Bois');
INSERT INTO mun VALUES (4564, 'SC', '42', '14706', 'Rio Dos Cedros');
INSERT INTO mun VALUES (4985, 'RS', '43', '15552', 'Rio Dos Indios');
INSERT INTO mun VALUES (4565, 'SC', '42', '14805', 'Rio Do Sul');
INSERT INTO mun VALUES (2919, 'MG', '31', '55207', 'Rio Espera');
INSERT INTO mun VALUES (1628, 'PE', '26', '11903', 'Rio Formoso');
INSERT INTO mun VALUES (4566, 'SC', '42', '14904', 'Rio Fortuna');
INSERT INTO mun VALUES (4986, 'RS', '43', '15602', 'Rio Grande');
INSERT INTO mun VALUES (3797, 'SP', '35', '44103', 'Rio Grande Da Serra');
INSERT INTO mun VALUES (1101, 'RN', '24', '00000', 'Rio Grande Do Norte');
INSERT INTO mun VALUES (865, 'PI', '22', '09005', 'Rio Grande Do Piaui');
INSERT INTO mun VALUES (4642, 'RS', '43', '00000', 'Rio Grande Do Sul');
INSERT INTO mun VALUES (3798, 'SP', '35', '44202', 'Riolandia');
INSERT INTO mun VALUES (1762, 'AL', '27', '07701', 'Rio Largo');
INSERT INTO mun VALUES (2920, 'MG', '31', '55306', 'Rio Manso');
INSERT INTO mun VALUES (275, 'PA', '15', '06161', 'Rio Maria');
INSERT INTO mun VALUES (4567, 'SC', '42', '15000', 'Rio Negrinho');
INSERT INTO mun VALUES (5204, 'MS', '50', '07307', 'Rio Negro');
INSERT INTO mun VALUES (4258, 'PR', '41', '22305', 'Rio Negro');
INSERT INTO mun VALUES (2921, 'MG', '31', '55405', 'Rio Novo');
INSERT INTO mun VALUES (3191, 'ES', '32', '04401', 'Rio Novo Do Sul');
INSERT INTO mun VALUES (2922, 'MG', '31', '55504', 'Rio Paranaiba');
INSERT INTO mun VALUES (4987, 'RS', '43', '15701', 'Rio Pardo');
INSERT INTO mun VALUES (2923, 'MG', '31', '55603', 'Rio Pardo De Minas');
INSERT INTO mun VALUES (2924, 'MG', '31', '55702', 'Rio Piracicaba');
INSERT INTO mun VALUES (2925, 'MG', '31', '55801', 'Rio Pomba');
INSERT INTO mun VALUES (2926, 'MG', '31', '55900', 'Rio Preto');
INSERT INTO mun VALUES (144, 'AM', '13', '03569', 'Rio Preto Da Eva');
INSERT INTO mun VALUES (5555, 'GO', '52', '18789', 'Rio Quente');
INSERT INTO mun VALUES (5254, 'MT', '51', '03361', 'Conquista D''oeste');
INSERT INTO mun VALUES (2190, 'BA', '29', '27002', 'Rio Real');
INSERT INTO mun VALUES (4568, 'SC', '42', '15059', 'Rio Rufino');
INSERT INTO mun VALUES (447, 'TO', '17', '18758', 'Rio Sono');
INSERT INTO mun VALUES (1433, 'PB', '25', '12903', 'Rio Tinto');
INSERT INTO mun VALUES (5556, 'GO', '52', '18805', 'Rio Verde');
INSERT INTO mun VALUES (5205, 'MS', '50', '07406', 'Rio Verde De Mato Grosso');
INSERT INTO mun VALUES (2927, 'MG', '31', '56007', 'Rio Vermelho');
INSERT INTO mun VALUES (4988, 'RS', '43', '15750', 'Riozinho');
INSERT INTO mun VALUES (4569, 'SC', '42', '15075', 'Riqueza');
INSERT INTO mun VALUES (2928, 'MG', '31', '56106', 'Ritapolis');
INSERT INTO mun VALUES (3791, 'SP', '35', '43501', 'Riversul');
INSERT INTO mun VALUES (4989, 'RS', '43', '15800', 'Roca Sales');
INSERT INTO mun VALUES (5206, 'MS', '50', '07505', 'Rochedo');
INSERT INTO mun VALUES (2929, 'MG', '31', '56205', 'Rochedo De Minas');
INSERT INTO mun VALUES (4570, 'SC', '42', '15109', 'Rodeio');
INSERT INTO mun VALUES (5262, 'MT', '51', '03809', 'Figueiropolis D''oeste');
INSERT INTO mun VALUES (5265, 'MT', '51', '03957', 'Gloria D''oeste');
INSERT INTO mun VALUES (4990, 'RS', '43', '15909', 'Rodeio Bonito');
INSERT INTO mun VALUES (2930, 'MG', '31', '56304', 'Rodeiro');
INSERT INTO mun VALUES (2191, 'BA', '29', '27101', 'Rodelas');
INSERT INTO mun VALUES (1221, 'RN', '24', '11007', 'Rodolfo Fernandes');
INSERT INTO mun VALUES (88, 'AC', '12', '00427', 'Rodrigues Alves');
INSERT INTO mun VALUES (4991, 'RS', '43', '15958', 'Rolador');
INSERT INTO mun VALUES (4259, 'PR', '41', '22404', 'Rolandia');
INSERT INTO mun VALUES (4992, 'RS', '43', '16006', 'Rolante');
INSERT INTO mun VALUES (39, 'RO', '11', '00288', 'Rolim De Moura');
INSERT INTO mun VALUES (2931, 'MG', '31', '56403', 'Romaria');
INSERT INTO mun VALUES (4571, 'SC', '42', '15208', 'Romelandia');
INSERT INTO mun VALUES (5278, 'MT', '51', '05234', 'Lambari D''oeste');
INSERT INTO mun VALUES (4260, 'PR', '41', '22503', 'Roncador');
INSERT INTO mun VALUES (4993, 'RS', '43', '16105', 'Ronda Alta');
INSERT INTO mun VALUES (4994, 'RS', '43', '16204', 'Rondinha');
INSERT INTO mun VALUES (5329, 'MT', '51', '07578', 'Rondolandia');
INSERT INTO mun VALUES (4261, 'PR', '41', '22602', 'Rondon');
INSERT INTO mun VALUES (276, 'PA', '15', '06187', 'Rondon Do Para');
INSERT INTO mun VALUES (5330, 'MT', '51', '07602', 'Rondonopolis');
INSERT INTO mun VALUES (4995, 'RS', '43', '16303', 'Roque Gonzales');
INSERT INTO mun VALUES (158, 'RR', '14', '00000', 'Roraima');
INSERT INTO mun VALUES (170, 'RR', '14', '00472', 'Rorainopolis');
INSERT INTO mun VALUES (3799, 'SP', '35', '44251', 'Rosana');
INSERT INTO mun VALUES (634, 'MA', '21', '09601', 'Rosario');
INSERT INTO mun VALUES (2932, 'MG', '31', '56452', 'Rosario Da Limeira');
INSERT INTO mun VALUES (1842, 'SE', '28', '06107', 'Rosario Do Catete');
INSERT INTO mun VALUES (4262, 'PR', '41', '22651', 'Rosario Do Ivai');
INSERT INTO mun VALUES (4996, 'RS', '43', '16402', 'Rosario Do Sul');
INSERT INTO mun VALUES (5331, 'MT', '51', '07701', 'Rosario Oeste');
INSERT INTO mun VALUES (3800, 'SP', '35', '44301', 'Roseira');
INSERT INTO mun VALUES (1763, 'AL', '27', '07800', 'Roteiro');
INSERT INTO mun VALUES (2933, 'MG', '31', '56502', 'Rubelita');
INSERT INTO mun VALUES (3801, 'SP', '35', '44400', 'Rubiacea');
INSERT INTO mun VALUES (5557, 'GO', '52', '18904', 'Rubiataba');
INSERT INTO mun VALUES (2934, 'MG', '31', '56601', 'Rubim');
INSERT INTO mun VALUES (3802, 'SP', '35', '44509', 'Rubineia');
INSERT INTO mun VALUES (277, 'PA', '15', '06195', 'Ruropolis');
INSERT INTO mun VALUES (1071, 'CE', '23', '11801', 'Russas');
INSERT INTO mun VALUES (2192, 'BA', '29', '27200', 'Ruy Barbosa');
INSERT INTO mun VALUES (1223, 'RN', '24', '11106', 'Ruy Barbosa');
INSERT INTO mun VALUES (2935, 'MG', '31', '56700', 'Sabara');
INSERT INTO mun VALUES (4263, 'PR', '41', '22701', 'Sabaudia');
INSERT INTO mun VALUES (3803, 'SP', '35', '44608', 'Sabino');
INSERT INTO mun VALUES (2936, 'MG', '31', '56809', 'Sabinopolis');
INSERT INTO mun VALUES (1072, 'CE', '23', '11900', 'Saboeiro');
INSERT INTO mun VALUES (2937, 'MG', '31', '56908', 'Sacramento');
INSERT INTO mun VALUES (4997, 'RS', '43', '16428', 'Sagrada Familia');
INSERT INTO mun VALUES (3804, 'SP', '35', '44707', 'Sagres');
INSERT INTO mun VALUES (1629, 'PE', '26', '12000', 'Saire');
INSERT INTO mun VALUES (443, 'TO', '17', '18501', 'Recursolandia');
INSERT INTO mun VALUES (1069, 'CE', '23', '11603', 'Redenção');
INSERT INTO mun VALUES (274, 'PA', '15', '06138', 'Redenção');
INSERT INTO mun VALUES (3777, 'SP', '35', '42305', 'Redenção Da Serra');
INSERT INTO mun VALUES (860, 'PI', '22', '08700', 'Redenção Do Gurgueia');
INSERT INTO mun VALUES (4982, 'RS', '43', '15404', 'Redentora');
INSERT INTO mun VALUES (2907, 'MG', '31', '54150', 'Reduto');
INSERT INTO mun VALUES (861, 'PI', '22', '08809', 'Regeneração');
INSERT INTO mun VALUES (1776, 'AL', '27', '09004', 'Tanque D''arca');
INSERT INTO mun VALUES (3778, 'SP', '35', '42404', 'Regente Feijo');
INSERT INTO mun VALUES (3779, 'SP', '35', '42503', 'Reginopolis');
INSERT INTO mun VALUES (11362, 'RS', '43', 'TR069', 'Região Central RS');
INSERT INTO mun VALUES (3780, 'SP', '35', '42602', 'Registro');
INSERT INTO mun VALUES (4983, 'RS', '43', '15453', 'Relvado');
INSERT INTO mun VALUES (2179, 'BA', '29', '26004', 'Remanso');
INSERT INTO mun VALUES (1426, 'PB', '25', '12705', 'Remigio');
INSERT INTO mun VALUES (4248, 'PR', '41', '21604', 'Renascença');
INSERT INTO mun VALUES (1070, 'CE', '23', '11702', 'Reriutaba');
INSERT INTO mun VALUES (3272, 'RJ', '33', '04201', 'Resende');
INSERT INTO mun VALUES (2908, 'MG', '31', '54200', 'Resende Costa');
INSERT INTO mun VALUES (4249, 'PR', '41', '21703', 'Reserva');
INSERT INTO mun VALUES (5319, 'MT', '51', '07156', 'Reserva Do Cabaçal');
INSERT INTO mun VALUES (4250, 'PR', '41', '21752', 'Reserva Do Iguaçu');
INSERT INTO mun VALUES (2909, 'MG', '31', '54309', 'Resplendor');
INSERT INTO mun VALUES (2910, 'MG', '31', '54408', 'Ressaquinha');
INSERT INTO mun VALUES (3781, 'SP', '35', '42701', 'Restinga');
INSERT INTO mun VALUES (4984, 'RS', '43', '15503', 'Restinga Seca');
INSERT INTO mun VALUES (2180, 'BA', '29', '26103', 'Retirolandia');
INSERT INTO mun VALUES (2911, 'MG', '31', '54457', 'Riachinho');
INSERT INTO mun VALUES (444, 'TO', '17', '18550', 'Riachinho');
INSERT INTO mun VALUES (1428, 'PB', '25', '12747', 'Riachão');
INSERT INTO mun VALUES (632, 'MA', '21', '09502', 'Riachão');
INSERT INTO mun VALUES (1218, 'RN', '24', '10702', 'Riacho Da Cruz');
INSERT INTO mun VALUES (1626, 'PE', '26', '11705', 'Riacho Das Almas');
INSERT INTO mun VALUES (2181, 'BA', '29', '26202', 'Riachão Das Neves');
INSERT INTO mun VALUES (1219, 'RN', '24', '10801', 'Riacho De Santana');
INSERT INTO mun VALUES (2183, 'BA', '29', '26400', 'Riacho De Santana');
INSERT INTO mun VALUES (1431, 'PB', '25', '12788', 'Riacho De Santo Antonio');
INSERT INTO mun VALUES (1429, 'PB', '25', '12754', 'Riachão Do Bacamarte');
INSERT INTO mun VALUES (1839, 'SE', '28', '05802', 'Riachão Do Dantas');
INSERT INTO mun VALUES (2182, 'BA', '29', '26301', 'Riachão Do Jacuipe');
INSERT INTO mun VALUES (1430, 'PB', '25', '12762', 'Riachão Do Poço');
INSERT INTO mun VALUES (1432, 'PB', '25', '12804', 'Riacho Dos Cavalos');
INSERT INTO mun VALUES (2912, 'MG', '31', '54507', 'Riacho Dos Machados');
INSERT INTO mun VALUES (862, 'PI', '22', '08858', 'Riacho Frio');
INSERT INTO mun VALUES (1840, 'SE', '28', '05901', 'Riachuelo');
INSERT INTO mun VALUES (1220, 'RN', '24', '10900', 'Riachuelo');
INSERT INTO mun VALUES (5553, 'GO', '52', '18607', 'Rialma');
INSERT INTO mun VALUES (5554, 'GO', '52', '18706', 'Rianapolis');
INSERT INTO mun VALUES (633, 'MA', '21', '09551', 'Ribamar Fiquene');
INSERT INTO mun VALUES (5202, 'MS', '50', '07109', 'Ribas Do Rio Pardo');
INSERT INTO mun VALUES (3782, 'SP', '35', '42800', 'Ribeira');
INSERT INTO mun VALUES (2184, 'BA', '29', '26509', 'Ribeira Do Amparo');
INSERT INTO mun VALUES (863, 'PI', '22', '08874', 'Ribeira Do Piaui');
INSERT INTO mun VALUES (2185, 'BA', '29', '26608', 'Ribeira Do Pombal');
INSERT INTO mun VALUES (1627, 'PE', '26', '11804', 'Ribeirão');
INSERT INTO mun VALUES (3783, 'SP', '35', '42909', 'Ribeirão Bonito');
INSERT INTO mun VALUES (3784, 'SP', '35', '43006', 'Ribeirão Branco');
INSERT INTO mun VALUES (5320, 'MT', '51', '07180', 'Ribeirão Cascalheira');
INSERT INTO mun VALUES (4251, 'PR', '41', '21802', 'Ribeirão Claro');
INSERT INTO mun VALUES (3785, 'SP', '35', '43105', 'Ribeirão Corrente');
INSERT INTO mun VALUES (2913, 'MG', '31', '54606', 'Ribeirão Das Neves');
INSERT INTO mun VALUES (2186, 'BA', '29', '26657', 'Ribeirão Do Largo');
INSERT INTO mun VALUES (4252, 'PR', '41', '21901', 'Ribeirão Do Pinhal');
INSERT INTO mun VALUES (3787, 'SP', '35', '43238', 'Ribeirão Dos Indios');
INSERT INTO mun VALUES (3786, 'SP', '35', '43204', 'Ribeirão Do Sul');
INSERT INTO mun VALUES (864, 'PI', '22', '08908', 'Ribeiro Gonçalves');
INSERT INTO mun VALUES (3788, 'SP', '35', '43253', 'Ribeirão Grande');
INSERT INTO mun VALUES (3789, 'SP', '35', '43303', 'Ribeirão Pires');
INSERT INTO mun VALUES (1841, 'SE', '28', '06008', 'Ribeiropolis');
INSERT INTO mun VALUES (3790, 'SP', '35', '43402', 'Ribeirão Preto');
INSERT INTO mun VALUES (2914, 'MG', '31', '54705', 'Ribeirão Vermelho');
INSERT INTO mun VALUES (5321, 'MT', '51', '07198', 'Ribeirãozinho');
INSERT INTO mun VALUES (3792, 'SP', '35', '43600', 'Rifaina');
INSERT INTO mun VALUES (3793, 'SP', '35', '43709', 'Rincão');
INSERT INTO mun VALUES (3794, 'SP', '35', '43808', 'Rinopolis');
INSERT INTO mun VALUES (2915, 'MG', '31', '54804', 'Rio Acima');
INSERT INTO mun VALUES (4253, 'PR', '41', '22008', 'Rio Azul');
INSERT INTO mun VALUES (3190, 'ES', '32', '04351', 'Rio Bananal');
INSERT INTO mun VALUES (4254, 'PR', '41', '22107', 'Rio Bom');
INSERT INTO mun VALUES (3273, 'RJ', '33', '04300', 'Rio Bonito');
INSERT INTO mun VALUES (4255, 'PR', '41', '22156', 'Rio Bonito Do Iguaçu');
INSERT INTO mun VALUES (87, 'AC', '12', '00401', 'Rio Branco');
INSERT INTO mun VALUES (5322, 'MT', '51', '07206', 'Rio Branco');
INSERT INTO mun VALUES (4256, 'PR', '41', '22172', 'Rio Branco Do Ivai');
INSERT INTO mun VALUES (4257, 'PR', '41', '22206', 'Rio Branco Do Sul');
INSERT INTO mun VALUES (5203, 'MS', '50', '07208', 'Rio Brilhante');
INSERT INTO mun VALUES (2916, 'MG', '31', '54903', 'Rio Casca');
INSERT INTO mun VALUES (3795, 'SP', '35', '43907', 'Rio Claro');
INSERT INTO mun VALUES (3274, 'RJ', '33', '04409', 'Rio Claro');
INSERT INTO mun VALUES (38, 'RO', '11', '00262', 'Rio Crespo');
INSERT INTO mun VALUES (445, 'TO', '17', '18659', 'Rio Da Conceição');
INSERT INTO mun VALUES (4561, 'SC', '42', '14409', 'Rio Das Antas');
INSERT INTO mun VALUES (3275, 'RJ', '33', '04508', 'Rio Das Flores');
INSERT INTO mun VALUES (3276, 'RJ', '33', '04524', 'Rio Das Ostras');
INSERT INTO mun VALUES (3796, 'SP', '35', '44004', 'Rio Das Pedras');
INSERT INTO mun VALUES (2187, 'BA', '29', '26707', 'Rio De Contas');
INSERT INTO mun VALUES (3277, 'RJ', '33', '04557', 'Rio De Janeiro');
INSERT INTO mun VALUES (4555, 'SC', '42', '13906', 'Presidente Castelo Branc');
INSERT INTO mun VALUES (625, 'MA', '21', '09106', 'Presidente Dutra');
INSERT INTO mun VALUES (2172, 'BA', '29', '25600', 'Presidente Dutra');
INSERT INTO mun VALUES (3766, 'SP', '35', '41307', 'Presidente Epitacio');
INSERT INTO mun VALUES (143, 'AM', '13', '03536', 'Presidente Figueiredo');
INSERT INTO mun VALUES (4556, 'SC', '42', '14003', 'Presidente Getulio');
INSERT INTO mun VALUES (2173, 'BA', '29', '25709', 'Presidente Janio Quadros');
INSERT INTO mun VALUES (2897, 'MG', '31', '53202', 'Presidente Juscelino');
INSERT INTO mun VALUES (626, 'MA', '21', '09205', 'Presidente Juscelino');
INSERT INTO mun VALUES (1214, 'RN', '24', '10306', 'Presidente Juscelino');
INSERT INTO mun VALUES (3189, 'ES', '32', '04302', 'Presidente Kennedy');
INSERT INTO mun VALUES (441, 'TO', '17', '18402', 'Presidente Kennedy');
INSERT INTO mun VALUES (2898, 'MG', '31', '53301', 'Presidente Kubitschek');
INSERT INTO mun VALUES (4974, 'RS', '43', '15149', 'Presidente Lucena');
INSERT INTO mun VALUES (627, 'MA', '21', '09239', 'Presidente Medici');
INSERT INTO mun VALUES (37, 'RO', '11', '00254', 'Presidente Medici');
INSERT INTO mun VALUES (4557, 'SC', '42', '14102', 'Presidente Nereu');
INSERT INTO mun VALUES (2899, 'MG', '31', '53400', 'Presidente Olegario');
INSERT INTO mun VALUES (3767, 'SP', '35', '41406', 'Presidente Prudente');
INSERT INTO mun VALUES (628, 'MA', '21', '09270', 'Presidente Sarney');
INSERT INTO mun VALUES (2174, 'BA', '29', '25758', 'Presidente Tancredo Neve');
INSERT INTO mun VALUES (629, 'MA', '21', '09304', 'Presidente Vargas');
INSERT INTO mun VALUES (3768, 'SP', '35', '41505', 'Presidente Venceslau');
INSERT INTO mun VALUES (272, 'PA', '15', '06104', 'Primavera');
INSERT INTO mun VALUES (1622, 'PE', '26', '11408', 'Primavera');
INSERT INTO mun VALUES (63, 'RO', '11', '01476', 'Primavera De Rondonia');
INSERT INTO mun VALUES (5316, 'MT', '51', '07040', 'Primavera Do Leste');
INSERT INTO mun VALUES (630, 'MA', '21', '09403', 'Primeira Cruz');
INSERT INTO mun VALUES (4233, 'PR', '41', '20507', 'Primeiro De Maio');
INSERT INTO mun VALUES (4558, 'SC', '42', '14151', 'Princesa');
INSERT INTO mun VALUES (1422, 'PB', '25', '12309', 'Princesa Isabel');
INSERT INTO mun VALUES (5551, 'GO', '52', '18391', 'Professor Jamil');
INSERT INTO mun VALUES (4975, 'RS', '43', '15156', 'Progresso');
INSERT INTO mun VALUES (3769, 'SP', '35', '41604', 'Promissão');
INSERT INTO mun VALUES (1838, 'SE', '28', '05703', 'Propria');
INSERT INTO mun VALUES (4976, 'RS', '43', '15172', 'Protasio Alves');
INSERT INTO mun VALUES (2901, 'MG', '31', '53608', 'Prudente De Morais');
INSERT INTO mun VALUES (4234, 'PR', '41', '20606', 'Prudentopolis');
INSERT INTO mun VALUES (442, 'TO', '17', '18451', 'Pugmil');
INSERT INTO mun VALUES (1215, 'RN', '24', '10405', 'Pureza');
INSERT INTO mun VALUES (4977, 'RS', '43', '15206', 'Putinga');
INSERT INTO mun VALUES (1423, 'PB', '25', '12408', 'Puxinanã');
INSERT INTO mun VALUES (3770, 'SP', '35', '41653', 'Quadra');
INSERT INTO mun VALUES (4978, 'RS', '43', '15305', 'Quarai');
INSERT INTO mun VALUES (2902, 'MG', '31', '53707', 'Quartel Geral');
INSERT INTO mun VALUES (4235, 'PR', '41', '20655', 'Quarto Centenario');
INSERT INTO mun VALUES (3771, 'SP', '35', '41703', 'Quata');
INSERT INTO mun VALUES (4236, 'PR', '41', '20705', 'Quatigua');
INSERT INTO mun VALUES (273, 'PA', '15', '06112', 'Quatipuru');
INSERT INTO mun VALUES (3269, 'RJ', '33', '04128', 'Quatis');
INSERT INTO mun VALUES (4237, 'PR', '41', '20804', 'Quatro Barras');
INSERT INTO mun VALUES (4979, 'RS', '43', '15313', 'Quatro Irmãos');
INSERT INTO mun VALUES (4238, 'PR', '41', '20853', 'Quatro Pontes');
INSERT INTO mun VALUES (1761, 'AL', '27', '07602', 'Quebrangulo');
INSERT INTO mun VALUES (4239, 'PR', '41', '20903', 'Quedas Do Iguaçu');
INSERT INTO mun VALUES (859, 'PI', '22', '08650', 'Queimada Nova');
INSERT INTO mun VALUES (2175, 'BA', '29', '25808', 'Queimadas');
INSERT INTO mun VALUES (1424, 'PB', '25', '12507', 'Queimadas');
INSERT INTO mun VALUES (3270, 'RJ', '33', '04144', 'Queimados');
INSERT INTO mun VALUES (3772, 'SP', '35', '41802', 'Queiroz');
INSERT INTO mun VALUES (3773, 'SP', '35', '41901', 'Queluz');
INSERT INTO mun VALUES (2903, 'MG', '31', '53806', 'Queluzito');
INSERT INTO mun VALUES (5317, 'MT', '51', '07065', 'Querencia');
INSERT INTO mun VALUES (4240, 'PR', '41', '21000', 'Querencia Do Norte');
INSERT INTO mun VALUES (4980, 'RS', '43', '15321', 'Quevedos');
INSERT INTO mun VALUES (2176, 'BA', '29', '25907', 'Quijingue');
INSERT INTO mun VALUES (4559, 'SC', '42', '14201', 'Quilombo');
INSERT INTO mun VALUES (4241, 'PR', '41', '21109', 'Quinta Do Sol');
INSERT INTO mun VALUES (3774, 'SP', '35', '42008', 'Quintana');
INSERT INTO mun VALUES (4981, 'RS', '43', '15354', 'Quinze De Novembro');
INSERT INTO mun VALUES (1623, 'PE', '26', '11507', 'Quipapa');
INSERT INTO mun VALUES (5552, 'GO', '52', '18508', 'Quirinopolis');
INSERT INTO mun VALUES (3271, 'RJ', '33', '04151', 'Quissamã');
INSERT INTO mun VALUES (4242, 'PR', '41', '21208', 'Quitandinha');
INSERT INTO mun VALUES (1064, 'CE', '23', '11264', 'Quiterianopolis');
INSERT INTO mun VALUES (1425, 'PB', '25', '12606', 'Quixaba');
INSERT INTO mun VALUES (1624, 'PE', '26', '11533', 'Quixaba');
INSERT INTO mun VALUES (2177, 'BA', '29', '25931', 'Quixabeira');
INSERT INTO mun VALUES (1065, 'CE', '23', '11306', 'Quixada');
INSERT INTO mun VALUES (1066, 'CE', '23', '11355', 'Quixelo');
INSERT INTO mun VALUES (1067, 'CE', '23', '11405', 'Quixeramobim');
INSERT INTO mun VALUES (1068, 'CE', '23', '11504', 'Quixere');
INSERT INTO mun VALUES (1216, 'RN', '24', '10504', 'Rafael Fernandes');
INSERT INTO mun VALUES (1217, 'RN', '24', '10603', 'Rafael Godeiro');
INSERT INTO mun VALUES (2178, 'BA', '29', '25956', 'Rafael Jambeiro');
INSERT INTO mun VALUES (3775, 'SP', '35', '42107', 'Rafard');
INSERT INTO mun VALUES (4243, 'PR', '41', '21257', 'Ramilandia');
INSERT INTO mun VALUES (3776, 'SP', '35', '42206', 'Rancharia');
INSERT INTO mun VALUES (4244, 'PR', '41', '21307', 'Rancho Alegre');
INSERT INTO mun VALUES (4560, 'SC', '42', '14300', 'Rancho Queimado');
INSERT INTO mun VALUES (631, 'MA', '21', '09452', 'Raposa');
INSERT INTO mun VALUES (2904, 'MG', '31', '53905', 'Raposos');
INSERT INTO mun VALUES (2905, 'MG', '31', '54002', 'Raul Soares');
INSERT INTO mun VALUES (4246, 'PR', '41', '21406', 'Realeza');
INSERT INTO mun VALUES (4247, 'PR', '41', '21505', 'Rebouças');
INSERT INTO mun VALUES (1625, 'PE', '26', '11606', 'Recife');
INSERT INTO mun VALUES (2906, 'MG', '31', '54101', 'Recreio');
INSERT INTO mun VALUES (3188, 'ES', '32', '04252', 'Ponto Belo');
INSERT INTO mun VALUES (2885, 'MG', '31', '52131', 'Ponto Chique');
INSERT INTO mun VALUES (2886, 'MG', '31', '52170', 'Ponto Dos Volantes');
INSERT INTO mun VALUES (2168, 'BA', '29', '25253', 'Ponto Novo');
INSERT INTO mun VALUES (1620, 'PE', '26', '11200', 'Poção');
INSERT INTO mun VALUES (1211, 'RN', '24', '10108', 'Poço Branco');
INSERT INTO mun VALUES (1418, 'PB', '25', '12036', 'Poço Dantas');
INSERT INTO mun VALUES (4964, 'RS', '43', '14753', 'Poço Das Antas');
INSERT INTO mun VALUES (1757, 'AL', '27', '07206', 'Poço Das Trincheiras');
INSERT INTO mun VALUES (1419, 'PB', '25', '12077', 'Poço De Jose De Moura');
INSERT INTO mun VALUES (622, 'MA', '21', '08900', 'Poção De Pedras');
INSERT INTO mun VALUES (2880, 'MG', '31', '51701', 'Poço Fundo');
INSERT INTO mun VALUES (1835, 'SE', '28', '05406', 'Poço Redondo');
INSERT INTO mun VALUES (2881, 'MG', '31', '51800', 'Poços De Caldas');
INSERT INTO mun VALUES (1836, 'SE', '28', '05505', 'Poço Verde');
INSERT INTO mun VALUES (3754, 'SP', '35', '40408', 'Populina');
INSERT INTO mun VALUES (1060, 'CE', '23', '11009', 'Poranga');
INSERT INTO mun VALUES (3755, 'SP', '35', '40507', 'Porangaba');
INSERT INTO mun VALUES (5547, 'GO', '52', '18003', 'Porangatu');
INSERT INTO mun VALUES (3267, 'RJ', '33', '04102', 'Porciuncula');
INSERT INTO mun VALUES (4225, 'PR', '41', '20002', 'Porecatu');
INSERT INTO mun VALUES (11361, 'MT', '51', 'TR068', 'Portal do Amazonas MT');
INSERT INTO mun VALUES (1212, 'RN', '24', '10207', 'Portalegre');
INSERT INTO mun VALUES (1061, 'CE', '23', '11108', 'Porteiras');
INSERT INTO mun VALUES (2887, 'MG', '31', '52204', 'Porteirinha');
INSERT INTO mun VALUES (5548, 'GO', '52', '18052', 'Porteirão');
INSERT INTO mun VALUES (269, 'PA', '15', '05809', 'Portel');
INSERT INTO mun VALUES (5549, 'GO', '52', '18102', 'Portelandia');
INSERT INTO mun VALUES (856, 'PI', '22', '08502', 'Porto');
INSERT INTO mun VALUES (4967, 'RS', '43', '14803', 'Portão');
INSERT INTO mun VALUES (94, 'AC', '12', '00807', 'Porto Acre');
INSERT INTO mun VALUES (4968, 'RS', '43', '14902', 'Porto Alegre');
INSERT INTO mun VALUES (5311, 'MT', '51', '06778', 'Porto Alegre Do Norte');
INSERT INTO mun VALUES (857, 'PI', '22', '08551', 'Porto Alegre Do Piaui');
INSERT INTO mun VALUES (438, 'TO', '17', '18006', 'Porto Alegre Do Tocantins');
INSERT INTO mun VALUES (4226, 'PR', '41', '20101', 'Porto Amazonas');
INSERT INTO mun VALUES (4227, 'PR', '41', '20150', 'Porto Barreiro');
INSERT INTO mun VALUES (4551, 'SC', '42', '13500', 'Porto Belo');
INSERT INTO mun VALUES (1758, 'AL', '27', '07305', 'Porto Calvo');
INSERT INTO mun VALUES (1837, 'SE', '28', '05604', 'Porto Da Folha');
INSERT INTO mun VALUES (270, 'PA', '15', '05908', 'Porto De Moz');
INSERT INTO mun VALUES (1759, 'AL', '27', '07404', 'Porto De Pedras');
INSERT INTO mun VALUES (1213, 'RN', '24', '10256', 'Porto Do Mangue');
INSERT INTO mun VALUES (5312, 'MT', '51', '06802', 'Porto Dos Gauchos');
INSERT INTO mun VALUES (5313, 'MT', '51', '06828', 'Porto Esperidião');
INSERT INTO mun VALUES (5314, 'MT', '51', '06851', 'Porto Estrela');
INSERT INTO mun VALUES (3756, 'SP', '35', '40606', 'Porto Feliz');
INSERT INTO mun VALUES (3757, 'SP', '35', '40705', 'Porto Ferreira');
INSERT INTO mun VALUES (2888, 'MG', '31', '52303', 'Porto Firme');
INSERT INTO mun VALUES (623, 'MA', '21', '09007', 'Porto Franco');
INSERT INTO mun VALUES (330, 'AP', '16', '00535', 'Porto Grande');
INSERT INTO mun VALUES (4969, 'RS', '43', '15008', 'Porto Lucena');
INSERT INTO mun VALUES (4970, 'RS', '43', '15057', 'Porto Maua');
INSERT INTO mun VALUES (5201, 'MS', '50', '06903', 'Porto Murtinho');
INSERT INTO mun VALUES (439, 'TO', '17', '18204', 'Porto Nacional');
INSERT INTO mun VALUES (3268, 'RJ', '33', '04110', 'Porto Real');
INSERT INTO mun VALUES (1760, 'AL', '27', '07503', 'Porto Real Do Colegio');
INSERT INTO mun VALUES (4228, 'PR', '41', '20200', 'Porto Rico');
INSERT INTO mun VALUES (624, 'MA', '21', '09056', 'Porto Rico Do Maranhão');
INSERT INTO mun VALUES (2169, 'BA', '29', '25303', 'Porto Seguro');
INSERT INTO mun VALUES (4552, 'SC', '42', '13609', 'Porto União');
INSERT INTO mun VALUES (36, 'RO', '11', '00205', 'Porto Velho');
INSERT INTO mun VALUES (4971, 'RS', '43', '15073', 'Porto Vera Cruz');
INSERT INTO mun VALUES (4229, 'PR', '41', '20309', 'Porto Vitoria');
INSERT INTO mun VALUES (86, 'AC', '12', '00393', 'Porto Walter');
INSERT INTO mun VALUES (4972, 'RS', '43', '15107', 'Porto Xavier');
INSERT INTO mun VALUES (5550, 'GO', '52', '18300', 'Posse');
INSERT INTO mun VALUES (2889, 'MG', '31', '52402', 'Pote');
INSERT INTO mun VALUES (1062, 'CE', '23', '11207', 'Potengi');
INSERT INTO mun VALUES (3758, 'SP', '35', '40754', 'Potim');
INSERT INTO mun VALUES (2170, 'BA', '29', '25402', 'Potiragua');
INSERT INTO mun VALUES (3759, 'SP', '35', '40804', 'Potirendaba');
INSERT INTO mun VALUES (1063, 'CE', '23', '11231', 'Potiretama');
INSERT INTO mun VALUES (2890, 'MG', '31', '52501', 'Pouso Alegre');
INSERT INTO mun VALUES (2891, 'MG', '31', '52600', 'Pouso Alto');
INSERT INTO mun VALUES (4973, 'RS', '43', '15131', 'Pouso Novo');
INSERT INTO mun VALUES (4553, 'SC', '42', '13708', 'Pouso Redondo');
INSERT INTO mun VALUES (5315, 'MT', '51', '07008', 'Poxoreo');
INSERT INTO mun VALUES (3760, 'SP', '35', '40853', 'Pracinha');
INSERT INTO mun VALUES (331, 'AP', '16', '00550', 'Pracuuba');
INSERT INTO mun VALUES (2171, 'BA', '29', '25501', 'Prado');
INSERT INTO mun VALUES (4230, 'PR', '41', '20333', 'Prado Ferreira');
INSERT INTO mun VALUES (3761, 'SP', '35', '40903', 'Pradopolis');
INSERT INTO mun VALUES (2892, 'MG', '31', '52709', 'Prados');
INSERT INTO mun VALUES (3762, 'SP', '35', '41000', 'Praia Grande');
INSERT INTO mun VALUES (4554, 'SC', '42', '13807', 'Praia Grande');
INSERT INTO mun VALUES (440, 'TO', '17', '18303', 'Praia Norte');
INSERT INTO mun VALUES (271, 'PA', '15', '06005', 'Prainha');
INSERT INTO mun VALUES (4231, 'PR', '41', '20358', 'Pranchita');
INSERT INTO mun VALUES (2893, 'MG', '31', '52808', 'Prata');
INSERT INTO mun VALUES (1421, 'PB', '25', '12200', 'Prata');
INSERT INTO mun VALUES (858, 'PI', '22', '08601', 'Prata Do Piaui');
INSERT INTO mun VALUES (3763, 'SP', '35', '41059', 'Pratania');
INSERT INTO mun VALUES (2894, 'MG', '31', '52907', 'Pratapolis');
INSERT INTO mun VALUES (2895, 'MG', '31', '53004', 'Pratinha');
INSERT INTO mun VALUES (3764, 'SP', '35', '41109', 'Presidente Alves');
INSERT INTO mun VALUES (2896, 'MG', '31', '53103', 'Presidente Bernardes');
INSERT INTO mun VALUES (3765, 'SP', '35', '41208', 'Presidente Bernardes');
INSERT INTO mun VALUES (4232, 'PR', '41', '20408', 'Presidente Castelo Branc');
INSERT INTO mun VALUES (853, 'PI', '22', '08205', 'Pio Ix');
INSERT INTO mun VALUES (620, 'MA', '21', '08702', 'Pio Xii');
INSERT INTO mun VALUES (3733, 'SP', '35', '38303', 'Piquerobi');
INSERT INTO mun VALUES (1058, 'CE', '23', '10902', 'Piquet Carneiro');
INSERT INTO mun VALUES (3734, 'SP', '35', '38501', 'Piquete');
INSERT INTO mun VALUES (3735, 'SP', '35', '38600', 'Piracaia');
INSERT INTO mun VALUES (5541, 'GO', '52', '17104', 'Piracanjuba');
INSERT INTO mun VALUES (2869, 'MG', '31', '50604', 'Piracema');
INSERT INTO mun VALUES (3736, 'SP', '35', '38709', 'Piracicaba');
INSERT INTO mun VALUES (854, 'PI', '22', '08304', 'Piracuruca');
INSERT INTO mun VALUES (3266, 'RJ', '33', '04003', 'Pirai');
INSERT INTO mun VALUES (2161, 'BA', '29', '24678', 'Pirai Do Norte');
INSERT INTO mun VALUES (4217, 'PR', '41', '19400', 'Pirai Do Sul');
INSERT INTO mun VALUES (3737, 'SP', '35', '38808', 'Piraju');
INSERT INTO mun VALUES (2870, 'MG', '31', '50703', 'Pirajuba');
INSERT INTO mun VALUES (3738, 'SP', '35', '38907', 'Pirajui');
INSERT INTO mun VALUES (1834, 'SE', '28', '05307', 'Pirambu');
INSERT INTO mun VALUES (2871, 'MG', '31', '50802', 'Piranga');
INSERT INTO mun VALUES (3739, 'SP', '35', '39004', 'Pirangi');
INSERT INTO mun VALUES (2873, 'MG', '31', '51008', 'Piranguinho');
INSERT INTO mun VALUES (2872, 'MG', '31', '50901', 'Piranguçu');
INSERT INTO mun VALUES (5542, 'GO', '52', '17203', 'Piranhas');
INSERT INTO mun VALUES (1756, 'AL', '27', '07107', 'Piranhas');
INSERT INTO mun VALUES (621, 'MA', '21', '08801', 'Pirapemas');
INSERT INTO mun VALUES (2874, 'MG', '31', '51107', 'Pirapetinga');
INSERT INTO mun VALUES (4961, 'RS', '43', '14555', 'Pirapo');
INSERT INTO mun VALUES (2875, 'MG', '31', '51206', 'Pirapora');
INSERT INTO mun VALUES (3740, 'SP', '35', '39103', 'Pirapora Do Bom Jesus');
INSERT INTO mun VALUES (3741, 'SP', '35', '39202', 'Pirapozinho');
INSERT INTO mun VALUES (4218, 'PR', '41', '19509', 'Piraquara');
INSERT INTO mun VALUES (434, 'TO', '17', '17206', 'Piraque');
INSERT INTO mun VALUES (3742, 'SP', '35', '39301', 'Pirassununga');
INSERT INTO mun VALUES (4962, 'RS', '43', '14605', 'Piratini');
INSERT INTO mun VALUES (3743, 'SP', '35', '39400', 'Piratininga');
INSERT INTO mun VALUES (4545, 'SC', '42', '13104', 'Piratuba');
INSERT INTO mun VALUES (2876, 'MG', '31', '51305', 'Pirauba');
INSERT INTO mun VALUES (5543, 'GO', '52', '17302', 'Pirenopolis');
INSERT INTO mun VALUES (5544, 'GO', '52', '17401', 'Pires Do Rio');
INSERT INTO mun VALUES (1059, 'CE', '23', '10951', 'Pires Ferreira');
INSERT INTO mun VALUES (2162, 'BA', '29', '24702', 'Piripa');
INSERT INTO mun VALUES (855, 'PI', '22', '08403', 'Piripiri');
INSERT INTO mun VALUES (2163, 'BA', '29', '24801', 'Piritiba');
INSERT INTO mun VALUES (1415, 'PB', '25', '11806', 'Pirpirituba');
INSERT INTO mun VALUES (4219, 'PR', '41', '19608', 'Pitanga');
INSERT INTO mun VALUES (3744, 'SP', '35', '39509', 'Pitangueiras');
INSERT INTO mun VALUES (4220, 'PR', '41', '19657', 'Pitangueiras');
INSERT INTO mun VALUES (2877, 'MG', '31', '51404', 'Pitangui');
INSERT INTO mun VALUES (1416, 'PB', '25', '11905', 'Pitimbu');
INSERT INTO mun VALUES (435, 'TO', '17', '17503', 'Pium');
INSERT INTO mun VALUES (3187, 'ES', '32', '04203', 'Piuma');
INSERT INTO mun VALUES (2878, 'MG', '31', '51503', 'Piumhi');
INSERT INTO mun VALUES (267, 'PA', '15', '05650', 'Placas');
INSERT INTO mun VALUES (85, 'AC', '12', '00385', 'Placido De Castro');
INSERT INTO mun VALUES (5545, 'GO', '52', '17609', 'Planaltina');
INSERT INTO mun VALUES (4221, 'PR', '41', '19707', 'Planaltina Do Parana');
INSERT INTO mun VALUES (2164, 'BA', '29', '24900', 'Planaltino');
INSERT INTO mun VALUES (3745, 'SP', '35', '39608', 'Planalto');
INSERT INTO mun VALUES (2165, 'BA', '29', '25006', 'Planalto');
INSERT INTO mun VALUES (4963, 'RS', '43', '14704', 'Planalto');
INSERT INTO mun VALUES (4222, 'PR', '41', '19806', 'Planalto');
INSERT INTO mun VALUES (4546, 'SC', '42', '13153', 'Planalto Alegre');
INSERT INTO mun VALUES (5306, 'MT', '51', '06455', 'Planalto Da Serra');
INSERT INTO mun VALUES (11357, 'SC', '42', 'TR064', 'Planalto Norte  SC');
INSERT INTO mun VALUES (11358, 'SC', '42', 'TR065', 'Planalto Serrano  SC');
INSERT INTO mun VALUES (2879, 'MG', '31', '51602', 'Planura');
INSERT INTO mun VALUES (3746, 'SP', '35', '39707', 'Platina');
INSERT INTO mun VALUES (11359, 'ES', '32', 'TR066', 'Pólo Colatina ES');
INSERT INTO mun VALUES (3747, 'SP', '35', '39806', 'Poa');
INSERT INTO mun VALUES (1417, 'PB', '25', '12002', 'Pocinhos');
INSERT INTO mun VALUES (5307, 'MT', '51', '06505', 'Pocone');
INSERT INTO mun VALUES (2882, 'MG', '31', '51909', 'Pocrane');
INSERT INTO mun VALUES (1747, 'AL', '27', '06406', 'Pão De Açucar');
INSERT INTO mun VALUES (2166, 'BA', '29', '25105', 'Poções');
INSERT INTO mun VALUES (2167, 'BA', '29', '25204', 'Pojuca');
INSERT INTO mun VALUES (3748, 'SP', '35', '39905', 'Poloni');
INSERT INTO mun VALUES (1420, 'PB', '25', '12101', 'Pombal');
INSERT INTO mun VALUES (1621, 'PE', '26', '11309', 'Pombos');
INSERT INTO mun VALUES (4547, 'SC', '42', '13203', 'Pomerode');
INSERT INTO mun VALUES (3749, 'SP', '35', '40002', 'Pompeia');
INSERT INTO mun VALUES (2883, 'MG', '31', '52006', 'Pompeu');
INSERT INTO mun VALUES (3750, 'SP', '35', '40101', 'Pongai');
INSERT INTO mun VALUES (268, 'PA', '15', '05700', 'Ponta De Pedras');
INSERT INTO mun VALUES (4223, 'PR', '41', '19905', 'Ponta Grossa');
INSERT INTO mun VALUES (3751, 'SP', '35', '40200', 'Pontal');
INSERT INTO mun VALUES (5308, 'MT', '51', '06653', 'Pontal Do Araguaia');
INSERT INTO mun VALUES (4224, 'PR', '41', '19954', 'Pontal Do Parana');
INSERT INTO mun VALUES (11360, 'SP', '35', 'TR067', 'Pontal do Paranapanema SP');
INSERT INTO mun VALUES (5546, 'GO', '52', '17708', 'Pontalina');
INSERT INTO mun VALUES (3752, 'SP', '35', '40259', 'Pontalinda');
INSERT INTO mun VALUES (5200, 'MS', '50', '06606', 'Ponta Porã');
INSERT INTO mun VALUES (4548, 'SC', '42', '13302', 'Ponte Alta');
INSERT INTO mun VALUES (1170, 'RN', '24', '06205', 'Lagoa D''anta');
INSERT INTO mun VALUES (436, 'TO', '17', '17800', 'Ponte Alta Do Bom Jesus');
INSERT INTO mun VALUES (4549, 'SC', '42', '13351', 'Ponte Alta Do Norte');
INSERT INTO mun VALUES (437, 'TO', '17', '17909', 'Ponte Alta Do Tocantins');
INSERT INTO mun VALUES (5309, 'MT', '51', '06703', 'Ponte Branca');
INSERT INTO mun VALUES (2884, 'MG', '31', '52105', 'Ponte Nova');
INSERT INTO mun VALUES (4966, 'RS', '43', '14787', 'Ponte Preta');
INSERT INTO mun VALUES (5310, 'MT', '51', '06752', 'Pontes E Lacerda');
INSERT INTO mun VALUES (4550, 'SC', '42', '13401', 'Ponte Serrada');
INSERT INTO mun VALUES (3753, 'SP', '35', '40309', 'Pontes Gestal');
INSERT INTO mun VALUES (4965, 'RS', '43', '14779', 'Pontão');
INSERT INTO mun VALUES (5199, 'MS', '50', '06408', 'Pedro Gomes');
INSERT INTO mun VALUES (848, 'PI', '22', '07900', 'Pedro Ii');
INSERT INTO mun VALUES (849, 'PI', '22', '07934', 'Pedro Laurentino');
INSERT INTO mun VALUES (2852, 'MG', '31', '49309', 'Pedro Leopoldo');
INSERT INTO mun VALUES (4951, 'RS', '43', '14209', 'Pedro Osorio');
INSERT INTO mun VALUES (1427, 'PB', '25', '12721', 'Pedro Regis');
INSERT INTO mun VALUES (2853, 'MG', '31', '49408', 'Pedro Teixeira');
INSERT INTO mun VALUES (1208, 'RN', '24', '09803', 'Pedro Velho');
INSERT INTO mun VALUES (430, 'TO', '17', '16604', 'Peixe');
INSERT INTO mun VALUES (265, 'PA', '15', '05601', 'Peixe-boi');
INSERT INTO mun VALUES (5305, 'MT', '51', '06422', 'Peixoto De Azevedo');
INSERT INTO mun VALUES (4952, 'RS', '43', '14308', 'Pejuçara');
INSERT INTO mun VALUES (4953, 'RS', '43', '14407', 'Pelotas');
INSERT INTO mun VALUES (1054, 'CE', '23', '10605', 'Penaforte');
INSERT INTO mun VALUES (615, 'MA', '21', '08306', 'Penalva');
INSERT INTO mun VALUES (3723, 'SP', '35', '37305', 'Penapolis');
INSERT INTO mun VALUES (1209, 'RN', '24', '09902', 'Pendencias');
INSERT INTO mun VALUES (1752, 'AL', '27', '06703', 'Penedo');
INSERT INTO mun VALUES (4539, 'SC', '42', '12502', 'Penha');
INSERT INTO mun VALUES (1055, 'CE', '23', '10704', 'Pentecoste');
INSERT INTO mun VALUES (2854, 'MG', '31', '49507', 'Pequeri');
INSERT INTO mun VALUES (2855, 'MG', '31', '49606', 'Pequi');
INSERT INTO mun VALUES (431, 'TO', '17', '16653', 'Pequizeiro');
INSERT INTO mun VALUES (2858, 'MG', '31', '49903', 'Perdões');
INSERT INTO mun VALUES (2856, 'MG', '31', '49705', 'Perdigão');
INSERT INTO mun VALUES (2857, 'MG', '31', '49804', 'Perdizes');
INSERT INTO mun VALUES (3724, 'SP', '35', '37404', 'Pereira Barreto');
INSERT INTO mun VALUES (3725, 'SP', '35', '37503', 'Pereiras');
INSERT INTO mun VALUES (1056, 'CE', '23', '10803', 'Pereiro');
INSERT INTO mun VALUES (616, 'MA', '21', '08405', 'Peri Mirim');
INSERT INTO mun VALUES (2859, 'MG', '31', '49952', 'Periquito');
INSERT INTO mun VALUES (4540, 'SC', '42', '12601', 'Peritiba');
INSERT INTO mun VALUES (617, 'MA', '21', '08454', 'Peritoro');
INSERT INTO mun VALUES (1493, 'PE', '26', '00000', 'Pernambuco');
INSERT INTO mun VALUES (4209, 'PR', '41', '18857', 'Perobal');
INSERT INTO mun VALUES (4210, 'PR', '41', '18907', 'Perola');
INSERT INTO mun VALUES (5538, 'GO', '52', '16452', 'Perolandia');
INSERT INTO mun VALUES (3726, 'SP', '35', '37602', 'Peruibe');
INSERT INTO mun VALUES (2860, 'MG', '31', '50000', 'Pescador');
INSERT INTO mun VALUES (1617, 'PE', '26', '10905', 'Pesqueira');
INSERT INTO mun VALUES (1618, 'PE', '26', '11002', 'Petrolandia');
INSERT INTO mun VALUES (4541, 'SC', '42', '12700', 'Petrolandia');
INSERT INTO mun VALUES (1619, 'PE', '26', '11101', 'Petrolina');
INSERT INTO mun VALUES (5539, 'GO', '52', '16809', 'Petrolina De Goias');
INSERT INTO mun VALUES (3264, 'RJ', '33', '03906', 'Petropolis');
INSERT INTO mun VALUES (1753, 'AL', '27', '06802', 'Piaçabuçu');
INSERT INTO mun VALUES (3727, 'SP', '35', '37701', 'Piacatu');
INSERT INTO mun VALUES (1410, 'PB', '25', '11301', 'Pianco');
INSERT INTO mun VALUES (266, 'PA', '15', '05635', 'Piçarra');
INSERT INTO mun VALUES (4542, 'SC', '42', '12809', 'Piçarras');
INSERT INTO mun VALUES (2156, 'BA', '29', '24306', 'Piatã');
INSERT INTO mun VALUES (2861, 'MG', '31', '50109', 'Piau');
INSERT INTO mun VALUES (693, 'PI', '22', '00000', 'Piauí');
INSERT INTO mun VALUES (4954, 'RS', '43', '14423', 'Picada Cafe');
INSERT INTO mun VALUES (851, 'PI', '22', '08007', 'Picos');
INSERT INTO mun VALUES (1411, 'PB', '25', '11400', 'Picui');
INSERT INTO mun VALUES (3728, 'SP', '35', '37800', 'Piedade');
INSERT INTO mun VALUES (2862, 'MG', '31', '50158', 'Piedade De Caratinga');
INSERT INTO mun VALUES (2863, 'MG', '31', '50208', 'Piedade De Ponte Nova');
INSERT INTO mun VALUES (2864, 'MG', '31', '50307', 'Piedade Do Rio Grande');
INSERT INTO mun VALUES (2865, 'MG', '31', '50406', 'Piedade Dos Gerais');
INSERT INTO mun VALUES (4212, 'PR', '41', '19103', 'Pien');
INSERT INTO mun VALUES (1754, 'AL', '27', '06901', 'Pilar');
INSERT INTO mun VALUES (1412, 'PB', '25', '11509', 'Pilar');
INSERT INTO mun VALUES (5540, 'GO', '52', '16908', 'Pilar De Goias');
INSERT INTO mun VALUES (3729, 'SP', '35', '37909', 'Pilar Do Sul');
INSERT INTO mun VALUES (1210, 'RN', '24', '10009', 'Pilões');
INSERT INTO mun VALUES (1413, 'PB', '25', '11608', 'Pilões');
INSERT INTO mun VALUES (1414, 'PB', '25', '11707', 'Pilõezinhos');
INSERT INTO mun VALUES (2157, 'BA', '29', '24405', 'Pilão Arcado');
INSERT INTO mun VALUES (2866, 'MG', '31', '50505', 'Pimenta');
INSERT INTO mun VALUES (35, 'RO', '11', '00189', 'Pimenta Bueno');
INSERT INTO mun VALUES (852, 'PI', '22', '08106', 'Pimenteiras');
INSERT INTO mun VALUES (62, 'RO', '11', '01468', 'Pimenteiras Do Oeste');
INSERT INTO mun VALUES (2158, 'BA', '29', '24504', 'Pindai');
INSERT INTO mun VALUES (3730, 'SP', '35', '38006', 'Pindamonhangaba');
INSERT INTO mun VALUES (618, 'MA', '21', '08504', 'Pindare-mirim');
INSERT INTO mun VALUES (1755, 'AL', '27', '07008', 'Pindoba');
INSERT INTO mun VALUES (2159, 'BA', '29', '24603', 'Pindobaçu');
INSERT INTO mun VALUES (3731, 'SP', '35', '38105', 'Pindorama');
INSERT INTO mun VALUES (433, 'TO', '17', '17008', 'Pindorama Do Tocantins');
INSERT INTO mun VALUES (1057, 'CE', '23', '10852', 'Pindoretama');
INSERT INTO mun VALUES (4213, 'PR', '41', '19152', 'Pinhais');
INSERT INTO mun VALUES (4955, 'RS', '43', '14456', 'Pinhal');
INSERT INTO mun VALUES (4956, 'RS', '43', '14464', 'Pinhal Da Serra');
INSERT INTO mun VALUES (4215, 'PR', '41', '19251', 'Pinhal De São Bento');
INSERT INTO mun VALUES (4957, 'RS', '43', '14472', 'Pinhal Grande');
INSERT INTO mun VALUES (4214, 'PR', '41', '19202', 'Pinhalão');
INSERT INTO mun VALUES (3732, 'SP', '35', '38204', 'Pinhalzinho');
INSERT INTO mun VALUES (4543, 'SC', '42', '12908', 'Pinhalzinho');
INSERT INTO mun VALUES (3265, 'RJ', '33', '03955', 'Pinheiral');
INSERT INTO mun VALUES (4958, 'RS', '43', '14498', 'Pinheirinho Do Vale');
INSERT INTO mun VALUES (619, 'MA', '21', '08603', 'Pinheiro');
INSERT INTO mun VALUES (4959, 'RS', '43', '14506', 'Pinheiro Machado');
INSERT INTO mun VALUES (4544, 'SC', '42', '13005', 'Pinheiro Preto');
INSERT INTO mun VALUES (3186, 'ES', '32', '04104', 'Pinheiros');
INSERT INTO mun VALUES (1833, 'SE', '28', '05208', 'Pinhão');
INSERT INTO mun VALUES (4216, 'PR', '41', '19301', 'Pinhão');
INSERT INTO mun VALUES (2160, 'BA', '29', '24652', 'Pintadas');
INSERT INTO mun VALUES (4960, 'RS', '43', '14530', 'Pinto Bandeira');
INSERT INTO mun VALUES (2868, 'MG', '31', '50570', 'Pintopolis');
INSERT INTO mun VALUES (1749, 'AL', '27', '06448', 'Paripueira');
INSERT INTO mun VALUES (3709, 'SP', '35', '36208', 'Pariquera-açu');
INSERT INTO mun VALUES (3710, 'SP', '35', '36257', 'Parisi');
INSERT INTO mun VALUES (841, 'PI', '22', '07603', 'Parnagua');
INSERT INTO mun VALUES (842, 'PI', '22', '07702', 'Parnaiba');
INSERT INTO mun VALUES (1612, 'PE', '26', '10400', 'Parnamirim');
INSERT INTO mun VALUES (1137, 'RN', '24', '03251', 'Parnamirim');
INSERT INTO mun VALUES (608, 'MA', '21', '07803', 'Parnarama');
INSERT INTO mun VALUES (4944, 'RS', '43', '14050', 'Parobe');
INSERT INTO mun VALUES (2831, 'MG', '31', '47501', 'Passabem');
INSERT INTO mun VALUES (1200, 'RN', '24', '09100', 'Passa E Fica');
INSERT INTO mun VALUES (1201, 'RN', '24', '09209', 'Passagem');
INSERT INTO mun VALUES (1404, 'PB', '25', '10709', 'Passagem');
INSERT INTO mun VALUES (609, 'MA', '21', '07902', 'Passagem Franca');
INSERT INTO mun VALUES (843, 'PI', '22', '07751', 'Passagem Franca Do Piaui');
INSERT INTO mun VALUES (2832, 'MG', '31', '47600', 'Passa Quatro');
INSERT INTO mun VALUES (4945, 'RS', '43', '14068', 'Passa Sete');
INSERT INTO mun VALUES (2833, 'MG', '31', '47709', 'Passa Tempo');
INSERT INTO mun VALUES (2834, 'MG', '31', '47808', 'Passa-vinte');
INSERT INTO mun VALUES (1613, 'PE', '26', '10509', 'Passira');
INSERT INTO mun VALUES (1750, 'AL', '27', '06505', 'Passo De Camaragibe');
INSERT INTO mun VALUES (4535, 'SC', '42', '12254', 'Passo De Torres');
INSERT INTO mun VALUES (4946, 'RS', '43', '14076', 'Passo Do Sobrado');
INSERT INTO mun VALUES (4947, 'RS', '43', '14100', 'Passo Fundo');
INSERT INTO mun VALUES (2835, 'MG', '31', '47907', 'Passos');
INSERT INTO mun VALUES (4536, 'SC', '42', '12270', 'Passos Maia');
INSERT INTO mun VALUES (610, 'MA', '21', '08009', 'Pastos Bons');
INSERT INTO mun VALUES (2836, 'MG', '31', '47956', 'Patis');
INSERT INTO mun VALUES (4204, 'PR', '41', '18451', 'Pato Bragado');
INSERT INTO mun VALUES (4205, 'PR', '41', '18501', 'Pato Branco');
INSERT INTO mun VALUES (1405, 'PB', '25', '10808', 'Patos');
INSERT INTO mun VALUES (2837, 'MG', '31', '48004', 'Patos De Minas');
INSERT INTO mun VALUES (844, 'PI', '22', '07777', 'Patos Do Piaui');
INSERT INTO mun VALUES (2838, 'MG', '31', '48103', 'Patrocinio');
INSERT INTO mun VALUES (2839, 'MG', '31', '48202', 'Patrocinio Do Muriae');
INSERT INTO mun VALUES (3711, 'SP', '35', '36307', 'Patrocinio Paulista');
INSERT INTO mun VALUES (1202, 'RN', '24', '09308', 'Patu');
INSERT INTO mun VALUES (3263, 'RJ', '33', '03856', 'Paty Do Alferes');
INSERT INTO mun VALUES (2151, 'BA', '29', '23902', 'Pau Brasil');
INSERT INTO mun VALUES (1614, 'PE', '26', '10608', 'Paudalho');
INSERT INTO mun VALUES (1204, 'RN', '24', '09407', 'Pau Dos Ferros');
INSERT INTO mun VALUES (142, 'AM', '13', '03502', 'Pauini');
INSERT INTO mun VALUES (2840, 'MG', '31', '48301', 'Paula Candido');
INSERT INTO mun VALUES (4206, 'PR', '41', '18600', 'Paula Freitas');
INSERT INTO mun VALUES (3712, 'SP', '35', '36406', 'Pauliceia');
INSERT INTO mun VALUES (3713, 'SP', '35', '36505', 'Paulinia');
INSERT INTO mun VALUES (611, 'MA', '21', '08058', 'Paulino Neves');
INSERT INTO mun VALUES (1406, 'PB', '25', '10907', 'Paulista');
INSERT INTO mun VALUES (1615, 'PE', '26', '10707', 'Paulista');
INSERT INTO mun VALUES (846, 'PI', '22', '07801', 'Paulistana');
INSERT INTO mun VALUES (3714, 'SP', '35', '36570', 'Paulistania');
INSERT INTO mun VALUES (2841, 'MG', '31', '48400', 'Paulistas');
INSERT INTO mun VALUES (2152, 'BA', '29', '24009', 'Paulo Afonso');
INSERT INTO mun VALUES (4948, 'RS', '43', '14134', 'Paulo Bento');
INSERT INTO mun VALUES (3715, 'SP', '35', '36604', 'Paulo De Faria');
INSERT INTO mun VALUES (4207, 'PR', '41', '18709', 'Paulo Frontin');
INSERT INTO mun VALUES (1751, 'AL', '27', '06604', 'Paulo Jacinto');
INSERT INTO mun VALUES (4537, 'SC', '42', '12304', 'Paulo Lopes');
INSERT INTO mun VALUES (612, 'MA', '21', '08108', 'Paulo Ramos');
INSERT INTO mun VALUES (4949, 'RS', '43', '14159', 'Paverama');
INSERT INTO mun VALUES (2842, 'MG', '31', '48509', 'Pavão');
INSERT INTO mun VALUES (847, 'PI', '22', '07850', 'Pavussu');
INSERT INTO mun VALUES (4208, 'PR', '41', '18808', 'Peabiru');
INSERT INTO mun VALUES (2843, 'MG', '31', '48608', 'Peçanha');
INSERT INTO mun VALUES (3716, 'SP', '35', '36703', 'Pederneiras');
INSERT INTO mun VALUES (2153, 'BA', '29', '24058', 'Pe De Serra');
INSERT INTO mun VALUES (1616, 'PE', '26', '10806', 'Pedra');
INSERT INTO mun VALUES (2844, 'MG', '31', '48707', 'Pedra Azul');
INSERT INTO mun VALUES (3717, 'SP', '35', '36802', 'Pedra Bela');
INSERT INTO mun VALUES (2845, 'MG', '31', '48756', 'Pedra Bonita');
INSERT INTO mun VALUES (1407, 'PB', '25', '11004', 'Pedra Branca');
INSERT INTO mun VALUES (1053, 'CE', '23', '10506', 'Pedra Branca');
INSERT INTO mun VALUES (321, 'AP', '16', '00154', 'Pedra Branca Do Amapari');
INSERT INTO mun VALUES (2846, 'MG', '31', '48806', 'Pedra Do Anta');
INSERT INTO mun VALUES (2847, 'MG', '31', '48905', 'Pedra Do Indaia');
INSERT INTO mun VALUES (2848, 'MG', '31', '49002', 'Pedra Dourada');
INSERT INTO mun VALUES (1205, 'RN', '24', '09506', 'Pedra Grande');
INSERT INTO mun VALUES (1408, 'PB', '25', '11103', 'Pedra Lavrada');
INSERT INTO mun VALUES (2849, 'MG', '31', '49101', 'Pedralva');
INSERT INTO mun VALUES (1831, 'SE', '28', '05000', 'Pedra Mole');
INSERT INTO mun VALUES (3718, 'SP', '35', '36901', 'Pedranopolis');
INSERT INTO mun VALUES (5304, 'MT', '51', '06372', 'Pedra Preta');
INSERT INTO mun VALUES (1206, 'RN', '24', '09605', 'Pedra Preta');
INSERT INTO mun VALUES (4950, 'RS', '43', '14175', 'Pedras Altas');
INSERT INTO mun VALUES (1409, 'PB', '25', '11202', 'Pedras De Fogo');
INSERT INTO mun VALUES (2850, 'MG', '31', '49150', 'Pedras De Maria Da Cruz');
INSERT INTO mun VALUES (4538, 'SC', '42', '12403', 'Pedras Grandes');
INSERT INTO mun VALUES (3719, 'SP', '35', '37008', 'Pedregulho');
INSERT INTO mun VALUES (3720, 'SP', '35', '37107', 'Pedreira');
INSERT INTO mun VALUES (613, 'MA', '21', '08207', 'Pedreiras');
INSERT INTO mun VALUES (1832, 'SE', '28', '05109', 'Pedrinhas');
INSERT INTO mun VALUES (3721, 'SP', '35', '37156', 'Pedrinhas Paulista');
INSERT INTO mun VALUES (2851, 'MG', '31', '49200', 'Pedrinopolis');
INSERT INTO mun VALUES (2154, 'BA', '29', '24108', 'Pedrão');
INSERT INTO mun VALUES (429, 'TO', '17', '16505', 'Pedro Afonso');
INSERT INTO mun VALUES (2155, 'BA', '29', '24207', 'Pedro Alexandre');
INSERT INTO mun VALUES (1207, 'RN', '24', '09704', 'Pedro Avelino');
INSERT INTO mun VALUES (3185, 'ES', '32', '04054', 'Pedro Canario');
INSERT INTO mun VALUES (3722, 'SP', '35', '37206', 'Pedro De Toledo');
INSERT INTO mun VALUES (614, 'MA', '21', '08256', 'Pedro Do Rosario');
INSERT INTO mun VALUES (3697, 'SP', '35', '35002', 'Palestina');
INSERT INTO mun VALUES (1745, 'AL', '27', '06208', 'Palestina');
INSERT INTO mun VALUES (5531, 'GO', '52', '15652', 'Palestina De Goias');
INSERT INTO mun VALUES (261, 'PA', '15', '05494', 'Palestina Do Para');
INSERT INTO mun VALUES (1047, 'CE', '23', '10001', 'Palhano');
INSERT INTO mun VALUES (4529, 'SC', '42', '11900', 'Palhoça');
INSERT INTO mun VALUES (2823, 'MG', '31', '46701', 'Palma');
INSERT INTO mun VALUES (1048, 'CE', '23', '10100', 'Palmacia');
INSERT INTO mun VALUES (1608, 'PE', '26', '10004', 'Palmares');
INSERT INTO mun VALUES (4936, 'RS', '43', '13656', 'Palmares Do Sul');
INSERT INTO mun VALUES (3698, 'SP', '35', '35101', 'Palmares Paulista');
INSERT INTO mun VALUES (468, 'TO', '17', '21000', 'Palmas');
INSERT INTO mun VALUES (4195, 'PR', '41', '17602', 'Palmas');
INSERT INTO mun VALUES (2146, 'BA', '29', '23407', 'Palmas De Monte Alto');
INSERT INTO mun VALUES (4530, 'SC', '42', '12007', 'Palma Sola');
INSERT INTO mun VALUES (4196, 'PR', '41', '17701', 'Palmeira');
INSERT INTO mun VALUES (4531, 'SC', '42', '12056', 'Palmeira');
INSERT INTO mun VALUES (4937, 'RS', '43', '13706', 'Palmeira Das Missões');
INSERT INTO mun VALUES (838, 'PI', '22', '07405', 'Palmeira Do Piaui');
INSERT INTO mun VALUES (1746, 'AL', '27', '06307', 'Palmeira Dos Indios');
INSERT INTO mun VALUES (839, 'PI', '22', '07504', 'Palmeirais');
INSERT INTO mun VALUES (606, 'MA', '21', '07605', 'Palmeirandia');
INSERT INTO mun VALUES (424, 'TO', '17', '15705', 'Palmeirante');
INSERT INTO mun VALUES (2147, 'BA', '29', '23506', 'Palmeiras');
INSERT INTO mun VALUES (5532, 'GO', '52', '15702', 'Palmeiras De Goias');
INSERT INTO mun VALUES (414, 'TO', '17', '13809', 'Palmeiras Do Tocantins');
INSERT INTO mun VALUES (1609, 'PE', '26', '10103', 'Palmeirina');
INSERT INTO mun VALUES (425, 'TO', '17', '15754', 'Palmeiropolis');
INSERT INTO mun VALUES (5533, 'GO', '52', '15801', 'Palmelo');
INSERT INTO mun VALUES (5534, 'GO', '52', '15900', 'Palminopolis');
INSERT INTO mun VALUES (3700, 'SP', '35', '35309', 'Palmital');
INSERT INTO mun VALUES (4197, 'PR', '41', '17800', 'Palmital');
INSERT INTO mun VALUES (4938, 'RS', '43', '13805', 'Palmitinho');
INSERT INTO mun VALUES (4532, 'SC', '42', '12106', 'Palmitos');
INSERT INTO mun VALUES (2824, 'MG', '31', '46750', 'Palmopolis');
INSERT INTO mun VALUES (4198, 'PR', '41', '17909', 'Palotina');
INSERT INTO mun VALUES (5535, 'GO', '52', '16007', 'Panama');
INSERT INTO mun VALUES (4939, 'RS', '43', '13904', 'Panambi');
INSERT INTO mun VALUES (3184, 'ES', '32', '04005', 'Pancas');
INSERT INTO mun VALUES (1610, 'PE', '26', '10202', 'Panelas');
INSERT INTO mun VALUES (3701, 'SP', '35', '35408', 'Panorama');
INSERT INTO mun VALUES (4940, 'RS', '43', '13953', 'Pantano Grande');
INSERT INTO mun VALUES (605, 'MA', '21', '07506', 'Paço Do Lumiar');
INSERT INTO mun VALUES (2825, 'MG', '31', '46909', 'Papagaios');
INSERT INTO mun VALUES (4533, 'SC', '42', '12205', 'Papanduva');
INSERT INTO mun VALUES (840, 'PI', '22', '07553', 'Paqueta');
INSERT INTO mun VALUES (174, 'PA', '15', '00000', 'Pará');
INSERT INTO mun VALUES (1269, 'PB', '25', '00000', 'Paraíba');
INSERT INTO mun VALUES (3260, 'RJ', '33', '03609', 'Paracambi');
INSERT INTO mun VALUES (2826, 'MG', '31', '47006', 'Paracatu');
INSERT INTO mun VALUES (1049, 'CE', '23', '10209', 'Paracuru');
INSERT INTO mun VALUES (2827, 'MG', '31', '47105', 'Para De Minas');
INSERT INTO mun VALUES (262, 'PA', '15', '05502', 'Paragominas');
INSERT INTO mun VALUES (2828, 'MG', '31', '47204', 'Paraguaçu');
INSERT INTO mun VALUES (3702, 'SP', '35', '35507', 'Paraguaçu Paulista');
INSERT INTO mun VALUES (4941, 'RS', '43', '14001', 'Parai');
INSERT INTO mun VALUES (3261, 'RJ', '33', '03708', 'Paraiba Do Sul');
INSERT INTO mun VALUES (607, 'MA', '21', '07704', 'Paraibano');
INSERT INTO mun VALUES (3703, 'SP', '35', '35606', 'Paraibuna');
INSERT INTO mun VALUES (1050, 'CE', '23', '10258', 'Paraipaba');
INSERT INTO mun VALUES (3704, 'SP', '35', '35705', 'Paraiso');
INSERT INTO mun VALUES (4534, 'SC', '42', '12239', 'Paraiso');
INSERT INTO mun VALUES (4199, 'PR', '41', '18006', 'Paraiso Do Norte');
INSERT INTO mun VALUES (4942, 'RS', '43', '14027', 'Paraiso Do Sul');
INSERT INTO mun VALUES (426, 'TO', '17', '16109', 'Paraiso Do Tocantins');
INSERT INTO mun VALUES (2829, 'MG', '31', '47303', 'Paraisopolis');
INSERT INTO mun VALUES (1051, 'CE', '23', '10308', 'Parambu');
INSERT INTO mun VALUES (2148, 'BA', '29', '23605', 'Paramirim');
INSERT INTO mun VALUES (1052, 'CE', '23', '10407', 'Paramoti');
INSERT INTO mun VALUES (427, 'TO', '17', '16208', 'Paranã');
INSERT INTO mun VALUES (3948, 'PR', '41', '00000', 'Paraná');
INSERT INTO mun VALUES (1195, 'RN', '24', '08607', 'Parana');
INSERT INTO mun VALUES (4200, 'PR', '41', '18105', 'Paranacity');
INSERT INTO mun VALUES (4201, 'PR', '41', '18204', 'Paranagua');
INSERT INTO mun VALUES (5197, 'MS', '50', '06309', 'Paranaiba');
INSERT INTO mun VALUES (5536, 'GO', '52', '16304', 'Paranaiguara');
INSERT INTO mun VALUES (5301, 'MT', '51', '06299', 'Paranaita');
INSERT INTO mun VALUES (3705, 'SP', '35', '35804', 'Paranapanema');
INSERT INTO mun VALUES (4202, 'PR', '41', '18303', 'Paranapoema');
INSERT INTO mun VALUES (3706, 'SP', '35', '35903', 'Paranapuã');
INSERT INTO mun VALUES (1611, 'PE', '26', '10301', 'Paranatama');
INSERT INTO mun VALUES (5302, 'MT', '51', '06307', 'Paranatinga');
INSERT INTO mun VALUES (4203, 'PR', '41', '18402', 'Paranavai');
INSERT INTO mun VALUES (11356, 'PR', '41', 'TR063', 'Paraná Centro PR');
INSERT INTO mun VALUES (5198, 'MS', '50', '06358', 'Paranhos');
INSERT INTO mun VALUES (2830, 'MG', '31', '47402', 'Paraopeba');
INSERT INTO mun VALUES (3707, 'SP', '35', '36000', 'Parapuã');
INSERT INTO mun VALUES (1403, 'PB', '25', '10659', 'Parari');
INSERT INTO mun VALUES (3262, 'RJ', '33', '03807', 'Parati');
INSERT INTO mun VALUES (2149, 'BA', '29', '23704', 'Paratinga');
INSERT INTO mun VALUES (1196, 'RN', '24', '08706', 'Parau');
INSERT INTO mun VALUES (263, 'PA', '15', '05536', 'Parauapebas');
INSERT INTO mun VALUES (5537, 'GO', '52', '16403', 'Parauna');
INSERT INTO mun VALUES (1197, 'RN', '24', '08805', 'Parazinho');
INSERT INTO mun VALUES (3708, 'SP', '35', '36109', 'Pardinho');
INSERT INTO mun VALUES (4943, 'RS', '43', '14035', 'Pareci Novo');
INSERT INTO mun VALUES (61, 'RO', '11', '01450', 'Parecis');
INSERT INTO mun VALUES (1198, 'RN', '24', '08904', 'Parelhas');
INSERT INTO mun VALUES (1748, 'AL', '27', '06422', 'Pariconha');
INSERT INTO mun VALUES (141, 'AM', '13', '03403', 'Parintins');
INSERT INTO mun VALUES (2150, 'BA', '29', '23803', 'Paripiranga');
INSERT INTO mun VALUES (4930, 'RS', '43', '13425', 'Novo Machado');
INSERT INTO mun VALUES (5298, 'MT', '51', '06265', 'Novo Mundo');
INSERT INTO mun VALUES (1040, 'CE', '23', '09409', 'Novo Oriente');
INSERT INTO mun VALUES (2803, 'MG', '31', '45356', 'Novo Oriente De Minas');
INSERT INTO mun VALUES (831, 'PI', '22', '06902', 'Novo Oriente Do Piaui');
INSERT INTO mun VALUES (5526, 'GO', '52', '15256', 'Novo Planalto');
INSERT INTO mun VALUES (253, 'PA', '15', '05031', 'Novo Progresso');
INSERT INTO mun VALUES (254, 'PA', '15', '05064', 'Novo Repartimento');
INSERT INTO mun VALUES (2867, 'MG', '31', '50539', 'Pingo-d''agua');
INSERT INTO mun VALUES (2804, 'MG', '31', '45372', 'Novorizonte');
INSERT INTO mun VALUES (5303, 'MT', '51', '06315', 'Novo Santo Antonio');
INSERT INTO mun VALUES (832, 'PI', '22', '06951', 'Novo Santo Antonio');
INSERT INTO mun VALUES (5300, 'MT', '51', '06281', 'Novo São Joaquim');
INSERT INTO mun VALUES (4931, 'RS', '43', '13441', 'Novo Tiradentes');
INSERT INTO mun VALUES (2141, 'BA', '29', '23050', 'Novo Triunfo');
INSERT INTO mun VALUES (4932, 'RS', '43', '13466', 'Novo Xingu');
INSERT INTO mun VALUES (3682, 'SP', '35', '33601', 'Nuporanga');
INSERT INTO mun VALUES (255, 'PA', '15', '05106', 'Obidos');
INSERT INTO mun VALUES (1041, 'CE', '23', '09458', 'Ocara');
INSERT INTO mun VALUES (3683, 'SP', '35', '33700', 'Ocauçu');
INSERT INTO mun VALUES (833, 'PI', '22', '07009', 'Oeiras');
INSERT INTO mun VALUES (256, 'PA', '15', '05205', 'Oeiras Do Para');
INSERT INTO mun VALUES (11354, 'GO', '52', 'TR061', 'Oeste Rio Vermelho GO');
INSERT INTO mun VALUES (11355, 'SC', '42', 'TR062', 'Oeste SC');
INSERT INTO mun VALUES (329, 'AP', '16', '00501', 'Oiapoque');
INSERT INTO mun VALUES (2805, 'MG', '31', '45406', 'Olaria');
INSERT INTO mun VALUES (3684, 'SP', '35', '33809', 'Oleo');
INSERT INTO mun VALUES (3685, 'SP', '35', '33908', 'Olimpia');
INSERT INTO mun VALUES (2807, 'MG', '31', '45505', 'Olimpio Noronha');
INSERT INTO mun VALUES (1604, 'PE', '26', '09600', 'Olinda');
INSERT INTO mun VALUES (604, 'MA', '21', '07456', 'Olinda Nova Do Maranhão');
INSERT INTO mun VALUES (2142, 'BA', '29', '23100', 'Olindina');
INSERT INTO mun VALUES (1401, 'PB', '25', '10501', 'Olivedos');
INSERT INTO mun VALUES (2808, 'MG', '31', '45604', 'Oliveira');
INSERT INTO mun VALUES (423, 'TO', '17', '15507', 'Oliveira De Fatima');
INSERT INTO mun VALUES (2143, 'BA', '29', '23209', 'Oliveira Dos Brejinhos');
INSERT INTO mun VALUES (2809, 'MG', '31', '45703', 'Oliveira Fortes');
INSERT INTO mun VALUES (1743, 'AL', '27', '06000', 'Olivença');
INSERT INTO mun VALUES (2810, 'MG', '31', '45802', 'Onça De Pitangui');
INSERT INTO mun VALUES (3686, 'SP', '35', '34005', 'Onda Verde');
INSERT INTO mun VALUES (2811, 'MG', '31', '45851', 'Oratorios');
INSERT INTO mun VALUES (3687, 'SP', '35', '34104', 'Oriente');
INSERT INTO mun VALUES (3688, 'SP', '35', '34203', 'Orindiuva');
INSERT INTO mun VALUES (257, 'PA', '15', '05304', 'Oriximina');
INSERT INTO mun VALUES (2812, 'MG', '31', '45877', 'Orizania');
INSERT INTO mun VALUES (5527, 'GO', '52', '15306', 'Orizona');
INSERT INTO mun VALUES (3689, 'SP', '35', '34302', 'Orlandia');
INSERT INTO mun VALUES (4523, 'SC', '42', '11702', 'Orleans');
INSERT INTO mun VALUES (1605, 'PE', '26', '09709', 'Orobo');
INSERT INTO mun VALUES (1606, 'PE', '26', '09808', 'Oroco');
INSERT INTO mun VALUES (1042, 'CE', '23', '09508', 'Oros');
INSERT INTO mun VALUES (4191, 'PR', '41', '17305', 'Ortigueira');
INSERT INTO mun VALUES (3690, 'SP', '35', '34401', 'Osasco');
INSERT INTO mun VALUES (3691, 'SP', '35', '34500', 'Oscar Bressane');
INSERT INTO mun VALUES (4934, 'RS', '43', '13508', 'Osorio');
INSERT INTO mun VALUES (3692, 'SP', '35', '34609', 'Osvaldo Cruz');
INSERT INTO mun VALUES (4524, 'SC', '42', '11751', 'Otacilio Costa');
INSERT INTO mun VALUES (258, 'PA', '15', '05403', 'Ourem');
INSERT INTO mun VALUES (2144, 'BA', '29', '23308', 'Ouriçangas');
INSERT INTO mun VALUES (1607, 'PE', '26', '09907', 'Ouricuri');
INSERT INTO mun VALUES (259, 'PA', '15', '05437', 'Ourilandia Do Norte');
INSERT INTO mun VALUES (3693, 'SP', '35', '34708', 'Ourinhos');
INSERT INTO mun VALUES (4192, 'PR', '41', '17404', 'Ourizona');
INSERT INTO mun VALUES (4525, 'SC', '42', '11801', 'Ouro');
INSERT INTO mun VALUES (1194, 'RN', '24', '08508', 'Ouro Branco');
INSERT INTO mun VALUES (2813, 'MG', '31', '45901', 'Ouro Branco');
INSERT INTO mun VALUES (1744, 'AL', '27', '06109', 'Ouro Branco');
INSERT INTO mun VALUES (3694, 'SP', '35', '34757', 'Ouroeste');
INSERT INTO mun VALUES (2814, 'MG', '31', '46008', 'Ouro Fino');
INSERT INTO mun VALUES (2145, 'BA', '29', '23357', 'Ourolandia');
INSERT INTO mun VALUES (2815, 'MG', '31', '46107', 'Ouro Preto');
INSERT INTO mun VALUES (34, 'RO', '11', '00155', 'Ouro Preto Do Oeste');
INSERT INTO mun VALUES (1402, 'PB', '25', '10600', 'Ouro Velho');
INSERT INTO mun VALUES (4526, 'SC', '42', '11850', 'Ouro Verde');
INSERT INTO mun VALUES (3695, 'SP', '35', '34807', 'Ouro Verde');
INSERT INTO mun VALUES (5528, 'GO', '52', '15405', 'Ouro Verde De Goias');
INSERT INTO mun VALUES (2816, 'MG', '31', '46206', 'Ouro Verde De Minas');
INSERT INTO mun VALUES (4193, 'PR', '41', '17453', 'Ouro Verde Do Oeste');
INSERT INTO mun VALUES (5529, 'GO', '52', '15504', 'Ouvidor');
INSERT INTO mun VALUES (3696, 'SP', '35', '34906', 'Pacaembu');
INSERT INTO mun VALUES (260, 'PA', '15', '05486', 'Pacaja');
INSERT INTO mun VALUES (1043, 'CE', '23', '09607', 'Pacajus');
INSERT INTO mun VALUES (5574, 'GO', '52', '20009', 'SÃo JoÃo D''alianÇa');
INSERT INTO mun VALUES (169, 'RR', '14', '00456', 'Pacaraima');
INSERT INTO mun VALUES (1830, 'SE', '28', '04904', 'Pacatuba');
INSERT INTO mun VALUES (1044, 'CE', '23', '09706', 'Pacatuba');
INSERT INTO mun VALUES (1045, 'CE', '23', '09805', 'Pacoti');
INSERT INTO mun VALUES (1046, 'CE', '23', '09904', 'Pacuja');
INSERT INTO mun VALUES (5530, 'GO', '52', '15603', 'Padre Bernardo');
INSERT INTO mun VALUES (2817, 'MG', '31', '46255', 'Padre Carvalho');
INSERT INTO mun VALUES (835, 'PI', '22', '07207', 'Padre Marcos');
INSERT INTO mun VALUES (2818, 'MG', '31', '46305', 'Padre Paraiso');
INSERT INTO mun VALUES (836, 'PI', '22', '07306', 'Paes Landim');
INSERT INTO mun VALUES (4527, 'SC', '42', '11876', 'Paial');
INSERT INTO mun VALUES (4194, 'PR', '41', '17503', 'Paiçandu');
INSERT INTO mun VALUES (4935, 'RS', '43', '13607', 'Paim Filho');
INSERT INTO mun VALUES (2819, 'MG', '31', '46404', 'Paineiras');
INSERT INTO mun VALUES (4528, 'SC', '42', '11892', 'Painel');
INSERT INTO mun VALUES (2820, 'MG', '31', '46503', 'Pains');
INSERT INTO mun VALUES (2821, 'MG', '31', '46552', 'Pai Pedro');
INSERT INTO mun VALUES (2822, 'MG', '31', '46602', 'Paiva');
INSERT INTO mun VALUES (837, 'PI', '22', '07355', 'Pajeu Do Piaui');
INSERT INTO mun VALUES (1192, 'RN', '24', '08300', 'Nova Cruz');
INSERT INTO mun VALUES (4518, 'SC', '42', '11405', 'Nova Erechim');
INSERT INTO mun VALUES (4180, 'PR', '41', '16901', 'Nova Esperança');
INSERT INTO mun VALUES (250, 'PA', '15', '04950', 'Nova Esperança Do Piria');
INSERT INTO mun VALUES (4181, 'PR', '41', '16950', 'Nova Esperança Do Sudoes');
INSERT INTO mun VALUES (4919, 'RS', '43', '13037', 'Nova Esperança Do Sul');
INSERT INTO mun VALUES (3674, 'SP', '35', '32900', 'Nova Europa');
INSERT INTO mun VALUES (2134, 'BA', '29', '22730', 'Nova Fatima');
INSERT INTO mun VALUES (4182, 'PR', '41', '17008', 'Nova Fatima');
INSERT INTO mun VALUES (1397, 'PB', '25', '10105', 'Nova Floresta');
INSERT INTO mun VALUES (3258, 'RJ', '33', '03401', 'Nova Friburgo');
INSERT INTO mun VALUES (5520, 'GO', '52', '14861', 'Nova Gloria');
INSERT INTO mun VALUES (3675, 'SP', '35', '33007', 'Nova Granada');
INSERT INTO mun VALUES (5354, 'MT', '51', '08808', 'Nova Guarita');
INSERT INTO mun VALUES (3676, 'SP', '35', '33106', 'Nova Guataporanga');
INSERT INTO mun VALUES (4920, 'RS', '43', '13060', 'Nova Hartz');
INSERT INTO mun VALUES (2135, 'BA', '29', '22755', 'Nova Ibia');
INSERT INTO mun VALUES (3259, 'RJ', '33', '03500', 'Nova Iguaçu');
INSERT INTO mun VALUES (5521, 'GO', '52', '14879', 'Nova Iguaçu De Goias');
INSERT INTO mun VALUES (3677, 'SP', '35', '33205', 'Nova Independencia');
INSERT INTO mun VALUES (601, 'MA', '21', '07308', 'Nova Iorque');
INSERT INTO mun VALUES (251, 'PA', '15', '04976', 'Nova Ipixuna');
INSERT INTO mun VALUES (3678, 'SP', '35', '33254', 'Novais');
INSERT INTO mun VALUES (4519, 'SC', '42', '11454', 'Nova Itaberaba');
INSERT INTO mun VALUES (2136, 'BA', '29', '22805', 'Nova Itarana');
INSERT INTO mun VALUES (5290, 'MT', '51', '06182', 'Nova Lacerda');
INSERT INTO mun VALUES (4183, 'PR', '41', '17057', 'Nova Laranjeiras');
INSERT INTO mun VALUES (2796, 'MG', '31', '44805', 'Nova Lima');
INSERT INTO mun VALUES (4184, 'PR', '41', '17107', 'Nova Londrina');
INSERT INTO mun VALUES (3679, 'SP', '35', '33304', 'Nova Luzitania');
INSERT INTO mun VALUES (43, 'RO', '11', '00338', 'Nova Mamore');
INSERT INTO mun VALUES (5355, 'MT', '51', '08857', 'Nova Marilandia');
INSERT INTO mun VALUES (5356, 'MT', '51', '08907', 'Nova Maringa');
INSERT INTO mun VALUES (2797, 'MG', '31', '44904', 'Nova Modica');
INSERT INTO mun VALUES (5357, 'MT', '51', '08956', 'Nova Monte Verde');
INSERT INTO mun VALUES (5294, 'MT', '51', '06224', 'Nova Mutum');
INSERT INTO mun VALUES (5289, 'MT', '51', '06174', 'Nova Nazare');
INSERT INTO mun VALUES (3680, 'SP', '35', '33403', 'Nova Odessa');
INSERT INTO mun VALUES (5295, 'MT', '51', '06232', 'Nova Olimpia');
INSERT INTO mun VALUES (4185, 'PR', '41', '17206', 'Nova Olimpia');
INSERT INTO mun VALUES (1398, 'PB', '25', '10204', 'Nova Olinda');
INSERT INTO mun VALUES (1038, 'CE', '23', '09201', 'Nova Olinda');
INSERT INTO mun VALUES (418, 'TO', '17', '14880', 'Nova Olinda');
INSERT INTO mun VALUES (602, 'MA', '21', '07357', 'Nova Olinda Do Maranhão');
INSERT INTO mun VALUES (138, 'AM', '13', '03106', 'Nova Olinda Do Norte');
INSERT INTO mun VALUES (4921, 'RS', '43', '13086', 'Nova Padua');
INSERT INTO mun VALUES (4922, 'RS', '43', '13102', 'Nova Palma');
INSERT INTO mun VALUES (1399, 'PB', '25', '10303', 'Nova Palmeira');
INSERT INTO mun VALUES (4923, 'RS', '43', '13201', 'Nova Petropolis');
INSERT INTO mun VALUES (2798, 'MG', '31', '45000', 'Nova Ponte');
INSERT INTO mun VALUES (2799, 'MG', '31', '45059', 'Nova Porteirinha');
INSERT INTO mun VALUES (4924, 'RS', '43', '13300', 'Nova Prata');
INSERT INTO mun VALUES (4188, 'PR', '41', '17255', 'Nova Prata Do Iguaçu');
INSERT INTO mun VALUES (4925, 'RS', '43', '13334', 'Nova Ramada');
INSERT INTO mun VALUES (2137, 'BA', '29', '22854', 'Nova Redenção');
INSERT INTO mun VALUES (2800, 'MG', '31', '45109', 'Nova Resende');
INSERT INTO mun VALUES (5522, 'GO', '52', '14903', 'Nova Roma');
INSERT INTO mun VALUES (4926, 'RS', '43', '13359', 'Nova Roma Do Sul');
INSERT INTO mun VALUES (419, 'TO', '17', '15002', 'Nova Rosalandia');
INSERT INTO mun VALUES (1039, 'CE', '23', '09300', 'Nova Russas');
INSERT INTO mun VALUES (4186, 'PR', '41', '17214', 'Nova Santa Barbara');
INSERT INTO mun VALUES (5291, 'MT', '51', '06190', 'Nova Santa Helena');
INSERT INTO mun VALUES (850, 'PI', '22', '07959', 'Nova Santa Rita');
INSERT INTO mun VALUES (4927, 'RS', '43', '13375', 'Nova Santa Rita');
INSERT INTO mun VALUES (4187, 'PR', '41', '17222', 'Nova Santa Rosa');
INSERT INTO mun VALUES (2801, 'MG', '31', '45208', 'Nova Serrana');
INSERT INTO mun VALUES (2138, 'BA', '29', '22904', 'Nova Soure');
INSERT INTO mun VALUES (4189, 'PR', '41', '17271', 'Nova Tebas');
INSERT INTO mun VALUES (252, 'PA', '15', '05007', 'Nova Timboteua');
INSERT INTO mun VALUES (4520, 'SC', '42', '11504', 'Nova Trento');
INSERT INTO mun VALUES (5296, 'MT', '51', '06240', 'Nova Ubiratã');
INSERT INTO mun VALUES (2694, 'MG', '31', '36603', 'Nova União');
INSERT INTO mun VALUES (60, 'RO', '11', '01435', 'Nova União');
INSERT INTO mun VALUES (3183, 'ES', '32', '03908', 'Nova Venecia');
INSERT INTO mun VALUES (4521, 'SC', '42', '11603', 'Nova Veneza');
INSERT INTO mun VALUES (5523, 'GO', '52', '15009', 'Nova Veneza');
INSERT INTO mun VALUES (2139, 'BA', '29', '23001', 'Nova Viçosa');
INSERT INTO mun VALUES (5297, 'MT', '51', '06257', 'Nova Xavantina');
INSERT INTO mun VALUES (420, 'TO', '17', '15101', 'Novo Acordo');
INSERT INTO mun VALUES (139, 'AM', '13', '03205', 'Novo Airão');
INSERT INTO mun VALUES (421, 'TO', '17', '15150', 'Novo Alegre');
INSERT INTO mun VALUES (140, 'AM', '13', '03304', 'Novo Aripuanã');
INSERT INTO mun VALUES (4933, 'RS', '43', '13490', 'Novo Barreiro');
INSERT INTO mun VALUES (5524, 'GO', '52', '15207', 'Novo Brasil');
INSERT INTO mun VALUES (4928, 'RS', '43', '13391', 'Novo Cabrais');
INSERT INTO mun VALUES (2802, 'MG', '31', '45307', 'Novo Cruzeiro');
INSERT INTO mun VALUES (5525, 'GO', '52', '15231', 'Novo Gama');
INSERT INTO mun VALUES (4929, 'RS', '43', '13409', 'Novo Hamburgo');
INSERT INTO mun VALUES (3681, 'SP', '35', '33502', 'Novo Horizonte');
INSERT INTO mun VALUES (2140, 'BA', '29', '23035', 'Novo Horizonte');
INSERT INTO mun VALUES (4522, 'SC', '42', '11652', 'Novo Horizonte');
INSERT INTO mun VALUES (5299, 'MT', '51', '06273', 'Novo Horizonte Do Norte');
INSERT INTO mun VALUES (48, 'RO', '11', '00502', 'Novo Horizonte Do Oeste');
INSERT INTO mun VALUES (5196, 'MS', '50', '06259', 'Novo Horizonte Do Sul');
INSERT INTO mun VALUES (4190, 'PR', '41', '17297', 'Novo Itacolomi');
INSERT INTO mun VALUES (422, 'TO', '17', '15259', 'Novo Jardim');
INSERT INTO mun VALUES (1739, 'AL', '27', '05606', 'Novo Lino');
INSERT INTO mun VALUES (2127, 'BA', '29', '22250', 'Muquem De São Francisco');
INSERT INTO mun VALUES (3182, 'ES', '32', '03809', 'Muqui');
INSERT INTO mun VALUES (2783, 'MG', '31', '43906', 'Muriae');
INSERT INTO mun VALUES (1823, 'SE', '28', '04300', 'Muribeca');
INSERT INTO mun VALUES (1738, 'AL', '27', '05507', 'Murici');
INSERT INTO mun VALUES (827, 'PI', '22', '06696', 'Murici Dos Portelas');
INSERT INTO mun VALUES (415, 'TO', '17', '13957', 'Muricilandia');
INSERT INTO mun VALUES (2128, 'BA', '29', '22300', 'Muritiba');
INSERT INTO mun VALUES (3662, 'SP', '35', '32108', 'Murutinga Do Sul');
INSERT INTO mun VALUES (2129, 'BA', '29', '22409', 'Mutuipe');
INSERT INTO mun VALUES (2784, 'MG', '31', '44003', 'Mutum');
INSERT INTO mun VALUES (5513, 'GO', '52', '14101', 'Mutunopolis');
INSERT INTO mun VALUES (4907, 'RS', '43', '12609', 'Muçum');
INSERT INTO mun VALUES (2785, 'MG', '31', '44102', 'Muzambinho');
INSERT INTO mun VALUES (2786, 'MG', '31', '44201', 'Nacip Raydan');
INSERT INTO mun VALUES (3663, 'SP', '35', '32157', 'Nantes');
INSERT INTO mun VALUES (2787, 'MG', '31', '44300', 'Nanuque');
INSERT INTO mun VALUES (2788, 'MG', '31', '44359', 'Naque');
INSERT INTO mun VALUES (3664, 'SP', '35', '32207', 'Narandiba');
INSERT INTO mun VALUES (1190, 'RN', '24', '08102', 'Natal');
INSERT INTO mun VALUES (2789, 'MG', '31', '44375', 'Natalandia');
INSERT INTO mun VALUES (2790, 'MG', '31', '44409', 'Natercia');
INSERT INTO mun VALUES (416, 'TO', '17', '14203', 'Natividade');
INSERT INTO mun VALUES (3255, 'RJ', '33', '03104', 'Natividade');
INSERT INTO mun VALUES (3665, 'SP', '35', '32306', 'Natividade Da Serra');
INSERT INTO mun VALUES (1395, 'PB', '25', '09909', 'Natuba');
INSERT INTO mun VALUES (4517, 'SC', '42', '11306', 'Navegantes');
INSERT INTO mun VALUES (5192, 'MS', '50', '05707', 'Navirai');
INSERT INTO mun VALUES (417, 'TO', '17', '14302', 'Nazare');
INSERT INTO mun VALUES (2130, 'BA', '29', '22508', 'Nazare');
INSERT INTO mun VALUES (1603, 'PE', '26', '09501', 'Nazare Da Mata');
INSERT INTO mun VALUES (828, 'PI', '22', '06704', 'Nazare Do Piaui');
INSERT INTO mun VALUES (2791, 'MG', '31', '44508', 'Nazareno');
INSERT INTO mun VALUES (3666, 'SP', '35', '32405', 'Nazare Paulista');
INSERT INTO mun VALUES (1396, 'PB', '25', '10006', 'Nazarezinho');
INSERT INTO mun VALUES (5514, 'GO', '52', '14408', 'Nazario');
INSERT INTO mun VALUES (1824, 'SE', '28', '04409', 'Neopolis');
INSERT INTO mun VALUES (2792, 'MG', '31', '44607', 'Nepomuceno');
INSERT INTO mun VALUES (5515, 'GO', '52', '14507', 'Neropolis');
INSERT INTO mun VALUES (3667, 'SP', '35', '32504', 'Neves Paulista');
INSERT INTO mun VALUES (137, 'AM', '13', '03007', 'Nhamunda');
INSERT INTO mun VALUES (3668, 'SP', '35', '32603', 'Nhandeara');
INSERT INTO mun VALUES (4911, 'RS', '43', '12674', 'Nicolau Vergueiro');
INSERT INTO mun VALUES (2131, 'BA', '29', '22607', 'Nilo Peçanha');
INSERT INTO mun VALUES (3256, 'RJ', '33', '03203', 'Nilopolis');
INSERT INTO mun VALUES (599, 'MA', '21', '07209', 'Nina Rodrigues');
INSERT INTO mun VALUES (2793, 'MG', '31', '44656', 'Ninheira');
INSERT INTO mun VALUES (5193, 'MS', '50', '05806', 'Nioaque');
INSERT INTO mun VALUES (3669, 'SP', '35', '32702', 'Nipoã');
INSERT INTO mun VALUES (5516, 'GO', '52', '14606', 'Niquelandia');
INSERT INTO mun VALUES (1191, 'RN', '24', '08201', 'Nisia Floresta');
INSERT INTO mun VALUES (3257, 'RJ', '33', '03302', 'Niteroi');
INSERT INTO mun VALUES (5285, 'MT', '51', '05903', 'Nobres');
INSERT INTO mun VALUES (4910, 'RS', '43', '12658', 'Não-me-toque');
INSERT INTO mun VALUES (4912, 'RS', '43', '12708', 'Nonoai');
INSERT INTO mun VALUES (11350, 'PA', '15', 'TR057', 'Nordeste Paraense  PA');
INSERT INTO mun VALUES (2132, 'BA', '29', '22656', 'Nordestina');
INSERT INTO mun VALUES (168, 'RR', '14', '00407', 'Normandia');
INSERT INTO mun VALUES (11391, 'MG', '31', 'TR098', 'Noroeste de Minas');
INSERT INTO mun VALUES (11351, 'RJ', '33', 'TR058', 'Noroeste  RJ');
INSERT INTO mun VALUES (11352, 'ES', '32', 'TR059', 'Norte ES');
INSERT INTO mun VALUES (5286, 'MT', '51', '06000', 'Nortelandia');
INSERT INTO mun VALUES (11353, 'RJ', '33', 'TR060', 'Norte RJ');
INSERT INTO mun VALUES (1825, 'SE', '28', '04458', 'Nossa Senhora Aparecida');
INSERT INTO mun VALUES (1826, 'SE', '28', '04508', 'Nossa Senhora Da Gloria');
INSERT INTO mun VALUES (1827, 'SE', '28', '04607', 'Nossa Senhora Das Dores');
INSERT INTO mun VALUES (4175, 'PR', '41', '16406', 'Nossa Senhora Das Graças');
INSERT INTO mun VALUES (1828, 'SE', '28', '04706', 'Nossa Senhora De Lourdes');
INSERT INTO mun VALUES (829, 'PI', '22', '06753', 'Nossa Senhora De Nazare');
INSERT INTO mun VALUES (5287, 'MT', '51', '06109', 'Nossa Senhora Do Livrame');
INSERT INTO mun VALUES (1829, 'SE', '28', '04805', 'Nossa Senhora Do Socorro');
INSERT INTO mun VALUES (830, 'PI', '22', '06803', 'Nossa Senhora Dos Remedi');
INSERT INTO mun VALUES (3670, 'SP', '35', '32801', 'Nova Aliança');
INSERT INTO mun VALUES (4176, 'PR', '41', '16505', 'Nova Aliança Do Ivai');
INSERT INTO mun VALUES (4913, 'RS', '43', '12757', 'Nova Alvorada');
INSERT INTO mun VALUES (5194, 'MS', '50', '06002', 'Nova Alvorada Do Sul');
INSERT INTO mun VALUES (5517, 'GO', '52', '14705', 'Nova America');
INSERT INTO mun VALUES (4177, 'PR', '41', '16604', 'Nova America Da Colina');
INSERT INTO mun VALUES (5195, 'MS', '50', '06200', 'Nova Andradina');
INSERT INTO mun VALUES (4914, 'RS', '43', '12807', 'Nova Araça');
INSERT INTO mun VALUES (5518, 'GO', '52', '14804', 'Nova Aurora');
INSERT INTO mun VALUES (4178, 'PR', '41', '16703', 'Nova Aurora');
INSERT INTO mun VALUES (5288, 'MT', '51', '06158', 'Nova Bandeirantes');
INSERT INTO mun VALUES (4915, 'RS', '43', '12906', 'Nova Bassano');
INSERT INTO mun VALUES (2794, 'MG', '31', '44672', 'Nova Belem');
INSERT INTO mun VALUES (4916, 'RS', '43', '12955', 'Nova Boa Vista');
INSERT INTO mun VALUES (5292, 'MT', '51', '06208', 'Nova Brasilandia');
INSERT INTO mun VALUES (33, 'RO', '11', '00148', 'Nova Brasilandia Doeste');
INSERT INTO mun VALUES (4917, 'RS', '43', '13003', 'Nova Brescia');
INSERT INTO mun VALUES (3671, 'SP', '35', '32827', 'Nova Campina');
INSERT INTO mun VALUES (2133, 'BA', '29', '22706', 'Nova Canaã');
INSERT INTO mun VALUES (5293, 'MT', '51', '06216', 'Nova Canaã Do Norte');
INSERT INTO mun VALUES (3672, 'SP', '35', '32843', 'Nova Canaã Paulista');
INSERT INTO mun VALUES (4918, 'RS', '43', '13011', 'Nova Candelaria');
INSERT INTO mun VALUES (4179, 'PR', '41', '16802', 'Nova Cantu');
INSERT INTO mun VALUES (3673, 'SP', '35', '32868', 'Nova Castilho');
INSERT INTO mun VALUES (600, 'MA', '21', '07258', 'Nova Colinas');
INSERT INTO mun VALUES (5519, 'GO', '52', '14838', 'Nova Crixas');
INSERT INTO mun VALUES (2767, 'MG', '31', '42502', 'Monjolos');
INSERT INTO mun VALUES (596, 'MA', '21', '06904', 'Monção');
INSERT INTO mun VALUES (822, 'PI', '22', '06407', 'Monsenhor Gil');
INSERT INTO mun VALUES (823, 'PI', '22', '06506', 'Monsenhor Hipolito');
INSERT INTO mun VALUES (2768, 'MG', '31', '42601', 'Monsenhor Paulo');
INSERT INTO mun VALUES (1032, 'CE', '23', '08609', 'Monsenhor Tabosa');
INSERT INTO mun VALUES (711, 'PI', '22', '01176', 'Barra D''alcantara');
INSERT INTO mun VALUES (1391, 'PB', '25', '09503', 'Montadas');
INSERT INTO mun VALUES (2769, 'MG', '31', '42700', 'Montalvania');
INSERT INTO mun VALUES (3179, 'ES', '32', '03502', 'Montanha');
INSERT INTO mun VALUES (1186, 'RN', '24', '07708', 'Montanhas');
INSERT INTO mun VALUES (4898, 'RS', '43', '12351', 'Montauri');
INSERT INTO mun VALUES (248, 'PA', '15', '04802', 'Monte Alegre');
INSERT INTO mun VALUES (1187, 'RN', '24', '07807', 'Monte Alegre');
INSERT INTO mun VALUES (5504, 'GO', '52', '13509', 'Monte Alegre De Goias');
INSERT INTO mun VALUES (2770, 'MG', '31', '42809', 'Monte Alegre De Minas');
INSERT INTO mun VALUES (1822, 'SE', '28', '04201', 'Monte Alegre De Sergipe');
INSERT INTO mun VALUES (824, 'PI', '22', '06605', 'Monte Alegre Do Piaui');
INSERT INTO mun VALUES (4899, 'RS', '43', '12377', 'Monte Alegre Dos Campos');
INSERT INTO mun VALUES (3652, 'SP', '35', '31209', 'Monte Alegre Do Sul');
INSERT INTO mun VALUES (3653, 'SP', '35', '31308', 'Monte Alto');
INSERT INTO mun VALUES (3654, 'SP', '35', '31407', 'Monte Aprazivel');
INSERT INTO mun VALUES (2771, 'MG', '31', '42908', 'Monte Azul');
INSERT INTO mun VALUES (3655, 'SP', '35', '31506', 'Monte Azul Paulista');
INSERT INTO mun VALUES (2772, 'MG', '31', '43005', 'Monte Belo');
INSERT INTO mun VALUES (4900, 'RS', '43', '12385', 'Monte Belo Do Sul');
INSERT INTO mun VALUES (4513, 'SC', '42', '11058', 'Monte Carlo');
INSERT INTO mun VALUES (2773, 'MG', '31', '43104', 'Monte Carmelo');
INSERT INTO mun VALUES (3656, 'SP', '35', '31605', 'Monte Castelo');
INSERT INTO mun VALUES (4514, 'SC', '42', '11108', 'Monte Castelo');
INSERT INTO mun VALUES (1188, 'RN', '24', '07906', 'Monte Das Gameleiras');
INSERT INTO mun VALUES (412, 'TO', '17', '13601', 'Monte Do Carmo');
INSERT INTO mun VALUES (2774, 'MG', '31', '43153', 'Monte Formoso');
INSERT INTO mun VALUES (1392, 'PB', '25', '09602', 'Monte Horebe');
INSERT INTO mun VALUES (1393, 'PB', '25', '09701', 'Monteiro');
INSERT INTO mun VALUES (3657, 'SP', '35', '31704', 'Monteiro Lobato');
INSERT INTO mun VALUES (1737, 'AL', '27', '05408', 'Monteiropolis');
INSERT INTO mun VALUES (3658, 'SP', '35', '31803', 'Monte Mor');
INSERT INTO mun VALUES (4901, 'RS', '43', '12401', 'Montenegro');
INSERT INTO mun VALUES (59, 'RO', '11', '01401', 'Monte Negro');
INSERT INTO mun VALUES (597, 'MA', '21', '07001', 'Montes Altos');
INSERT INTO mun VALUES (2118, 'BA', '29', '21500', 'Monte Santo');
INSERT INTO mun VALUES (2775, 'MG', '31', '43203', 'Monte Santo De Minas');
INSERT INTO mun VALUES (413, 'TO', '17', '13700', 'Monte Santo Do Tocantins');
INSERT INTO mun VALUES (1379, 'PB', '25', '08802', 'Malta');
INSERT INTO mun VALUES (2776, 'MG', '31', '43302', 'Montes Claros');
INSERT INTO mun VALUES (5505, 'GO', '52', '13707', 'Montes Claros De Goias');
INSERT INTO mun VALUES (2777, 'MG', '31', '43401', 'Monte Sião');
INSERT INTO mun VALUES (2778, 'MG', '31', '43450', 'Montezuma');
INSERT INTO mun VALUES (5506, 'GO', '52', '13756', 'Montividiu');
INSERT INTO mun VALUES (5507, 'GO', '52', '13772', 'Montividiu Do Norte');
INSERT INTO mun VALUES (1033, 'CE', '23', '08708', 'Morada Nova');
INSERT INTO mun VALUES (2779, 'MG', '31', '43500', 'Morada Nova De Minas');
INSERT INTO mun VALUES (1034, 'CE', '23', '08807', 'Moraujo');
INSERT INTO mun VALUES (1655, 'PE', '26', '14303', 'Moreilandia');
INSERT INTO mun VALUES (4172, 'PR', '41', '16109', 'Moreira Sales');
INSERT INTO mun VALUES (1602, 'PE', '26', '09402', 'Moreno');
INSERT INTO mun VALUES (4902, 'RS', '43', '12427', 'Mormaço');
INSERT INTO mun VALUES (2119, 'BA', '29', '21609', 'Morpara');
INSERT INTO mun VALUES (4173, 'PR', '41', '16208', 'Morretes');
INSERT INTO mun VALUES (1035, 'CE', '23', '08906', 'Morrinhos');
INSERT INTO mun VALUES (5508, 'GO', '52', '13806', 'Morrinhos');
INSERT INTO mun VALUES (4903, 'RS', '43', '12443', 'Morrinhos Do Sul');
INSERT INTO mun VALUES (3659, 'SP', '35', '31902', 'Morro Agudo');
INSERT INTO mun VALUES (5509, 'GO', '52', '13855', 'Morro Agudo De Goias');
INSERT INTO mun VALUES (825, 'PI', '22', '06654', 'Morro Cabeça No Tempo');
INSERT INTO mun VALUES (4515, 'SC', '42', '11207', 'Morro Da Fumaça');
INSERT INTO mun VALUES (2780, 'MG', '31', '43609', 'Morro Da Garça');
INSERT INTO mun VALUES (2120, 'BA', '29', '21708', 'Morro Do Chapeu');
INSERT INTO mun VALUES (826, 'PI', '22', '06670', 'Morro Do Chapeu Do Piaui');
INSERT INTO mun VALUES (2781, 'MG', '31', '43708', 'Morro Do Pilar');
INSERT INTO mun VALUES (4516, 'SC', '42', '11256', 'Morro Grande');
INSERT INTO mun VALUES (4904, 'RS', '43', '12450', 'Morro Redondo');
INSERT INTO mun VALUES (4905, 'RS', '43', '12476', 'Morro Reuter');
INSERT INTO mun VALUES (598, 'MA', '21', '07100', 'Morros');
INSERT INTO mun VALUES (2121, 'BA', '29', '21807', 'Mortugaba');
INSERT INTO mun VALUES (3660, 'SP', '35', '32009', 'Morungaba');
INSERT INTO mun VALUES (5510, 'GO', '52', '13905', 'Mossamedes');
INSERT INTO mun VALUES (1189, 'RN', '24', '08003', 'Mossoro');
INSERT INTO mun VALUES (4906, 'RS', '43', '12500', 'Mostardas');
INSERT INTO mun VALUES (3661, 'SP', '35', '32058', 'Motuca');
INSERT INTO mun VALUES (5511, 'GO', '52', '14002', 'Mozarlandia');
INSERT INTO mun VALUES (249, 'PA', '15', '04901', 'Muana');
INSERT INTO mun VALUES (167, 'RR', '14', '00308', 'Mucajai');
INSERT INTO mun VALUES (1036, 'CE', '23', '09003', 'Mucambo');
INSERT INTO mun VALUES (2122, 'BA', '29', '21906', 'Mucuge');
INSERT INTO mun VALUES (2123, 'BA', '29', '22003', 'Mucuri');
INSERT INTO mun VALUES (3180, 'ES', '32', '03601', 'Mucurici');
INSERT INTO mun VALUES (4908, 'RS', '43', '12617', 'Muitos Capões');
INSERT INTO mun VALUES (4909, 'RS', '43', '12625', 'Muliterno');
INSERT INTO mun VALUES (1394, 'PB', '25', '09800', 'Mulungu');
INSERT INTO mun VALUES (1037, 'CE', '23', '09102', 'Mulungu');
INSERT INTO mun VALUES (2124, 'BA', '29', '22052', 'Mulungu Do Morro');
INSERT INTO mun VALUES (2125, 'BA', '29', '22102', 'Mundo Novo');
INSERT INTO mun VALUES (5512, 'GO', '52', '14051', 'Mundo Novo');
INSERT INTO mun VALUES (5191, 'MS', '50', '05681', 'Mundo Novo');
INSERT INTO mun VALUES (2782, 'MG', '31', '43807', 'Munhoz');
INSERT INTO mun VALUES (4174, 'PR', '41', '16307', 'Munhoz De Melo');
INSERT INTO mun VALUES (2126, 'BA', '29', '22201', 'Muniz Ferreira');
INSERT INTO mun VALUES (3181, 'ES', '32', '03700', 'Muniz Freire');
INSERT INTO mun VALUES (4166, 'PR', '41', '15754', 'Maua Da Serra');
INSERT INTO mun VALUES (136, 'AM', '13', '02900', 'Maues');
INSERT INTO mun VALUES (5499, 'GO', '52', '13004', 'Maurilandia');
INSERT INTO mun VALUES (409, 'TO', '17', '12801', 'Maurilandia Do Tocantins');
INSERT INTO mun VALUES (1025, 'CE', '23', '08104', 'Mauriti');
INSERT INTO mun VALUES (1184, 'RN', '24', '07500', 'Maxaranguape');
INSERT INTO mun VALUES (4895, 'RS', '43', '12203', 'Maximiliano De Almeida');
INSERT INTO mun VALUES (328, 'AP', '16', '00402', 'Mazagão');
INSERT INTO mun VALUES (11345, 'RS', '43', 'TR052', 'Médio Alto Uruguai RS');
INSERT INTO mun VALUES (11390, 'MG', '31', 'TR097', 'Médio Jequetinhonha');
INSERT INTO mun VALUES (11346, 'MG', '31', 'RT053', 'Médio Rio Doce MG');
INSERT INTO mun VALUES (11347, 'PB', '25', 'TR054', 'Médio Sertão PB');
INSERT INTO mun VALUES (11348, 'BA', '29', 'TR055', 'Médio São Francisco BA');
INSERT INTO mun VALUES (2754, 'MG', '31', '41306', 'Medeiros');
INSERT INTO mun VALUES (2113, 'BA', '29', '21104', 'Medeiros Neto');
INSERT INTO mun VALUES (4167, 'PR', '41', '15804', 'Medianeira');
INSERT INTO mun VALUES (244, 'PA', '15', '04455', 'Medicilandia');
INSERT INTO mun VALUES (2755, 'MG', '31', '41405', 'Medina');
INSERT INTO mun VALUES (238, 'PA', '15', '04059', 'Mãe Do Rio');
INSERT INTO mun VALUES (4509, 'SC', '42', '10803', 'Meleiro');
INSERT INTO mun VALUES (245, 'PA', '15', '04505', 'Melgaço');
INSERT INTO mun VALUES (3251, 'RJ', '33', '02809', 'Mendes');
INSERT INTO mun VALUES (2756, 'MG', '31', '41504', 'Mendes Pimentel');
INSERT INTO mun VALUES (3634, 'SP', '35', '29500', 'Mendonça');
INSERT INTO mun VALUES (4168, 'PR', '41', '15853', 'Mercedes');
INSERT INTO mun VALUES (2757, 'MG', '31', '41603', 'Merces');
INSERT INTO mun VALUES (3635, 'SP', '35', '29609', 'Meridiano');
INSERT INTO mun VALUES (1026, 'CE', '23', '08203', 'Meruoca');
INSERT INTO mun VALUES (3636, 'SP', '35', '29658', 'Mesopolis');
INSERT INTO mun VALUES (3252, 'RJ', '33', '02858', 'Mesquita');
INSERT INTO mun VALUES (2758, 'MG', '31', '41702', 'Mesquita');
INSERT INTO mun VALUES (1735, 'AL', '27', '05200', 'Messias');
INSERT INTO mun VALUES (1185, 'RN', '24', '07609', 'Messias Targino');
INSERT INTO mun VALUES (819, 'PI', '22', '06209', 'Miguel Alves');
INSERT INTO mun VALUES (2114, 'BA', '29', '21203', 'Miguel Calmon');
INSERT INTO mun VALUES (820, 'PI', '22', '06308', 'Miguel Leão');
INSERT INTO mun VALUES (3637, 'SP', '35', '29708', 'Miguelopolis');
INSERT INTO mun VALUES (3253, 'RJ', '33', '02908', 'Miguel Pereira');
INSERT INTO mun VALUES (1027, 'CE', '23', '08302', 'Milagres');
INSERT INTO mun VALUES (2115, 'BA', '29', '21302', 'Milagres');
INSERT INTO mun VALUES (592, 'MA', '21', '06672', 'Milagres Do Maranhão');
INSERT INTO mun VALUES (1028, 'CE', '23', '08351', 'Milhã');
INSERT INTO mun VALUES (821, 'PI', '22', '06357', 'Milton Brandão');
INSERT INTO mun VALUES (5500, 'GO', '52', '13053', 'Mimoso De Goias');
INSERT INTO mun VALUES (3178, 'ES', '32', '03403', 'Mimoso Do Sul');
INSERT INTO mun VALUES (1736, 'AL', '27', '05309', 'Minador Do Negrão');
INSERT INTO mun VALUES (4896, 'RS', '43', '12252', 'Minas Do Leão');
INSERT INTO mun VALUES (2276, 'MG', '31', '00000', 'Minas Gerais');
INSERT INTO mun VALUES (2759, 'MG', '31', '41801', 'Minas Novas');
INSERT INTO mun VALUES (5501, 'GO', '52', '13087', 'Minaçu');
INSERT INTO mun VALUES (2760, 'MG', '31', '41900', 'Minduri');
INSERT INTO mun VALUES (5502, 'GO', '52', '13103', 'Mineiros');
INSERT INTO mun VALUES (3638, 'SP', '35', '29807', 'Mineiros Do Tiete');
INSERT INTO mun VALUES (57, 'RO', '11', '01203', 'Ministro Andreazza');
INSERT INTO mun VALUES (2761, 'MG', '31', '42007', 'Mirabela');
INSERT INTO mun VALUES (3639, 'SP', '35', '29906', 'Miracatu');
INSERT INTO mun VALUES (3254, 'RJ', '33', '03005', 'Miracema');
INSERT INTO mun VALUES (410, 'TO', '17', '13205', 'Miracema Do Tocantins');
INSERT INTO mun VALUES (593, 'MA', '21', '06706', 'Mirador');
INSERT INTO mun VALUES (4169, 'PR', '41', '15903', 'Mirador');
INSERT INTO mun VALUES (2762, 'MG', '31', '42106', 'Miradouro');
INSERT INTO mun VALUES (3640, 'SP', '35', '30003', 'Mira Estrela');
INSERT INTO mun VALUES (4897, 'RS', '43', '12302', 'Miraguai');
INSERT INTO mun VALUES (2763, 'MG', '31', '42205', 'Mirai');
INSERT INTO mun VALUES (1029, 'CE', '23', '08377', 'Miraima');
INSERT INTO mun VALUES (5190, 'MS', '50', '05608', 'Miranda');
INSERT INTO mun VALUES (594, 'MA', '21', '06755', 'Miranda Do Norte');
INSERT INTO mun VALUES (1601, 'PE', '26', '09303', 'Mirandiba');
INSERT INTO mun VALUES (3641, 'SP', '35', '30102', 'Mirandopolis');
INSERT INTO mun VALUES (2116, 'BA', '29', '21401', 'Mirangaba');
INSERT INTO mun VALUES (411, 'TO', '17', '13304', 'Miranorte');
INSERT INTO mun VALUES (2117, 'BA', '29', '21450', 'Mirante');
INSERT INTO mun VALUES (58, 'RO', '11', '01302', 'Mirante Da Serra');
INSERT INTO mun VALUES (3642, 'SP', '35', '30201', 'Mirante Do Paranapanema');
INSERT INTO mun VALUES (4170, 'PR', '41', '16000', 'Miraselva');
INSERT INTO mun VALUES (3643, 'SP', '35', '30300', 'Mirassol');
INSERT INTO mun VALUES (3644, 'SP', '35', '30409', 'Mirassolandia');
INSERT INTO mun VALUES (2764, 'MG', '31', '42254', 'Miravania');
INSERT INTO mun VALUES (4510, 'SC', '42', '10852', 'Mirim Doce');
INSERT INTO mun VALUES (595, 'MA', '21', '06805', 'Mirinzal');
INSERT INTO mun VALUES (4171, 'PR', '41', '16059', 'Missal');
INSERT INTO mun VALUES (11349, 'RS', '43', 'TR056', 'Missões RS');
INSERT INTO mun VALUES (1030, 'CE', '23', '08401', 'Missão Velha');
INSERT INTO mun VALUES (246, 'PA', '15', '04604', 'Mocajuba');
INSERT INTO mun VALUES (3645, 'SP', '35', '30508', 'Mococa');
INSERT INTO mun VALUES (4511, 'SC', '42', '10902', 'Modelo');
INSERT INTO mun VALUES (2765, 'MG', '31', '42304', 'Moeda');
INSERT INTO mun VALUES (2766, 'MG', '31', '42403', 'Moema');
INSERT INTO mun VALUES (1390, 'PB', '25', '09404', 'Mogeiro');
INSERT INTO mun VALUES (3647, 'SP', '35', '30706', 'Mogi Guaçu');
INSERT INTO mun VALUES (5503, 'GO', '52', '13400', 'Moipora');
INSERT INTO mun VALUES (1821, 'SE', '28', '04102', 'Moita Bonita');
INSERT INTO mun VALUES (3646, 'SP', '35', '30607', 'Moji Das Cruzes');
INSERT INTO mun VALUES (3648, 'SP', '35', '30805', 'Moji-mirim');
INSERT INTO mun VALUES (247, 'PA', '15', '04703', 'Moju');
INSERT INTO mun VALUES (1031, 'CE', '23', '08500', 'Mombaça');
INSERT INTO mun VALUES (3649, 'SP', '35', '30904', 'Mombuca');
INSERT INTO mun VALUES (4512, 'SC', '42', '11009', 'Mondai');
INSERT INTO mun VALUES (3650, 'SP', '35', '31001', 'Monções');
INSERT INTO mun VALUES (3651, 'SP', '35', '31100', 'Mongagua');
INSERT INTO mun VALUES (1729, 'AL', '27', '04609', 'Maravilha');
INSERT INTO mun VALUES (2734, 'MG', '31', '39706', 'Maravilhas');
INSERT INTO mun VALUES (1382, 'PB', '25', '09057', 'Marcação');
INSERT INTO mun VALUES (5282, 'MT', '51', '05580', 'Marcelandia');
INSERT INTO mun VALUES (4887, 'RS', '43', '11908', 'Marcelino Ramos');
INSERT INTO mun VALUES (1182, 'RN', '24', '07302', 'Marcelino Vieira');
INSERT INTO mun VALUES (2109, 'BA', '29', '20809', 'Marcionilio Souza');
INSERT INTO mun VALUES (1022, 'CE', '23', '07809', 'Marco');
INSERT INTO mun VALUES (815, 'PI', '22', '05953', 'Marcolandia');
INSERT INTO mun VALUES (816, 'PI', '22', '06001', 'Marcos Parente');
INSERT INTO mun VALUES (2735, 'MG', '31', '39805', 'Mar De Espanha');
INSERT INTO mun VALUES (4151, 'PR', '41', '14609', 'Marechal Candido Rondon');
INSERT INTO mun VALUES (1730, 'AL', '27', '04708', 'Marechal Deodoro');
INSERT INTO mun VALUES (3176, 'ES', '32', '03346', 'Marechal Floriano');
INSERT INTO mun VALUES (84, 'AC', '12', '00351', 'Marechal Thaumaturgo');
INSERT INTO mun VALUES (4506, 'SC', '42', '10555', 'Marema');
INSERT INTO mun VALUES (1383, 'PB', '25', '09107', 'Mari');
INSERT INTO mun VALUES (2736, 'MG', '31', '39904', 'Maria Da Fe');
INSERT INTO mun VALUES (4152, 'PR', '41', '14708', 'Maria Helena');
INSERT INTO mun VALUES (4153, 'PR', '41', '14807', 'Marialva');
INSERT INTO mun VALUES (2737, 'MG', '31', '40001', 'Mariana');
INSERT INTO mun VALUES (4888, 'RS', '43', '11981', 'Mariana Pimentel');
INSERT INTO mun VALUES (4889, 'RS', '43', '12005', 'Mariano Moro');
INSERT INTO mun VALUES (407, 'TO', '17', '12504', 'Marianopolis Do Tocantin');
INSERT INTO mun VALUES (3628, 'SP', '35', '28908', 'Mariapolis');
INSERT INTO mun VALUES (1731, 'AL', '27', '04807', 'Maribondo');
INSERT INTO mun VALUES (3250, 'RJ', '33', '02700', 'Marica');
INSERT INTO mun VALUES (2738, 'MG', '31', '40100', 'Marilac');
INSERT INTO mun VALUES (3177, 'ES', '32', '03353', 'Marilandia');
INSERT INTO mun VALUES (4154, 'PR', '41', '14906', 'Marilandia Do Sul');
INSERT INTO mun VALUES (4155, 'PR', '41', '15002', 'Marilena');
INSERT INTO mun VALUES (3629, 'SP', '35', '29005', 'Marilia');
INSERT INTO mun VALUES (4156, 'PR', '41', '15101', 'Mariluz');
INSERT INTO mun VALUES (4157, 'PR', '41', '15200', 'Maringa');
INSERT INTO mun VALUES (3630, 'SP', '35', '29104', 'Marinopolis');
INSERT INTO mun VALUES (2739, 'MG', '31', '40159', 'Mario Campos');
INSERT INTO mun VALUES (4158, 'PR', '41', '15309', 'Mariopolis');
INSERT INTO mun VALUES (4159, 'PR', '41', '15358', 'Maripa');
INSERT INTO mun VALUES (2740, 'MG', '31', '40209', 'Maripa De Minas');
INSERT INTO mun VALUES (243, 'PA', '15', '04422', 'Marituba');
INSERT INTO mun VALUES (1384, 'PB', '25', '09156', 'Marizopolis');
INSERT INTO mun VALUES (2741, 'MG', '31', '40308', 'Marlieria');
INSERT INTO mun VALUES (4160, 'PR', '41', '15408', 'Marmeleiro');
INSERT INTO mun VALUES (2742, 'MG', '31', '40407', 'Marmelopolis');
INSERT INTO mun VALUES (2718, 'MG', '31', '38609', 'Lima Duarte');
INSERT INTO mun VALUES (4890, 'RS', '43', '12054', 'Marques De Souza');
INSERT INTO mun VALUES (4161, 'PR', '41', '15457', 'Marquinho');
INSERT INTO mun VALUES (2743, 'MG', '31', '40506', 'Martinho Campos');
INSERT INTO mun VALUES (1023, 'CE', '23', '07908', 'Martinopole');
INSERT INTO mun VALUES (3631, 'SP', '35', '29203', 'Martinopolis');
INSERT INTO mun VALUES (1183, 'RN', '24', '07401', 'Martins');
INSERT INTO mun VALUES (2744, 'MG', '31', '40530', 'Martins Soares');
INSERT INTO mun VALUES (1820, 'SE', '28', '04003', 'Maruim');
INSERT INTO mun VALUES (4162, 'PR', '41', '15507', 'Marumbi');
INSERT INTO mun VALUES (1732, 'AL', '27', '04906', 'Mar Vermelho');
INSERT INTO mun VALUES (5497, 'GO', '52', '12907', 'Marzagão');
INSERT INTO mun VALUES (2110, 'BA', '29', '20908', 'Mascote');
INSERT INTO mun VALUES (1024, 'CE', '23', '08005', 'Massape');
INSERT INTO mun VALUES (817, 'PI', '22', '06050', 'Massape Do Piaui');
INSERT INTO mun VALUES (4507, 'SC', '42', '10605', 'Massaranduba');
INSERT INTO mun VALUES (1385, 'PB', '25', '09206', 'Massaranduba');
INSERT INTO mun VALUES (4891, 'RS', '43', '12104', 'Mata');
INSERT INTO mun VALUES (2111, 'BA', '29', '21005', 'Mata De São João');
INSERT INTO mun VALUES (1733, 'AL', '27', '05002', 'Mata Grande');
INSERT INTO mun VALUES (1386, 'PB', '25', '09305', 'Mataraca');
INSERT INTO mun VALUES (588, 'MA', '21', '06409', 'Mata Roma');
INSERT INTO mun VALUES (11343, 'PE', '26', 'TR050', 'Mata Sul PE');
INSERT INTO mun VALUES (2745, 'MG', '31', '40555', 'Mata Verde');
INSERT INTO mun VALUES (408, 'TO', '17', '12702', 'Mateiros');
INSERT INTO mun VALUES (4163, 'PR', '41', '15606', 'Matelandia');
INSERT INTO mun VALUES (2746, 'MG', '31', '40605', 'Materlandia');
INSERT INTO mun VALUES (590, 'MA', '21', '06607', 'Matões');
INSERT INTO mun VALUES (591, 'MA', '21', '06631', 'Matões Do Norte');
INSERT INTO mun VALUES (2747, 'MG', '31', '40704', 'Mateus Leme');
INSERT INTO mun VALUES (3122, 'MG', '31', '71501', 'Mathias Lobato');
INSERT INTO mun VALUES (2748, 'MG', '31', '40803', 'Matias Barbosa');
INSERT INTO mun VALUES (2749, 'MG', '31', '40852', 'Matias Cardoso');
INSERT INTO mun VALUES (818, 'PI', '22', '06100', 'Matias Olimpio');
INSERT INTO mun VALUES (2112, 'BA', '29', '21054', 'Matina');
INSERT INTO mun VALUES (589, 'MA', '21', '06508', 'Matinha');
INSERT INTO mun VALUES (1387, 'PB', '25', '09339', 'Matinhas');
INSERT INTO mun VALUES (4164, 'PR', '41', '15705', 'Matinhos');
INSERT INTO mun VALUES (2750, 'MG', '31', '40902', 'Matipo');
INSERT INTO mun VALUES (3632, 'SP', '35', '29302', 'Matão');
INSERT INTO mun VALUES (4892, 'RS', '43', '12138', 'Mato Castelhano');
INSERT INTO mun VALUES (11344, 'RN', '24', 'TR051', 'Mato Grande RN');
INSERT INTO mun VALUES (5218, 'MT', '51', '00000', 'Mato Grosso');
INSERT INTO mun VALUES (1388, 'PB', '25', '09370', 'Mato Grosso');
INSERT INTO mun VALUES (5140, 'MS', '50', '00000', 'Mato Grosso Do Sul');
INSERT INTO mun VALUES (4893, 'RS', '43', '12153', 'Mato Leitão');
INSERT INTO mun VALUES (4894, 'RS', '43', '12179', 'Mato Queimado');
INSERT INTO mun VALUES (4165, 'PR', '41', '15739', 'Mato Rico');
INSERT INTO mun VALUES (4508, 'SC', '42', '10704', 'Matos Costa');
INSERT INTO mun VALUES (2751, 'MG', '31', '41009', 'Mato Verde');
INSERT INTO mun VALUES (2752, 'MG', '31', '41108', 'Matozinhos');
INSERT INTO mun VALUES (5498, 'GO', '52', '12956', 'Matrinchã');
INSERT INTO mun VALUES (1734, 'AL', '27', '05101', 'Matriz De Camaragibe');
INSERT INTO mun VALUES (5283, 'MT', '51', '05606', 'Matupa');
INSERT INTO mun VALUES (1389, 'PB', '25', '09396', 'Matureia');
INSERT INTO mun VALUES (2753, 'MG', '31', '41207', 'Matutina');
INSERT INTO mun VALUES (3633, 'SP', '35', '29401', 'Maua');
INSERT INTO mun VALUES (1179, 'RN', '24', '07104', 'Macaiba');
INSERT INTO mun VALUES (2094, 'BA', '29', '19603', 'Macajuba');
INSERT INTO mun VALUES (1817, 'SE', '28', '03708', 'Macambira');
INSERT INTO mun VALUES (327, 'AP', '16', '00303', 'Macapa');
INSERT INTO mun VALUES (1597, 'PE', '26', '09006', 'Macaparana');
INSERT INTO mun VALUES (2095, 'BA', '29', '19702', 'Macarani');
INSERT INTO mun VALUES (3618, 'SP', '35', '28007', 'Macatuba');
INSERT INTO mun VALUES (1180, 'RN', '24', '07203', 'Macau');
INSERT INTO mun VALUES (3619, 'SP', '35', '28106', 'Macaubal');
INSERT INTO mun VALUES (2096, 'BA', '29', '19801', 'Macaubas');
INSERT INTO mun VALUES (3620, 'SP', '35', '28205', 'Macedonia');
INSERT INTO mun VALUES (1726, 'AL', '27', '04302', 'Maceio');
INSERT INTO mun VALUES (2725, 'MG', '31', '38906', 'Machacalis');
INSERT INTO mun VALUES (4880, 'RS', '43', '11700', 'Machadinho');
INSERT INTO mun VALUES (32, 'RO', '11', '00130', 'Machadinho Doeste');
INSERT INTO mun VALUES (2726, 'MG', '31', '39003', 'Machado');
INSERT INTO mun VALUES (1598, 'PE', '26', '09105', 'Machados');
INSERT INTO mun VALUES (4500, 'SC', '42', '10050', 'Macieira');
INSERT INTO mun VALUES (3247, 'RJ', '33', '02452', 'Macuco');
INSERT INTO mun VALUES (2097, 'BA', '29', '19900', 'Macurure');
INSERT INTO mun VALUES (1019, 'CE', '23', '07635', 'Madalena');
INSERT INTO mun VALUES (813, 'PI', '22', '05854', 'Madeiro');
INSERT INTO mun VALUES (2098, 'BA', '29', '19926', 'Madre De Deus');
INSERT INTO mun VALUES (2727, 'MG', '31', '39102', 'Madre De Deus De Minas');
INSERT INTO mun VALUES (2099, 'BA', '29', '19959', 'Maetinga');
INSERT INTO mun VALUES (4501, 'SC', '42', '10100', 'Mafra');
INSERT INTO mun VALUES (239, 'PA', '15', '04109', 'Magalhães Barata');
INSERT INTO mun VALUES (584, 'MA', '21', '06300', 'Magalhães De Almeida');
INSERT INTO mun VALUES (3621, 'SP', '35', '28304', 'Magda');
INSERT INTO mun VALUES (3248, 'RJ', '33', '02502', 'Mage');
INSERT INTO mun VALUES (2100, 'BA', '29', '20007', 'Maiquinique');
INSERT INTO mun VALUES (2101, 'BA', '29', '20106', 'Mairi');
INSERT INTO mun VALUES (3622, 'SP', '35', '28403', 'Mairinque');
INSERT INTO mun VALUES (3623, 'SP', '35', '28502', 'Mairiporã');
INSERT INTO mun VALUES (5494, 'GO', '52', '12600', 'Mairipotaba');
INSERT INTO mun VALUES (4502, 'SC', '42', '10209', 'Major Gercino');
INSERT INTO mun VALUES (1727, 'AL', '27', '04401', 'Major Isidoro');
INSERT INTO mun VALUES (1181, 'RN', '24', '07252', 'Major Sales');
INSERT INTO mun VALUES (4503, 'SC', '42', '10308', 'Major Vieira');
INSERT INTO mun VALUES (2728, 'MG', '31', '39201', 'Malacacheta');
INSERT INTO mun VALUES (2102, 'BA', '29', '20205', 'Malhada');
INSERT INTO mun VALUES (2103, 'BA', '29', '20304', 'Malhada De Pedras');
INSERT INTO mun VALUES (1818, 'SE', '28', '03807', 'Malhada Dos Bois');
INSERT INTO mun VALUES (1819, 'SE', '28', '03906', 'Malhador');
INSERT INTO mun VALUES (4143, 'PR', '41', '13908', 'Mallet');
INSERT INTO mun VALUES (1380, 'PB', '25', '08901', 'Mamanguape');
INSERT INTO mun VALUES (5495, 'GO', '52', '12709', 'Mambai');
INSERT INTO mun VALUES (4144, 'PR', '41', '14005', 'Mambore');
INSERT INTO mun VALUES (2729, 'MG', '31', '39250', 'Mamonas');
INSERT INTO mun VALUES (4882, 'RS', '43', '11734', 'Mampituba');
INSERT INTO mun VALUES (131, 'AM', '13', '02504', 'Manacapuru');
INSERT INTO mun VALUES (1381, 'PB', '25', '09008', 'Manaira');
INSERT INTO mun VALUES (132, 'AM', '13', '02553', 'Manaquiri');
INSERT INTO mun VALUES (1599, 'PE', '26', '09154', 'Manari');
INSERT INTO mun VALUES (133, 'AM', '13', '02603', 'Manaus');
INSERT INTO mun VALUES (82, 'AC', '12', '00336', 'Mancio Lima');
INSERT INTO mun VALUES (4146, 'PR', '41', '14203', 'Mandaguari');
INSERT INTO mun VALUES (4145, 'PR', '41', '14104', 'Mandaguaçu');
INSERT INTO mun VALUES (4147, 'PR', '41', '14302', 'Mandirituba');
INSERT INTO mun VALUES (3624, 'SP', '35', '28601', 'Manduri');
INSERT INTO mun VALUES (4148, 'PR', '41', '14351', 'Manfrinopolis');
INSERT INTO mun VALUES (2730, 'MG', '31', '39300', 'Manga');
INSERT INTO mun VALUES (3249, 'RJ', '33', '02601', 'Mangaratiba');
INSERT INTO mun VALUES (4149, 'PR', '41', '14401', 'Mangueirinha');
INSERT INTO mun VALUES (2731, 'MG', '31', '39409', 'Manhuaçu');
INSERT INTO mun VALUES (2732, 'MG', '31', '39508', 'Manhumirim');
INSERT INTO mun VALUES (134, 'AM', '13', '02702', 'Manicore');
INSERT INTO mun VALUES (814, 'PI', '22', '05904', 'Manoel Emidio');
INSERT INTO mun VALUES (4150, 'PR', '41', '14500', 'Manoel Ribas');
INSERT INTO mun VALUES (83, 'AC', '12', '00344', 'Manoel Urbano');
INSERT INTO mun VALUES (4883, 'RS', '43', '11759', 'Manoel Viana');
INSERT INTO mun VALUES (2104, 'BA', '29', '20403', 'Manoel Vitorino');
INSERT INTO mun VALUES (2105, 'BA', '29', '20452', 'Mansidão');
INSERT INTO mun VALUES (2733, 'MG', '31', '39607', 'Mantena');
INSERT INTO mun VALUES (3174, 'ES', '32', '03304', 'Mantenopolis');
INSERT INTO mun VALUES (4884, 'RS', '43', '11775', 'Maquine');
INSERT INTO mun VALUES (135, 'AM', '13', '02801', 'Maraã');
INSERT INTO mun VALUES (240, 'PA', '15', '04208', 'Maraba');
INSERT INTO mun VALUES (3625, 'SP', '35', '28700', 'Maraba Paulista');
INSERT INTO mun VALUES (3626, 'SP', '35', '28809', 'Maracai');
INSERT INTO mun VALUES (4504, 'SC', '42', '10407', 'Maracaja');
INSERT INTO mun VALUES (5189, 'MS', '50', '05400', 'Maracaju');
INSERT INTO mun VALUES (241, 'PA', '15', '04307', 'Maracanã');
INSERT INTO mun VALUES (1020, 'CE', '23', '07650', 'Maracanau');
INSERT INTO mun VALUES (2106, 'BA', '29', '20502', 'Maracas');
INSERT INTO mun VALUES (585, 'MA', '21', '06326', 'Maracaçume');
INSERT INTO mun VALUES (1728, 'AL', '27', '04500', 'Maragogi');
INSERT INTO mun VALUES (2107, 'BA', '29', '20601', 'Maragogipe');
INSERT INTO mun VALUES (1600, 'PE', '26', '09204', 'Maraial');
INSERT INTO mun VALUES (586, 'MA', '21', '06359', 'Maraja Do Sena');
INSERT INTO mun VALUES (1021, 'CE', '23', '07700', 'Maranguape');
INSERT INTO mun VALUES (587, 'MA', '21', '06375', 'Maranhãozinho');
INSERT INTO mun VALUES (475, 'MA', '21', '00000', 'Maranão');
INSERT INTO mun VALUES (242, 'PA', '15', '04406', 'Marapanim');
INSERT INTO mun VALUES (3627, 'SP', '35', '28858', 'Marapoama');
INSERT INTO mun VALUES (5496, 'GO', '52', '12808', 'Mara Rosa');
INSERT INTO mun VALUES (4885, 'RS', '43', '11791', 'Marata');
INSERT INTO mun VALUES (3175, 'ES', '32', '03320', 'Marataizes');
INSERT INTO mun VALUES (4886, 'RS', '43', '11809', 'Marau');
INSERT INTO mun VALUES (2108, 'BA', '29', '20700', 'Marau');
INSERT INTO mun VALUES (4505, 'SC', '42', '10506', 'Maravilha');
INSERT INTO mun VALUES (2086, 'BA', '29', '19058', 'Lajedo Do Tabocal');
INSERT INTO mun VALUES (3245, 'RJ', '33', '02304', 'Laje Do Muriae');
INSERT INTO mun VALUES (1175, 'RN', '24', '06700', 'Lajes');
INSERT INTO mun VALUES (1176, 'RN', '24', '06809', 'Lajes Pintadas');
INSERT INTO mun VALUES (2708, 'MG', '31', '37700', 'Lajinha');
INSERT INTO mun VALUES (2087, 'BA', '29', '19108', 'Lamarão');
INSERT INTO mun VALUES (2709, 'MG', '31', '37809', 'Lambari');
INSERT INTO mun VALUES (2710, 'MG', '31', '37908', 'Lamim');
INSERT INTO mun VALUES (810, 'PI', '22', '05607', 'Landri Sales');
INSERT INTO mun VALUES (4131, 'PR', '41', '13205', 'Lapa');
INSERT INTO mun VALUES (2088, 'BA', '29', '19157', 'Lapão');
INSERT INTO mun VALUES (3172, 'ES', '32', '03163', 'Laranja Da Terra');
INSERT INTO mun VALUES (2711, 'MG', '31', '38005', 'Laranjal');
INSERT INTO mun VALUES (4132, 'PR', '41', '13254', 'Laranjal');
INSERT INTO mun VALUES (326, 'AP', '16', '00279', 'Laranjal Do Jari');
INSERT INTO mun VALUES (3601, 'SP', '35', '26407', 'Laranjal Paulista');
INSERT INTO mun VALUES (1816, 'SE', '28', '03609', 'Laranjeiras');
INSERT INTO mun VALUES (4133, 'PR', '41', '13304', 'Laranjeiras Do Sul');
INSERT INTO mun VALUES (2712, 'MG', '31', '38104', 'Lassance');
INSERT INTO mun VALUES (1374, 'PB', '25', '08406', 'Lastro');
INSERT INTO mun VALUES (4492, 'SC', '42', '09508', 'Laurentino');
INSERT INTO mun VALUES (2089, 'BA', '29', '19207', 'Lauro De Freitas');
INSERT INTO mun VALUES (4493, 'SC', '42', '09607', 'Lauro Muller');
INSERT INTO mun VALUES (404, 'TO', '17', '12157', 'Lavandeira');
INSERT INTO mun VALUES (3602, 'SP', '35', '26506', 'Lavinia');
INSERT INTO mun VALUES (2713, 'MG', '31', '38203', 'Lavras');
INSERT INTO mun VALUES (1017, 'CE', '23', '07502', 'Lavras Da Mangabeira');
INSERT INTO mun VALUES (4876, 'RS', '43', '11502', 'Lavras Do Sul');
INSERT INTO mun VALUES (3603, 'SP', '35', '26605', 'Lavrinhas');
INSERT INTO mun VALUES (2714, 'MG', '31', '38302', 'Leandro Ferreira');
INSERT INTO mun VALUES (4494, 'SC', '42', '09706', 'Lebon Regis');
INSERT INTO mun VALUES (3604, 'SP', '35', '26704', 'Leme');
INSERT INTO mun VALUES (2715, 'MG', '31', '38351', 'Leme Do Prado');
INSERT INTO mun VALUES (11341, 'MA', '21', 'TR048', 'Lençóis Maranhenses  MA');
INSERT INTO mun VALUES (2090, 'BA', '29', '19306', 'Lençois');
INSERT INTO mun VALUES (3605, 'SP', '35', '26803', 'Lençois Paulista');
INSERT INTO mun VALUES (4495, 'SC', '42', '09805', 'Leoberto Leal');
INSERT INTO mun VALUES (2716, 'MG', '31', '38401', 'Leopoldina');
INSERT INTO mun VALUES (5492, 'GO', '52', '12303', 'Leopoldo De Bulhões');
INSERT INTO mun VALUES (4134, 'PR', '41', '13403', 'Leopolis');
INSERT INTO mun VALUES (4877, 'RS', '43', '11601', 'Liberato Salzano');
INSERT INTO mun VALUES (2717, 'MG', '31', '38500', 'Liberdade');
INSERT INTO mun VALUES (2091, 'BA', '29', '19405', 'Licinio De Almeida');
INSERT INTO mun VALUES (4135, 'PR', '41', '13429', 'Lidianopolis');
INSERT INTO mun VALUES (581, 'MA', '21', '06003', 'Lima Campos');
INSERT INTO mun VALUES (3606, 'SP', '35', '26902', 'Limeira');
INSERT INTO mun VALUES (2719, 'MG', '31', '38625', 'Limeira Do Oeste');
INSERT INTO mun VALUES (1596, 'PE', '26', '08909', 'Limoeiro');
INSERT INTO mun VALUES (1725, 'AL', '27', '04203', 'Limoeiro De Anadia');
INSERT INTO mun VALUES (237, 'PA', '15', '04000', 'Limoeiro Do Ajuru');
INSERT INTO mun VALUES (1018, 'CE', '23', '07601', 'Limoeiro Do Norte');
INSERT INTO mun VALUES (4136, 'PR', '41', '13452', 'Lindoeste');
INSERT INTO mun VALUES (3607, 'SP', '35', '27009', 'Lindoia');
INSERT INTO mun VALUES (4496, 'SC', '42', '09854', 'Lindoia Do Sul');
INSERT INTO mun VALUES (4878, 'RS', '43', '11627', 'Lindolfo Collor');
INSERT INTO mun VALUES (4879, 'RS', '43', '11643', 'Linha Nova');
INSERT INTO mun VALUES (3173, 'ES', '32', '03205', 'Linhares');
INSERT INTO mun VALUES (3608, 'SP', '35', '27108', 'Lins');
INSERT INTO mun VALUES (11342, 'BA', '29', 'TR049', 'Litoral Sul BA');
INSERT INTO mun VALUES (1375, 'PB', '25', '08505', 'Livramento');
INSERT INTO mun VALUES (2092, 'BA', '29', '19504', 'Livramento De Nossa Senh');
INSERT INTO mun VALUES (405, 'TO', '17', '12405', 'Lizarda');
INSERT INTO mun VALUES (4137, 'PR', '41', '13502', 'Loanda');
INSERT INTO mun VALUES (4138, 'PR', '41', '13601', 'Lobato');
INSERT INTO mun VALUES (1376, 'PB', '25', '08554', 'Logradouro');
INSERT INTO mun VALUES (4139, 'PR', '41', '13700', 'Londrina');
INSERT INTO mun VALUES (2720, 'MG', '31', '38658', 'Lontra');
INSERT INTO mun VALUES (4497, 'SC', '42', '09904', 'Lontras');
INSERT INTO mun VALUES (3609, 'SP', '35', '27207', 'Lorena');
INSERT INTO mun VALUES (582, 'MA', '21', '06102', 'Loreto');
INSERT INTO mun VALUES (3610, 'SP', '35', '27256', 'Lourdes');
INSERT INTO mun VALUES (3611, 'SP', '35', '27306', 'Louveira');
INSERT INTO mun VALUES (5279, 'MT', '51', '05259', 'Lucas Do Rio Verde');
INSERT INTO mun VALUES (603, 'MA', '21', '07407', 'Olho D''agua Das CunhÃs');
INSERT INTO mun VALUES (3612, 'SP', '35', '27405', 'Lucelia');
INSERT INTO mun VALUES (1377, 'PB', '25', '08604', 'Lucena');
INSERT INTO mun VALUES (3613, 'SP', '35', '27504', 'Lucianopolis');
INSERT INTO mun VALUES (5280, 'MT', '51', '05309', 'Luciara');
INSERT INTO mun VALUES (1177, 'RN', '24', '06908', 'Lucrecia');
INSERT INTO mun VALUES (3614, 'SP', '35', '27603', 'Luis Antonio');
INSERT INTO mun VALUES (2721, 'MG', '31', '38674', 'Luisburgo');
INSERT INTO mun VALUES (811, 'PI', '22', '05706', 'Luis Correia');
INSERT INTO mun VALUES (583, 'MA', '21', '06201', 'Luis Domingues');
INSERT INTO mun VALUES (2093, 'BA', '29', '19553', 'Luis Eduardo Magalhães');
INSERT INTO mun VALUES (1178, 'RN', '24', '07005', 'Luis Gomes');
INSERT INTO mun VALUES (2722, 'MG', '31', '38682', 'Luislandia');
INSERT INTO mun VALUES (4498, 'SC', '42', '10001', 'Luiz Alves');
INSERT INTO mun VALUES (4140, 'PR', '41', '13734', 'Luiziana');
INSERT INTO mun VALUES (3615, 'SP', '35', '27702', 'Luiziania');
INSERT INTO mun VALUES (2723, 'MG', '31', '38708', 'Luminarias');
INSERT INTO mun VALUES (4141, 'PR', '41', '13759', 'Lunardelli');
INSERT INTO mun VALUES (3616, 'SP', '35', '27801', 'Lupercio');
INSERT INTO mun VALUES (4142, 'PR', '41', '13809', 'Lupionopolis');
INSERT INTO mun VALUES (3617, 'SP', '35', '27900', 'Lutecia');
INSERT INTO mun VALUES (2724, 'MG', '31', '38807', 'Luz');
INSERT INTO mun VALUES (4499, 'SC', '42', '10035', 'Luzerna');
INSERT INTO mun VALUES (5493, 'GO', '52', '12501', 'Luziania');
INSERT INTO mun VALUES (812, 'PI', '22', '05805', 'Luzilandia');
INSERT INTO mun VALUES (406, 'TO', '17', '12454', 'Luzinopolis');
INSERT INTO mun VALUES (4881, 'RS', '43', '11718', 'Maçambara');
INSERT INTO mun VALUES (3246, 'RJ', '33', '02403', 'Macae');
INSERT INTO mun VALUES (1587, 'PE', '26', '08255', 'Jucati');
INSERT INTO mun VALUES (1168, 'RN', '24', '06106', 'Jucurutu');
INSERT INTO mun VALUES (2077, 'BA', '29', '18456', 'Jucuruçu');
INSERT INTO mun VALUES (5275, 'MT', '51', '05150', 'Juina');
INSERT INTO mun VALUES (2696, 'MG', '31', '36702', 'Juiz De Fora');
INSERT INTO mun VALUES (802, 'PI', '22', '05524', 'Julio Borges');
INSERT INTO mun VALUES (4869, 'RS', '43', '11205', 'Julio De Castilhos');
INSERT INTO mun VALUES (3594, 'SP', '35', '25805', 'Julio Mesquita');
INSERT INTO mun VALUES (3595, 'SP', '35', '25854', 'Jumirim');
INSERT INTO mun VALUES (573, 'MA', '21', '05658', 'Junco Do Maranhão');
INSERT INTO mun VALUES (1368, 'PB', '25', '07804', 'Junco Do Serido');
INSERT INTO mun VALUES (1169, 'RN', '24', '06155', 'Jundia');
INSERT INTO mun VALUES (1722, 'AL', '27', '03908', 'Jundia');
INSERT INTO mun VALUES (3596, 'SP', '35', '25904', 'Jundiai');
INSERT INTO mun VALUES (4127, 'PR', '41', '12900', 'Jundiai Do Sul');
INSERT INTO mun VALUES (1723, 'AL', '27', '04005', 'Junqueiro');
INSERT INTO mun VALUES (3597, 'SP', '35', '26001', 'Junqueiropolis');
INSERT INTO mun VALUES (1588, 'PE', '26', '08305', 'Jupi');
INSERT INTO mun VALUES (4487, 'SC', '42', '09177', 'Jupia');
INSERT INTO mun VALUES (3598, 'SP', '35', '26100', 'Juquia');
INSERT INTO mun VALUES (3599, 'SP', '35', '26209', 'Juquitiba');
INSERT INTO mun VALUES (2697, 'MG', '31', '36801', 'Juramento');
INSERT INTO mun VALUES (4128, 'PR', '41', '12959', 'Juranda');
INSERT INTO mun VALUES (1589, 'PE', '26', '08404', 'Jurema');
INSERT INTO mun VALUES (803, 'PI', '22', '05532', 'Jurema');
INSERT INTO mun VALUES (1369, 'PB', '25', '07903', 'Juripiranga');
INSERT INTO mun VALUES (1370, 'PB', '25', '08000', 'Juru');
INSERT INTO mun VALUES (128, 'AM', '13', '02207', 'Jurua');
INSERT INTO mun VALUES (2698, 'MG', '31', '36900', 'Juruaia');
INSERT INTO mun VALUES (5276, 'MT', '51', '05176', 'Juruena');
INSERT INTO mun VALUES (236, 'PA', '15', '03903', 'Juruti');
INSERT INTO mun VALUES (5277, 'MT', '51', '05200', 'Juscimeira');
INSERT INTO mun VALUES (4129, 'PR', '41', '13007', 'Jussara');
INSERT INTO mun VALUES (5490, 'GO', '52', '12204', 'Jussara');
INSERT INTO mun VALUES (2078, 'BA', '29', '18506', 'Jussara');
INSERT INTO mun VALUES (2079, 'BA', '29', '18555', 'Jussari');
INSERT INTO mun VALUES (2080, 'BA', '29', '18605', 'Jussiape');
INSERT INTO mun VALUES (129, 'AM', '13', '02306', 'Jutai');
INSERT INTO mun VALUES (5186, 'MS', '50', '05152', 'Juti');
INSERT INTO mun VALUES (2699, 'MG', '31', '36959', 'Juvenilia');
INSERT INTO mun VALUES (4130, 'PR', '41', '13106', 'Kalore');
INSERT INTO mun VALUES (130, 'AM', '13', '02405', 'Labrea');
INSERT INTO mun VALUES (4488, 'SC', '42', '09201', 'Lacerdopolis');
INSERT INTO mun VALUES (2700, 'MG', '31', '37007', 'Ladainha');
INSERT INTO mun VALUES (5187, 'MS', '50', '05202', 'Ladario');
INSERT INTO mun VALUES (2081, 'BA', '29', '18704', 'Lafaiete Coutinho');
INSERT INTO mun VALUES (2701, 'MG', '31', '37106', 'Lagamar');
INSERT INTO mun VALUES (1815, 'SE', '28', '03500', 'Lagarto');
INSERT INTO mun VALUES (4489, 'SC', '42', '09300', 'Lages');
INSERT INTO mun VALUES (1371, 'PB', '25', '08109', 'Lagoa');
INSERT INTO mun VALUES (805, 'PI', '22', '05557', 'Lagoa Alegre');
INSERT INTO mun VALUES (4870, 'RS', '43', '11239', 'Lagoa Bonita Do Sul');
INSERT INTO mun VALUES (1724, 'AL', '27', '04104', 'Lagoa Da Canoa');
INSERT INTO mun VALUES (401, 'TO', '17', '11902', 'Lagoa Da Confusão');
INSERT INTO mun VALUES (2702, 'MG', '31', '37205', 'Lagoa Da Prata');
INSERT INTO mun VALUES (1372, 'PB', '25', '08208', 'Lagoa De Dentro');
INSERT INTO mun VALUES (1171, 'RN', '24', '06304', 'Lagoa De Pedras');
INSERT INTO mun VALUES (807, 'PI', '22', '05573', 'Lagoa De São Francisco');
INSERT INTO mun VALUES (1172, 'RN', '24', '06403', 'Lagoa De Velhos');
INSERT INTO mun VALUES (806, 'PI', '22', '05565', 'Lagoa Do Barro Do Piaui');
INSERT INTO mun VALUES (1590, 'PE', '26', '08453', 'Lagoa Do Carro');
INSERT INTO mun VALUES (1591, 'PE', '26', '08503', 'Lagoa Do Itaenga');
INSERT INTO mun VALUES (577, 'MA', '21', '05922', 'Lagoa Do Mato');
INSERT INTO mun VALUES (1592, 'PE', '26', '08602', 'Lagoa Do Ouro');
INSERT INTO mun VALUES (808, 'PI', '22', '05581', 'Lagoa Do Piaui');
INSERT INTO mun VALUES (1593, 'PE', '26', '08701', 'Lagoa Dos Gatos');
INSERT INTO mun VALUES (809, 'PI', '22', '05599', 'Lagoa Do Sitio');
INSERT INTO mun VALUES (2703, 'MG', '31', '37304', 'Lagoa Dos Patos');
INSERT INTO mun VALUES (4872, 'RS', '43', '11270', 'Lagoa Dos Tres Cantos');
INSERT INTO mun VALUES (402, 'TO', '17', '11951', 'Lagoa Do Tocantins');
INSERT INTO mun VALUES (2704, 'MG', '31', '37403', 'Lagoa Dourada');
INSERT INTO mun VALUES (2705, 'MG', '31', '37502', 'Lagoa Formosa');
INSERT INTO mun VALUES (2706, 'MG', '31', '37536', 'Lagoa Grande');
INSERT INTO mun VALUES (1594, 'PE', '26', '08750', 'Lagoa Grande');
INSERT INTO mun VALUES (579, 'MA', '21', '05963', 'Lagoa Grande Do Maranhão');
INSERT INTO mun VALUES (1173, 'RN', '24', '06502', 'Lagoa Nova');
INSERT INTO mun VALUES (2082, 'BA', '29', '18753', 'Lagoa Real');
INSERT INTO mun VALUES (1174, 'RN', '24', '06601', 'Lagoa Salgada');
INSERT INTO mun VALUES (5491, 'GO', '52', '12253', 'Lagoa Santa');
INSERT INTO mun VALUES (2707, 'MG', '31', '37601', 'Lagoa Santa');
INSERT INTO mun VALUES (1373, 'PB', '25', '08307', 'Lagoa Seca');
INSERT INTO mun VALUES (4873, 'RS', '43', '11304', 'Lagoa Vermelha');
INSERT INTO mun VALUES (574, 'MA', '21', '05708', 'Lago Da Pedra');
INSERT INTO mun VALUES (575, 'MA', '21', '05807', 'Lago Do Junco');
INSERT INTO mun VALUES (578, 'MA', '21', '05948', 'Lago Dos Rodrigues');
INSERT INTO mun VALUES (3600, 'SP', '35', '26308', 'Lagoinha');
INSERT INTO mun VALUES (804, 'PI', '22', '05540', 'Lagoinha Do Piaui');
INSERT INTO mun VALUES (4871, 'RS', '43', '11254', 'Lagoão');
INSERT INTO mun VALUES (576, 'MA', '21', '05906', 'Lago Verde');
INSERT INTO mun VALUES (4490, 'SC', '42', '09409', 'Laguna');
INSERT INTO mun VALUES (5188, 'MS', '50', '05251', 'Laguna Carapã');
INSERT INTO mun VALUES (2083, 'BA', '29', '18803', 'Laje');
INSERT INTO mun VALUES (4874, 'RS', '43', '11403', 'Lajeado');
INSERT INTO mun VALUES (403, 'TO', '17', '12009', 'Lajeado');
INSERT INTO mun VALUES (4875, 'RS', '43', '11429', 'Lajeado Do Bugre');
INSERT INTO mun VALUES (4491, 'SC', '42', '09458', 'Lajeado Grande');
INSERT INTO mun VALUES (580, 'MA', '21', '05989', 'Lajeado Novo');
INSERT INTO mun VALUES (2085, 'BA', '29', '19009', 'Lajedinho');
INSERT INTO mun VALUES (1595, 'PE', '26', '08800', 'Lajedo');
INSERT INTO mun VALUES (2084, 'BA', '29', '18902', 'Lajedão');
INSERT INTO mun VALUES (1814, 'SE', '28', '03401', 'Japoatã');
INSERT INTO mun VALUES (2677, 'MG', '31', '35357', 'Japonvar');
INSERT INTO mun VALUES (5182, 'MS', '50', '04809', 'Japorã');
INSERT INTO mun VALUES (127, 'AM', '13', '02108', 'Japura');
INSERT INTO mun VALUES (4121, 'PR', '41', '12405', 'Japura');
INSERT INTO mun VALUES (1582, 'PE', '26', '07950', 'Jaqueira');
INSERT INTO mun VALUES (4866, 'RS', '43', '11122', 'Jaquirana');
INSERT INTO mun VALUES (5485, 'GO', '52', '11800', 'Jaragua');
INSERT INTO mun VALUES (4482, 'SC', '42', '08906', 'Jaragua Do Sul');
INSERT INTO mun VALUES (5183, 'MS', '50', '04908', 'Jaraguari');
INSERT INTO mun VALUES (1719, 'AL', '27', '03700', 'Jaramataia');
INSERT INTO mun VALUES (1012, 'CE', '23', '07106', 'Jardim');
INSERT INTO mun VALUES (5184, 'MS', '50', '05004', 'Jardim');
INSERT INTO mun VALUES (4122, 'PR', '41', '12504', 'Jardim Alegre');
INSERT INTO mun VALUES (1162, 'RN', '24', '05504', 'Jardim De Angicos');
INSERT INTO mun VALUES (1163, 'RN', '24', '05603', 'Jardim De Piranhas');
INSERT INTO mun VALUES (794, 'PI', '22', '05250', 'Jardim Do Mulato');
INSERT INTO mun VALUES (1164, 'RN', '24', '05702', 'Jardim Do Serido');
INSERT INTO mun VALUES (4123, 'PR', '41', '12603', 'Jardim Olinda');
INSERT INTO mun VALUES (3587, 'SP', '35', '25102', 'Jardinopolis');
INSERT INTO mun VALUES (4483, 'SC', '42', '08955', 'Jardinopolis');
INSERT INTO mun VALUES (4867, 'RS', '43', '11130', 'Jari');
INSERT INTO mun VALUES (3588, 'SP', '35', '25201', 'Jarinu');
INSERT INTO mun VALUES (30, 'RO', '11', '00114', 'Jaru');
INSERT INTO mun VALUES (5486, 'GO', '52', '11909', 'Jatai');
INSERT INTO mun VALUES (4124, 'PR', '41', '12702', 'Jataizinho');
INSERT INTO mun VALUES (1583, 'PE', '26', '08008', 'Jatauba');
INSERT INTO mun VALUES (5185, 'MS', '50', '05103', 'Jatei');
INSERT INTO mun VALUES (1013, 'CE', '23', '07205', 'Jati');
INSERT INTO mun VALUES (1584, 'PE', '26', '08057', 'Jatoba');
INSERT INTO mun VALUES (569, 'MA', '21', '05450', 'Jatoba');
INSERT INTO mun VALUES (795, 'PI', '22', '05276', 'Jatoba Do Piaui');
INSERT INTO mun VALUES (3589, 'SP', '35', '25300', 'Jau');
INSERT INTO mun VALUES (399, 'TO', '17', '11506', 'Jau Do Tocantins');
INSERT INTO mun VALUES (5487, 'GO', '52', '12006', 'Jaupaci');
INSERT INTO mun VALUES (5273, 'MT', '51', '05002', 'Jauru');
INSERT INTO mun VALUES (2678, 'MG', '31', '35407', 'Jeceaba');
INSERT INTO mun VALUES (2679, 'MG', '31', '35456', 'Jenipapo De Minas');
INSERT INTO mun VALUES (570, 'MA', '21', '05476', 'Jenipapo Dos Vieiras');
INSERT INTO mun VALUES (2680, 'MG', '31', '35506', 'Jequeri');
INSERT INTO mun VALUES (1720, 'AL', '27', '03759', 'Jequia Da Praia');
INSERT INTO mun VALUES (2071, 'BA', '29', '18001', 'Jequie');
INSERT INTO mun VALUES (2681, 'MG', '31', '35605', 'Jequitai');
INSERT INTO mun VALUES (2682, 'MG', '31', '35704', 'Jequitiba');
INSERT INTO mun VALUES (2683, 'MG', '31', '35803', 'Jequitinhonha');
INSERT INTO mun VALUES (2028, 'BA', '29', '14208', 'Irajuba');
INSERT INTO mun VALUES (2072, 'BA', '29', '18100', 'Jeremoabo');
INSERT INTO mun VALUES (1364, 'PB', '25', '07408', 'Jerico');
INSERT INTO mun VALUES (3590, 'SP', '35', '25409', 'Jeriquara');
INSERT INTO mun VALUES (3170, 'ES', '32', '03106', 'Jeronimo Monteiro');
INSERT INTO mun VALUES (796, 'PI', '22', '05300', 'Jerumenha');
INSERT INTO mun VALUES (2684, 'MG', '31', '35902', 'Jesuania');
INSERT INTO mun VALUES (4125, 'PR', '41', '12751', 'Jesuitas');
INSERT INTO mun VALUES (5488, 'GO', '52', '12055', 'Jesupolis');
INSERT INTO mun VALUES (1014, 'CE', '23', '07254', 'Jijoca De Jericoacoara');
INSERT INTO mun VALUES (31, 'RO', '11', '00122', 'Ji-parana');
INSERT INTO mun VALUES (2073, 'BA', '29', '18209', 'Jiquiriça');
INSERT INTO mun VALUES (2074, 'BA', '29', '18308', 'Jitauna');
INSERT INTO mun VALUES (4484, 'SC', '42', '09003', 'Joaçaba');
INSERT INTO mun VALUES (2685, 'MG', '31', '36009', 'Joaima');
INSERT INTO mun VALUES (2686, 'MG', '31', '36108', 'Joanesia');
INSERT INTO mun VALUES (3591, 'SP', '35', '25508', 'Joanopolis');
INSERT INTO mun VALUES (2689, 'MG', '31', '36405', 'Joaquim Felicio');
INSERT INTO mun VALUES (1721, 'AL', '27', '03809', 'Joaquim Gomes');
INSERT INTO mun VALUES (1586, 'PE', '26', '08206', 'Joaquim Nabuco');
INSERT INTO mun VALUES (798, 'PI', '22', '05409', 'Joaquim Pires');
INSERT INTO mun VALUES (4126, 'PR', '41', '12801', 'Joaquim Tavora');
INSERT INTO mun VALUES (799, 'PI', '22', '05458', 'Joca Marques');
INSERT INTO mun VALUES (4868, 'RS', '43', '11155', 'Joia');
INSERT INTO mun VALUES (4485, 'SC', '42', '09102', 'Joinville');
INSERT INTO mun VALUES (1585, 'PE', '26', '08107', 'João Alfredo');
INSERT INTO mun VALUES (1165, 'RN', '24', '05801', 'João Camara');
INSERT INTO mun VALUES (797, 'PI', '22', '05359', 'João Costa');
INSERT INTO mun VALUES (1166, 'RN', '24', '05900', 'João Dias');
INSERT INTO mun VALUES (2075, 'BA', '29', '18357', 'João Dourado');
INSERT INTO mun VALUES (571, 'MA', '21', '05500', 'João Lisboa');
INSERT INTO mun VALUES (2687, 'MG', '31', '36207', 'João Monlevade');
INSERT INTO mun VALUES (3171, 'ES', '32', '03130', 'João Neiva');
INSERT INTO mun VALUES (1365, 'PB', '25', '07507', 'João Pessoa');
INSERT INTO mun VALUES (2688, 'MG', '31', '36306', 'João Pinheiro');
INSERT INTO mun VALUES (3592, 'SP', '35', '25607', 'João Ramalho');
INSERT INTO mun VALUES (2690, 'MG', '31', '36504', 'Jordania');
INSERT INTO mun VALUES (81, 'AC', '12', '00328', 'Jordão');
INSERT INTO mun VALUES (4486, 'SC', '42', '09151', 'Jose Boiteux');
INSERT INTO mun VALUES (3593, 'SP', '35', '25706', 'Jose Bonifacio');
INSERT INTO mun VALUES (1167, 'RN', '24', '06007', 'Jose Da Penha');
INSERT INTO mun VALUES (800, 'PI', '22', '05508', 'Jose De Freitas');
INSERT INTO mun VALUES (2691, 'MG', '31', '36520', 'Jose Gonçalves De Minas');
INSERT INTO mun VALUES (572, 'MA', '21', '05609', 'Joselandia');
INSERT INTO mun VALUES (2693, 'MG', '31', '36579', 'Josenopolis');
INSERT INTO mun VALUES (2692, 'MG', '31', '36553', 'Jose Raydan');
INSERT INTO mun VALUES (5489, 'GO', '52', '12105', 'Joviania');
INSERT INTO mun VALUES (11340, 'RO', '11', 'TR047', 'Jí-Paraná RO');
INSERT INTO mun VALUES (5274, 'MT', '51', '05101', 'Juara');
INSERT INTO mun VALUES (1366, 'PB', '25', '07606', 'Juarez Tavora');
INSERT INTO mun VALUES (400, 'TO', '17', '11803', 'Juarina');
INSERT INTO mun VALUES (2695, 'MG', '31', '36652', 'Juatuba');
INSERT INTO mun VALUES (1367, 'PB', '25', '07705', 'Juazeirinho');
INSERT INTO mun VALUES (2076, 'BA', '29', '18407', 'Juazeiro');
INSERT INTO mun VALUES (1015, 'CE', '23', '07304', 'Juazeiro Do Norte');
INSERT INTO mun VALUES (801, 'PI', '22', '05516', 'Juazeiro Do Piaui');
INSERT INTO mun VALUES (1016, 'CE', '23', '07403', 'Jucas');
INSERT INTO mun VALUES (2658, 'MG', '31', '33758', 'Itau De Minas');
INSERT INTO mun VALUES (791, 'PI', '22', '05102', 'Itaueira');
INSERT INTO mun VALUES (2659, 'MG', '31', '33808', 'Itauna');
INSERT INTO mun VALUES (4109, 'PR', '41', '11308', 'Itauna Do Sul');
INSERT INTO mun VALUES (5481, 'GO', '52', '11404', 'Itauçu');
INSERT INTO mun VALUES (2660, 'MG', '31', '33907', 'Itaverava');
INSERT INTO mun VALUES (2661, 'MG', '31', '34004', 'Itinga');
INSERT INTO mun VALUES (568, 'MA', '21', '05427', 'Itinga Do Maranhão');
INSERT INTO mun VALUES (5270, 'MT', '51', '04609', 'Itiquira');
INSERT INTO mun VALUES (3572, 'SP', '35', '23602', 'Itirapina');
INSERT INTO mun VALUES (3573, 'SP', '35', '23701', 'Itirapuã');
INSERT INTO mun VALUES (2058, 'BA', '29', '16906', 'Itiruçu');
INSERT INTO mun VALUES (2059, 'BA', '29', '17003', 'Itiuba');
INSERT INTO mun VALUES (3574, 'SP', '35', '23800', 'Itobi');
INSERT INTO mun VALUES (2060, 'BA', '29', '17102', 'Itororo');
INSERT INTO mun VALUES (3575, 'SP', '35', '23909', 'Itu');
INSERT INTO mun VALUES (2061, 'BA', '29', '17201', 'Ituaçu');
INSERT INTO mun VALUES (2062, 'BA', '29', '17300', 'Itubera');
INSERT INTO mun VALUES (2662, 'MG', '31', '34103', 'Itueta');
INSERT INTO mun VALUES (2663, 'MG', '31', '34202', 'Ituiutaba');
INSERT INTO mun VALUES (5482, 'GO', '52', '11503', 'Itumbiara');
INSERT INTO mun VALUES (2664, 'MG', '31', '34301', 'Itumirim');
INSERT INTO mun VALUES (3576, 'SP', '35', '24006', 'Itupeva');
INSERT INTO mun VALUES (233, 'PA', '15', '03705', 'Itupiranga');
INSERT INTO mun VALUES (4478, 'SC', '42', '08500', 'Ituporanga');
INSERT INTO mun VALUES (2665, 'MG', '31', '34400', 'Iturama');
INSERT INTO mun VALUES (2666, 'MG', '31', '34509', 'Itutinga');
INSERT INTO mun VALUES (3577, 'SP', '35', '24105', 'Ituverava');
INSERT INTO mun VALUES (2063, 'BA', '29', '17334', 'Iuiu');
INSERT INTO mun VALUES (3168, 'ES', '32', '03007', 'Iuna');
INSERT INTO mun VALUES (4110, 'PR', '41', '11407', 'Ivai');
INSERT INTO mun VALUES (4111, 'PR', '41', '11506', 'Ivaiporã');
INSERT INTO mun VALUES (4112, 'PR', '41', '11555', 'Ivate');
INSERT INTO mun VALUES (4113, 'PR', '41', '11605', 'Ivatuba');
INSERT INTO mun VALUES (5181, 'MS', '50', '04700', 'Ivinhema');
INSERT INTO mun VALUES (5483, 'GO', '52', '11602', 'Ivolandia');
INSERT INTO mun VALUES (4859, 'RS', '43', '10751', 'Ivora');
INSERT INTO mun VALUES (4860, 'RS', '43', '10801', 'Ivoti');
INSERT INTO mun VALUES (1157, 'RN', '24', '05009', 'Jaçanã');
INSERT INTO mun VALUES (1581, 'PE', '26', '07901', 'Jaboatão Dos Guararapes');
INSERT INTO mun VALUES (4479, 'SC', '42', '08609', 'Jabora');
INSERT INTO mun VALUES (3578, 'SP', '35', '24204', 'Jaborandi');
INSERT INTO mun VALUES (2064, 'BA', '29', '17359', 'Jaborandi');
INSERT INTO mun VALUES (4114, 'PR', '41', '11704', 'Jaboti');
INSERT INTO mun VALUES (4861, 'RS', '43', '10850', 'Jaboticaba');
INSERT INTO mun VALUES (3579, 'SP', '35', '24303', 'Jaboticabal');
INSERT INTO mun VALUES (2667, 'MG', '31', '34608', 'Jaboticatubas');
INSERT INTO mun VALUES (2065, 'BA', '29', '17409', 'Jacaraci');
INSERT INTO mun VALUES (1363, 'PB', '25', '07309', 'Jacarau');
INSERT INTO mun VALUES (234, 'PA', '15', '03754', 'Jacareacanga');
INSERT INTO mun VALUES (1716, 'AL', '27', '03403', 'Jacare Dos Homens');
INSERT INTO mun VALUES (3580, 'SP', '35', '24402', 'Jacarei');
INSERT INTO mun VALUES (4115, 'PR', '41', '11803', 'Jacarezinho');
INSERT INTO mun VALUES (3581, 'SP', '35', '24501', 'Jaci');
INSERT INTO mun VALUES (5271, 'MT', '51', '04807', 'Jaciara');
INSERT INTO mun VALUES (2668, 'MG', '31', '34707', 'Jacinto');
INSERT INTO mun VALUES (4480, 'SC', '42', '08708', 'Jacinto Machado');
INSERT INTO mun VALUES (2066, 'BA', '29', '17508', 'Jacobina');
INSERT INTO mun VALUES (792, 'PI', '22', '05151', 'Jacobina Do Piaui');
INSERT INTO mun VALUES (2669, 'MG', '31', '34806', 'Jacui');
INSERT INTO mun VALUES (1717, 'AL', '27', '03502', 'Jacuipe');
INSERT INTO mun VALUES (4862, 'RS', '43', '10876', 'Jacuizinho');
INSERT INTO mun VALUES (235, 'PA', '15', '03804', 'Jacunda');
INSERT INTO mun VALUES (3582, 'SP', '35', '24600', 'Jacupiranga');
INSERT INTO mun VALUES (2670, 'MG', '31', '34905', 'Jacutinga');
INSERT INTO mun VALUES (4863, 'RS', '43', '10900', 'Jacutinga');
INSERT INTO mun VALUES (4116, 'PR', '41', '11902', 'Jaguapitã');
INSERT INTO mun VALUES (2067, 'BA', '29', '17607', 'Jaguaquara');
INSERT INTO mun VALUES (2068, 'BA', '29', '17706', 'Jaguarari');
INSERT INTO mun VALUES (2671, 'MG', '31', '35001', 'Jaguaraçu');
INSERT INTO mun VALUES (3169, 'ES', '32', '03056', 'Jaguare');
INSERT INTO mun VALUES (1008, 'CE', '23', '06702', 'Jaguaretama');
INSERT INTO mun VALUES (4865, 'RS', '43', '11106', 'Jaguari');
INSERT INTO mun VALUES (4117, 'PR', '41', '12009', 'Jaguariaiva');
INSERT INTO mun VALUES (1009, 'CE', '23', '06801', 'Jaguaribara');
INSERT INTO mun VALUES (1010, 'CE', '23', '06900', 'Jaguaribe');
INSERT INTO mun VALUES (2069, 'BA', '29', '17805', 'Jaguaripe');
INSERT INTO mun VALUES (3583, 'SP', '35', '24709', 'Jaguariuna');
INSERT INTO mun VALUES (4864, 'RS', '43', '11007', 'Jaguarão');
INSERT INTO mun VALUES (1011, 'CE', '23', '07007', 'Jaguaruana');
INSERT INTO mun VALUES (4481, 'SC', '42', '08807', 'Jaguaruna');
INSERT INTO mun VALUES (2672, 'MG', '31', '35050', 'Jaiba');
INSERT INTO mun VALUES (793, 'PI', '22', '05201', 'Jaicos');
INSERT INTO mun VALUES (3584, 'SP', '35', '24808', 'Jales');
INSERT INTO mun VALUES (3585, 'SP', '35', '24907', 'Jambeiro');
INSERT INTO mun VALUES (2673, 'MG', '31', '35076', 'Jampruca');
INSERT INTO mun VALUES (2674, 'MG', '31', '35100', 'Janauba');
INSERT INTO mun VALUES (5484, 'GO', '52', '11701', 'Jandaia');
INSERT INTO mun VALUES (4118, 'PR', '41', '12108', 'Jandaia Do Sul');
INSERT INTO mun VALUES (2070, 'BA', '29', '17904', 'Jandaira');
INSERT INTO mun VALUES (1158, 'RN', '24', '05108', 'Jandaira');
INSERT INTO mun VALUES (3586, 'SP', '35', '25003', 'Jandira');
INSERT INTO mun VALUES (1159, 'RN', '24', '05207', 'Janduis');
INSERT INTO mun VALUES (5272, 'MT', '51', '04906', 'Jangada');
INSERT INTO mun VALUES (4119, 'PR', '41', '12207', 'Janiopolis');
INSERT INTO mun VALUES (2675, 'MG', '31', '35209', 'Januaria');
INSERT INTO mun VALUES (1160, 'RN', '24', '05306', 'Januario Cicco');
INSERT INTO mun VALUES (2676, 'MG', '31', '35308', 'Japaraiba');
INSERT INTO mun VALUES (1718, 'AL', '27', '03601', 'Japaratinga');
INSERT INTO mun VALUES (1813, 'SE', '28', '03302', 'Japaratuba');
INSERT INTO mun VALUES (3244, 'RJ', '33', '02270', 'Japeri');
INSERT INTO mun VALUES (1161, 'RN', '24', '05405', 'Japi');
INSERT INTO mun VALUES (4120, 'PR', '41', '12306', 'Japira');
INSERT INTO mun VALUES (566, 'MA', '21', '05351', 'Itaipava Do Grajau');
INSERT INTO mun VALUES (2643, 'MG', '31', '32305', 'Itaipe');
INSERT INTO mun VALUES (4104, 'PR', '41', '10953', 'Itaipulandia');
INSERT INTO mun VALUES (1002, 'CE', '23', '06256', 'Itaitinga');
INSERT INTO mun VALUES (232, 'PA', '15', '03606', 'Itaituba');
INSERT INTO mun VALUES (5476, 'GO', '52', '10802', 'Itaja');
INSERT INTO mun VALUES (1155, 'RN', '24', '04853', 'Itaja');
INSERT INTO mun VALUES (4474, 'SC', '42', '08203', 'Itajai');
INSERT INTO mun VALUES (3553, 'SP', '35', '21903', 'Itajobi');
INSERT INTO mun VALUES (3554, 'SP', '35', '22000', 'Itaju');
INSERT INTO mun VALUES (2644, 'MG', '31', '32404', 'Itajuba');
INSERT INTO mun VALUES (2042, 'BA', '29', '15403', 'Itaju Do Colonia');
INSERT INTO mun VALUES (2043, 'BA', '29', '15502', 'Itajuipe');
INSERT INTO mun VALUES (3240, 'RJ', '33', '02056', 'Italva');
INSERT INTO mun VALUES (1576, 'PE', '26', '07604', 'Itamaraca');
INSERT INTO mun VALUES (2044, 'BA', '29', '15601', 'Itamaraju');
INSERT INTO mun VALUES (2645, 'MG', '31', '32503', 'Itamarandiba');
INSERT INTO mun VALUES (125, 'AM', '13', '01951', 'Itamarati');
INSERT INTO mun VALUES (2646, 'MG', '31', '32602', 'Itamarati De Minas');
INSERT INTO mun VALUES (2045, 'BA', '29', '15700', 'Itamari');
INSERT INTO mun VALUES (2647, 'MG', '31', '32701', 'Itambacuri');
INSERT INTO mun VALUES (4105, 'PR', '41', '11001', 'Itambaraca');
INSERT INTO mun VALUES (428, 'TO', '17', '16307', 'Pau D''arco');
INSERT INTO mun VALUES (2046, 'BA', '29', '15809', 'Itambe');
INSERT INTO mun VALUES (1577, 'PE', '26', '07653', 'Itambe');
INSERT INTO mun VALUES (4106, 'PR', '41', '11100', 'Itambe');
INSERT INTO mun VALUES (2648, 'MG', '31', '32800', 'Itambe Do Mato Dentro');
INSERT INTO mun VALUES (2649, 'MG', '31', '32909', 'Itamogi');
INSERT INTO mun VALUES (2650, 'MG', '31', '33006', 'Itamonte');
INSERT INTO mun VALUES (2047, 'BA', '29', '15908', 'Itanagra');
INSERT INTO mun VALUES (3555, 'SP', '35', '22109', 'Itanhaem');
INSERT INTO mun VALUES (2651, 'MG', '31', '33105', 'Itanhandu');
INSERT INTO mun VALUES (2048, 'BA', '29', '16005', 'Itanhem');
INSERT INTO mun VALUES (2652, 'MG', '31', '33204', 'Itanhomi');
INSERT INTO mun VALUES (2653, 'MG', '31', '33303', 'Itaobim');
INSERT INTO mun VALUES (3556, 'SP', '35', '22158', 'Itaoca');
INSERT INTO mun VALUES (3241, 'RJ', '33', '02106', 'Itaocara');
INSERT INTO mun VALUES (5477, 'GO', '52', '10901', 'Itapaci');
INSERT INTO mun VALUES (1003, 'CE', '23', '06306', 'Itapage');
INSERT INTO mun VALUES (2654, 'MG', '31', '33402', 'Itapagipe');
INSERT INTO mun VALUES (2049, 'BA', '29', '16104', 'Itaparica');
INSERT INTO mun VALUES (2050, 'BA', '29', '16203', 'Itape');
INSERT INTO mun VALUES (2051, 'BA', '29', '16302', 'Itapebi');
INSERT INTO mun VALUES (2655, 'MG', '31', '33501', 'Itapecerica');
INSERT INTO mun VALUES (3557, 'SP', '35', '22208', 'Itapecerica Da Serra');
INSERT INTO mun VALUES (567, 'MA', '21', '05401', 'Itapecuru Mirim');
INSERT INTO mun VALUES (4475, 'SC', '42', '08302', 'Itapema');
INSERT INTO mun VALUES (3166, 'ES', '32', '02801', 'Itapemirim');
INSERT INTO mun VALUES (3242, 'RJ', '33', '02205', 'Itaperuna');
INSERT INTO mun VALUES (4108, 'PR', '41', '11258', 'Itaperuçu');
INSERT INTO mun VALUES (1578, 'PE', '26', '07703', 'Itapetim');
INSERT INTO mun VALUES (2052, 'BA', '29', '16401', 'Itapetinga');
INSERT INTO mun VALUES (3558, 'SP', '35', '22307', 'Itapetininga');
INSERT INTO mun VALUES (2656, 'MG', '31', '33600', 'Itapeva');
INSERT INTO mun VALUES (3559, 'SP', '35', '22406', 'Itapeva');
INSERT INTO mun VALUES (3560, 'SP', '35', '22505', 'Itapevi');
INSERT INTO mun VALUES (2053, 'BA', '29', '16500', 'Itapicuru');
INSERT INTO mun VALUES (1004, 'CE', '23', '06405', 'Itapipoca');
INSERT INTO mun VALUES (11339, 'CE', '23', 'TR046', 'Itapipoca CE');
INSERT INTO mun VALUES (3561, 'SP', '35', '22604', 'Itapira');
INSERT INTO mun VALUES (4476, 'SC', '42', '08401', 'Itapiranga');
INSERT INTO mun VALUES (126, 'AM', '13', '02009', 'Itapiranga');
INSERT INTO mun VALUES (5478, 'GO', '52', '11008', 'Itapirapuã');
INSERT INTO mun VALUES (3562, 'SP', '35', '22653', 'Itapirapuã Paulista');
INSERT INTO mun VALUES (397, 'TO', '17', '10904', 'Itapiratins');
INSERT INTO mun VALUES (1579, 'PE', '26', '07752', 'Itapissuma');
INSERT INTO mun VALUES (2054, 'BA', '29', '16609', 'Itapitanga');
INSERT INTO mun VALUES (1005, 'CE', '23', '06504', 'Itapiuna');
INSERT INTO mun VALUES (4477, 'SC', '42', '08450', 'Itapoa');
INSERT INTO mun VALUES (3563, 'SP', '35', '22703', 'Itapolis');
INSERT INTO mun VALUES (5179, 'MS', '50', '04502', 'Itaporã');
INSERT INTO mun VALUES (1360, 'PB', '25', '07002', 'Itaporanga');
INSERT INTO mun VALUES (3564, 'SP', '35', '22802', 'Itaporanga');
INSERT INTO mun VALUES (398, 'TO', '17', '11100', 'Itaporã Do Tocantins');
INSERT INTO mun VALUES (1361, 'PB', '25', '07101', 'Itapororoca');
INSERT INTO mun VALUES (4855, 'RS', '43', '10579', 'Itapuca');
INSERT INTO mun VALUES (56, 'RO', '11', '01104', 'Itapuã Do Oeste');
INSERT INTO mun VALUES (3565, 'SP', '35', '22901', 'Itapui');
INSERT INTO mun VALUES (3566, 'SP', '35', '23008', 'Itapura');
INSERT INTO mun VALUES (5479, 'GO', '52', '11206', 'Itapuranga');
INSERT INTO mun VALUES (3567, 'SP', '35', '23107', 'Itaquaquecetuba');
INSERT INTO mun VALUES (2055, 'BA', '29', '16708', 'Itaquara');
INSERT INTO mun VALUES (4856, 'RS', '43', '10603', 'Itaqui');
INSERT INTO mun VALUES (5180, 'MS', '50', '04601', 'Itaquirai');
INSERT INTO mun VALUES (1580, 'PE', '26', '07802', 'Itaquitinga');
INSERT INTO mun VALUES (3167, 'ES', '32', '02900', 'Itarana');
INSERT INTO mun VALUES (2056, 'BA', '29', '16807', 'Itarantim');
INSERT INTO mun VALUES (3568, 'SP', '35', '23206', 'Itarare');
INSERT INTO mun VALUES (1006, 'CE', '23', '06553', 'Itarema');
INSERT INTO mun VALUES (3569, 'SP', '35', '23305', 'Itariri');
INSERT INTO mun VALUES (5480, 'GO', '52', '11305', 'Itarumã');
INSERT INTO mun VALUES (4857, 'RS', '43', '10652', 'Itati');
INSERT INTO mun VALUES (3243, 'RJ', '33', '02254', 'Itatiaia');
INSERT INTO mun VALUES (2657, 'MG', '31', '33709', 'Itatiaiuçu');
INSERT INTO mun VALUES (3570, 'SP', '35', '23404', 'Itatiba');
INSERT INTO mun VALUES (4858, 'RS', '43', '10702', 'Itatiba Do Sul');
INSERT INTO mun VALUES (2057, 'BA', '29', '16856', 'Itatim');
INSERT INTO mun VALUES (3571, 'SP', '35', '23503', 'Itatinga');
INSERT INTO mun VALUES (1007, 'CE', '23', '06603', 'Itatira');
INSERT INTO mun VALUES (1362, 'PB', '25', '07200', 'Itatuba');
INSERT INTO mun VALUES (1156, 'RN', '24', '04903', 'Itau');
INSERT INTO mun VALUES (5269, 'MT', '51', '04559', 'Itauba');
INSERT INTO mun VALUES (325, 'AP', '16', '00253', 'Itaubal');
INSERT INTO mun VALUES (5469, 'GO', '52', '10109', 'Ipameri');
INSERT INTO mun VALUES (2632, 'MG', '31', '31208', 'Ipanema');
INSERT INTO mun VALUES (1153, 'RN', '24', '04705', 'Ipanguaçu');
INSERT INTO mun VALUES (995, 'CE', '23', '05654', 'Ipaporanga');
INSERT INTO mun VALUES (2633, 'MG', '31', '31307', 'Ipatinga');
INSERT INTO mun VALUES (996, 'CE', '23', '05704', 'Ipaumirim');
INSERT INTO mun VALUES (3542, 'SP', '35', '20905', 'Ipaussu');
INSERT INTO mun VALUES (4850, 'RS', '43', '10439', 'Ipe');
INSERT INTO mun VALUES (2024, 'BA', '29', '13804', 'Ipecaeta');
INSERT INTO mun VALUES (3543, 'SP', '35', '21002', 'Ipero');
INSERT INTO mun VALUES (3544, 'SP', '35', '21101', 'Ipeuna');
INSERT INTO mun VALUES (2025, 'BA', '29', '13903', 'Ipiau');
INSERT INTO mun VALUES (2634, 'MG', '31', '31406', 'Ipiaçu');
INSERT INTO mun VALUES (3545, 'SP', '35', '21150', 'Ipigua');
INSERT INTO mun VALUES (2026, 'BA', '29', '14000', 'Ipira');
INSERT INTO mun VALUES (4464, 'SC', '42', '07601', 'Ipira');
INSERT INTO mun VALUES (4098, 'PR', '41', '10508', 'Ipiranga');
INSERT INTO mun VALUES (5470, 'GO', '52', '10158', 'Ipiranga De Goias');
INSERT INTO mun VALUES (788, 'PI', '22', '04808', 'Ipiranga Do Piaui');
INSERT INTO mun VALUES (4851, 'RS', '43', '10462', 'Ipiranga Do Sul');
INSERT INTO mun VALUES (122, 'AM', '13', '01803', 'Ipixuna');
INSERT INTO mun VALUES (230, 'PA', '15', '03457', 'Ipixuna Do Para');
INSERT INTO mun VALUES (1572, 'PE', '26', '07208', 'Ipojuca');
INSERT INTO mun VALUES (4099, 'PR', '41', '10607', 'Iporã');
INSERT INTO mun VALUES (5471, 'GO', '52', '10208', 'Ipora');
INSERT INTO mun VALUES (3546, 'SP', '35', '21200', 'Iporanga');
INSERT INTO mun VALUES (4465, 'SC', '42', '07650', 'Iporã Do Oeste');
INSERT INTO mun VALUES (997, 'CE', '23', '05803', 'Ipu');
INSERT INTO mun VALUES (3547, 'SP', '35', '21309', 'Ipuã');
INSERT INTO mun VALUES (4466, 'SC', '42', '07684', 'Ipuaçu');
INSERT INTO mun VALUES (1573, 'PE', '26', '07307', 'Ipubi');
INSERT INTO mun VALUES (1154, 'RN', '24', '04804', 'Ipueira');
INSERT INTO mun VALUES (394, 'TO', '17', '09807', 'Ipueiras');
INSERT INTO mun VALUES (998, 'CE', '23', '05902', 'Ipueiras');
INSERT INTO mun VALUES (2635, 'MG', '31', '31505', 'Ipuiuna');
INSERT INTO mun VALUES (4467, 'SC', '42', '07700', 'Ipumirim');
INSERT INTO mun VALUES (2027, 'BA', '29', '14109', 'Ipupiara');
INSERT INTO mun VALUES (999, 'CE', '23', '06009', 'Iracema');
INSERT INTO mun VALUES (166, 'RR', '14', '00282', 'Iracema');
INSERT INTO mun VALUES (4100, 'PR', '41', '10656', 'Iracema Do Oeste');
INSERT INTO mun VALUES (3548, 'SP', '35', '21408', 'Iracemapolis');
INSERT INTO mun VALUES (4468, 'SC', '42', '07759', 'Iraceminha');
INSERT INTO mun VALUES (4852, 'RS', '43', '10504', 'Irai');
INSERT INTO mun VALUES (2636, 'MG', '31', '31604', 'Irai De Minas');
INSERT INTO mun VALUES (2029, 'BA', '29', '14307', 'Iramaia');
INSERT INTO mun VALUES (123, 'AM', '13', '01852', 'Iranduba');
INSERT INTO mun VALUES (4469, 'SC', '42', '07809', 'Irani');
INSERT INTO mun VALUES (3549, 'SP', '35', '21507', 'Irapuã');
INSERT INTO mun VALUES (3550, 'SP', '35', '21606', 'Irapuru');
INSERT INTO mun VALUES (2030, 'BA', '29', '14406', 'Iraquara');
INSERT INTO mun VALUES (2031, 'BA', '29', '14505', 'Irara');
INSERT INTO mun VALUES (4470, 'SC', '42', '07858', 'Irati');
INSERT INTO mun VALUES (4101, 'PR', '41', '10706', 'Irati');
INSERT INTO mun VALUES (1000, 'CE', '23', '06108', 'Irauçuba');
INSERT INTO mun VALUES (11338, 'BA', '29', 'TR045', 'Irecê  BA');
INSERT INTO mun VALUES (2032, 'BA', '29', '14604', 'Irece');
INSERT INTO mun VALUES (4102, 'PR', '41', '10805', 'Iretama');
INSERT INTO mun VALUES (4471, 'SC', '42', '07908', 'Irineopolis');
INSERT INTO mun VALUES (231, 'PA', '15', '03507', 'Irituia');
INSERT INTO mun VALUES (3164, 'ES', '32', '02652', 'Irupi');
INSERT INTO mun VALUES (789, 'PI', '22', '04907', 'Isaias Coelho');
INSERT INTO mun VALUES (5472, 'GO', '52', '10307', 'Israelandia');
INSERT INTO mun VALUES (4472, 'SC', '42', '08005', 'Ita');
INSERT INTO mun VALUES (4853, 'RS', '43', '10538', 'Itaara');
INSERT INTO mun VALUES (1809, 'SE', '28', '02908', 'Itabaiana');
INSERT INTO mun VALUES (1359, 'PB', '25', '06905', 'Itabaiana');
INSERT INTO mun VALUES (1810, 'SE', '28', '03005', 'Itabaianinha');
INSERT INTO mun VALUES (2033, 'BA', '29', '14653', 'Itabela');
INSERT INTO mun VALUES (3551, 'SP', '35', '21705', 'Itabera');
INSERT INTO mun VALUES (2034, 'BA', '29', '14703', 'Itaberaba');
INSERT INTO mun VALUES (5473, 'GO', '52', '10406', 'Itaberai');
INSERT INTO mun VALUES (1811, 'SE', '28', '03104', 'Itabi');
INSERT INTO mun VALUES (2637, 'MG', '31', '31703', 'Itabira');
INSERT INTO mun VALUES (2638, 'MG', '31', '31802', 'Itabirinha De Mantena');
INSERT INTO mun VALUES (2639, 'MG', '31', '31901', 'Itabirito');
INSERT INTO mun VALUES (3238, 'RJ', '33', '01900', 'Itaborai');
INSERT INTO mun VALUES (2035, 'BA', '29', '14802', 'Itabuna');
INSERT INTO mun VALUES (395, 'TO', '17', '10508', 'Itacaja');
INSERT INTO mun VALUES (2640, 'MG', '31', '32008', 'Itacambira');
INSERT INTO mun VALUES (2641, 'MG', '31', '32107', 'Itacarambi');
INSERT INTO mun VALUES (2036, 'BA', '29', '14901', 'Itacare');
INSERT INTO mun VALUES (124, 'AM', '13', '01902', 'Itacoatiara');
INSERT INTO mun VALUES (1574, 'PE', '26', '07406', 'Itacuruba');
INSERT INTO mun VALUES (4854, 'RS', '43', '10553', 'Itacurubi');
INSERT INTO mun VALUES (2037, 'BA', '29', '15007', 'Itaete');
INSERT INTO mun VALUES (2038, 'BA', '29', '15106', 'Itagi');
INSERT INTO mun VALUES (2039, 'BA', '29', '15205', 'Itagiba');
INSERT INTO mun VALUES (2040, 'BA', '29', '15304', 'Itagimirim');
INSERT INTO mun VALUES (3239, 'RJ', '33', '02007', 'Itaguai');
INSERT INTO mun VALUES (4103, 'PR', '41', '10904', 'Itaguaje');
INSERT INTO mun VALUES (2642, 'MG', '31', '32206', 'Itaguara');
INSERT INTO mun VALUES (5474, 'GO', '52', '10562', 'Itaguari');
INSERT INTO mun VALUES (5475, 'GO', '52', '10604', 'Itaguaru');
INSERT INTO mun VALUES (396, 'TO', '17', '10706', 'Itaguatins');
INSERT INTO mun VALUES (3165, 'ES', '32', '02702', 'Itaguaçu');
INSERT INTO mun VALUES (2041, 'BA', '29', '15353', 'Itaguaçu Da Bahia');
INSERT INTO mun VALUES (3552, 'SP', '35', '21804', 'Itai');
INSERT INTO mun VALUES (1001, 'CE', '23', '06207', 'Itaiçaba');
INSERT INTO mun VALUES (1575, 'PE', '26', '07505', 'Itaiba');
INSERT INTO mun VALUES (4293, 'PR', '41', '25209', 'SÃo Jorge D''oeste');
INSERT INTO mun VALUES (790, 'PI', '22', '05003', 'Itainopolis');
INSERT INTO mun VALUES (4473, 'SC', '42', '08104', 'Itaiopolis');
INSERT INTO mun VALUES (2014, 'BA', '29', '12905', 'Ibirataia');
INSERT INTO mun VALUES (3161, 'ES', '32', '02504', 'Ibiraçu');
INSERT INTO mun VALUES (2614, 'MG', '31', '29806', 'Ibirite');
INSERT INTO mun VALUES (4842, 'RS', '43', '10009', 'Ibiruba');
INSERT INTO mun VALUES (2015, 'BA', '29', '13002', 'Ibitiara');
INSERT INTO mun VALUES (3527, 'SP', '35', '19600', 'Ibitinga');
INSERT INTO mun VALUES (3162, 'ES', '32', '02553', 'Ibitirama');
INSERT INTO mun VALUES (2016, 'BA', '29', '13101', 'Ibitita');
INSERT INTO mun VALUES (2615, 'MG', '31', '29905', 'Ibitiura De Minas');
INSERT INTO mun VALUES (5609, 'SP', '35', '99999', 'Ibituiva');
INSERT INTO mun VALUES (2616, 'MG', '31', '30002', 'Ibituruna');
INSERT INTO mun VALUES (3528, 'SP', '35', '19709', 'Ibiuna');
INSERT INTO mun VALUES (2017, 'BA', '29', '13200', 'Ibotirama');
INSERT INTO mun VALUES (991, 'CE', '23', '05357', 'Icapui');
INSERT INTO mun VALUES (2617, 'MG', '31', '30051', 'Icarai De Minas');
INSERT INTO mun VALUES (4090, 'PR', '41', '09906', 'Icaraima');
INSERT INTO mun VALUES (562, 'MA', '21', '05104', 'Icatu');
INSERT INTO mun VALUES (3529, 'SP', '35', '19808', 'Icem');
INSERT INTO mun VALUES (2018, 'BA', '29', '13309', 'Ichu');
INSERT INTO mun VALUES (992, 'CE', '23', '05407', 'Ico');
INSERT INTO mun VALUES (3163, 'ES', '32', '02603', 'Iconha');
INSERT INTO mun VALUES (1152, 'RN', '24', '04606', 'Ielmo Marinho');
INSERT INTO mun VALUES (3530, 'SP', '35', '19907', 'Iepe');
INSERT INTO mun VALUES (1713, 'AL', '27', '03106', 'Igaci');
INSERT INTO mun VALUES (2019, 'BA', '29', '13408', 'Igaporã');
INSERT INTO mun VALUES (1305, 'PB', '25', '02607', 'Igaracy');
INSERT INTO mun VALUES (3532, 'SP', '35', '20103', 'Igarapava');
INSERT INTO mun VALUES (2618, 'MG', '31', '30101', 'Igarape');
INSERT INTO mun VALUES (227, 'PA', '15', '03200', 'Igarape-açu');
INSERT INTO mun VALUES (563, 'MA', '21', '05153', 'Igarape Do Meio');
INSERT INTO mun VALUES (564, 'MA', '21', '05203', 'Igarape Grande');
INSERT INTO mun VALUES (228, 'PA', '15', '03309', 'Igarape-miri');
INSERT INTO mun VALUES (1568, 'PE', '26', '06804', 'Igarassu');
INSERT INTO mun VALUES (3533, 'SP', '35', '20202', 'Igarata');
INSERT INTO mun VALUES (2619, 'MG', '31', '30200', 'Igaratinga');
INSERT INTO mun VALUES (3531, 'SP', '35', '20004', 'Igaraçu Do Tiete');
INSERT INTO mun VALUES (2020, 'BA', '29', '13457', 'Igrapiuna');
INSERT INTO mun VALUES (1714, 'AL', '27', '03205', 'Igreja Nova');
INSERT INTO mun VALUES (4843, 'RS', '43', '10108', 'Igrejinha');
INSERT INTO mun VALUES (3237, 'RJ', '33', '01876', 'Iguaba Grande');
INSERT INTO mun VALUES (2021, 'BA', '29', '13507', 'Iguai');
INSERT INTO mun VALUES (3534, 'SP', '35', '20301', 'Iguape');
INSERT INTO mun VALUES (1569, 'PE', '26', '06903', 'Iguaraci');
INSERT INTO mun VALUES (4091, 'PR', '41', '10003', 'Iguaraçu');
INSERT INTO mun VALUES (2620, 'MG', '31', '30309', 'Iguatama');
INSERT INTO mun VALUES (5177, 'MS', '50', '04304', 'Iguatemi');
INSERT INTO mun VALUES (993, 'CE', '23', '05506', 'Iguatu');
INSERT INTO mun VALUES (4092, 'PR', '41', '10052', 'Iguatu');
INSERT INTO mun VALUES (2621, 'MG', '31', '30408', 'Ijaci');
INSERT INTO mun VALUES (4844, 'RS', '43', '10207', 'Ijui');
INSERT INTO mun VALUES (3535, 'SP', '35', '20400', 'Ilhabela');
INSERT INTO mun VALUES (3536, 'SP', '35', '20426', 'Ilha Comprida');
INSERT INTO mun VALUES (1807, 'SE', '28', '02700', 'Ilha Das Flores');
INSERT INTO mun VALUES (786, 'PI', '22', '04659', 'Ilha Grande');
INSERT INTO mun VALUES (3537, 'SP', '35', '20442', 'Ilha Solteira');
INSERT INTO mun VALUES (2022, 'BA', '29', '13606', 'Ilheus');
INSERT INTO mun VALUES (4458, 'SC', '42', '07106', 'Ilhota');
INSERT INTO mun VALUES (2622, 'MG', '31', '30507', 'Ilicinea');
INSERT INTO mun VALUES (4845, 'RS', '43', '10306', 'Ilopolis');
INSERT INTO mun VALUES (1357, 'PB', '25', '06707', 'Imaculada');
INSERT INTO mun VALUES (4459, 'SC', '42', '07205', 'Imarui');
INSERT INTO mun VALUES (4093, 'PR', '41', '10078', 'Imbau');
INSERT INTO mun VALUES (4846, 'RS', '43', '10330', 'Imbe');
INSERT INTO mun VALUES (2623, 'MG', '31', '30556', 'Imbe De Minas');
INSERT INTO mun VALUES (4460, 'SC', '42', '07304', 'Imbituba');
INSERT INTO mun VALUES (4094, 'PR', '41', '10102', 'Imbituva');
INSERT INTO mun VALUES (4461, 'SC', '42', '07403', 'Imbuia');
INSERT INTO mun VALUES (4847, 'RS', '43', '10363', 'Imigrante');
INSERT INTO mun VALUES (565, 'MA', '21', '05302', 'Imperatriz');
INSERT INTO mun VALUES (5466, 'GO', '52', '09937', 'Inaciolandia');
INSERT INTO mun VALUES (4095, 'PR', '41', '10201', 'Inacio Martins');
INSERT INTO mun VALUES (4096, 'PR', '41', '10300', 'Inaja');
INSERT INTO mun VALUES (1570, 'PE', '26', '07000', 'Inaja');
INSERT INTO mun VALUES (2624, 'MG', '31', '30606', 'Inconfidentes');
INSERT INTO mun VALUES (2625, 'MG', '31', '30655', 'Indaiabira');
INSERT INTO mun VALUES (4462, 'SC', '42', '07502', 'Indaial');
INSERT INTO mun VALUES (3538, 'SP', '35', '20509', 'Indaiatuba');
INSERT INTO mun VALUES (4848, 'RS', '43', '10405', 'Independencia');
INSERT INTO mun VALUES (994, 'CE', '23', '05605', 'Independencia');
INSERT INTO mun VALUES (3539, 'SP', '35', '20608', 'Indiana');
INSERT INTO mun VALUES (2626, 'MG', '31', '30705', 'Indianopolis');
INSERT INTO mun VALUES (4097, 'PR', '41', '10409', 'Indianopolis');
INSERT INTO mun VALUES (3540, 'SP', '35', '20707', 'Indiaporã');
INSERT INTO mun VALUES (5467, 'GO', '52', '09952', 'Indiara');
INSERT INTO mun VALUES (1808, 'SE', '28', '02809', 'Indiaroba');
INSERT INTO mun VALUES (5268, 'MT', '51', '04500', 'Indiavai');
INSERT INTO mun VALUES (1358, 'PB', '25', '06806', 'Inga');
INSERT INTO mun VALUES (2627, 'MG', '31', '30804', 'Ingai');
INSERT INTO mun VALUES (1571, 'PE', '26', '07109', 'Ingazeira');
INSERT INTO mun VALUES (4849, 'RS', '43', '10413', 'Inhacora');
INSERT INTO mun VALUES (2023, 'BA', '29', '13705', 'Inhambupe');
INSERT INTO mun VALUES (11337, 'CE', '23', 'TR044', 'Inhamuns Crateús CE');
INSERT INTO mun VALUES (229, 'PA', '15', '03408', 'Inhangapi');
INSERT INTO mun VALUES (1715, 'AL', '27', '03304', 'Inhapi');
INSERT INTO mun VALUES (2628, 'MG', '31', '30903', 'Inhapim');
INSERT INTO mun VALUES (2629, 'MG', '31', '31000', 'Inhauma');
INSERT INTO mun VALUES (787, 'PI', '22', '04709', 'Inhuma');
INSERT INTO mun VALUES (5468, 'GO', '52', '10000', 'Inhumas');
INSERT INTO mun VALUES (2630, 'MG', '31', '31109', 'Inimutaba');
INSERT INTO mun VALUES (5178, 'MS', '50', '04403', 'Inocencia');
INSERT INTO mun VALUES (3541, 'SP', '35', '20806', 'Inubia Paulista');
INSERT INTO mun VALUES (4463, 'SC', '42', '07577', 'Iomere');
INSERT INTO mun VALUES (2631, 'MG', '31', '31158', 'Ipaba');
INSERT INTO mun VALUES (4082, 'PR', '41', '09302', 'Guaraniaçu');
INSERT INTO mun VALUES (4832, 'RS', '43', '09506', 'Guarani Das Missões');
INSERT INTO mun VALUES (5460, 'GO', '52', '09408', 'Guarani De Goias');
INSERT INTO mun VALUES (3508, 'SP', '35', '18107', 'Guarantã');
INSERT INTO mun VALUES (5266, 'MT', '51', '04104', 'Guarantã Do Norte');
INSERT INTO mun VALUES (3159, 'ES', '32', '02405', 'Guarapari');
INSERT INTO mun VALUES (4083, 'PR', '41', '09401', 'Guarapuava');
INSERT INTO mun VALUES (4084, 'PR', '41', '09500', 'Guaraqueçaba');
INSERT INTO mun VALUES (2600, 'MG', '31', '28501', 'Guarara');
INSERT INTO mun VALUES (3509, 'SP', '35', '18206', 'Guararapes');
INSERT INTO mun VALUES (3510, 'SP', '35', '18305', 'Guararema');
INSERT INTO mun VALUES (2002, 'BA', '29', '11808', 'Guaratinga');
INSERT INTO mun VALUES (3511, 'SP', '35', '18404', 'Guaratingueta');
INSERT INTO mun VALUES (4085, 'PR', '41', '09609', 'Guaratuba');
INSERT INTO mun VALUES (2601, 'MG', '31', '28600', 'Guarda-mor');
INSERT INTO mun VALUES (3512, 'SP', '35', '18503', 'Guarei');
INSERT INTO mun VALUES (3513, 'SP', '35', '18602', 'Guariba');
INSERT INTO mun VALUES (784, 'PI', '22', '04550', 'Guaribas');
INSERT INTO mun VALUES (5461, 'GO', '52', '09457', 'Guarinos');
INSERT INTO mun VALUES (3514, 'SP', '35', '18701', 'Guaruja');
INSERT INTO mun VALUES (4451, 'SC', '42', '06603', 'Guaruja Do Sul');
INSERT INTO mun VALUES (3515, 'SP', '35', '18800', 'Guarulhos');
INSERT INTO mun VALUES (4452, 'SC', '42', '06652', 'Guatambu');
INSERT INTO mun VALUES (3516, 'SP', '35', '18859', 'Guatapara');
INSERT INTO mun VALUES (3158, 'ES', '32', '02306', 'Guaçui');
INSERT INTO mun VALUES (2602, 'MG', '31', '28709', 'Guaxupe');
INSERT INTO mun VALUES (5176, 'MS', '50', '04106', 'Guia Lopes Da Laguna');
INSERT INTO mun VALUES (2603, 'MG', '31', '28808', 'Guidoval');
INSERT INTO mun VALUES (2604, 'MG', '31', '28907', 'Guimarania');
INSERT INTO mun VALUES (560, 'MA', '21', '04909', 'Guimarães');
INSERT INTO mun VALUES (11336, 'MG', '31', 'TR043', 'Guimarães Rosa  MG');
INSERT INTO mun VALUES (5267, 'MT', '51', '04203', 'Guiratinga');
INSERT INTO mun VALUES (2605, 'MG', '31', '29004', 'Guiricema');
INSERT INTO mun VALUES (2606, 'MG', '31', '29103', 'Gurinhatã');
INSERT INTO mun VALUES (1354, 'PB', '25', '06400', 'Gurinhem');
INSERT INTO mun VALUES (1355, 'PB', '25', '06509', 'Gurjão');
INSERT INTO mun VALUES (226, 'PA', '15', '03101', 'Gurupa');
INSERT INTO mun VALUES (393, 'TO', '17', '09500', 'Gurupi');
INSERT INTO mun VALUES (3517, 'SP', '35', '18909', 'Guzolandia');
INSERT INTO mun VALUES (4833, 'RS', '43', '09555', 'Harmonia');
INSERT INTO mun VALUES (5462, 'GO', '52', '09606', 'Heitorai');
INSERT INTO mun VALUES (2607, 'MG', '31', '29202', 'Heliodora');
INSERT INTO mun VALUES (2003, 'BA', '29', '11857', 'Heliopolis');
INSERT INTO mun VALUES (3518, 'SP', '35', '19006', 'Herculandia');
INSERT INTO mun VALUES (4792, 'RS', '43', '07104', 'Herval');
INSERT INTO mun VALUES (4834, 'RS', '43', '09571', 'Herveiras');
INSERT INTO mun VALUES (5463, 'GO', '52', '09705', 'Hidrolandia');
INSERT INTO mun VALUES (986, 'CE', '23', '05209', 'Hidrolandia');
INSERT INTO mun VALUES (5464, 'GO', '52', '09804', 'Hidrolina');
INSERT INTO mun VALUES (3519, 'SP', '35', '19055', 'Holambra');
INSERT INTO mun VALUES (4086, 'PR', '41', '09658', 'Honorio Serpa');
INSERT INTO mun VALUES (987, 'CE', '23', '05233', 'Horizonte');
INSERT INTO mun VALUES (4835, 'RS', '43', '09605', 'Horizontina');
INSERT INTO mun VALUES (3520, 'SP', '35', '19071', 'Hortolandia');
INSERT INTO mun VALUES (785, 'PI', '22', '04600', 'Hugo Napoleão');
INSERT INTO mun VALUES (4836, 'RS', '43', '09654', 'Hulha Negra');
INSERT INTO mun VALUES (4837, 'RS', '43', '09704', 'Humaita');
INSERT INTO mun VALUES (121, 'AM', '13', '01704', 'Humaita');
INSERT INTO mun VALUES (561, 'MA', '21', '05005', 'Humberto De Campos');
INSERT INTO mun VALUES (3521, 'SP', '35', '19105', 'Iacanga');
INSERT INTO mun VALUES (5465, 'GO', '52', '09903', 'Iaciara');
INSERT INTO mun VALUES (3522, 'SP', '35', '19204', 'Iacri');
INSERT INTO mun VALUES (2608, 'MG', '31', '29301', 'Iapu');
INSERT INTO mun VALUES (4457, 'SC', '42', '07007', 'Içara');
INSERT INTO mun VALUES (3523, 'SP', '35', '19253', 'Iaras');
INSERT INTO mun VALUES (1565, 'PE', '26', '06507', 'Iati');
INSERT INTO mun VALUES (2004, 'BA', '29', '11907', 'Iaçu');
INSERT INTO mun VALUES (4087, 'PR', '41', '09708', 'Ibaiti');
INSERT INTO mun VALUES (4838, 'RS', '43', '09753', 'Ibarama');
INSERT INTO mun VALUES (988, 'CE', '23', '05266', 'Ibaretama');
INSERT INTO mun VALUES (3524, 'SP', '35', '19303', 'Ibate');
INSERT INTO mun VALUES (1712, 'AL', '27', '03007', 'Ibateguara');
INSERT INTO mun VALUES (3160, 'ES', '32', '02454', 'Ibatiba');
INSERT INTO mun VALUES (4088, 'PR', '41', '09757', 'Ibema');
INSERT INTO mun VALUES (2609, 'MG', '31', '29400', 'Ibertioga');
INSERT INTO mun VALUES (2610, 'MG', '31', '29509', 'Ibia');
INSERT INTO mun VALUES (4839, 'RS', '43', '09803', 'Ibiaça');
INSERT INTO mun VALUES (2611, 'MG', '31', '29608', 'Ibiai');
INSERT INTO mun VALUES (4454, 'SC', '42', '06751', 'Ibiam');
INSERT INTO mun VALUES (989, 'CE', '23', '05308', 'Ibiapina');
INSERT INTO mun VALUES (1356, 'PB', '25', '06608', 'Ibiara');
INSERT INTO mun VALUES (2005, 'BA', '29', '12004', 'Ibiassuce');
INSERT INTO mun VALUES (2006, 'BA', '29', '12103', 'Ibicarai');
INSERT INTO mun VALUES (4455, 'SC', '42', '06801', 'Ibicare');
INSERT INTO mun VALUES (2007, 'BA', '29', '12202', 'Ibicoara');
INSERT INTO mun VALUES (2008, 'BA', '29', '12301', 'Ibicui');
INSERT INTO mun VALUES (990, 'CE', '23', '05332', 'Ibicuitinga');
INSERT INTO mun VALUES (1566, 'PE', '26', '06606', 'Ibimirim');
INSERT INTO mun VALUES (2009, 'BA', '29', '12400', 'Ibipeba');
INSERT INTO mun VALUES (2010, 'BA', '29', '12509', 'Ibipitanga');
INSERT INTO mun VALUES (4089, 'PR', '41', '09807', 'Ibiporã');
INSERT INTO mun VALUES (2011, 'BA', '29', '12608', 'Ibiquera');
INSERT INTO mun VALUES (3525, 'SP', '35', '19402', 'Ibira');
INSERT INTO mun VALUES (2612, 'MG', '31', '29657', 'Ibiracatu');
INSERT INTO mun VALUES (2613, 'MG', '31', '29707', 'Ibiraci');
INSERT INTO mun VALUES (4840, 'RS', '43', '09902', 'Ibiraiaras');
INSERT INTO mun VALUES (1567, 'PE', '26', '06705', 'Ibirajuba');
INSERT INTO mun VALUES (4456, 'SC', '42', '06900', 'Ibirama');
INSERT INTO mun VALUES (2012, 'BA', '29', '12707', 'Ibirapitanga');
INSERT INTO mun VALUES (2013, 'BA', '29', '12806', 'Ibirapuã');
INSERT INTO mun VALUES (4841, 'RS', '43', '09951', 'Ibirapuitã');
INSERT INTO mun VALUES (3526, 'SP', '35', '19501', 'Ibirarema');
INSERT INTO mun VALUES (1997, 'BA', '29', '11402', 'Gloria');
INSERT INTO mun VALUES (5175, 'MS', '50', '04007', 'Gloria De Dourados');
INSERT INTO mun VALUES (1561, 'PE', '26', '06101', 'Gloria Do Goita');
INSERT INTO mun VALUES (4824, 'RS', '43', '09050', 'Glorinha');
INSERT INTO mun VALUES (550, 'MA', '21', '04305', 'Godofredo Viana');
INSERT INTO mun VALUES (4072, 'PR', '41', '08551', 'Godoy Moreira');
INSERT INTO mun VALUES (2586, 'MG', '31', '27370', 'Goiabeira');
INSERT INTO mun VALUES (1562, 'PE', '26', '06200', 'Goiana');
INSERT INTO mun VALUES (2587, 'MG', '31', '27388', 'Goiana');
INSERT INTO mun VALUES (5450, 'GO', '52', '08400', 'Goianapolis');
INSERT INTO mun VALUES (5451, 'GO', '52', '08509', 'Goiandira');
INSERT INTO mun VALUES (5452, 'GO', '52', '08608', 'Goianesia');
INSERT INTO mun VALUES (225, 'PA', '15', '03093', 'Goianesia Do Para');
INSERT INTO mun VALUES (5453, 'GO', '52', '08707', 'Goiania');
INSERT INTO mun VALUES (1148, 'RN', '24', '04200', 'Goianinha');
INSERT INTO mun VALUES (5454, 'GO', '52', '08806', 'Goianira');
INSERT INTO mun VALUES (390, 'TO', '17', '08304', 'Goianorte');
INSERT INTO mun VALUES (5455, 'GO', '52', '08905', 'Goias');
INSERT INTO mun VALUES (391, 'TO', '17', '09005', 'Goiatins');
INSERT INTO mun VALUES (5456, 'GO', '52', '09101', 'Goiatuba');
INSERT INTO mun VALUES (4073, 'PR', '41', '08601', 'Goioere');
INSERT INTO mun VALUES (4074, 'PR', '41', '08650', 'Goioxim');
INSERT INTO mun VALUES (5358, 'GO', '52', '00000', 'Goiás');
INSERT INTO mun VALUES (2588, 'MG', '31', '27404', 'Gonçalves');
INSERT INTO mun VALUES (551, 'MA', '21', '04404', 'Gonçalves Dias');
INSERT INTO mun VALUES (1998, 'BA', '29', '11501', 'Gongogi');
INSERT INTO mun VALUES (2589, 'MG', '31', '27503', 'Gonzaga');
INSERT INTO mun VALUES (2590, 'MG', '31', '27602', 'Gouveia');
INSERT INTO mun VALUES (5457, 'GO', '52', '09150', 'Gouvelandia');
INSERT INTO mun VALUES (552, 'MA', '21', '04503', 'Governador Archer');
INSERT INTO mun VALUES (4445, 'SC', '42', '06009', 'Governador Celso Ramos');
INSERT INTO mun VALUES (1149, 'RN', '24', '04309', 'Governador Dix-sept Rosa');
INSERT INTO mun VALUES (553, 'MA', '21', '04552', 'Governador Edison Lobão');
INSERT INTO mun VALUES (554, 'MA', '21', '04602', 'Governador Eugenio Barro');
INSERT INTO mun VALUES (55, 'RO', '11', '01005', 'Governador Jorge Teixeir');
INSERT INTO mun VALUES (3157, 'ES', '32', '02256', 'Governador Lindenberg');
INSERT INTO mun VALUES (555, 'MA', '21', '04628', 'Governador Luiz Rocha');
INSERT INTO mun VALUES (1999, 'BA', '29', '11600', 'Governador Mangabeira');
INSERT INTO mun VALUES (556, 'MA', '21', '04651', 'Governador Newton Bello');
INSERT INTO mun VALUES (557, 'MA', '21', '04677', 'Governador Nunes Freire');
INSERT INTO mun VALUES (2591, 'MG', '31', '27701', 'Governador Valadares');
INSERT INTO mun VALUES (979, 'CE', '23', '04657', 'Graça');
INSERT INTO mun VALUES (558, 'MA', '21', '04701', 'Graça Aranha');
INSERT INTO mun VALUES (1806, 'SE', '28', '02601', 'Gracho Cardoso');
INSERT INTO mun VALUES (559, 'MA', '21', '04800', 'Grajau');
INSERT INTO mun VALUES (4825, 'RS', '43', '09100', 'Gramado');
INSERT INTO mun VALUES (4826, 'RS', '43', '09126', 'Gramado Dos Loureiros');
INSERT INTO mun VALUES (4827, 'RS', '43', '09159', 'Gramado Xavier');
INSERT INTO mun VALUES (11335, 'MS', '50', 'TR042', 'Grande Dourados MS');
INSERT INTO mun VALUES (4075, 'PR', '41', '08700', 'Grandes Rios');
INSERT INTO mun VALUES (1563, 'PE', '26', '06309', 'Granito');
INSERT INTO mun VALUES (980, 'CE', '23', '04707', 'Granja');
INSERT INTO mun VALUES (981, 'CE', '23', '04806', 'Granjeiro');
INSERT INTO mun VALUES (1564, 'PE', '26', '06408', 'Gravata');
INSERT INTO mun VALUES (4828, 'RS', '43', '09209', 'Gravatai');
INSERT INTO mun VALUES (4447, 'SC', '42', '06207', 'Gravatal');
INSERT INTO mun VALUES (982, 'CE', '23', '04905', 'Groairas');
INSERT INTO mun VALUES (2592, 'MG', '31', '27800', 'Grão Mogol');
INSERT INTO mun VALUES (4446, 'SC', '42', '06108', 'Grão Para');
INSERT INTO mun VALUES (1150, 'RN', '24', '04408', 'Grossos');
INSERT INTO mun VALUES (2593, 'MG', '31', '27909', 'Grupiara');
INSERT INTO mun VALUES (4829, 'RS', '43', '09258', 'Guabiju');
INSERT INTO mun VALUES (4448, 'SC', '42', '06306', 'Guabiruba');
INSERT INTO mun VALUES (783, 'PI', '22', '04501', 'Guadalupe');
INSERT INTO mun VALUES (3499, 'SP', '35', '17208', 'Guaiçara');
INSERT INTO mun VALUES (4830, 'RS', '43', '09308', 'Guaiba');
INSERT INTO mun VALUES (3500, 'SP', '35', '17307', 'Guaimbe');
INSERT INTO mun VALUES (3501, 'SP', '35', '17406', 'Guaira');
INSERT INTO mun VALUES (4076, 'PR', '41', '08809', 'Guaira');
INSERT INTO mun VALUES (4077, 'PR', '41', '08908', 'Guairaça');
INSERT INTO mun VALUES (983, 'CE', '23', '04954', 'Guaiuba');
INSERT INTO mun VALUES (120, 'AM', '13', '01654', 'Guajara');
INSERT INTO mun VALUES (29, 'RO', '11', '00106', 'Guajara-mirim');
INSERT INTO mun VALUES (2000, 'BA', '29', '11659', 'Guajeru');
INSERT INTO mun VALUES (1151, 'RN', '24', '04507', 'Guamare');
INSERT INTO mun VALUES (4078, 'PR', '41', '08957', 'Guamiranga');
INSERT INTO mun VALUES (2001, 'BA', '29', '11709', 'Guanambi');
INSERT INTO mun VALUES (2594, 'MG', '31', '28006', 'Guanhães');
INSERT INTO mun VALUES (2595, 'MG', '31', '28105', 'Guape');
INSERT INTO mun VALUES (3503, 'SP', '35', '17604', 'Guapiara');
INSERT INTO mun VALUES (3502, 'SP', '35', '17505', 'Guapiaçu');
INSERT INTO mun VALUES (3236, 'RJ', '33', '01850', 'Guapimirim');
INSERT INTO mun VALUES (4079, 'PR', '41', '09005', 'Guapirama');
INSERT INTO mun VALUES (5458, 'GO', '52', '09200', 'Guapo');
INSERT INTO mun VALUES (4831, 'RS', '43', '09407', 'Guapore');
INSERT INTO mun VALUES (4080, 'PR', '41', '09104', 'Guaporema');
INSERT INTO mun VALUES (3504, 'SP', '35', '17703', 'Guara');
INSERT INTO mun VALUES (3505, 'SP', '35', '17802', 'Guaraçai');
INSERT INTO mun VALUES (1353, 'PB', '25', '06301', 'Guarabira');
INSERT INTO mun VALUES (3506, 'SP', '35', '17901', 'Guaraci');
INSERT INTO mun VALUES (4081, 'PR', '41', '09203', 'Guaraci');
INSERT INTO mun VALUES (4449, 'SC', '42', '06405', 'Guaraciaba');
INSERT INTO mun VALUES (2596, 'MG', '31', '28204', 'Guaraciaba');
INSERT INTO mun VALUES (984, 'CE', '23', '05001', 'Guaraciaba Do Norte');
INSERT INTO mun VALUES (2597, 'MG', '31', '28253', 'Guaraciama');
INSERT INTO mun VALUES (392, 'TO', '17', '09302', 'Guarai');
INSERT INTO mun VALUES (5459, 'GO', '52', '09291', 'Guaraita');
INSERT INTO mun VALUES (985, 'CE', '23', '05100', 'Guaramiranga');
INSERT INTO mun VALUES (4450, 'SC', '42', '06504', 'Guaramirim');
INSERT INTO mun VALUES (2598, 'MG', '31', '28303', 'Guaranesia');
INSERT INTO mun VALUES (2599, 'MG', '31', '28402', 'Guarani');
INSERT INTO mun VALUES (3487, 'SP', '35', '16101', 'Florinia');
INSERT INTO mun VALUES (119, 'AM', '13', '01605', 'Fonte Boa');
INSERT INTO mun VALUES (4812, 'RS', '43', '08300', 'Fontoura Xavier');
INSERT INTO mun VALUES (2567, 'MG', '31', '26109', 'Formiga');
INSERT INTO mun VALUES (4813, 'RS', '43', '08409', 'Formigueiro');
INSERT INTO mun VALUES (5446, 'GO', '52', '08004', 'Formosa');
INSERT INTO mun VALUES (547, 'MA', '21', '04099', 'Formosa Da Serra Negra');
INSERT INTO mun VALUES (4066, 'PR', '41', '08205', 'Formosa Do Oeste');
INSERT INTO mun VALUES (1993, 'BA', '29', '11105', 'Formosa Do Rio Preto');
INSERT INTO mun VALUES (4437, 'SC', '42', '05431', 'Formosa Do Sul');
INSERT INTO mun VALUES (2568, 'MG', '31', '26208', 'Formoso');
INSERT INTO mun VALUES (5447, 'GO', '52', '08103', 'Formoso');
INSERT INTO mun VALUES (388, 'TO', '17', '08205', 'Formoso Do Araguaia');
INSERT INTO mun VALUES (4814, 'RS', '43', '08433', 'Forquetinha');
INSERT INTO mun VALUES (974, 'CE', '23', '04350', 'Forquilha');
INSERT INTO mun VALUES (4438, 'SC', '42', '05456', 'Forquilhinha');
INSERT INTO mun VALUES (975, 'CE', '23', '04400', 'Fortaleza');
INSERT INTO mun VALUES (2569, 'MG', '31', '26307', 'Fortaleza De Minas');
INSERT INTO mun VALUES (548, 'MA', '21', '04107', 'Fortaleza Dos Nogueiras');
INSERT INTO mun VALUES (4815, 'RS', '43', '08458', 'Fortaleza Dos Valos');
INSERT INTO mun VALUES (389, 'TO', '17', '08254', 'Fortaleza Do Tabocão');
INSERT INTO mun VALUES (976, 'CE', '23', '04459', 'Fortim');
INSERT INTO mun VALUES (549, 'MA', '21', '04206', 'Fortuna');
INSERT INTO mun VALUES (2570, 'MG', '31', '26406', 'Fortuna De Minas');
INSERT INTO mun VALUES (4067, 'PR', '41', '08304', 'Foz Do Iguaçu');
INSERT INTO mun VALUES (4070, 'PR', '41', '08452', 'Foz Do Jordão');
INSERT INTO mun VALUES (4439, 'SC', '42', '05506', 'Fraiburgo');
INSERT INTO mun VALUES (3488, 'SP', '35', '16200', 'Franca');
INSERT INTO mun VALUES (776, 'PI', '22', '04006', 'Francinopolis');
INSERT INTO mun VALUES (4068, 'PR', '41', '08320', 'Francisco Alves');
INSERT INTO mun VALUES (777, 'PI', '22', '04105', 'Francisco Ayres');
INSERT INTO mun VALUES (2571, 'MG', '31', '26505', 'Francisco Badaro');
INSERT INTO mun VALUES (4069, 'PR', '41', '08403', 'Francisco Beltrão');
INSERT INTO mun VALUES (1145, 'RN', '24', '03905', 'Francisco Dantas');
INSERT INTO mun VALUES (2572, 'MG', '31', '26604', 'Francisco Dumont');
INSERT INTO mun VALUES (778, 'PI', '22', '04154', 'Francisco Macedo');
INSERT INTO mun VALUES (3489, 'SP', '35', '16309', 'Francisco Morato');
INSERT INTO mun VALUES (2574, 'MG', '31', '26752', 'Franciscopolis');
INSERT INTO mun VALUES (2573, 'MG', '31', '26703', 'Francisco Sa');
INSERT INTO mun VALUES (779, 'PI', '22', '04204', 'Francisco Santos');
INSERT INTO mun VALUES (3490, 'SP', '35', '16408', 'Franco Da Rocha');
INSERT INTO mun VALUES (977, 'CE', '23', '04509', 'Frecheirinha');
INSERT INTO mun VALUES (1138, 'RN', '24', '03301', 'Encanto');
INSERT INTO mun VALUES (4816, 'RS', '43', '08508', 'Frederico Westphalen');
INSERT INTO mun VALUES (2575, 'MG', '31', '26802', 'Frei Gaspar');
INSERT INTO mun VALUES (2576, 'MG', '31', '26901', 'Frei Inocencio');
INSERT INTO mun VALUES (2577, 'MG', '31', '26950', 'Frei Lagonegro');
INSERT INTO mun VALUES (1351, 'PB', '25', '06202', 'Frei Martinho');
INSERT INTO mun VALUES (1558, 'PE', '26', '05806', 'Frei Miguelinho');
INSERT INTO mun VALUES (1803, 'SE', '28', '02304', 'Frei Paulo');
INSERT INTO mun VALUES (4440, 'SC', '42', '05555', 'Frei Rogerio');
INSERT INTO mun VALUES (2578, 'MG', '31', '27008', 'Fronteira');
INSERT INTO mun VALUES (2579, 'MG', '31', '27057', 'Fronteira Dos Vales');
INSERT INTO mun VALUES (780, 'PI', '22', '04303', 'Fronteiras');
INSERT INTO mun VALUES (2580, 'MG', '31', '27073', 'Fruta De Leite');
INSERT INTO mun VALUES (2581, 'MG', '31', '27107', 'Frutal');
INSERT INTO mun VALUES (1146, 'RN', '24', '04002', 'Frutuoso Gomes');
INSERT INTO mun VALUES (3156, 'ES', '32', '02207', 'Fundão');
INSERT INTO mun VALUES (2582, 'MG', '31', '27206', 'Funilandia');
INSERT INTO mun VALUES (3491, 'SP', '35', '16507', 'Gabriel Monteiro');
INSERT INTO mun VALUES (1352, 'PB', '25', '06251', 'Gado Bravo');
INSERT INTO mun VALUES (3492, 'SP', '35', '16606', 'Galia');
INSERT INTO mun VALUES (2583, 'MG', '31', '27305', 'Galileia');
INSERT INTO mun VALUES (1147, 'RN', '24', '04101', 'Galinhos');
INSERT INTO mun VALUES (4441, 'SC', '42', '05605', 'Galvão');
INSERT INTO mun VALUES (1559, 'PE', '26', '05905', 'Gameleira');
INSERT INTO mun VALUES (5448, 'GO', '52', '08152', 'Gameleira De Goias');
INSERT INTO mun VALUES (2584, 'MG', '31', '27339', 'Gameleiras');
INSERT INTO mun VALUES (1994, 'BA', '29', '11204', 'Gandu');
INSERT INTO mun VALUES (3493, 'SP', '35', '16705', 'Garça');
INSERT INTO mun VALUES (1560, 'PE', '26', '06002', 'Garanhuns');
INSERT INTO mun VALUES (1804, 'SE', '28', '02403', 'Gararu');
INSERT INTO mun VALUES (4817, 'RS', '43', '08607', 'Garibaldi');
INSERT INTO mun VALUES (4442, 'SC', '42', '05704', 'Garopaba');
INSERT INTO mun VALUES (224, 'PA', '15', '03077', 'Garrafão Do Norte');
INSERT INTO mun VALUES (4818, 'RS', '43', '08656', 'Garruchos');
INSERT INTO mun VALUES (4443, 'SC', '42', '05803', 'Garuva');
INSERT INTO mun VALUES (4444, 'SC', '42', '05902', 'Gaspar');
INSERT INTO mun VALUES (3494, 'SP', '35', '16804', 'Gastão Vidigal');
INSERT INTO mun VALUES (5263, 'MT', '51', '03858', 'Gaucha Do Norte');
INSERT INTO mun VALUES (4819, 'RS', '43', '08706', 'Gaurama');
INSERT INTO mun VALUES (1995, 'BA', '29', '11253', 'Gavião');
INSERT INTO mun VALUES (3495, 'SP', '35', '16853', 'Gavião Peixoto');
INSERT INTO mun VALUES (781, 'PI', '22', '04352', 'Geminiano');
INSERT INTO mun VALUES (4820, 'RS', '43', '08805', 'General Camara');
INSERT INTO mun VALUES (5264, 'MT', '51', '03908', 'General Carneiro');
INSERT INTO mun VALUES (4071, 'PR', '41', '08502', 'General Carneiro');
INSERT INTO mun VALUES (1805, 'SE', '28', '02502', 'General Maynard');
INSERT INTO mun VALUES (3496, 'SP', '35', '16903', 'General Salgado');
INSERT INTO mun VALUES (978, 'CE', '23', '04608', 'General Sampaio');
INSERT INTO mun VALUES (4821, 'RS', '43', '08854', 'Gentil');
INSERT INTO mun VALUES (1996, 'BA', '29', '11303', 'Gentio Do Ouro');
INSERT INTO mun VALUES (3497, 'SP', '35', '17000', 'Getulina');
INSERT INTO mun VALUES (4822, 'RS', '43', '08904', 'Getulio Vargas');
INSERT INTO mun VALUES (782, 'PI', '22', '04402', 'Gilbues');
INSERT INTO mun VALUES (1711, 'AL', '27', '02900', 'Girau Do Ponciano');
INSERT INTO mun VALUES (4823, 'RS', '43', '09001', 'Girua');
INSERT INTO mun VALUES (2585, 'MG', '31', '27354', 'Glaucilandia');
INSERT INTO mun VALUES (3498, 'SP', '35', '17109', 'Glicerio');
INSERT INTO mun VALUES (3947, 'SP', '35', '57303', 'Estiva Gerbi');
INSERT INTO mun VALUES (11334, 'GO', '52', 'TR041', 'Estrada de Ferro GO');
INSERT INTO mun VALUES (544, 'MA', '21', '04057', 'Estreito');
INSERT INTO mun VALUES (4801, 'RS', '43', '07807', 'Estrela');
INSERT INTO mun VALUES (2551, 'MG', '31', '24609', 'Estrela Dalva');
INSERT INTO mun VALUES (1707, 'AL', '27', '02553', 'Estrela De Alagoas');
INSERT INTO mun VALUES (2552, 'MG', '31', '24708', 'Estrela Do Indaia');
INSERT INTO mun VALUES (3477, 'SP', '35', '15301', 'Estrela Do Norte');
INSERT INTO mun VALUES (5441, 'GO', '52', '07501', 'Estrela Do Norte');
INSERT INTO mun VALUES (2553, 'MG', '31', '24807', 'Estrela Do Sul');
INSERT INTO mun VALUES (4802, 'RS', '43', '07815', 'Estrela Velha');
INSERT INTO mun VALUES (1985, 'BA', '29', '10701', 'Euclides Da Cunha');
INSERT INTO mun VALUES (3478, 'SP', '35', '15350', 'Euclides Da Cunha Paulis');
INSERT INTO mun VALUES (4803, 'RS', '43', '07831', 'Eugenio De Castro');
INSERT INTO mun VALUES (2554, 'MG', '31', '24906', 'Eugenopolis');
INSERT INTO mun VALUES (1986, 'BA', '29', '10727', 'Eunapolis');
INSERT INTO mun VALUES (972, 'CE', '23', '04285', 'Eusebio');
INSERT INTO mun VALUES (2555, 'MG', '31', '25002', 'Ewbank Da Camara');
INSERT INTO mun VALUES (2556, 'MG', '31', '25101', 'Extrema');
INSERT INTO mun VALUES (1141, 'RN', '24', '03608', 'Extremoz');
INSERT INTO mun VALUES (1552, 'PE', '26', '05301', 'Exu');
INSERT INTO mun VALUES (1350, 'PB', '25', '06103', 'Fagundes');
INSERT INTO mun VALUES (4804, 'RS', '43', '07864', 'Fagundes Varela');
INSERT INTO mun VALUES (5442, 'GO', '52', '07535', 'Faina');
INSERT INTO mun VALUES (2557, 'MG', '31', '25200', 'Fama');
INSERT INTO mun VALUES (2558, 'MG', '31', '25309', 'Faria Lemos');
INSERT INTO mun VALUES (973, 'CE', '23', '04301', 'Farias Brito');
INSERT INTO mun VALUES (222, 'PA', '15', '03002', 'Faro');
INSERT INTO mun VALUES (4055, 'PR', '41', '07553', 'Farol');
INSERT INTO mun VALUES (4805, 'RS', '43', '07906', 'Farroupilha');
INSERT INTO mun VALUES (3479, 'SP', '35', '15400', 'Fartura');
INSERT INTO mun VALUES (772, 'PI', '22', '03750', 'Fartura Do Piaui');
INSERT INTO mun VALUES (1987, 'BA', '29', '10750', 'Fatima');
INSERT INTO mun VALUES (385, 'TO', '17', '07553', 'Fatima');
INSERT INTO mun VALUES (5174, 'MS', '50', '03801', 'Fatima Do Sul');
INSERT INTO mun VALUES (4056, 'PR', '41', '07603', 'Faxinal');
INSERT INTO mun VALUES (4434, 'SC', '42', '05308', 'Faxinal Dos Guedes');
INSERT INTO mun VALUES (4806, 'RS', '43', '08003', 'Faxinal Do Soturno');
INSERT INTO mun VALUES (4807, 'RS', '43', '08052', 'Faxinalzinho');
INSERT INTO mun VALUES (5443, 'GO', '52', '07600', 'Fazenda Nova');
INSERT INTO mun VALUES (4057, 'PR', '41', '07652', 'Fazenda Rio Grande');
INSERT INTO mun VALUES (4808, 'RS', '43', '08078', 'Fazenda Vilanova');
INSERT INTO mun VALUES (80, 'AC', '12', '00302', 'Feijo');
INSERT INTO mun VALUES (1988, 'BA', '29', '10776', 'Feira Da Mata');
INSERT INTO mun VALUES (1989, 'BA', '29', '10800', 'Feira De Santana');
INSERT INTO mun VALUES (1708, 'AL', '27', '02603', 'Feira Grande');
INSERT INTO mun VALUES (1802, 'SE', '28', '02205', 'Feira Nova');
INSERT INTO mun VALUES (1553, 'PE', '26', '05400', 'Feira Nova');
INSERT INTO mun VALUES (545, 'MA', '21', '04073', 'Feira Nova Do Maranhão');
INSERT INTO mun VALUES (2559, 'MG', '31', '25408', 'Felicio Dos Santos');
INSERT INTO mun VALUES (1142, 'RN', '24', '03707', 'Felipe Guerra');
INSERT INTO mun VALUES (2561, 'MG', '31', '25606', 'Felisburgo');
INSERT INTO mun VALUES (2562, 'MG', '31', '25705', 'Felixlandia');
INSERT INTO mun VALUES (4809, 'RS', '43', '08102', 'Feliz');
INSERT INTO mun VALUES (1709, 'AL', '27', '02702', 'Feliz Deserto');
INSERT INTO mun VALUES (5261, 'MT', '51', '03700', 'Feliz Natal');
INSERT INTO mun VALUES (4058, 'PR', '41', '07702', 'Fenix');
INSERT INTO mun VALUES (4059, 'PR', '41', '07736', 'Fernandes Pinheiro');
INSERT INTO mun VALUES (2563, 'MG', '31', '25804', 'Fernandes Tourinho');
INSERT INTO mun VALUES (1554, 'PE', '26', '05459', 'Fernando De Noronha');
INSERT INTO mun VALUES (546, 'MA', '21', '04081', 'Fernando Falcão');
INSERT INTO mun VALUES (1143, 'RN', '24', '03756', 'Fernando Pedroza');
INSERT INTO mun VALUES (3480, 'SP', '35', '15509', 'Fernandopolis');
INSERT INTO mun VALUES (3481, 'SP', '35', '15608', 'Fernando Prestes');
INSERT INTO mun VALUES (3482, 'SP', '35', '15657', 'Fernão');
INSERT INTO mun VALUES (3483, 'SP', '35', '15707', 'Ferraz De Vasconcelos');
INSERT INTO mun VALUES (324, 'AP', '16', '00238', 'Ferreira Gomes');
INSERT INTO mun VALUES (1555, 'PE', '26', '05509', 'Ferreiros');
INSERT INTO mun VALUES (2564, 'MG', '31', '25903', 'Ferros');
INSERT INTO mun VALUES (2565, 'MG', '31', '25952', 'Fervedouro');
INSERT INTO mun VALUES (4060, 'PR', '41', '07751', 'Figueira');
INSERT INTO mun VALUES (386, 'TO', '17', '07652', 'Figueiropolis');
INSERT INTO mun VALUES (387, 'TO', '17', '07702', 'Filadelfia');
INSERT INTO mun VALUES (1990, 'BA', '29', '10859', 'Filadelfia');
INSERT INTO mun VALUES (1991, 'BA', '29', '10909', 'Firmino Alves');
INSERT INTO mun VALUES (5444, 'GO', '52', '07808', 'Firminopolis');
INSERT INTO mun VALUES (1710, 'AL', '27', '02801', 'Flexeiras');
INSERT INTO mun VALUES (4061, 'PR', '41', '07801', 'Florai');
INSERT INTO mun VALUES (1144, 'RN', '24', '03806', 'Florania');
INSERT INTO mun VALUES (3484, 'SP', '35', '15806', 'Flora Rica');
INSERT INTO mun VALUES (4062, 'PR', '41', '07850', 'Flor Da Serra Do Sul');
INSERT INTO mun VALUES (4435, 'SC', '42', '05357', 'Flor Do Sertão');
INSERT INTO mun VALUES (3485, 'SP', '35', '15905', 'Floreal');
INSERT INTO mun VALUES (1556, 'PE', '26', '05608', 'Flores');
INSERT INTO mun VALUES (4810, 'RS', '43', '08201', 'Flores Da Cunha');
INSERT INTO mun VALUES (5445, 'GO', '52', '07907', 'Flores De Goias');
INSERT INTO mun VALUES (773, 'PI', '22', '03800', 'Flores Do Piaui');
INSERT INTO mun VALUES (1557, 'PE', '26', '05707', 'Floresta');
INSERT INTO mun VALUES (4063, 'PR', '41', '07900', 'Floresta');
INSERT INTO mun VALUES (1992, 'BA', '29', '11006', 'Floresta Azul');
INSERT INTO mun VALUES (223, 'PA', '15', '03044', 'Floresta Do Araguaia');
INSERT INTO mun VALUES (774, 'PI', '22', '03859', 'Floresta Do Piaui');
INSERT INTO mun VALUES (2566, 'MG', '31', '26000', 'Florestal');
INSERT INTO mun VALUES (4064, 'PR', '41', '08007', 'Florestopolis');
INSERT INTO mun VALUES (775, 'PI', '22', '03909', 'Floriano');
INSERT INTO mun VALUES (4811, 'RS', '43', '08250', 'Floriano Peixoto');
INSERT INTO mun VALUES (4436, 'SC', '42', '05407', 'Florianopolis');
INSERT INTO mun VALUES (4065, 'PR', '41', '08106', 'Florida');
INSERT INTO mun VALUES (3486, 'SP', '35', '16002', 'Florida Paulista');
INSERT INTO mun VALUES (5171, 'MS', '50', '03504', 'Douradina');
INSERT INTO mun VALUES (4048, 'PR', '41', '07256', 'Douradina');
INSERT INTO mun VALUES (3461, 'SP', '35', '14304', 'Dourado');
INSERT INTO mun VALUES (2538, 'MG', '31', '23502', 'Douradoquara');
INSERT INTO mun VALUES (5172, 'MS', '50', '03702', 'Dourados');
INSERT INTO mun VALUES (4049, 'PR', '41', '07306', 'Doutor Camargo');
INSERT INTO mun VALUES (4781, 'RS', '43', '06734', 'Doutor Mauricio Cardoso');
INSERT INTO mun VALUES (4430, 'SC', '42', '05159', 'Doutor Pedrinho');
INSERT INTO mun VALUES (4782, 'RS', '43', '06759', 'Doutor Ricardo');
INSERT INTO mun VALUES (1136, 'RN', '24', '03202', 'Doutor Severiano');
INSERT INTO mun VALUES (4344, 'PR', '41', '28633', 'Doutor Ulysses');
INSERT INTO mun VALUES (5438, 'GO', '52', '07253', 'Doverlandia');
INSERT INTO mun VALUES (3462, 'SP', '35', '14403', 'Dracena');
INSERT INTO mun VALUES (3463, 'SP', '35', '14502', 'Duartina');
INSERT INTO mun VALUES (3233, 'RJ', '33', '01603', 'Duas Barras');
INSERT INTO mun VALUES (1347, 'PB', '25', '05808', 'Duas Estradas');
INSERT INTO mun VALUES (383, 'TO', '17', '07306', 'Duere');
INSERT INTO mun VALUES (3464, 'SP', '35', '14601', 'Dumont');
INSERT INTO mun VALUES (542, 'MA', '21', '03901', 'Duque Bacelar');
INSERT INTO mun VALUES (3234, 'RJ', '33', '01702', 'Duque De Caxias');
INSERT INTO mun VALUES (2539, 'MG', '31', '23528', 'Durande');
INSERT INTO mun VALUES (3465, 'SP', '35', '14700', 'Echaporã');
INSERT INTO mun VALUES (3155, 'ES', '32', '02108', 'Ecoporanga');
INSERT INTO mun VALUES (5439, 'GO', '52', '07352', 'Edealina');
INSERT INTO mun VALUES (5440, 'GO', '52', '07402', 'Edeia');
INSERT INTO mun VALUES (4245, 'PR', '41', '21356', 'Rancho Alegre D''oeste');
INSERT INTO mun VALUES (117, 'AM', '13', '01407', 'Eirunepe');
INSERT INTO mun VALUES (3466, 'SP', '35', '14809', 'Eldorado');
INSERT INTO mun VALUES (5173, 'MS', '50', '03751', 'Eldorado');
INSERT INTO mun VALUES (221, 'PA', '15', '02954', 'Eldorado Dos Carajas');
INSERT INTO mun VALUES (4783, 'RS', '43', '06767', 'Eldorado Do Sul');
INSERT INTO mun VALUES (769, 'PI', '22', '03503', 'Elesbão Veloso');
INSERT INTO mun VALUES (3467, 'SP', '35', '14908', 'Elias Fausto');
INSERT INTO mun VALUES (770, 'PI', '22', '03602', 'Eliseu Martins');
INSERT INTO mun VALUES (3468, 'SP', '35', '14924', 'Elisiario');
INSERT INTO mun VALUES (1981, 'BA', '29', '10305', 'Elisio Medrado');
INSERT INTO mun VALUES (2540, 'MG', '31', '23601', 'Eloi Mendes');
INSERT INTO mun VALUES (1348, 'PB', '25', '05907', 'Emas');
INSERT INTO mun VALUES (3469, 'SP', '35', '14957', 'Embauba');
INSERT INTO mun VALUES (3470, 'SP', '35', '15004', 'Embu');
INSERT INTO mun VALUES (3471, 'SP', '35', '15103', 'Embu-guaçu');
INSERT INTO mun VALUES (3472, 'SP', '35', '15129', 'Emilianopolis');
INSERT INTO mun VALUES (4784, 'RS', '43', '06809', 'Encantado');
INSERT INTO mun VALUES (1982, 'BA', '29', '10404', 'Encruzilhada');
INSERT INTO mun VALUES (4785, 'RS', '43', '06908', 'Encruzilhada Do Sul');
INSERT INTO mun VALUES (4050, 'PR', '41', '07405', 'Eneas Marques');
INSERT INTO mun VALUES (4051, 'PR', '41', '07504', 'Engenheiro Beltrão');
INSERT INTO mun VALUES (2541, 'MG', '31', '23700', 'Engenheiro Caldas');
INSERT INTO mun VALUES (3473, 'SP', '35', '15152', 'Engenheiro Coelho');
INSERT INTO mun VALUES (2542, 'MG', '31', '23809', 'Engenheiro Navarro');
INSERT INTO mun VALUES (3235, 'RJ', '33', '01801', 'Engenheiro Paulo De Fron');
INSERT INTO mun VALUES (4786, 'RS', '43', '06924', 'Engenho Velho');
INSERT INTO mun VALUES (11332, 'AM', '13', 'TR039', 'Entorno de Manaus AM');
INSERT INTO mun VALUES (2543, 'MG', '31', '23858', 'Entre Folhas');
INSERT INTO mun VALUES (4787, 'RS', '43', '06932', 'Entre-ijuis');
INSERT INTO mun VALUES (1983, 'BA', '29', '10503', 'Entre Rios');
INSERT INTO mun VALUES (4431, 'SC', '42', '05175', 'Entre Rios');
INSERT INTO mun VALUES (2544, 'MG', '31', '23908', 'Entre Rios De Minas');
INSERT INTO mun VALUES (4053, 'PR', '41', '07538', 'Entre Rios Do Oeste');
INSERT INTO mun VALUES (4788, 'RS', '43', '06957', 'Entre Rios Do Sul');
INSERT INTO mun VALUES (11333, 'PI', '22', 'TR040', 'Entre Rios PI');
INSERT INTO mun VALUES (118, 'AM', '13', '01506', 'Envira');
INSERT INTO mun VALUES (79, 'AC', '12', '00252', 'Epitaciolandia');
INSERT INTO mun VALUES (1139, 'RN', '24', '03400', 'Equador');
INSERT INTO mun VALUES (4789, 'RS', '43', '06973', 'Erebango');
INSERT INTO mun VALUES (4790, 'RS', '43', '07005', 'Erechim');
INSERT INTO mun VALUES (971, 'CE', '23', '04277', 'Erere');
INSERT INTO mun VALUES (1864, 'BA', '29', '00504', 'Erico Cardoso');
INSERT INTO mun VALUES (4432, 'SC', '42', '05191', 'Ermo');
INSERT INTO mun VALUES (4791, 'RS', '43', '07054', 'Ernestina');
INSERT INTO mun VALUES (4793, 'RS', '43', '07203', 'Erval Grande');
INSERT INTO mun VALUES (2545, 'MG', '31', '24005', 'Ervalia');
INSERT INTO mun VALUES (4794, 'RS', '43', '07302', 'Erval Seco');
INSERT INTO mun VALUES (4433, 'SC', '42', '05209', 'Erval Velho');
INSERT INTO mun VALUES (1551, 'PE', '26', '05202', 'Escada');
INSERT INTO mun VALUES (4795, 'RS', '43', '07401', 'Esmeralda');
INSERT INTO mun VALUES (2546, 'MG', '31', '24104', 'Esmeraldas');
INSERT INTO mun VALUES (2547, 'MG', '31', '24203', 'Espera Feliz');
INSERT INTO mun VALUES (1349, 'PB', '25', '06004', 'Esperança');
INSERT INTO mun VALUES (4796, 'RS', '43', '07450', 'Esperança Do Sul');
INSERT INTO mun VALUES (4052, 'PR', '41', '07520', 'Esperança Nova');
INSERT INTO mun VALUES (771, 'PI', '22', '03701', 'Esperantina');
INSERT INTO mun VALUES (384, 'TO', '17', '07405', 'Esperantina');
INSERT INTO mun VALUES (543, 'MA', '21', '04008', 'Esperantinopolis');
INSERT INTO mun VALUES (4054, 'PR', '41', '07546', 'Espigão Alto Do Iguaçu');
INSERT INTO mun VALUES (28, 'RO', '11', '00098', 'Espigão Doeste');
INSERT INTO mun VALUES (2548, 'MG', '31', '24302', 'Espinosa');
INSERT INTO mun VALUES (1140, 'RN', '24', '03509', 'Espirito Santo');
INSERT INTO mun VALUES (2549, 'MG', '31', '24401', 'Espirito Santo Do Dourad');
INSERT INTO mun VALUES (3474, 'SP', '35', '15186', 'Espirito Santo Do Pinhal');
INSERT INTO mun VALUES (3475, 'SP', '35', '15194', 'Espirito Santo Do Turvo');
INSERT INTO mun VALUES (1984, 'BA', '29', '10602', 'Esplanada');
INSERT INTO mun VALUES (3130, 'ES', '32', '00000', 'Espírito Santo');
INSERT INTO mun VALUES (4797, 'RS', '43', '07500', 'Espumoso');
INSERT INTO mun VALUES (1801, 'SE', '28', '02106', 'Estancia');
INSERT INTO mun VALUES (4799, 'RS', '43', '07609', 'Estancia Velha');
INSERT INTO mun VALUES (4798, 'RS', '43', '07559', 'Estação');
INSERT INTO mun VALUES (4800, 'RS', '43', '07708', 'Esteio');
INSERT INTO mun VALUES (2550, 'MG', '31', '24500', 'Estiva');
INSERT INTO mun VALUES (5434, 'GO', '52', '06701', 'Damianopolis');
INSERT INTO mun VALUES (1342, 'PB', '25', '05352', 'Damião');
INSERT INTO mun VALUES (5435, 'GO', '52', '06800', 'Damolandia');
INSERT INTO mun VALUES (379, 'TO', '17', '06506', 'Darcinopolis');
INSERT INTO mun VALUES (11326, 'MS', '50', 'TR033', 'Da Reforma MS');
INSERT INTO mun VALUES (1977, 'BA', '29', '10008', 'Dario Meira');
INSERT INTO mun VALUES (2509, 'MG', '31', '21001', 'Datas');
INSERT INTO mun VALUES (4770, 'RS', '43', '06304', 'David Canabarro');
INSERT INTO mun VALUES (540, 'MA', '21', '03752', 'Davinopolis');
INSERT INTO mun VALUES (2806, 'MG', '31', '45455', 'Olhos-d''agua');
INSERT INTO mun VALUES (5436, 'GO', '52', '06909', 'Davinopolis');
INSERT INTO mun VALUES (2510, 'MG', '31', '21100', 'Delfim Moreira');
INSERT INTO mun VALUES (2511, 'MG', '31', '21209', 'Delfinopolis');
INSERT INTO mun VALUES (1705, 'AL', '27', '02405', 'Delmiro Gouveia');
INSERT INTO mun VALUES (2512, 'MG', '31', '21258', 'Delta');
INSERT INTO mun VALUES (764, 'PI', '22', '03305', 'Demerval Lobão');
INSERT INTO mun VALUES (5258, 'MT', '51', '03452', 'Denise');
INSERT INTO mun VALUES (5169, 'MS', '50', '03454', 'Deodapolis');
INSERT INTO mun VALUES (970, 'CE', '23', '04269', 'Deputado Irapuan Pinheir');
INSERT INTO mun VALUES (4771, 'RS', '43', '06320', 'Derrubadas');
INSERT INTO mun VALUES (3454, 'SP', '35', '13702', 'Descalvado');
INSERT INTO mun VALUES (4427, 'SC', '42', '04905', 'Descanso');
INSERT INTO mun VALUES (2513, 'MG', '31', '21308', 'Descoberto');
INSERT INTO mun VALUES (1343, 'PB', '25', '05402', 'Desterro');
INSERT INTO mun VALUES (2514, 'MG', '31', '21407', 'Desterro De Entre Rios');
INSERT INTO mun VALUES (2515, 'MG', '31', '21506', 'Desterro Do Melo');
INSERT INTO mun VALUES (4772, 'RS', '43', '06353', 'Dezesseis De Novembro');
INSERT INTO mun VALUES (3455, 'SP', '35', '13801', 'Diadema');
INSERT INTO mun VALUES (1345, 'PB', '25', '05600', 'Diamante');
INSERT INTO mun VALUES (4044, 'PR', '41', '07108', 'Diamante Do Norte');
INSERT INTO mun VALUES (4045, 'PR', '41', '07124', 'Diamante Do Sul');
INSERT INTO mun VALUES (2516, 'MG', '31', '21605', 'Diamantina');
INSERT INTO mun VALUES (5259, 'MT', '51', '03502', 'Diamantino');
INSERT INTO mun VALUES (380, 'TO', '17', '07009', 'Dianopolis');
INSERT INTO mun VALUES (4773, 'RS', '43', '06379', 'Dilermando De Aguiar');
INSERT INTO mun VALUES (2517, 'MG', '31', '21704', 'Diogo De Vasconcelos');
INSERT INTO mun VALUES (2518, 'MG', '31', '21803', 'Dionisio');
INSERT INTO mun VALUES (4428, 'SC', '42', '05001', 'Dionisio Cerqueira');
INSERT INTO mun VALUES (5437, 'GO', '52', '07105', 'Diorama');
INSERT INTO mun VALUES (3456, 'SP', '35', '13850', 'Dirce Reis');
INSERT INTO mun VALUES (765, 'PI', '22', '03354', 'Dirceu Arcoverde');
INSERT INTO mun VALUES (5605, 'DF', '53', '00000', 'Distrito Federal');
INSERT INTO mun VALUES (1800, 'SE', '28', '02007', 'Divina Pastora');
INSERT INTO mun VALUES (2519, 'MG', '31', '21902', 'Divinesia');
INSERT INTO mun VALUES (2520, 'MG', '31', '22009', 'Divino');
INSERT INTO mun VALUES (2521, 'MG', '31', '22108', 'Divino Das Laranjeiras');
INSERT INTO mun VALUES (3152, 'ES', '32', '01803', 'Divino De São Lourenço');
INSERT INTO mun VALUES (3457, 'SP', '35', '13900', 'Divinolandia');
INSERT INTO mun VALUES (2522, 'MG', '31', '22207', 'Divinolandia De Minas');
INSERT INTO mun VALUES (2523, 'MG', '31', '22306', 'Divinopolis');
INSERT INTO mun VALUES (5449, 'GO', '52', '08301', 'Divinopolis De Goias');
INSERT INTO mun VALUES (381, 'TO', '17', '07108', 'Divinopolis Do Tocantins');
INSERT INTO mun VALUES (2524, 'MG', '31', '22355', 'Divisa Alegre');
INSERT INTO mun VALUES (2525, 'MG', '31', '22405', 'Divisa Nova');
INSERT INTO mun VALUES (2526, 'MG', '31', '22454', 'Divisopolis');
INSERT INTO mun VALUES (11327, 'AL', '27', 'TR034', 'Do Agreste AL');
INSERT INTO mun VALUES (11328, 'AL', '27', 'TR035', 'Do Alto Sertão  AL');
INSERT INTO mun VALUES (3458, 'SP', '35', '14007', 'Dobrada');
INSERT INTO mun VALUES (3459, 'SP', '35', '14106', 'Dois Corregos');
INSERT INTO mun VALUES (4774, 'RS', '43', '06403', 'Dois Irmãos');
INSERT INTO mun VALUES (4775, 'RS', '43', '06429', 'Dois Irmãos Das Missões');
INSERT INTO mun VALUES (5170, 'MS', '50', '03488', 'Dois Irmãos Do Buriti');
INSERT INTO mun VALUES (382, 'TO', '17', '07207', 'Dois Irmãos Do Tocantins');
INSERT INTO mun VALUES (4776, 'RS', '43', '06452', 'Dois Lajeados');
INSERT INTO mun VALUES (1706, 'AL', '27', '02504', 'Dois Riachos');
INSERT INTO mun VALUES (4047, 'PR', '41', '07207', 'Dois Vizinhos');
INSERT INTO mun VALUES (3460, 'SP', '35', '14205', 'Dolcinopolis');
INSERT INTO mun VALUES (11329, 'AL', '27', 'TR036', 'Do Litoral Norte  AL');
INSERT INTO mun VALUES (5260, 'MT', '51', '03601', 'Dom Aquino');
INSERT INTO mun VALUES (1979, 'BA', '29', '10107', 'Dom Basilio');
INSERT INTO mun VALUES (2527, 'MG', '31', '22470', 'Dom Bosco');
INSERT INTO mun VALUES (2528, 'MG', '31', '22504', 'Dom Cavati');
INSERT INTO mun VALUES (11330, 'AL', '27', 'TR037', 'Do Médio Sertão AL');
INSERT INTO mun VALUES (220, 'PA', '15', '02939', 'Dom Eliseu');
INSERT INTO mun VALUES (766, 'PI', '22', '03404', 'Dom Expedito Lopes');
INSERT INTO mun VALUES (4777, 'RS', '43', '06502', 'Dom Feliciano');
INSERT INTO mun VALUES (3153, 'ES', '32', '01902', 'Domingos Martins');
INSERT INTO mun VALUES (767, 'PI', '22', '03420', 'Domingos Mourão');
INSERT INTO mun VALUES (768, 'PI', '22', '03453', 'Dom Inocencio');
INSERT INTO mun VALUES (2529, 'MG', '31', '22603', 'Dom Joaquim');
INSERT INTO mun VALUES (1980, 'BA', '29', '10206', 'Dom Macedo Costa');
INSERT INTO mun VALUES (4779, 'RS', '43', '06601', 'Dom Pedrito');
INSERT INTO mun VALUES (541, 'MA', '21', '03802', 'Dom Pedro');
INSERT INTO mun VALUES (4778, 'RS', '43', '06551', 'Dom Pedro De Alcantara');
INSERT INTO mun VALUES (1740, 'AL', '27', '05705', 'Olho D''agua Das Flores');
INSERT INTO mun VALUES (2530, 'MG', '31', '22702', 'Dom Silverio');
INSERT INTO mun VALUES (2531, 'MG', '31', '22801', 'Dom Viçoso');
INSERT INTO mun VALUES (4429, 'SC', '42', '05100', 'Dona Emma');
INSERT INTO mun VALUES (2532, 'MG', '31', '22900', 'Dona Eusebia');
INSERT INTO mun VALUES (4780, 'RS', '43', '06700', 'Dona Francisca');
INSERT INTO mun VALUES (1346, 'PB', '25', '05709', 'Dona Ines');
INSERT INTO mun VALUES (2533, 'MG', '31', '23007', 'Dores De Campos');
INSERT INTO mun VALUES (2534, 'MG', '31', '23106', 'Dores De Guanhães');
INSERT INTO mun VALUES (2535, 'MG', '31', '23205', 'Dores Do Indaia');
INSERT INTO mun VALUES (3154, 'ES', '32', '02009', 'Dores Do Rio Preto');
INSERT INTO mun VALUES (2536, 'MG', '31', '23304', 'Dores Do Turvo');
INSERT INTO mun VALUES (2537, 'MG', '31', '23403', 'Doresopolis');
INSERT INTO mun VALUES (1550, 'PE', '26', '05152', 'Dormentes');
INSERT INTO mun VALUES (11331, 'BA', '29', 'TR038', 'Do Sisal BA');
INSERT INTO mun VALUES (3444, 'SP', '35', '12704', 'Corumbatai');
INSERT INTO mun VALUES (4036, 'PR', '41', '06555', 'Corumbatai Do Sul');
INSERT INTO mun VALUES (26, 'RO', '11', '00072', 'Corumbiara');
INSERT INTO mun VALUES (4421, 'SC', '42', '04509', 'Corupa');
INSERT INTO mun VALUES (1703, 'AL', '27', '02306', 'Coruripe');
INSERT INTO mun VALUES (3445, 'SP', '35', '12803', 'Cosmopolis');
INSERT INTO mun VALUES (3446, 'SP', '35', '12902', 'Cosmorama');
INSERT INTO mun VALUES (27, 'RO', '11', '00080', 'Costa Marques');
INSERT INTO mun VALUES (5167, 'MS', '50', '03256', 'Costa Rica');
INSERT INTO mun VALUES (1971, 'BA', '29', '09406', 'Cotegipe');
INSERT INTO mun VALUES (3447, 'SP', '35', '13009', 'Cotia');
INSERT INTO mun VALUES (4762, 'RS', '43', '05959', 'Cotiporã');
INSERT INTO mun VALUES (5255, 'MT', '51', '03379', 'Cotriguaçu');
INSERT INTO mun VALUES (376, 'TO', '17', '06001', 'Couto De Magalhães');
INSERT INTO mun VALUES (2497, 'MG', '31', '20102', 'Couto De Magalhães De Mi');
INSERT INTO mun VALUES (4763, 'RS', '43', '05975', 'Coxilha');
INSERT INTO mun VALUES (5168, 'MS', '50', '03306', 'Coxim');
INSERT INTO mun VALUES (1334, 'PB', '25', '04850', 'Coxixola');
INSERT INTO mun VALUES (3854, 'SP', '35', '49300', 'SÃo JoÃo Do Pau D''alho');
INSERT INTO mun VALUES (1704, 'AL', '27', '02355', 'Craibas');
INSERT INTO mun VALUES (966, 'CE', '23', '04103', 'Crateus');
INSERT INTO mun VALUES (967, 'CE', '23', '04202', 'Crato');
INSERT INTO mun VALUES (3448, 'SP', '35', '13108', 'Cravinhos');
INSERT INTO mun VALUES (1972, 'BA', '29', '09505', 'Cravolandia');
INSERT INTO mun VALUES (4423, 'SC', '42', '04608', 'Criciuma');
INSERT INTO mun VALUES (2498, 'MG', '31', '20151', 'Crisolita');
INSERT INTO mun VALUES (1973, 'BA', '29', '09604', 'Crisopolis');
INSERT INTO mun VALUES (4764, 'RS', '43', '06007', 'Crissiumal');
INSERT INTO mun VALUES (2499, 'MG', '31', '20201', 'Cristais');
INSERT INTO mun VALUES (3449, 'SP', '35', '13207', 'Cristais Paulista');
INSERT INTO mun VALUES (4765, 'RS', '43', '06056', 'Cristal');
INSERT INTO mun VALUES (377, 'TO', '17', '06100', 'Cristalandia');
INSERT INTO mun VALUES (758, 'PI', '22', '03008', 'Cristalandia Do Piaui');
INSERT INTO mun VALUES (4766, 'RS', '43', '06072', 'Cristal Do Sul');
INSERT INTO mun VALUES (2500, 'MG', '31', '20300', 'Cristalia');
INSERT INTO mun VALUES (5429, 'GO', '52', '06206', 'Cristalina');
INSERT INTO mun VALUES (2501, 'MG', '31', '20409', 'Cristiano Otoni');
INSERT INTO mun VALUES (5430, 'GO', '52', '06305', 'Cristianopolis');
INSERT INTO mun VALUES (2502, 'MG', '31', '20508', 'Cristina');
INSERT INTO mun VALUES (1798, 'SE', '28', '01702', 'Cristinapolis');
INSERT INTO mun VALUES (759, 'PI', '22', '03107', 'Cristino Castro');
INSERT INTO mun VALUES (1974, 'BA', '29', '09703', 'Cristopolis');
INSERT INTO mun VALUES (5431, 'GO', '52', '06404', 'Crixas');
INSERT INTO mun VALUES (378, 'TO', '17', '06258', 'Crixas Do Tocantins');
INSERT INTO mun VALUES (968, 'CE', '23', '04236', 'Croata');
INSERT INTO mun VALUES (5432, 'GO', '52', '06503', 'Crominia');
INSERT INTO mun VALUES (2503, 'MG', '31', '20607', 'Crucilandia');
INSERT INTO mun VALUES (969, 'CE', '23', '04251', 'Cruz');
INSERT INTO mun VALUES (3450, 'SP', '35', '13306', 'Cruzalia');
INSERT INTO mun VALUES (4767, 'RS', '43', '06106', 'Cruz Alta');
INSERT INTO mun VALUES (4768, 'RS', '43', '06130', 'Cruzaltense');
INSERT INTO mun VALUES (1975, 'BA', '29', '09802', 'Cruz Das Almas');
INSERT INTO mun VALUES (1335, 'PB', '25', '04900', 'Cruz Do Espirito Santo');
INSERT INTO mun VALUES (3451, 'SP', '35', '13405', 'Cruzeiro');
INSERT INTO mun VALUES (2504, 'MG', '31', '20706', 'Cruzeiro Da Fortaleza');
INSERT INTO mun VALUES (4037, 'PR', '41', '06571', 'Cruzeiro Do Iguaçu');
INSERT INTO mun VALUES (4038, 'PR', '41', '06605', 'Cruzeiro Do Oeste');
INSERT INTO mun VALUES (78, 'AC', '12', '00203', 'Cruzeiro Do Sul');
INSERT INTO mun VALUES (4769, 'RS', '43', '06205', 'Cruzeiro Do Sul');
INSERT INTO mun VALUES (4039, 'PR', '41', '06704', 'Cruzeiro Do Sul');
INSERT INTO mun VALUES (1134, 'RN', '24', '03004', 'Cruzeta');
INSERT INTO mun VALUES (2505, 'MG', '31', '20805', 'Cruzilia');
INSERT INTO mun VALUES (4040, 'PR', '41', '06803', 'Cruz Machado');
INSERT INTO mun VALUES (4041, 'PR', '41', '06852', 'Cruzmaltina');
INSERT INTO mun VALUES (1336, 'PB', '25', '05006', 'Cubati');
INSERT INTO mun VALUES (3452, 'SP', '35', '13504', 'Cubatão');
INSERT INTO mun VALUES (5256, 'MT', '51', '03403', 'Cuiaba');
INSERT INTO mun VALUES (1337, 'PB', '25', '05105', 'Cuite');
INSERT INTO mun VALUES (1339, 'PB', '25', '05238', 'Cuite De Mamanguape');
INSERT INTO mun VALUES (1338, 'PB', '25', '05204', 'Cuitegi');
INSERT INTO mun VALUES (54, 'RO', '11', '00940', 'Cujubim');
INSERT INTO mun VALUES (5433, 'GO', '52', '06602', 'Cumari');
INSERT INTO mun VALUES (1547, 'PE', '26', '04908', 'Cumaru');
INSERT INTO mun VALUES (215, 'PA', '15', '02764', 'Cumaru Do Norte');
INSERT INTO mun VALUES (1799, 'SE', '28', '01900', 'Cumbe');
INSERT INTO mun VALUES (3453, 'SP', '35', '13603', 'Cunha');
INSERT INTO mun VALUES (4424, 'SC', '42', '04707', 'Cunha Porã');
INSERT INTO mun VALUES (4425, 'SC', '42', '04756', 'Cunhatai');
INSERT INTO mun VALUES (2506, 'MG', '31', '20839', 'Cuparaque');
INSERT INTO mun VALUES (1548, 'PE', '26', '05004', 'Cupira');
INSERT INTO mun VALUES (1976, 'BA', '29', '09901', 'Curaça');
INSERT INTO mun VALUES (760, 'PI', '22', '03206', 'Curimata');
INSERT INTO mun VALUES (216, 'PA', '15', '02772', 'Curionopolis');
INSERT INTO mun VALUES (4042, 'PR', '41', '06902', 'Curitiba');
INSERT INTO mun VALUES (4426, 'SC', '42', '04806', 'Curitibanos');
INSERT INTO mun VALUES (4043, 'PR', '41', '07009', 'Curiuva');
INSERT INTO mun VALUES (761, 'PI', '22', '03230', 'Currais');
INSERT INTO mun VALUES (1135, 'RN', '24', '03103', 'Currais Novos');
INSERT INTO mun VALUES (1340, 'PB', '25', '05279', 'Curral De Cima');
INSERT INTO mun VALUES (2507, 'MG', '31', '20870', 'Curral De Dentro');
INSERT INTO mun VALUES (217, 'PA', '15', '02806', 'Curralinho');
INSERT INTO mun VALUES (762, 'PI', '22', '03255', 'Curralinhos');
INSERT INTO mun VALUES (763, 'PI', '22', '03271', 'Curral Novo Do Piaui');
INSERT INTO mun VALUES (1341, 'PB', '25', '05303', 'Curral Velho');
INSERT INTO mun VALUES (218, 'PA', '15', '02855', 'Curua');
INSERT INTO mun VALUES (219, 'PA', '15', '02905', 'Curuça');
INSERT INTO mun VALUES (539, 'MA', '21', '03703', 'Cururupu');
INSERT INTO mun VALUES (5257, 'MT', '51', '03437', 'Curvelandia');
INSERT INTO mun VALUES (2508, 'MG', '31', '20904', 'Curvelo');
INSERT INTO mun VALUES (1549, 'PE', '26', '05103', 'Custodia');
INSERT INTO mun VALUES (323, 'AP', '16', '00212', 'Cutias');
INSERT INTO mun VALUES (11325, 'AL', '27', 'TR032', 'Da Bacia Leiteira AL');
INSERT INTO mun VALUES (2466, 'MG', '31', '17306', 'Conceição Das Alagoas');
INSERT INTO mun VALUES (2465, 'MG', '31', '17207', 'Conceição Das Pedras');
INSERT INTO mun VALUES (2467, 'MG', '31', '17405', 'Conceição De Ipanema');
INSERT INTO mun VALUES (3231, 'RJ', '33', '01405', 'Conceição De Macabu');
INSERT INTO mun VALUES (1960, 'BA', '29', '08309', 'Conceição Do Almeida');
INSERT INTO mun VALUES (213, 'PA', '15', '02707', 'Conceição Do Araguaia');
INSERT INTO mun VALUES (755, 'PI', '22', '02802', 'Conceição Do Caninde');
INSERT INTO mun VALUES (3151, 'ES', '32', '01704', 'Conceição Do Castelo');
INSERT INTO mun VALUES (1961, 'BA', '29', '08408', 'Conceição Do Coite');
INSERT INTO mun VALUES (1962, 'BA', '29', '08507', 'Conceição Do Jacuipe');
INSERT INTO mun VALUES (537, 'MA', '21', '03554', 'Conceição Do Lago-açu');
INSERT INTO mun VALUES (2468, 'MG', '31', '17504', 'Conceição Do Mato Dentro');
INSERT INTO mun VALUES (2469, 'MG', '31', '17603', 'Conceição Do Para');
INSERT INTO mun VALUES (2470, 'MG', '31', '17702', 'Conceição Do Rio Verde');
INSERT INTO mun VALUES (2471, 'MG', '31', '17801', 'Conceição Dos Ouros');
INSERT INTO mun VALUES (375, 'TO', '17', '05607', 'Conceição Do Tocantins');
INSERT INTO mun VALUES (3439, 'SP', '35', '12209', 'Conchal');
INSERT INTO mun VALUES (3440, 'SP', '35', '12308', 'Conchas');
INSERT INTO mun VALUES (4417, 'SC', '42', '04301', 'Concordia');
INSERT INTO mun VALUES (214, 'PA', '15', '02756', 'Concordia Do Para');
INSERT INTO mun VALUES (1544, 'PE', '26', '04601', 'Condado');
INSERT INTO mun VALUES (1330, 'PB', '25', '04504', 'Condado');
INSERT INTO mun VALUES (1963, 'BA', '29', '08606', 'Conde');
INSERT INTO mun VALUES (1331, 'PB', '25', '04603', 'Conde');
INSERT INTO mun VALUES (1964, 'BA', '29', '08705', 'Condeuba');
INSERT INTO mun VALUES (4755, 'RS', '43', '05702', 'Condor');
INSERT INTO mun VALUES (2472, 'MG', '31', '17836', 'Conego Marinho');
INSERT INTO mun VALUES (11324, 'MS', '50', 'TR031', 'Cone Sul MS');
INSERT INTO mun VALUES (2473, 'MG', '31', '17876', 'Confins');
INSERT INTO mun VALUES (5253, 'MT', '51', '03353', 'Confresa');
INSERT INTO mun VALUES (1332, 'PB', '25', '04702', 'Congo');
INSERT INTO mun VALUES (2474, 'MG', '31', '17900', 'Congonhal');
INSERT INTO mun VALUES (2475, 'MG', '31', '18007', 'Congonhas');
INSERT INTO mun VALUES (2476, 'MG', '31', '18106', 'Congonhas Do Norte');
INSERT INTO mun VALUES (4029, 'PR', '41', '06001', 'Congonhinhas');
INSERT INTO mun VALUES (2477, 'MG', '31', '18205', 'Conquista');
INSERT INTO mun VALUES (2478, 'MG', '31', '18304', 'Conselheiro Lafaiete');
INSERT INTO mun VALUES (4030, 'PR', '41', '06100', 'Conselheiro Mairinck');
INSERT INTO mun VALUES (2479, 'MG', '31', '18403', 'Conselheiro Pena');
INSERT INTO mun VALUES (2480, 'MG', '31', '18502', 'Consolação');
INSERT INTO mun VALUES (4756, 'RS', '43', '05801', 'Constantina');
INSERT INTO mun VALUES (2481, 'MG', '31', '18601', 'Contagem');
INSERT INTO mun VALUES (4031, 'PR', '41', '06209', 'Contenda');
INSERT INTO mun VALUES (1965, 'BA', '29', '08804', 'Contendas Do Sincora');
INSERT INTO mun VALUES (2482, 'MG', '31', '18700', 'Coqueiral');
INSERT INTO mun VALUES (4757, 'RS', '43', '05835', 'Coqueiro Baixo');
INSERT INTO mun VALUES (4758, 'RS', '43', '05850', 'Coqueiros Do Sul');
INSERT INTO mun VALUES (1702, 'AL', '27', '02207', 'Coqueiro Seco');
INSERT INTO mun VALUES (2483, 'MG', '31', '18809', 'Coração De Jesus');
INSERT INTO mun VALUES (1966, 'BA', '29', '08903', 'Coração De Maria');
INSERT INTO mun VALUES (4032, 'PR', '41', '06308', 'Corbelia');
INSERT INTO mun VALUES (3232, 'RJ', '33', '01504', 'Cordeiro');
INSERT INTO mun VALUES (3441, 'SP', '35', '12407', 'Cordeiropolis');
INSERT INTO mun VALUES (1967, 'BA', '29', '09000', 'Cordeiros');
INSERT INTO mun VALUES (4418, 'SC', '42', '04350', 'Cordilheira Alta');
INSERT INTO mun VALUES (2484, 'MG', '31', '18908', 'Cordisburgo');
INSERT INTO mun VALUES (2485, 'MG', '31', '19005', 'Cordislandia');
INSERT INTO mun VALUES (965, 'CE', '23', '04004', 'Coreau');
INSERT INTO mun VALUES (1333, 'PB', '25', '04801', 'Coremas');
INSERT INTO mun VALUES (5164, 'MS', '50', '03108', 'Corguinho');
INSERT INTO mun VALUES (1968, 'BA', '29', '09109', 'Coribe');
INSERT INTO mun VALUES (2486, 'MG', '31', '19104', 'Corinto');
INSERT INTO mun VALUES (4033, 'PR', '41', '06407', 'Cornelio Procopio');
INSERT INTO mun VALUES (2487, 'MG', '31', '19203', 'Coroaci');
INSERT INTO mun VALUES (3442, 'SP', '35', '12506', 'Coroados');
INSERT INTO mun VALUES (538, 'MA', '21', '03604', 'Coroata');
INSERT INTO mun VALUES (2488, 'MG', '31', '19302', 'Coromandel');
INSERT INTO mun VALUES (4759, 'RS', '43', '05871', 'Coronel Barros');
INSERT INTO mun VALUES (4760, 'RS', '43', '05900', 'Coronel Bicaco');
INSERT INTO mun VALUES (4034, 'PR', '41', '06456', 'Coronel Domingos Soares');
INSERT INTO mun VALUES (1132, 'RN', '24', '02808', 'Coronel Ezequiel');
INSERT INTO mun VALUES (2489, 'MG', '31', '19401', 'Coronel Fabriciano');
INSERT INTO mun VALUES (4419, 'SC', '42', '04400', 'Coronel Freitas');
INSERT INTO mun VALUES (1133, 'RN', '24', '02907', 'Coronel João Pessoa');
INSERT INTO mun VALUES (1969, 'BA', '29', '09208', 'Coronel João Sa');
INSERT INTO mun VALUES (756, 'PI', '22', '02851', 'Coronel Jose Dias');
INSERT INTO mun VALUES (3443, 'SP', '35', '12605', 'Coronel Macedo');
INSERT INTO mun VALUES (4420, 'SC', '42', '04459', 'Coronel Martins');
INSERT INTO mun VALUES (2490, 'MG', '31', '19500', 'Coronel Murta');
INSERT INTO mun VALUES (2491, 'MG', '31', '19609', 'Coronel Pacheco');
INSERT INTO mun VALUES (4761, 'RS', '43', '05934', 'Coronel Pilar');
INSERT INTO mun VALUES (5165, 'MS', '50', '03157', 'Coronel Sapucaia');
INSERT INTO mun VALUES (4035, 'PR', '41', '06506', 'Coronel Vivida');
INSERT INTO mun VALUES (2492, 'MG', '31', '19708', 'Coronel Xavier Chaves');
INSERT INTO mun VALUES (2493, 'MG', '31', '19807', 'Corrego Danta');
INSERT INTO mun VALUES (2494, 'MG', '31', '19906', 'Corrego Do Bom Jesus');
INSERT INTO mun VALUES (5426, 'GO', '52', '05703', 'Corrego Do Ouro');
INSERT INTO mun VALUES (2495, 'MG', '31', '19955', 'Corrego Fundo');
INSERT INTO mun VALUES (2496, 'MG', '31', '20003', 'Corrego Novo');
INSERT INTO mun VALUES (4422, 'SC', '42', '04558', 'Correia Pinto');
INSERT INTO mun VALUES (757, 'PI', '22', '02901', 'Corrente');
INSERT INTO mun VALUES (1545, 'PE', '26', '04700', 'Correntes');
INSERT INTO mun VALUES (1970, 'BA', '29', '09307', 'Correntina');
INSERT INTO mun VALUES (1546, 'PE', '26', '04809', 'Cortes');
INSERT INTO mun VALUES (5166, 'MS', '50', '03207', 'Corumba');
INSERT INTO mun VALUES (5427, 'GO', '52', '05802', 'Corumba De Goias');
INSERT INTO mun VALUES (5428, 'GO', '52', '05901', 'Corumbaiba');
INSERT INTO mun VALUES (4743, 'RS', '43', '05173', 'Cerro Grande Do Sul');
INSERT INTO mun VALUES (4744, 'RS', '43', '05207', 'Cerro Largo');
INSERT INTO mun VALUES (4413, 'SC', '42', '04178', 'Cerro Negro');
INSERT INTO mun VALUES (3434, 'SP', '35', '11607', 'Cesario Lange');
INSERT INTO mun VALUES (4022, 'PR', '41', '05300', 'Ceu Azul');
INSERT INTO mun VALUES (5421, 'GO', '52', '05455', 'Cezarina');
INSERT INTO mun VALUES (2451, 'MG', '31', '15904', 'Chacara');
INSERT INTO mun VALUES (2452, 'MG', '31', '16001', 'Chale');
INSERT INTO mun VALUES (4745, 'RS', '43', '05306', 'Chapada');
INSERT INTO mun VALUES (372, 'TO', '17', '05102', 'Chapada Da Natividade');
INSERT INTO mun VALUES (371, 'TO', '17', '04600', 'Chapada De Areia');
INSERT INTO mun VALUES (11320, 'BA', '29', 'TR027', 'Chapada Diamantina  BA');
INSERT INTO mun VALUES (11321, 'RN', '24', 'TR028', 'Chapada do Apodi  RN');
INSERT INTO mun VALUES (2453, 'MG', '31', '16100', 'Chapada Do Norte');
INSERT INTO mun VALUES (5247, 'MT', '51', '03007', 'Chapada Dos Guimarães');
INSERT INTO mun VALUES (2454, 'MG', '31', '16159', 'Chapada Gaucha');
INSERT INTO mun VALUES (532, 'MA', '21', '03208', 'Chapadinha');
INSERT INTO mun VALUES (5422, 'GO', '52', '05471', 'Chapadão Do Ceu');
INSERT INTO mun VALUES (4414, 'SC', '42', '04194', 'Chapadão Do Lageado');
INSERT INTO mun VALUES (5163, 'MS', '50', '02951', 'Chapadão Do Sul');
INSERT INTO mun VALUES (4415, 'SC', '42', '04202', 'Chapeco');
INSERT INTO mun VALUES (11322, 'SC', '42', 'TR029', 'Chapecózinho SC');
INSERT INTO mun VALUES (3435, 'SP', '35', '11706', 'Charqueada');
INSERT INTO mun VALUES (4746, 'RS', '43', '05355', 'Charqueadas');
INSERT INTO mun VALUES (4747, 'RS', '43', '05371', 'Charrua');
INSERT INTO mun VALUES (962, 'CE', '23', '03907', 'Chaval');
INSERT INTO mun VALUES (3946, 'SP', '35', '57204', 'Chavantes');
INSERT INTO mun VALUES (211, 'PA', '15', '02509', 'Chaves');
INSERT INTO mun VALUES (1542, 'PE', '26', '04403', 'Chã De Alegria');
INSERT INTO mun VALUES (1543, 'PE', '26', '04502', 'Chã Grande');
INSERT INTO mun VALUES (2455, 'MG', '31', '16209', 'Chiador');
INSERT INTO mun VALUES (4748, 'RS', '43', '05405', 'Chiapetta');
INSERT INTO mun VALUES (4023, 'PR', '41', '05409', 'Chopinzinho');
INSERT INTO mun VALUES (963, 'CE', '23', '03931', 'Choro');
INSERT INTO mun VALUES (964, 'CE', '23', '03956', 'Chorozinho');
INSERT INTO mun VALUES (1954, 'BA', '29', '07707', 'Chorrocho');
INSERT INTO mun VALUES (1699, 'AL', '27', '01902', 'Chã Preta');
INSERT INTO mun VALUES (4749, 'RS', '43', '05439', 'Chui');
INSERT INTO mun VALUES (53, 'RO', '11', '00924', 'Chupinguaia');
INSERT INTO mun VALUES (4750, 'RS', '43', '05447', 'Chuvisca');
INSERT INTO mun VALUES (4024, 'PR', '41', '05508', 'Cianorte');
INSERT INTO mun VALUES (1955, 'BA', '29', '07806', 'Cicero Dantas');
INSERT INTO mun VALUES (4025, 'PR', '41', '05607', 'Cidade Gaucha');
INSERT INTO mun VALUES (5423, 'GO', '52', '05497', 'Cidade Ocidental');
INSERT INTO mun VALUES (533, 'MA', '21', '03257', 'Cidelandia');
INSERT INTO mun VALUES (4751, 'RS', '43', '05454', 'Cidreira');
INSERT INTO mun VALUES (1956, 'BA', '29', '07905', 'Cipo');
INSERT INTO mun VALUES (2456, 'MG', '31', '16308', 'Cipotanea');
INSERT INTO mun VALUES (4752, 'RS', '43', '05504', 'Ciriaco');
INSERT INTO mun VALUES (2457, 'MG', '31', '16407', 'Claraval');
INSERT INTO mun VALUES (2458, 'MG', '31', '16506', 'Claro Dos Poções');
INSERT INTO mun VALUES (5248, 'MT', '51', '03056', 'Claudia');
INSERT INTO mun VALUES (2459, 'MG', '31', '16605', 'Claudio');
INSERT INTO mun VALUES (3436, 'SP', '35', '11904', 'Clementina');
INSERT INTO mun VALUES (4026, 'PR', '41', '05706', 'Clevelandia');
INSERT INTO mun VALUES (1957, 'BA', '29', '08002', 'Coaraci');
INSERT INTO mun VALUES (115, 'AM', '13', '01209', 'Coari');
INSERT INTO mun VALUES (11323, 'MA', '21', 'TR030', 'Cocais  MA');
INSERT INTO mun VALUES (749, 'PI', '22', '02703', 'Cocal');
INSERT INTO mun VALUES (750, 'PI', '22', '02711', 'Cocal De Telha');
INSERT INTO mun VALUES (751, 'PI', '22', '02729', 'Cocal Dos Alves');
INSERT INTO mun VALUES (4416, 'SC', '42', '04251', 'Cocal Do Sul');
INSERT INTO mun VALUES (5249, 'MT', '51', '03106', 'Cocalinho');
INSERT INTO mun VALUES (5424, 'GO', '52', '05513', 'Cocalzinho De Goias');
INSERT INTO mun VALUES (1958, 'BA', '29', '08101', 'Cocos');
INSERT INTO mun VALUES (116, 'AM', '13', '01308', 'Codajas');
INSERT INTO mun VALUES (534, 'MA', '21', '03307', 'Codo');
INSERT INTO mun VALUES (535, 'MA', '21', '03406', 'Coelho Neto');
INSERT INTO mun VALUES (2460, 'MG', '31', '16704', 'Coimbra');
INSERT INTO mun VALUES (1700, 'AL', '27', '02009', 'Coite Do Noia');
INSERT INTO mun VALUES (752, 'PI', '22', '02737', 'Coivaras');
INSERT INTO mun VALUES (212, 'PA', '15', '02608', 'Colares');
INSERT INTO mun VALUES (3149, 'ES', '32', '01506', 'Colatina');
INSERT INTO mun VALUES (5250, 'MT', '51', '03205', 'Colider');
INSERT INTO mun VALUES (3437, 'SP', '35', '12001', 'Colina');
INSERT INTO mun VALUES (4753, 'RS', '43', '05587', 'Colinas');
INSERT INTO mun VALUES (536, 'MA', '21', '03505', 'Colinas');
INSERT INTO mun VALUES (5425, 'GO', '52', '05521', 'Colinas Do Sul');
INSERT INTO mun VALUES (373, 'TO', '17', '05508', 'Colinas Do Tocantins');
INSERT INTO mun VALUES (432, 'TO', '17', '16703', 'Colmeia');
INSERT INTO mun VALUES (5251, 'MT', '51', '03254', 'Colniza');
INSERT INTO mun VALUES (3438, 'SP', '35', '12100', 'Colombia');
INSERT INTO mun VALUES (4027, 'PR', '41', '05805', 'Colombo');
INSERT INTO mun VALUES (753, 'PI', '22', '02752', 'Colonia Do Gurgueia');
INSERT INTO mun VALUES (754, 'PI', '22', '02778', 'Colonia Do Piaui');
INSERT INTO mun VALUES (1701, 'AL', '27', '02108', 'Colonia Leopoldina');
INSERT INTO mun VALUES (4754, 'RS', '43', '05603', 'Colorado');
INSERT INTO mun VALUES (4028, 'PR', '41', '05904', 'Colorado');
INSERT INTO mun VALUES (25, 'RO', '11', '00064', 'Colorado Do Oeste');
INSERT INTO mun VALUES (2461, 'MG', '31', '16803', 'Coluna');
INSERT INTO mun VALUES (374, 'TO', '17', '05557', 'Combinado');
INSERT INTO mun VALUES (2462, 'MG', '31', '16902', 'Comendador Gomes');
INSERT INTO mun VALUES (3225, 'RJ', '33', '00951', 'Comendador Levy Gasparia');
INSERT INTO mun VALUES (2463, 'MG', '31', '17009', 'Comercinho');
INSERT INTO mun VALUES (5252, 'MT', '51', '03304', 'Comodoro');
INSERT INTO mun VALUES (1329, 'PB', '25', '04405', 'Conceição');
INSERT INTO mun VALUES (2464, 'MG', '31', '17108', 'Conceição Da Aparecida');
INSERT INTO mun VALUES (3150, 'ES', '32', '01605', 'Conceição Da Barra');
INSERT INTO mun VALUES (2441, 'MG', '31', '15201', 'Conceição Da Barra De Mi');
INSERT INTO mun VALUES (1959, 'BA', '29', '08200', 'Conceição Da Feira');
INSERT INTO mun VALUES (1796, 'SE', '28', '01504', 'Carmopolis');
INSERT INTO mun VALUES (2433, 'MG', '31', '14501', 'Carmopolis De Minas');
INSERT INTO mun VALUES (1535, 'PE', '26', '03900', 'Carnaiba');
INSERT INTO mun VALUES (1128, 'RN', '24', '02402', 'Carnauba Dos Dantas');
INSERT INTO mun VALUES (1129, 'RN', '24', '02501', 'Carnaubais');
INSERT INTO mun VALUES (11319, 'PI', '22', 'TR026', 'Carnaubais PI');
INSERT INTO mun VALUES (956, 'CE', '23', '03402', 'Carnaubal');
INSERT INTO mun VALUES (1536, 'PE', '26', '03926', 'Carnaubeira Da Penha');
INSERT INTO mun VALUES (2434, 'MG', '31', '14550', 'Carneirinho');
INSERT INTO mun VALUES (1698, 'AL', '27', '01803', 'Carneiros');
INSERT INTO mun VALUES (165, 'RR', '14', '00233', 'Caroebe');
INSERT INTO mun VALUES (525, 'MA', '21', '02804', 'Carolina');
INSERT INTO mun VALUES (1537, 'PE', '26', '04007', 'Carpina');
INSERT INTO mun VALUES (2435, 'MG', '31', '14600', 'Carrancas');
INSERT INTO mun VALUES (1324, 'PB', '25', '04108', 'Carrapateira');
INSERT INTO mun VALUES (368, 'TO', '17', '03891', 'Carrasco Bonito');
INSERT INTO mun VALUES (1538, 'PE', '26', '04106', 'Caruaru');
INSERT INTO mun VALUES (526, 'MA', '21', '02903', 'Carutapera');
INSERT INTO mun VALUES (2436, 'MG', '31', '14709', 'Carvalhopolis');
INSERT INTO mun VALUES (2437, 'MG', '31', '14808', 'Carvalhos');
INSERT INTO mun VALUES (3426, 'SP', '35', '10807', 'Casa Branca');
INSERT INTO mun VALUES (2438, 'MG', '31', '14907', 'Casa Grande');
INSERT INTO mun VALUES (1948, 'BA', '29', '07202', 'Casa Nova');
INSERT INTO mun VALUES (4735, 'RS', '43', '04903', 'Casca');
INSERT INTO mun VALUES (2439, 'MG', '31', '15003', 'Cascalho Rico');
INSERT INTO mun VALUES (957, 'CE', '23', '03501', 'Cascavel');
INSERT INTO mun VALUES (4017, 'PR', '41', '04808', 'Cascavel');
INSERT INTO mun VALUES (369, 'TO', '17', '03909', 'Caseara');
INSERT INTO mun VALUES (4736, 'RS', '43', '04952', 'Caseiros');
INSERT INTO mun VALUES (3230, 'RJ', '33', '01306', 'Casimiro De Abreu');
INSERT INTO mun VALUES (1539, 'PE', '26', '04155', 'Casinhas');
INSERT INTO mun VALUES (1325, 'PB', '25', '04157', 'Casserengue');
INSERT INTO mun VALUES (2440, 'MG', '31', '15102', 'Cassia');
INSERT INTO mun VALUES (3427, 'SP', '35', '10906', 'Cassia Dos Coqueiros');
INSERT INTO mun VALUES (5162, 'MS', '50', '02902', 'Cassilandia');
INSERT INTO mun VALUES (210, 'PA', '15', '02400', 'Castanhal');
INSERT INTO mun VALUES (5246, 'MT', '51', '02850', 'Castanheira');
INSERT INTO mun VALUES (52, 'RO', '11', '00908', 'Castanheiras');
INSERT INTO mun VALUES (5416, 'GO', '52', '05059', 'Castelandia');
INSERT INTO mun VALUES (3148, 'ES', '32', '01407', 'Castelo');
INSERT INTO mun VALUES (747, 'PI', '22', '02604', 'Castelo Do Piaui');
INSERT INTO mun VALUES (3428, 'SP', '35', '11003', 'Castilho');
INSERT INTO mun VALUES (4018, 'PR', '41', '04907', 'Castro');
INSERT INTO mun VALUES (1949, 'BA', '29', '07301', 'Castro Alves');
INSERT INTO mun VALUES (2442, 'MG', '31', '15300', 'Cataguases');
INSERT INTO mun VALUES (4211, 'PR', '41', '19004', 'Perola D''oeste');
INSERT INTO mun VALUES (5417, 'GO', '52', '05109', 'Catalão');
INSERT INTO mun VALUES (3429, 'SP', '35', '11102', 'Catanduva');
INSERT INTO mun VALUES (4410, 'SC', '42', '04004', 'Catanduvas');
INSERT INTO mun VALUES (4019, 'PR', '41', '05003', 'Catanduvas');
INSERT INTO mun VALUES (958, 'CE', '23', '03600', 'Catarina');
INSERT INTO mun VALUES (2443, 'MG', '31', '15359', 'Catas Altas');
INSERT INTO mun VALUES (2444, 'MG', '31', '15409', 'Catas Altas Da Noruega');
INSERT INTO mun VALUES (1540, 'PE', '26', '04205', 'Catende');
INSERT INTO mun VALUES (3430, 'SP', '35', '11201', 'Catigua');
INSERT INTO mun VALUES (1326, 'PB', '25', '04207', 'Catingueira');
INSERT INTO mun VALUES (1950, 'BA', '29', '07400', 'Catolandia');
INSERT INTO mun VALUES (1327, 'PB', '25', '04306', 'Catole Do Rocha');
INSERT INTO mun VALUES (1951, 'BA', '29', '07509', 'Catu');
INSERT INTO mun VALUES (4737, 'RS', '43', '05009', 'Catuipe');
INSERT INTO mun VALUES (2445, 'MG', '31', '15458', 'Catuji');
INSERT INTO mun VALUES (959, 'CE', '23', '03659', 'Catunda');
INSERT INTO mun VALUES (5418, 'GO', '52', '05208', 'Caturai');
INSERT INTO mun VALUES (1952, 'BA', '29', '07558', 'Caturama');
INSERT INTO mun VALUES (1328, 'PB', '25', '04355', 'Caturite');
INSERT INTO mun VALUES (2446, 'MG', '31', '15474', 'Catuti');
INSERT INTO mun VALUES (5404, 'GO', '52', '04300', 'Caçu');
INSERT INTO mun VALUES (960, 'CE', '23', '03709', 'Caucaia');
INSERT INTO mun VALUES (5419, 'GO', '52', '05307', 'Cavalcante');
INSERT INTO mun VALUES (2447, 'MG', '31', '15508', 'Caxambu');
INSERT INTO mun VALUES (4411, 'SC', '42', '04103', 'Caxambu Do Sul');
INSERT INTO mun VALUES (527, 'MA', '21', '03000', 'Caxias');
INSERT INTO mun VALUES (4738, 'RS', '43', '05108', 'Caxias Do Sul');
INSERT INTO mun VALUES (748, 'PI', '22', '02653', 'Caxingo');
INSERT INTO mun VALUES (916, 'CE', '23', '00000', 'Ceará');
INSERT INTO mun VALUES (1130, 'RN', '24', '02600', 'Ceara-mirim');
INSERT INTO mun VALUES (3431, 'SP', '35', '11300', 'Cedral');
INSERT INTO mun VALUES (528, 'MA', '21', '03109', 'Cedral');
INSERT INTO mun VALUES (1541, 'PE', '26', '04304', 'Cedro');
INSERT INTO mun VALUES (961, 'CE', '23', '03808', 'Cedro');
INSERT INTO mun VALUES (1797, 'SE', '28', '01603', 'Cedro De São João');
INSERT INTO mun VALUES (2448, 'MG', '31', '15607', 'Cedro Do Abaete');
INSERT INTO mun VALUES (4412, 'SC', '42', '04152', 'Celso Ramos');
INSERT INTO mun VALUES (370, 'TO', '17', '04105', 'Centenario');
INSERT INTO mun VALUES (4739, 'RS', '43', '05116', 'Centenario');
INSERT INTO mun VALUES (4020, 'PR', '41', '05102', 'Centenario Do Sul');
INSERT INTO mun VALUES (1953, 'BA', '29', '07608', 'Central');
INSERT INTO mun VALUES (2449, 'MG', '31', '15706', 'Central De Minas');
INSERT INTO mun VALUES (529, 'MA', '21', '03125', 'Central Do Maranhão');
INSERT INTO mun VALUES (2450, 'MG', '31', '15805', 'Centralina');
INSERT INTO mun VALUES (530, 'MA', '21', '03158', 'Centro Do Guilherme');
INSERT INTO mun VALUES (531, 'MA', '21', '03174', 'Centro Novo Do Maranhão');
INSERT INTO mun VALUES (24, 'RO', '11', '00056', 'Cerejeiras');
INSERT INTO mun VALUES (5420, 'GO', '52', '05406', 'Ceres');
INSERT INTO mun VALUES (3432, 'SP', '35', '11409', 'Cerqueira Cesar');
INSERT INTO mun VALUES (3433, 'SP', '35', '11508', 'Cerquilho');
INSERT INTO mun VALUES (4740, 'RS', '43', '05124', 'Cerrito');
INSERT INTO mun VALUES (4021, 'PR', '41', '05201', 'Cerro Azul');
INSERT INTO mun VALUES (4741, 'RS', '43', '05132', 'Cerro Branco');
INSERT INTO mun VALUES (1131, 'RN', '24', '02709', 'Cerro Cora');
INSERT INTO mun VALUES (4742, 'RS', '43', '05157', 'Cerro Grande');
INSERT INTO mun VALUES (2407, 'MG', '31', '12059', 'Cantagalo');
INSERT INTO mun VALUES (4012, 'PR', '41', '04451', 'Cantagalo');
INSERT INTO mun VALUES (523, 'MA', '21', '02705', 'Cantanhede');
INSERT INTO mun VALUES (741, 'PI', '22', '02307', 'Canto Do Buriti');
INSERT INTO mun VALUES (11316, 'PR', '41', 'TR023', 'Cantuquiriguaçu  PR');
INSERT INTO mun VALUES (1941, 'BA', '29', '06824', 'Canudos');
INSERT INTO mun VALUES (4723, 'RS', '43', '04614', 'Canudos Do Vale');
INSERT INTO mun VALUES (111, 'AM', '13', '00904', 'Canutama');
INSERT INTO mun VALUES (208, 'PA', '15', '02202', 'Capanema');
INSERT INTO mun VALUES (4013, 'PR', '41', '04501', 'Capanema');
INSERT INTO mun VALUES (11317, 'ES', '32', 'TR024', 'Caparaó  ES');
INSERT INTO mun VALUES (2408, 'MG', '31', '12109', 'Caparao');
INSERT INTO mun VALUES (4453, 'SC', '42', '06702', 'Herval D''oeste');
INSERT INTO mun VALUES (1794, 'SE', '28', '01306', 'Capela');
INSERT INTO mun VALUES (1697, 'AL', '27', '01704', 'Capela');
INSERT INTO mun VALUES (4729, 'RS', '43', '04689', 'Capela De Santana');
INSERT INTO mun VALUES (3421, 'SP', '35', '10302', 'Capela Do Alto');
INSERT INTO mun VALUES (1942, 'BA', '29', '06857', 'Capela Do Alto Alegre');
INSERT INTO mun VALUES (2409, 'MG', '31', '12208', 'Capela Nova');
INSERT INTO mun VALUES (2410, 'MG', '31', '12307', 'Capelinha');
INSERT INTO mun VALUES (2411, 'MG', '31', '12406', 'Capetinga');
INSERT INTO mun VALUES (1322, 'PB', '25', '04033', 'Capim');
INSERT INTO mun VALUES (2412, 'MG', '31', '12505', 'Capim Branco');
INSERT INTO mun VALUES (1943, 'BA', '29', '06873', 'Capim Grosso');
INSERT INTO mun VALUES (2413, 'MG', '31', '12604', 'Capinopolis');
INSERT INTO mun VALUES (4408, 'SC', '42', '03907', 'Capinzal');
INSERT INTO mun VALUES (524, 'MA', '21', '02754', 'Capinzal Do Norte');
INSERT INTO mun VALUES (951, 'CE', '23', '02909', 'Capistrano');
INSERT INTO mun VALUES (4730, 'RS', '43', '04697', 'Capitão');
INSERT INTO mun VALUES (2414, 'MG', '31', '12653', 'Capitão Andrade');
INSERT INTO mun VALUES (742, 'PI', '22', '02406', 'Capitão De Campos');
INSERT INTO mun VALUES (2415, 'MG', '31', '12703', 'Capitão Eneas');
INSERT INTO mun VALUES (743, 'PI', '22', '02455', 'Capitão Gervasio Oliveir');
INSERT INTO mun VALUES (4014, 'PR', '41', '04600', 'Capitão Leonidas Marques');
INSERT INTO mun VALUES (2416, 'MG', '31', '12802', 'Capitolio');
INSERT INTO mun VALUES (209, 'PA', '15', '02301', 'Capitão Poço');
INSERT INTO mun VALUES (3422, 'SP', '35', '10401', 'Capivari');
INSERT INTO mun VALUES (4409, 'SC', '42', '03956', 'Capivari De Baixo');
INSERT INTO mun VALUES (4728, 'RS', '43', '04671', 'Capivari Do Sul');
INSERT INTO mun VALUES (77, 'AC', '12', '00179', 'Capixaba');
INSERT INTO mun VALUES (4401, 'SC', '42', '03253', 'Capão Alto');
INSERT INTO mun VALUES (3420, 'SP', '35', '10203', 'Capão Bonito');
INSERT INTO mun VALUES (4724, 'RS', '43', '04622', 'Capão Bonito Do Sul');
INSERT INTO mun VALUES (4725, 'RS', '43', '04630', 'Capão Da Canoa');
INSERT INTO mun VALUES (4726, 'RS', '43', '04655', 'Capão Do Cipo');
INSERT INTO mun VALUES (4727, 'RS', '43', '04663', 'Capão Do Leão');
INSERT INTO mun VALUES (1534, 'PE', '26', '03801', 'Capoeiras');
INSERT INTO mun VALUES (2417, 'MG', '31', '12901', 'Caputira');
INSERT INTO mun VALUES (4732, 'RS', '43', '04713', 'Caraa');
INSERT INTO mun VALUES (164, 'RR', '14', '00209', 'Caracarai');
INSERT INTO mun VALUES (5161, 'MS', '50', '02803', 'Caracol');
INSERT INTO mun VALUES (744, 'PI', '22', '02505', 'Caracol');
INSERT INTO mun VALUES (3423, 'SP', '35', '10500', 'Caraguatatuba');
INSERT INTO mun VALUES (4107, 'PR', '41', '11209', 'Itapejara D''oeste');
INSERT INTO mun VALUES (2418, 'MG', '31', '13008', 'Carai');
INSERT INTO mun VALUES (1944, 'BA', '29', '06899', 'Caraibas');
INSERT INTO mun VALUES (4015, 'PR', '41', '04659', 'Carambei');
INSERT INTO mun VALUES (2419, 'MG', '31', '13107', 'Caranaiba');
INSERT INTO mun VALUES (2420, 'MG', '31', '13206', 'Carandai');
INSERT INTO mun VALUES (2421, 'MG', '31', '13305', 'Carangola');
INSERT INTO mun VALUES (3224, 'RJ', '33', '00936', 'Carapebus');
INSERT INTO mun VALUES (3424, 'SP', '35', '10609', 'Carapicuiba');
INSERT INTO mun VALUES (2422, 'MG', '31', '13404', 'Caratinga');
INSERT INTO mun VALUES (112, 'AM', '13', '01001', 'Carauari');
INSERT INTO mun VALUES (1127, 'RN', '24', '02303', 'Caraubas');
INSERT INTO mun VALUES (1323, 'PB', '25', '04074', 'Caraubas');
INSERT INTO mun VALUES (745, 'PI', '22', '02539', 'Caraubas Do Piaui');
INSERT INTO mun VALUES (1945, 'BA', '29', '06907', 'Caravelas');
INSERT INTO mun VALUES (4731, 'RS', '43', '04705', 'Carazinho');
INSERT INTO mun VALUES (2423, 'MG', '31', '13503', 'Carbonita');
INSERT INTO mun VALUES (1946, 'BA', '29', '07004', 'Cardeal Da Silva');
INSERT INTO mun VALUES (3425, 'SP', '35', '10708', 'Cardoso');
INSERT INTO mun VALUES (3228, 'RJ', '33', '01157', 'Cardoso Moreira');
INSERT INTO mun VALUES (2424, 'MG', '31', '13602', 'Careaçu');
INSERT INTO mun VALUES (113, 'AM', '13', '01100', 'Careiro');
INSERT INTO mun VALUES (114, 'AM', '13', '01159', 'Careiro Da Varzea');
INSERT INTO mun VALUES (3147, 'ES', '32', '01308', 'Cariacica');
INSERT INTO mun VALUES (952, 'CE', '23', '03006', 'Caridade');
INSERT INTO mun VALUES (746, 'PI', '22', '02554', 'Caridade Do Piaui');
INSERT INTO mun VALUES (1947, 'BA', '29', '07103', 'Carinhanha');
INSERT INTO mun VALUES (1795, 'SE', '28', '01405', 'Carira');
INSERT INTO mun VALUES (953, 'CE', '23', '03105', 'Carire');
INSERT INTO mun VALUES (954, 'CE', '23', '03204', 'Caririaçu');
INSERT INTO mun VALUES (366, 'TO', '17', '03867', 'Cariri Do Tocantins');
INSERT INTO mun VALUES (11318, 'PB', '25', 'TR025', 'Cariri PB');
INSERT INTO mun VALUES (955, 'CE', '23', '03303', 'Carius');
INSERT INTO mun VALUES (5245, 'MT', '51', '02793', 'Carlinda');
INSERT INTO mun VALUES (4016, 'PR', '41', '04709', 'Carlopolis');
INSERT INTO mun VALUES (4733, 'RS', '43', '04804', 'Carlos Barbosa');
INSERT INTO mun VALUES (2425, 'MG', '31', '13701', 'Carlos Chagas');
INSERT INTO mun VALUES (4734, 'RS', '43', '04853', 'Carlos Gomes');
INSERT INTO mun VALUES (2426, 'MG', '31', '13800', 'Carmesia');
INSERT INTO mun VALUES (3229, 'RJ', '33', '01207', 'Carmo');
INSERT INTO mun VALUES (2427, 'MG', '31', '13909', 'Carmo Da Cachoeira');
INSERT INTO mun VALUES (2428, 'MG', '31', '14006', 'Carmo Da Mata');
INSERT INTO mun VALUES (2429, 'MG', '31', '14105', 'Carmo De Minas');
INSERT INTO mun VALUES (2430, 'MG', '31', '14204', 'Carmo Do Cajuru');
INSERT INTO mun VALUES (2431, 'MG', '31', '14303', 'Carmo Do Paranaiba');
INSERT INTO mun VALUES (2432, 'MG', '31', '14402', 'Carmo Do Rio Claro');
INSERT INTO mun VALUES (5415, 'GO', '52', '05000', 'Carmo Do Rio Verde');
INSERT INTO mun VALUES (367, 'TO', '17', '03883', 'Carmolandia');
INSERT INTO mun VALUES (4712, 'RS', '43', '03707', 'Campina Das Missões');
INSERT INTO mun VALUES (3410, 'SP', '35', '09452', 'Campina Do Monte Alegre');
INSERT INTO mun VALUES (4003, 'PR', '41', '03958', 'Campina Do Simão');
INSERT INTO mun VALUES (1321, 'PB', '25', '04009', 'Campina Grande');
INSERT INTO mun VALUES (4004, 'PR', '41', '04006', 'Campina Grande Do Sul');
INSERT INTO mun VALUES (5239, 'MT', '51', '02603', 'Campinapolis');
INSERT INTO mun VALUES (3411, 'SP', '35', '09502', 'Campinas');
INSERT INTO mun VALUES (735, 'PI', '22', '02109', 'Campinas Do Piaui');
INSERT INTO mun VALUES (4713, 'RS', '43', '03806', 'Campinas Do Sul');
INSERT INTO mun VALUES (5409, 'GO', '52', '04656', 'Campinaçu');
INSERT INTO mun VALUES (2396, 'MG', '31', '11101', 'Campina Verde');
INSERT INTO mun VALUES (5410, 'GO', '52', '04706', 'Campinorte');
INSERT INTO mun VALUES (1694, 'AL', '27', '01407', 'Campo Alegre');
INSERT INTO mun VALUES (4402, 'SC', '42', '03303', 'Campo Alegre');
INSERT INTO mun VALUES (5411, 'GO', '52', '04805', 'Campo Alegre De Goias');
INSERT INTO mun VALUES (1931, 'BA', '29', '05909', 'Campo Alegre De Lourdes');
INSERT INTO mun VALUES (736, 'PI', '22', '02117', 'Campo Alegre Do Fidalgo');
INSERT INTO mun VALUES (2397, 'MG', '31', '11150', 'Campo Azul');
INSERT INTO mun VALUES (2398, 'MG', '31', '11200', 'Campo Belo');
INSERT INTO mun VALUES (4403, 'SC', '42', '03402', 'Campo Belo Do Sul');
INSERT INTO mun VALUES (4714, 'RS', '43', '03905', 'Campo Bom');
INSERT INTO mun VALUES (4005, 'PR', '41', '04055', 'Campo Bonito');
INSERT INTO mun VALUES (1482, 'PB', '25', '16409', 'Campo De Santana');
INSERT INTO mun VALUES (1791, 'SE', '28', '01009', 'Campo Do Brito');
INSERT INTO mun VALUES (2399, 'MG', '31', '11309', 'Campo Do Meio');
INSERT INTO mun VALUES (4006, 'PR', '41', '04105', 'Campo Do Tenente');
INSERT INTO mun VALUES (4404, 'SC', '42', '03501', 'Campo Ere');
INSERT INTO mun VALUES (2400, 'MG', '31', '11408', 'Campo Florido');
INSERT INTO mun VALUES (1932, 'BA', '29', '06006', 'Campo Formoso');
INSERT INTO mun VALUES (1695, 'AL', '27', '01506', 'Campo Grande');
INSERT INTO mun VALUES (5160, 'MS', '50', '02704', 'Campo Grande');
INSERT INTO mun VALUES (737, 'PI', '22', '02133', 'Campo Grande Do Piaui');
INSERT INTO mun VALUES (4007, 'PR', '41', '04204', 'Campo Largo');
INSERT INTO mun VALUES (738, 'PI', '22', '02174', 'Campo Largo Do Piaui');
INSERT INTO mun VALUES (3403, 'SP', '35', '08900', 'Caiabu');
INSERT INTO mun VALUES (5412, 'GO', '52', '04854', 'Campo Limpo De Goias');
INSERT INTO mun VALUES (3412, 'SP', '35', '09601', 'Campo Limpo Paulista');
INSERT INTO mun VALUES (4008, 'PR', '41', '04253', 'Campo Magro');
INSERT INTO mun VALUES (739, 'PI', '22', '02208', 'Campo Maior');
INSERT INTO mun VALUES (4009, 'PR', '41', '04303', 'Campo Mourão');
INSERT INTO mun VALUES (4715, 'RS', '43', '04002', 'Campo Novo');
INSERT INTO mun VALUES (50, 'RO', '11', '00700', 'Campo Novo De Rondonia');
INSERT INTO mun VALUES (5240, 'MT', '51', '02637', 'Campo Novo Do Parecis');
INSERT INTO mun VALUES (1125, 'RN', '24', '02105', 'Campo Redondo');
INSERT INTO mun VALUES (2401, 'MG', '31', '11507', 'Campos Altos');
INSERT INTO mun VALUES (5413, 'GO', '52', '04904', 'Campos Belos');
INSERT INTO mun VALUES (4716, 'RS', '43', '04101', 'Campos Borges');
INSERT INTO mun VALUES (5242, 'MT', '51', '02686', 'Campos De Julio');
INSERT INTO mun VALUES (3413, 'SP', '35', '09700', 'Campos Do Jordão');
INSERT INTO mun VALUES (3226, 'RJ', '33', '01009', 'Campos Dos Goytacazes');
INSERT INTO mun VALUES (2402, 'MG', '31', '11606', 'Campos Gerais');
INSERT INTO mun VALUES (365, 'TO', '17', '03842', 'Campos Lindos');
INSERT INTO mun VALUES (4405, 'SC', '42', '03600', 'Campos Novos');
INSERT INTO mun VALUES (3414, 'SP', '35', '09809', 'Campos Novos Paulista');
INSERT INTO mun VALUES (949, 'CE', '23', '02701', 'Campos Sales');
INSERT INTO mun VALUES (5414, 'GO', '52', '04953', 'Campos Verdes');
INSERT INTO mun VALUES (5241, 'MT', '51', '02678', 'Campo Verde');
INSERT INTO mun VALUES (1532, 'PE', '26', '03603', 'Camutanga');
INSERT INTO mun VALUES (2403, 'MG', '31', '11705', 'Canaã');
INSERT INTO mun VALUES (5243, 'MT', '51', '02694', 'Canabrava Do Norte');
INSERT INTO mun VALUES (207, 'PA', '15', '02152', 'Canaã Dos Carajas');
INSERT INTO mun VALUES (3415, 'SP', '35', '09908', 'Cananeia');
INSERT INTO mun VALUES (1696, 'AL', '27', '01605', 'Canapi');
INSERT INTO mun VALUES (1933, 'BA', '29', '06105', 'Canapolis');
INSERT INTO mun VALUES (2404, 'MG', '31', '11804', 'Canapolis');
INSERT INTO mun VALUES (5244, 'MT', '51', '02702', 'Canarana');
INSERT INTO mun VALUES (1934, 'BA', '29', '06204', 'Canarana');
INSERT INTO mun VALUES (3416, 'SP', '35', '09957', 'Canas');
INSERT INTO mun VALUES (2405, 'MG', '31', '11903', 'Cana Verde');
INSERT INTO mun VALUES (740, 'PI', '22', '02251', 'Canavieira');
INSERT INTO mun VALUES (1935, 'BA', '29', '06303', 'Canavieiras');
INSERT INTO mun VALUES (1936, 'BA', '29', '06402', 'Candeal');
INSERT INTO mun VALUES (1937, 'BA', '29', '06501', 'Candeias');
INSERT INTO mun VALUES (51, 'RO', '11', '00809', 'Candeias Do Jamari');
INSERT INTO mun VALUES (4717, 'RS', '43', '04200', 'Candelaria');
INSERT INTO mun VALUES (1938, 'BA', '29', '06600', 'Candiba');
INSERT INTO mun VALUES (4010, 'PR', '41', '04402', 'Candido De Abreu');
INSERT INTO mun VALUES (4718, 'RS', '43', '04309', 'Candido Godoi');
INSERT INTO mun VALUES (522, 'MA', '21', '02606', 'Candido Mendes');
INSERT INTO mun VALUES (3417, 'SP', '35', '10005', 'Candido Mota');
INSERT INTO mun VALUES (3418, 'SP', '35', '10104', 'Candido Rodrigues');
INSERT INTO mun VALUES (1939, 'BA', '29', '06709', 'Candido Sales');
INSERT INTO mun VALUES (4719, 'RS', '43', '04358', 'Candiota');
INSERT INTO mun VALUES (4011, 'PR', '41', '04428', 'Candoi');
INSERT INTO mun VALUES (4720, 'RS', '43', '04408', 'Canela');
INSERT INTO mun VALUES (4406, 'SC', '42', '03709', 'Canelinha');
INSERT INTO mun VALUES (1126, 'RN', '24', '02204', 'Canguaretama');
INSERT INTO mun VALUES (4721, 'RS', '43', '04507', 'Canguçu');
INSERT INTO mun VALUES (1792, 'SE', '28', '01108', 'Canhoba');
INSERT INTO mun VALUES (1533, 'PE', '26', '03702', 'Canhotinho');
INSERT INTO mun VALUES (950, 'CE', '23', '02800', 'Caninde');
INSERT INTO mun VALUES (1793, 'SE', '28', '01207', 'Caninde De São Francisco');
INSERT INTO mun VALUES (3419, 'SP', '35', '10153', 'Canitar');
INSERT INTO mun VALUES (4722, 'RS', '43', '04606', 'Canoas');
INSERT INTO mun VALUES (4407, 'SC', '42', '03808', 'Canoinhas');
INSERT INTO mun VALUES (1940, 'BA', '29', '06808', 'Cansanção');
INSERT INTO mun VALUES (163, 'RR', '14', '00175', 'Canta');
INSERT INTO mun VALUES (3227, 'RJ', '33', '01108', 'Cantagalo');
INSERT INTO mun VALUES (5402, 'GO', '52', '04201', 'Cachoeira De Goias');
INSERT INTO mun VALUES (2382, 'MG', '31', '09709', 'Cachoeira De Minas');
INSERT INTO mun VALUES (2305, 'MG', '31', '02704', 'Cachoeira De Pajeu');
INSERT INTO mun VALUES (205, 'PA', '15', '02004', 'Cachoeira Do Arari');
INSERT INTO mun VALUES (204, 'PA', '15', '01956', 'Cachoeira Do Piria');
INSERT INTO mun VALUES (1312, 'PB', '25', '03308', 'Cachoeira Dos Indios');
INSERT INTO mun VALUES (4703, 'RS', '43', '03004', 'Cachoeira Do Sul');
INSERT INTO mun VALUES (2383, 'MG', '31', '09808', 'Cachoeira Dourada');
INSERT INTO mun VALUES (5403, 'GO', '52', '04250', 'Cachoeira Dourada');
INSERT INTO mun VALUES (518, 'MA', '21', '02374', 'Cachoeira Grande');
INSERT INTO mun VALUES (3400, 'SP', '35', '08603', 'Cachoeira Paulista');
INSERT INTO mun VALUES (3222, 'RJ', '33', '00803', 'Cachoeiras De Macacu');
INSERT INTO mun VALUES (4704, 'RS', '43', '03103', 'Cachoeirinha');
INSERT INTO mun VALUES (1526, 'PE', '26', '03108', 'Cachoeirinha');
INSERT INTO mun VALUES (364, 'TO', '17', '03826', 'Cachoeirinha');
INSERT INTO mun VALUES (3146, 'ES', '32', '01209', 'Cachoeiro De Itapemirim');
INSERT INTO mun VALUES (1313, 'PB', '25', '03407', 'Cacimba De Areia');
INSERT INTO mun VALUES (1314, 'PB', '25', '03506', 'Cacimba De Dentro');
INSERT INTO mun VALUES (1315, 'PB', '25', '03555', 'Cacimbas');
INSERT INTO mun VALUES (1691, 'AL', '27', '01209', 'Cacimbinhas');
INSERT INTO mun VALUES (4705, 'RS', '43', '03202', 'Cacique Doble');
INSERT INTO mun VALUES (23, 'RO', '11', '00049', 'Cacoal');
INSERT INTO mun VALUES (3401, 'SP', '35', '08702', 'Caconde');
INSERT INTO mun VALUES (1921, 'BA', '29', '05008', 'Cacule');
INSERT INTO mun VALUES (1922, 'BA', '29', '05107', 'Caem');
INSERT INTO mun VALUES (2384, 'MG', '31', '09907', 'Caetanopolis');
INSERT INTO mun VALUES (1923, 'BA', '29', '05156', 'Caetanos');
INSERT INTO mun VALUES (2385, 'MG', '31', '10004', 'Caete');
INSERT INTO mun VALUES (1527, 'PE', '26', '03207', 'Caetes');
INSERT INTO mun VALUES (1924, 'BA', '29', '05206', 'Caetite');
INSERT INTO mun VALUES (1925, 'BA', '29', '05305', 'Cafarnaum');
INSERT INTO mun VALUES (3995, 'PR', '41', '03404', 'Cafeara');
INSERT INTO mun VALUES (3402, 'SP', '35', '08801', 'Cafelandia');
INSERT INTO mun VALUES (3996, 'PR', '41', '03453', 'Cafelandia');
INSERT INTO mun VALUES (3997, 'PR', '41', '03479', 'Cafezal Do Sul');
INSERT INTO mun VALUES (2386, 'MG', '31', '10103', 'Caiana');
INSERT INTO mun VALUES (5405, 'GO', '52', '04409', 'Caiaponia');
INSERT INTO mun VALUES (1316, 'PB', '25', '03605', 'Caiçara');
INSERT INTO mun VALUES (4707, 'RS', '43', '03400', 'Caiçara');
INSERT INTO mun VALUES (1122, 'RN', '24', '01859', 'Caiçara Do Norte');
INSERT INTO mun VALUES (1123, 'RN', '24', '01909', 'Caiçara Do Rio Do Vento');
INSERT INTO mun VALUES (4706, 'RS', '43', '03301', 'Caibate');
INSERT INTO mun VALUES (4398, 'SC', '42', '03105', 'Caibi');
INSERT INTO mun VALUES (1124, 'RN', '24', '02006', 'Caico');
INSERT INTO mun VALUES (3404, 'SP', '35', '09007', 'Caieiras');
INSERT INTO mun VALUES (1926, 'BA', '29', '05404', 'Cairu');
INSERT INTO mun VALUES (3405, 'SP', '35', '09106', 'Caiua');
INSERT INTO mun VALUES (3406, 'SP', '35', '09205', 'Cajamar');
INSERT INTO mun VALUES (519, 'MA', '21', '02408', 'Cajapio');
INSERT INTO mun VALUES (520, 'MA', '21', '02507', 'Cajari');
INSERT INTO mun VALUES (3407, 'SP', '35', '09254', 'Cajati');
INSERT INTO mun VALUES (1317, 'PB', '25', '03704', 'Cajazeiras');
INSERT INTO mun VALUES (732, 'PI', '22', '02075', 'Cajazeiras Do Piaui');
INSERT INTO mun VALUES (1318, 'PB', '25', '03753', 'Cajazeirinhas');
INSERT INTO mun VALUES (3408, 'SP', '35', '09304', 'Cajobi');
INSERT INTO mun VALUES (1692, 'AL', '27', '01308', 'Cajueiro');
INSERT INTO mun VALUES (733, 'PI', '22', '02083', 'Cajueiro Da Praia');
INSERT INTO mun VALUES (2387, 'MG', '31', '10202', 'Cajuri');
INSERT INTO mun VALUES (3409, 'SP', '35', '09403', 'Cajuru');
INSERT INTO mun VALUES (1528, 'PE', '26', '03306', 'Calçado');
INSERT INTO mun VALUES (2388, 'MG', '31', '10301', 'Caldas');
INSERT INTO mun VALUES (1319, 'PB', '25', '03803', 'Caldas Brandão');
INSERT INTO mun VALUES (5406, 'GO', '52', '04508', 'Caldas Novas');
INSERT INTO mun VALUES (5407, 'GO', '52', '04557', 'Caldazinha');
INSERT INTO mun VALUES (1927, 'BA', '29', '05503', 'Caldeirão Grande');
INSERT INTO mun VALUES (734, 'PI', '22', '02091', 'Caldeirão Grande Do Piau');
INSERT INTO mun VALUES (3998, 'PR', '41', '03503', 'California');
INSERT INTO mun VALUES (4399, 'SC', '42', '03154', 'Calmon');
INSERT INTO mun VALUES (322, 'AP', '16', '00204', 'Calçoene');
INSERT INTO mun VALUES (1529, 'PE', '26', '03405', 'Calumbi');
INSERT INTO mun VALUES (1929, 'BA', '29', '05701', 'Camaçari');
INSERT INTO mun VALUES (1928, 'BA', '29', '05602', 'Camacan');
INSERT INTO mun VALUES (2389, 'MG', '31', '10400', 'Camacho');
INSERT INTO mun VALUES (1320, 'PB', '25', '03902', 'Camalau');
INSERT INTO mun VALUES (1930, 'BA', '29', '05800', 'Camamu');
INSERT INTO mun VALUES (2390, 'MG', '31', '10509', 'Camanducaia');
INSERT INTO mun VALUES (5159, 'MS', '50', '02605', 'Camapuã');
INSERT INTO mun VALUES (4708, 'RS', '43', '03509', 'Camaquã');
INSERT INTO mun VALUES (1530, 'PE', '26', '03454', 'Camaragibe');
INSERT INTO mun VALUES (4709, 'RS', '43', '03558', 'Camargo');
INSERT INTO mun VALUES (3999, 'PR', '41', '03602', 'Cambara');
INSERT INTO mun VALUES (4710, 'RS', '43', '03608', 'Cambara Do Sul');
INSERT INTO mun VALUES (4000, 'PR', '41', '03701', 'Cambe');
INSERT INTO mun VALUES (4001, 'PR', '41', '03800', 'Cambira');
INSERT INTO mun VALUES (4400, 'SC', '42', '03204', 'Camboriu');
INSERT INTO mun VALUES (3223, 'RJ', '33', '00902', 'Cambuci');
INSERT INTO mun VALUES (2391, 'MG', '31', '10608', 'Cambui');
INSERT INTO mun VALUES (2392, 'MG', '31', '10707', 'Cambuquira');
INSERT INTO mun VALUES (206, 'PA', '15', '02103', 'Cameta');
INSERT INTO mun VALUES (948, 'CE', '23', '02602', 'Camocim');
INSERT INTO mun VALUES (1531, 'PE', '26', '03504', 'Camocim De São Felix');
INSERT INTO mun VALUES (2393, 'MG', '31', '10806', 'Campanario');
INSERT INTO mun VALUES (2394, 'MG', '31', '10905', 'Campanha');
INSERT INTO mun VALUES (2395, 'MG', '31', '11002', 'Campestre');
INSERT INTO mun VALUES (1693, 'AL', '27', '01357', 'Campestre');
INSERT INTO mun VALUES (4711, 'RS', '43', '03673', 'Campestre Da Serra');
INSERT INTO mun VALUES (5408, 'GO', '52', '04607', 'Campestre De Goias');
INSERT INTO mun VALUES (521, 'MA', '21', '02556', 'Campestre Do Maranhão');
INSERT INTO mun VALUES (4002, 'PR', '41', '03909', 'Campina Da Lagoa');
INSERT INTO mun VALUES (3389, 'SP', '35', '07605', 'Bragança Paulista');
INSERT INTO mun VALUES (3993, 'PR', '41', '03354', 'Braganey');
INSERT INTO mun VALUES (1690, 'AL', '27', '01100', 'Branquinha');
INSERT INTO mun VALUES (4393, 'SC', '42', '02800', 'Braço Do Norte');
INSERT INTO mun VALUES (4394, 'SC', '42', '02859', 'Braço Do Trombudo');
INSERT INTO mun VALUES (5157, 'MS', '50', '02308', 'Brasilandia');
INSERT INTO mun VALUES (2368, 'MG', '31', '08552', 'Brasilandia De Minas');
INSERT INTO mun VALUES (3994, 'PR', '41', '03370', 'Brasilandia Do Sul');
INSERT INTO mun VALUES (361, 'TO', '17', '03602', 'Brasilandia Do Tocantins');
INSERT INTO mun VALUES (75, 'AC', '12', '00104', 'Brasileia');
INSERT INTO mun VALUES (727, 'PI', '22', '01960', 'Brasileira');
INSERT INTO mun VALUES (5606, 'DF', '53', '00108', 'Brasilia');
INSERT INTO mun VALUES (2369, 'MG', '31', '08602', 'Brasilia De Minas');
INSERT INTO mun VALUES (199, 'PA', '15', '01725', 'Brasil Novo');
INSERT INTO mun VALUES (5237, 'MT', '51', '01902', 'Brasnorte');
INSERT INTO mun VALUES (2372, 'MG', '31', '08909', 'Brasopolis');
INSERT INTO mun VALUES (2370, 'MG', '31', '08701', 'Bras Pires');
INSERT INTO mun VALUES (3390, 'SP', '35', '07704', 'Brauna');
INSERT INTO mun VALUES (2371, 'MG', '31', '08800', 'Braunas');
INSERT INTO mun VALUES (5395, 'GO', '52', '03609', 'Brazabrantes');
INSERT INTO mun VALUES (1912, 'BA', '29', '04308', 'Brejões');
INSERT INTO mun VALUES (3145, 'ES', '32', '01159', 'Brejetuba');
INSERT INTO mun VALUES (1121, 'RN', '24', '01800', 'Brejinho');
INSERT INTO mun VALUES (1520, 'PE', '26', '02506', 'Brejinho');
INSERT INTO mun VALUES (362, 'TO', '17', '03701', 'Brejinho De Nazare');
INSERT INTO mun VALUES (512, 'MA', '21', '02101', 'Brejo');
INSERT INTO mun VALUES (1519, 'PE', '26', '02407', 'Brejão');
INSERT INTO mun VALUES (3391, 'SP', '35', '07753', 'Brejo Alegre');
INSERT INTO mun VALUES (1521, 'PE', '26', '02605', 'Brejo Da Madre De Deus');
INSERT INTO mun VALUES (513, 'MA', '21', '02150', 'Brejo De Areia');
INSERT INTO mun VALUES (1307, 'PB', '25', '02805', 'Brejo Do Cruz');
INSERT INTO mun VALUES (728, 'PI', '22', '01988', 'Brejo Do Piaui');
INSERT INTO mun VALUES (1308, 'PB', '25', '02904', 'Brejo Dos Santos');
INSERT INTO mun VALUES (1790, 'SE', '28', '00704', 'Brejo Grande');
INSERT INTO mun VALUES (200, 'PA', '15', '01758', 'Brejo Grande Do Araguaia');
INSERT INTO mun VALUES (1913, 'BA', '29', '04407', 'Brejolandia');
INSERT INTO mun VALUES (947, 'CE', '23', '02503', 'Brejo Santo');
INSERT INTO mun VALUES (201, 'PA', '15', '01782', 'Breu Branco');
INSERT INTO mun VALUES (202, 'PA', '15', '01808', 'Breves');
INSERT INTO mun VALUES (5396, 'GO', '52', '03807', 'Britania');
INSERT INTO mun VALUES (4699, 'RS', '43', '02659', 'Brochier');
INSERT INTO mun VALUES (3392, 'SP', '35', '07803', 'Brodowski');
INSERT INTO mun VALUES (3393, 'SP', '35', '07902', 'Brotas');
INSERT INTO mun VALUES (1914, 'BA', '29', '04506', 'Brotas De Macaubas');
INSERT INTO mun VALUES (2373, 'MG', '31', '09006', 'Brumadinho');
INSERT INTO mun VALUES (1915, 'BA', '29', '04605', 'Brumado');
INSERT INTO mun VALUES (4395, 'SC', '42', '02875', 'Brunopolis');
INSERT INTO mun VALUES (4396, 'SC', '42', '02909', 'Brusque');
INSERT INTO mun VALUES (2374, 'MG', '31', '09105', 'Bueno Brandão');
INSERT INTO mun VALUES (2375, 'MG', '31', '09204', 'Buenopolis');
INSERT INTO mun VALUES (1522, 'PE', '26', '02704', 'Buenos Aires');
INSERT INTO mun VALUES (1916, 'BA', '29', '04704', 'Buerarema');
INSERT INTO mun VALUES (2376, 'MG', '31', '09253', 'Bugre');
INSERT INTO mun VALUES (1523, 'PE', '26', '02803', 'Buique');
INSERT INTO mun VALUES (76, 'AC', '12', '00138', 'Bujari');
INSERT INTO mun VALUES (203, 'PA', '15', '01907', 'Bujaru');
INSERT INTO mun VALUES (3394, 'SP', '35', '08009', 'Buri');
INSERT INTO mun VALUES (3395, 'SP', '35', '08108', 'Buritama');
INSERT INTO mun VALUES (514, 'MA', '21', '02200', 'Buriti');
INSERT INTO mun VALUES (5397, 'GO', '52', '03906', 'Buriti Alegre');
INSERT INTO mun VALUES (515, 'MA', '21', '02309', 'Buriti Bravo');
INSERT INTO mun VALUES (516, 'MA', '21', '02325', 'Buriticupu');
INSERT INTO mun VALUES (5398, 'GO', '52', '03939', 'Buriti De Goias');
INSERT INTO mun VALUES (729, 'PI', '22', '02000', 'Buriti Dos Lopes');
INSERT INTO mun VALUES (730, 'PI', '22', '02026', 'Buriti Dos Montes');
INSERT INTO mun VALUES (363, 'TO', '17', '03800', 'Buriti Do Tocantins');
INSERT INTO mun VALUES (5399, 'GO', '52', '03962', 'Buritinopolis');
INSERT INTO mun VALUES (1917, 'BA', '29', '04753', 'Buritirama');
INSERT INTO mun VALUES (517, 'MA', '21', '02358', 'Buritirana');
INSERT INTO mun VALUES (47, 'RO', '11', '00452', 'Buritis');
INSERT INTO mun VALUES (2377, 'MG', '31', '09303', 'Buritis');
INSERT INTO mun VALUES (3396, 'SP', '35', '08207', 'Buritizal');
INSERT INTO mun VALUES (2378, 'MG', '31', '09402', 'Buritizeiro');
INSERT INTO mun VALUES (4700, 'RS', '43', '02709', 'Butia');
INSERT INTO mun VALUES (4397, 'SC', '42', '03006', 'Caçador');
INSERT INTO mun VALUES (3399, 'SP', '35', '08504', 'Caçapava');
INSERT INTO mun VALUES (4701, 'RS', '43', '02808', 'Caçapava Do Sul');
INSERT INTO mun VALUES (110, 'AM', '13', '00839', 'Caapiranga');
INSERT INTO mun VALUES (1309, 'PB', '25', '03001', 'Caaporã');
INSERT INTO mun VALUES (5158, 'MS', '50', '02407', 'Caarapo');
INSERT INTO mun VALUES (1918, 'BA', '29', '04803', 'Caatiba');
INSERT INTO mun VALUES (1310, 'PB', '25', '03100', 'Cabaceiras');
INSERT INTO mun VALUES (1919, 'BA', '29', '04852', 'Cabaceiras Do Paraguaçu');
INSERT INTO mun VALUES (2379, 'MG', '31', '09451', 'Cabeceira Grande');
INSERT INTO mun VALUES (5400, 'GO', '52', '04003', 'Cabeceiras');
INSERT INTO mun VALUES (731, 'PI', '22', '02059', 'Cabeceiras Do Piaui');
INSERT INTO mun VALUES (1311, 'PB', '25', '03209', 'Cabedelo');
INSERT INTO mun VALUES (22, 'RO', '11', '00031', 'Cabixi');
INSERT INTO mun VALUES (1524, 'PE', '26', '02902', 'Cabo De Santo Agostinho');
INSERT INTO mun VALUES (3221, 'RJ', '33', '00704', 'Cabo Frio');
INSERT INTO mun VALUES (2380, 'MG', '31', '09501', 'Cabo Verde');
INSERT INTO mun VALUES (3397, 'SP', '35', '08306', 'Cabralia Paulista');
INSERT INTO mun VALUES (3398, 'SP', '35', '08405', 'Cabreuva');
INSERT INTO mun VALUES (1525, 'PE', '26', '03009', 'Cabrobo');
INSERT INTO mun VALUES (49, 'RO', '11', '00601', 'Cacaulandia');
INSERT INTO mun VALUES (4702, 'RS', '43', '02907', 'Cacequi');
INSERT INTO mun VALUES (5238, 'MT', '51', '02504', 'Caceres');
INSERT INTO mun VALUES (1920, 'BA', '29', '04902', 'Cachoeira');
INSERT INTO mun VALUES (5401, 'GO', '52', '04102', 'Cachoeira Alta');
INSERT INTO mun VALUES (2381, 'MG', '31', '09600', 'Cachoeira Da Prata');
INSERT INTO mun VALUES (4687, 'RS', '43', '02204', 'Boa Vista Do Burica');
INSERT INTO mun VALUES (4688, 'RS', '43', '02220', 'Boa Vista Do Cadeado');
INSERT INTO mun VALUES (508, 'MA', '21', '01970', 'Boa Vista Do Gurupi');
INSERT INTO mun VALUES (4689, 'RS', '43', '02238', 'Boa Vista Do Incra');
INSERT INTO mun VALUES (107, 'AM', '13', '00680', 'Boa Vista Do Ramos');
INSERT INTO mun VALUES (4690, 'RS', '43', '02253', 'Boa Vista Do Sul');
INSERT INTO mun VALUES (1905, 'BA', '29', '03805', 'Boa Vista Do Tupim');
INSERT INTO mun VALUES (1689, 'AL', '27', '01001', 'Boca Da Mata');
INSERT INTO mun VALUES (108, 'AM', '13', '00706', 'Boca Do Acre');
INSERT INTO mun VALUES (722, 'PI', '22', '01804', 'Bocaina');
INSERT INTO mun VALUES (3379, 'SP', '35', '06805', 'Bocaina');
INSERT INTO mun VALUES (2353, 'MG', '31', '07208', 'Bocaina De Minas');
INSERT INTO mun VALUES (4386, 'SC', '42', '02438', 'Bocaina Do Sul');
INSERT INTO mun VALUES (2354, 'MG', '31', '07307', 'Bocaiuva');
INSERT INTO mun VALUES (3988, 'PR', '41', '03107', 'Bocaiuva Do Sul');
INSERT INTO mun VALUES (1119, 'RN', '24', '01651', 'Bodo');
INSERT INTO mun VALUES (1515, 'PE', '26', '02001', 'Bodoco');
INSERT INTO mun VALUES (5155, 'MS', '50', '02159', 'Bodoquena');
INSERT INTO mun VALUES (3380, 'SP', '35', '06904', 'Bofete');
INSERT INTO mun VALUES (3381, 'SP', '35', '07001', 'Boituva');
INSERT INTO mun VALUES (4387, 'SC', '42', '02453', 'Bombinhas');
INSERT INTO mun VALUES (1516, 'PE', '26', '02100', 'Bom Conselho');
INSERT INTO mun VALUES (2355, 'MG', '31', '07406', 'Bom Despacho');
INSERT INTO mun VALUES (1517, 'PE', '26', '02209', 'Bom Jardim');
INSERT INTO mun VALUES (3219, 'RJ', '33', '00506', 'Bom Jardim');
INSERT INTO mun VALUES (509, 'MA', '21', '02002', 'Bom Jardim');
INSERT INTO mun VALUES (4388, 'SC', '42', '02503', 'Bom Jardim Da Serra');
INSERT INTO mun VALUES (5391, 'GO', '52', '03401', 'Bom Jardim De Goias');
INSERT INTO mun VALUES (2356, 'MG', '31', '07505', 'Bom Jardim De Minas');
INSERT INTO mun VALUES (4691, 'RS', '43', '02303', 'Bom Jesus');
INSERT INTO mun VALUES (1301, 'PB', '25', '02201', 'Bom Jesus');
INSERT INTO mun VALUES (1120, 'RN', '24', '01701', 'Bom Jesus');
INSERT INTO mun VALUES (4389, 'SC', '42', '02537', 'Bom Jesus');
INSERT INTO mun VALUES (723, 'PI', '22', '01903', 'Bom Jesus');
INSERT INTO mun VALUES (1906, 'BA', '29', '03904', 'Bom Jesus Da Lapa');
INSERT INTO mun VALUES (2357, 'MG', '31', '07604', 'Bom Jesus Da Penha');
INSERT INTO mun VALUES (1907, 'BA', '29', '03953', 'Bom Jesus Da Serra');
INSERT INTO mun VALUES (510, 'MA', '21', '02036', 'Bom Jesus Das Selvas');
INSERT INTO mun VALUES (5392, 'GO', '52', '03500', 'Bom Jesus De Goias');
INSERT INTO mun VALUES (2358, 'MG', '31', '07703', 'Bom Jesus Do Amparo');
INSERT INTO mun VALUES (5236, 'MT', '51', '01852', 'Bom Jesus Do Araguaia');
INSERT INTO mun VALUES (2359, 'MG', '31', '07802', 'Bom Jesus Do Galho');
INSERT INTO mun VALUES (3220, 'RJ', '33', '00605', 'Bom Jesus Do Itabapoana');
INSERT INTO mun VALUES (3144, 'ES', '32', '01100', 'Bom Jesus Do Norte');
INSERT INTO mun VALUES (4390, 'SC', '42', '02578', 'Bom Jesus Do Oeste');
INSERT INTO mun VALUES (3382, 'SP', '35', '07100', 'Bom Jesus Dos Perdões');
INSERT INTO mun VALUES (3989, 'PR', '41', '03156', 'Bom Jesus Do Sul');
INSERT INTO mun VALUES (360, 'TO', '17', '03305', 'Bom Jesus Do Tocantins');
INSERT INTO mun VALUES (196, 'PA', '15', '01576', 'Bom Jesus Do Tocantins');
INSERT INTO mun VALUES (511, 'MA', '21', '02077', 'Bom Lugar');
INSERT INTO mun VALUES (4692, 'RS', '43', '02352', 'Bom Principio');
INSERT INTO mun VALUES (724, 'PI', '22', '01919', 'Bom Principio Do Piaui');
INSERT INTO mun VALUES (4693, 'RS', '43', '02378', 'Bom Progresso');
INSERT INTO mun VALUES (2360, 'MG', '31', '07901', 'Bom Repouso');
INSERT INTO mun VALUES (4391, 'SC', '42', '02602', 'Bom Retiro');
INSERT INTO mun VALUES (4694, 'RS', '43', '02402', 'Bom Retiro Do Sul');
INSERT INTO mun VALUES (1302, 'PB', '25', '02300', 'Bom Sucesso');
INSERT INTO mun VALUES (2361, 'MG', '31', '08008', 'Bom Sucesso');
INSERT INTO mun VALUES (3990, 'PR', '41', '03206', 'Bom Sucesso');
INSERT INTO mun VALUES (3383, 'SP', '35', '07159', 'Bom Sucesso De Itarare');
INSERT INTO mun VALUES (3991, 'PR', '41', '03222', 'Bom Sucesso Do Sul');
INSERT INTO mun VALUES (2362, 'MG', '31', '08107', 'Bonfim');
INSERT INTO mun VALUES (162, 'RR', '14', '00159', 'Bonfim');
INSERT INTO mun VALUES (725, 'PI', '22', '01929', 'Bonfim Do Piaui');
INSERT INTO mun VALUES (5393, 'GO', '52', '03559', 'Bonfinopolis');
INSERT INTO mun VALUES (2363, 'MG', '31', '08206', 'Bonfinopolis De Minas');
INSERT INTO mun VALUES (1908, 'BA', '29', '04001', 'Boninal');
INSERT INTO mun VALUES (5156, 'MS', '50', '02209', 'Bonito');
INSERT INTO mun VALUES (197, 'PA', '15', '01600', 'Bonito');
INSERT INTO mun VALUES (1909, 'BA', '29', '04050', 'Bonito');
INSERT INTO mun VALUES (1518, 'PE', '26', '02308', 'Bonito');
INSERT INTO mun VALUES (2364, 'MG', '31', '08255', 'Bonito De Minas');
INSERT INTO mun VALUES (1303, 'PB', '25', '02409', 'Bonito De Santa Fe');
INSERT INTO mun VALUES (5394, 'GO', '52', '03575', 'Bonopolis');
INSERT INTO mun VALUES (1304, 'PB', '25', '02508', 'Boqueirão');
INSERT INTO mun VALUES (4695, 'RS', '43', '02451', 'Boqueirão Do Leão');
INSERT INTO mun VALUES (726, 'PI', '22', '01945', 'Boqueirão Do Piaui');
INSERT INTO mun VALUES (1789, 'SE', '28', '00670', 'Boquim');
INSERT INTO mun VALUES (1910, 'BA', '29', '04100', 'Boquira');
INSERT INTO mun VALUES (3384, 'SP', '35', '07209', 'Bora');
INSERT INTO mun VALUES (3385, 'SP', '35', '07308', 'Boraceia');
INSERT INTO mun VALUES (109, 'AM', '13', '00805', 'Borba');
INSERT INTO mun VALUES (3386, 'SP', '35', '07407', 'Borborema');
INSERT INTO mun VALUES (1306, 'PB', '25', '02706', 'Borborema');
INSERT INTO mun VALUES (11314, 'PB', '25', 'TR021', 'Borborema  PB');
INSERT INTO mun VALUES (11315, 'RN', '24', 'TR022', 'Borborema  RN');
INSERT INTO mun VALUES (2365, 'MG', '31', '08305', 'Borda Da Mata');
INSERT INTO mun VALUES (3387, 'SP', '35', '07456', 'Borebi');
INSERT INTO mun VALUES (3992, 'PR', '41', '03305', 'Borrazopolis');
INSERT INTO mun VALUES (4696, 'RS', '43', '02501', 'Bossoroca');
INSERT INTO mun VALUES (2366, 'MG', '31', '08404', 'Botelhos');
INSERT INTO mun VALUES (3388, 'SP', '35', '07506', 'Botucatu');
INSERT INTO mun VALUES (2367, 'MG', '31', '08503', 'Botumirim');
INSERT INTO mun VALUES (1911, 'BA', '29', '04209', 'Botuporã');
INSERT INTO mun VALUES (4392, 'SC', '42', '02701', 'Botuvera');
INSERT INTO mun VALUES (4697, 'RS', '43', '02584', 'Bozano');
INSERT INTO mun VALUES (4698, 'RS', '43', '02600', 'Braga');
INSERT INTO mun VALUES (198, 'PA', '15', '01709', 'Bragança');
INSERT INTO mun VALUES (941, 'CE', '23', '02008', 'Barro');
INSERT INTO mun VALUES (5389, 'GO', '52', '03203', 'Barro Alto');
INSERT INTO mun VALUES (1898, 'BA', '29', '03235', 'Barro Alto');
INSERT INTO mun VALUES (1899, 'BA', '29', '03276', 'Barrocas');
INSERT INTO mun VALUES (714, 'PI', '22', '01408', 'Barro Duro');
INSERT INTO mun VALUES (358, 'TO', '17', '03107', 'Barrolandia');
INSERT INTO mun VALUES (1900, 'BA', '29', '03300', 'Barro Preto');
INSERT INTO mun VALUES (942, 'CE', '23', '02057', 'Barroquinha');
INSERT INTO mun VALUES (4683, 'RS', '43', '02006', 'Barros Cassal');
INSERT INTO mun VALUES (2339, 'MG', '31', '05905', 'Barroso');
INSERT INTO mun VALUES (3367, 'SP', '35', '05708', 'Barueri');
INSERT INTO mun VALUES (3368, 'SP', '35', '05807', 'Bastos');
INSERT INTO mun VALUES (5152, 'MS', '50', '01904', 'Bataguassu');
INSERT INTO mun VALUES (1686, 'AL', '27', '00706', 'Batalha');
INSERT INTO mun VALUES (715, 'PI', '22', '01507', 'Batalha');
INSERT INTO mun VALUES (3369, 'SP', '35', '05906', 'Batatais');
INSERT INTO mun VALUES (5153, 'MS', '50', '02001', 'Batayporã');
INSERT INTO mun VALUES (943, 'CE', '23', '02107', 'Baturite');
INSERT INTO mun VALUES (3370, 'SP', '35', '06003', 'Bauru');
INSERT INTO mun VALUES (1295, 'PB', '25', '01807', 'Bayeux');
INSERT INTO mun VALUES (3371, 'SP', '35', '06102', 'Bebedouro');
INSERT INTO mun VALUES (944, 'CE', '23', '02206', 'Beberibe');
INSERT INTO mun VALUES (945, 'CE', '23', '02305', 'Bela Cruz');
INSERT INTO mun VALUES (503, 'MA', '21', '01731', 'Belagua');
INSERT INTO mun VALUES (5154, 'MS', '50', '02100', 'Bela Vista');
INSERT INTO mun VALUES (3981, 'PR', '41', '02752', 'Bela Vista Da Caroba');
INSERT INTO mun VALUES (5390, 'GO', '52', '03302', 'Bela Vista De Goias');
INSERT INTO mun VALUES (2340, 'MG', '31', '06002', 'Bela Vista De Minas');
INSERT INTO mun VALUES (504, 'MA', '21', '01772', 'Bela Vista Do Maranhão');
INSERT INTO mun VALUES (3982, 'PR', '41', '02802', 'Bela Vista Do Paraiso');
INSERT INTO mun VALUES (716, 'PI', '22', '01556', 'Bela Vista Do Piaui');
INSERT INTO mun VALUES (4381, 'SC', '42', '02131', 'Bela Vista Do Toldo');
INSERT INTO mun VALUES (1296, 'PB', '25', '01906', 'Belem');
INSERT INTO mun VALUES (1687, 'AL', '27', '00805', 'Belem');
INSERT INTO mun VALUES (193, 'PA', '15', '01402', 'Belem');
INSERT INTO mun VALUES (4378, 'SC', '42', '02081', 'Bandeirante');
INSERT INTO mun VALUES (1510, 'PE', '26', '01508', 'Belem De Maria');
INSERT INTO mun VALUES (1511, 'PE', '26', '01607', 'Belem De São Francisco');
INSERT INTO mun VALUES (264, 'PA', '15', '05551', 'Pau D''arco');
INSERT INTO mun VALUES (1297, 'PB', '25', '02003', 'Belem Do Brejo Do Cruz');
INSERT INTO mun VALUES (717, 'PI', '22', '01572', 'Belem Do Piaui');
INSERT INTO mun VALUES (3218, 'RJ', '33', '00456', 'Belford Roxo');
INSERT INTO mun VALUES (2341, 'MG', '31', '06101', 'Belmiro Braga');
INSERT INTO mun VALUES (1901, 'BA', '29', '03409', 'Belmonte');
INSERT INTO mun VALUES (4382, 'SC', '42', '02156', 'Belmonte');
INSERT INTO mun VALUES (1902, 'BA', '29', '03508', 'Belo Campo');
INSERT INTO mun VALUES (2342, 'MG', '31', '06200', 'Belo Horizonte');
INSERT INTO mun VALUES (1512, 'PE', '26', '01706', 'Belo Jardim');
INSERT INTO mun VALUES (1688, 'AL', '27', '00904', 'Belo Monte');
INSERT INTO mun VALUES (2343, 'MG', '31', '06309', 'Belo Oriente');
INSERT INTO mun VALUES (2344, 'MG', '31', '06408', 'Belo Vale');
INSERT INTO mun VALUES (194, 'PA', '15', '01451', 'Belterra');
INSERT INTO mun VALUES (718, 'PI', '22', '01606', 'Beneditinos');
INSERT INTO mun VALUES (505, 'MA', '21', '01806', 'Benedito Leite');
INSERT INTO mun VALUES (4383, 'SC', '42', '02206', 'Benedito Novo');
INSERT INTO mun VALUES (195, 'PA', '15', '01501', 'Benevides');
INSERT INTO mun VALUES (105, 'AM', '13', '00607', 'Benjamin Constant');
INSERT INTO mun VALUES (4684, 'RS', '43', '02055', 'Benjamin Constant Do Sul');
INSERT INTO mun VALUES (3372, 'SP', '35', '06201', 'Bento De Abreu');
INSERT INTO mun VALUES (1118, 'RN', '24', '01602', 'Bento Fernandes');
INSERT INTO mun VALUES (4685, 'RS', '43', '02105', 'Bento Gonçalves');
INSERT INTO mun VALUES (506, 'MA', '21', '01905', 'Bequimão');
INSERT INTO mun VALUES (2345, 'MG', '31', '06507', 'Berilo');
INSERT INTO mun VALUES (2347, 'MG', '31', '06655', 'Berizal');
INSERT INTO mun VALUES (1298, 'PB', '25', '02052', 'Bernardino Batista');
INSERT INTO mun VALUES (3373, 'SP', '35', '06300', 'Bernardino De Campos');
INSERT INTO mun VALUES (507, 'MA', '21', '01939', 'Bernardo Do Mearim');
INSERT INTO mun VALUES (359, 'TO', '17', '03206', 'Bernardo Sayão');
INSERT INTO mun VALUES (3374, 'SP', '35', '06359', 'Bertioga');
INSERT INTO mun VALUES (719, 'PI', '22', '01705', 'Bertolinia');
INSERT INTO mun VALUES (2346, 'MG', '31', '06606', 'Bertopolis');
INSERT INTO mun VALUES (106, 'AM', '13', '00631', 'Beruri');
INSERT INTO mun VALUES (1513, 'PE', '26', '01805', 'Betania');
INSERT INTO mun VALUES (720, 'PI', '22', '01739', 'Betania Do Piaui');
INSERT INTO mun VALUES (2348, 'MG', '31', '06705', 'Betim');
INSERT INTO mun VALUES (1514, 'PE', '26', '01904', 'Bezerros');
INSERT INTO mun VALUES (2349, 'MG', '31', '06804', 'Bias Fortes');
INSERT INTO mun VALUES (2350, 'MG', '31', '06903', 'Bicas');
INSERT INTO mun VALUES (11313, 'TO', '17', 'TR020', 'Bico do Papagaio  TO');
INSERT INTO mun VALUES (4384, 'SC', '42', '02305', 'Biguaçu');
INSERT INTO mun VALUES (3375, 'SP', '35', '06409', 'Bilac');
INSERT INTO mun VALUES (2351, 'MG', '31', '07000', 'Biquinhas');
INSERT INTO mun VALUES (3376, 'SP', '35', '06508', 'Birigui');
INSERT INTO mun VALUES (3377, 'SP', '35', '06607', 'Biritiba-mirim');
INSERT INTO mun VALUES (1903, 'BA', '29', '03607', 'Biritinga');
INSERT INTO mun VALUES (3983, 'PR', '41', '02901', 'Bituruna');
INSERT INTO mun VALUES (4385, 'SC', '42', '02404', 'Blumenau');
INSERT INTO mun VALUES (2352, 'MG', '31', '07109', 'Boa Esperança');
INSERT INTO mun VALUES (3984, 'PR', '41', '03008', 'Boa Esperança');
INSERT INTO mun VALUES (3143, 'ES', '32', '01001', 'Boa Esperança');
INSERT INTO mun VALUES (3985, 'PR', '41', '03024', 'Boa Esperança Do Iguaçu');
INSERT INTO mun VALUES (3378, 'SP', '35', '06706', 'Boa Esperança Do Sul');
INSERT INTO mun VALUES (721, 'PI', '22', '01770', 'Boa Hora');
INSERT INTO mun VALUES (1904, 'BA', '29', '03706', 'Boa Nova');
INSERT INTO mun VALUES (1299, 'PB', '25', '02102', 'Boa Ventura');
INSERT INTO mun VALUES (3986, 'PR', '41', '03040', 'Boa Ventura De São Roque');
INSERT INTO mun VALUES (946, 'CE', '23', '02404', 'Boa Viagem');
INSERT INTO mun VALUES (161, 'RR', '14', '00100', 'Boa Vista');
INSERT INTO mun VALUES (1300, 'PB', '25', '02151', 'Boa Vista');
INSERT INTO mun VALUES (3987, 'PR', '41', '03057', 'Boa Vista Da Aparecida');
INSERT INTO mun VALUES (4686, 'RS', '43', '02154', 'Boa Vista Das Missões');
INSERT INTO mun VALUES (189, 'PA', '15', '01105', 'Bagre');
INSERT INTO mun VALUES (1858, 'BA', '29', '00000', 'Bahia');
INSERT INTO mun VALUES (1289, 'PB', '25', '01401', 'Baia Da Traição');
INSERT INTO mun VALUES (1115, 'RN', '24', '01404', 'Baia Formosa');
INSERT INTO mun VALUES (1889, 'BA', '29', '02500', 'Baianopolis');
INSERT INTO mun VALUES (190, 'PA', '15', '01204', 'Baião');
INSERT INTO mun VALUES (11308, 'MT', '51', 'TR015', 'Baixada Cuiabana  MT');
INSERT INTO mun VALUES (1890, 'BA', '29', '02609', 'Baixa Grande');
INSERT INTO mun VALUES (710, 'PI', '22', '01150', 'Baixa Grande Do Ribeiro');
INSERT INTO mun VALUES (937, 'CE', '23', '01802', 'Baixio');
INSERT INTO mun VALUES (11309, 'AM', '13', 'TR016', 'Baixo Amazonas  AM');
INSERT INTO mun VALUES (11310, 'PA', '15', 'TR017', 'Baixo Amazonas  PA');
INSERT INTO mun VALUES (11311, 'MT', '51', 'TR018', 'Baixo Araguaia  MT');
INSERT INTO mun VALUES (3141, 'ES', '32', '00805', 'Baixo Guandu');
INSERT INTO mun VALUES (11312, 'MA', '21', 'TR019', 'Baixo Parnaíba  MA');
INSERT INTO mun VALUES (3356, 'SP', '35', '04701', 'Balbinos');
INSERT INTO mun VALUES (2331, 'MG', '31', '05004', 'Baldim');
INSERT INTO mun VALUES (5388, 'GO', '52', '03104', 'Baliza');
INSERT INTO mun VALUES (4374, 'SC', '42', '01950', 'Balneario Arroio Do Silv');
INSERT INTO mun VALUES (4376, 'SC', '42', '02057', 'Balneario Barra Do Sul');
INSERT INTO mun VALUES (4375, 'SC', '42', '02008', 'Balneario Camboriu');
INSERT INTO mun VALUES (4377, 'SC', '42', '02073', 'Balneario Gaivota');
INSERT INTO mun VALUES (4673, 'RS', '43', '01636', 'Balneario Pinhal');
INSERT INTO mun VALUES (3357, 'SP', '35', '04800', 'Balsamo');
INSERT INTO mun VALUES (3976, 'PR', '41', '02307', 'Balsa Nova');
INSERT INTO mun VALUES (834, 'PI', '22', '07108', 'Olho D''agua Do Piaui');
INSERT INTO mun VALUES (499, 'MA', '21', '01400', 'Balsas');
INSERT INTO mun VALUES (2332, 'MG', '31', '05103', 'Bambui');
INSERT INTO mun VALUES (938, 'CE', '23', '01851', 'Banabuiu');
INSERT INTO mun VALUES (3358, 'SP', '35', '04909', 'Bananal');
INSERT INTO mun VALUES (1290, 'PB', '25', '01500', 'Bananeiras');
INSERT INTO mun VALUES (2333, 'MG', '31', '05202', 'Bandeira');
INSERT INTO mun VALUES (2334, 'MG', '31', '05301', 'Bandeira Do Sul');
INSERT INTO mun VALUES (5151, 'MS', '50', '01508', 'Bandeirantes');
INSERT INTO mun VALUES (845, 'PI', '22', '07793', 'Pau D''arco Do Piaui');
INSERT INTO mun VALUES (3977, 'PR', '41', '02406', 'Bandeirantes');
INSERT INTO mun VALUES (356, 'TO', '17', '03057', 'Bandeirantes Do Tocantin');
INSERT INTO mun VALUES (191, 'PA', '15', '01253', 'Bannach');
INSERT INTO mun VALUES (1891, 'BA', '29', '02658', 'Banzae');
INSERT INTO mun VALUES (1291, 'PB', '25', '01534', 'Barauna');
INSERT INTO mun VALUES (1116, 'RN', '24', '01453', 'Barauna');
INSERT INTO mun VALUES (2337, 'MG', '31', '05608', 'Barbacena');
INSERT INTO mun VALUES (939, 'CE', '23', '01901', 'Barbalha');
INSERT INTO mun VALUES (3360, 'SP', '35', '05104', 'Barbosa');
INSERT INTO mun VALUES (3978, 'PR', '41', '02505', 'Barbosa Ferraz');
INSERT INTO mun VALUES (192, 'PA', '15', '01303', 'Barcarena');
INSERT INTO mun VALUES (1117, 'RN', '24', '01503', 'Barcelona');
INSERT INTO mun VALUES (103, 'AM', '13', '00409', 'Barcelos');
INSERT INTO mun VALUES (3361, 'SP', '35', '05203', 'Bariri');
INSERT INTO mun VALUES (4674, 'RS', '43', '01651', 'Barão');
INSERT INTO mun VALUES (3359, 'SP', '35', '05005', 'Barão De Antonina');
INSERT INTO mun VALUES (2335, 'MG', '31', '05400', 'Barão De Cocais');
INSERT INTO mun VALUES (4675, 'RS', '43', '01701', 'Barão De Cotegipe');
INSERT INTO mun VALUES (500, 'MA', '21', '01509', 'Barão De Grajau');
INSERT INTO mun VALUES (5233, 'MT', '51', '01605', 'Barão De Melgaço');
INSERT INTO mun VALUES (2336, 'MG', '31', '05509', 'Barão De Monte Alto');
INSERT INTO mun VALUES (4676, 'RS', '43', '01750', 'Barão Do Triunfo');
INSERT INTO mun VALUES (1892, 'BA', '29', '02708', 'Barra');
INSERT INTO mun VALUES (3362, 'SP', '35', '05302', 'Barra Bonita');
INSERT INTO mun VALUES (4379, 'SC', '42', '02099', 'Barra Bonita');
INSERT INTO mun VALUES (4677, 'RS', '43', '01800', 'Barracão');
INSERT INTO mun VALUES (3979, 'PR', '41', '02604', 'Barracão');
INSERT INTO mun VALUES (1893, 'BA', '29', '02807', 'Barra Da Estiva');
INSERT INTO mun VALUES (1508, 'PE', '26', '01300', 'Barra De Guabiraba');
INSERT INTO mun VALUES (1292, 'PB', '25', '01575', 'Barra De Santana');
INSERT INTO mun VALUES (1293, 'PB', '25', '01609', 'Barra De Santa Rosa');
INSERT INTO mun VALUES (1684, 'AL', '27', '00508', 'Barra De Santo Antonio');
INSERT INTO mun VALUES (3142, 'ES', '32', '00904', 'Barra De São Francisco');
INSERT INTO mun VALUES (1685, 'AL', '27', '00607', 'Barra De São Miguel');
INSERT INTO mun VALUES (1741, 'AL', '27', '05804', 'Olho D''agua Do Casado');
INSERT INTO mun VALUES (1294, 'PB', '25', '01708', 'Barra De São Miguel');
INSERT INTO mun VALUES (5234, 'MT', '51', '01704', 'Barra Do Bugres');
INSERT INTO mun VALUES (3363, 'SP', '35', '05351', 'Barra Do Chapeu');
INSERT INTO mun VALUES (1894, 'BA', '29', '02906', 'Barra Do Choça');
INSERT INTO mun VALUES (501, 'MA', '21', '01608', 'Barra Do Corda');
INSERT INTO mun VALUES (5235, 'MT', '51', '01803', 'Barra Do Garças');
INSERT INTO mun VALUES (4678, 'RS', '43', '01859', 'Barra Do Guarita');
INSERT INTO mun VALUES (3980, 'PR', '41', '02703', 'Barra Do Jacare');
INSERT INTO mun VALUES (1895, 'BA', '29', '03003', 'Barra Do Mendes');
INSERT INTO mun VALUES (357, 'TO', '17', '03073', 'Barra Do Ouro');
INSERT INTO mun VALUES (3216, 'RJ', '33', '00308', 'Barra Do Pirai');
INSERT INTO mun VALUES (4679, 'RS', '43', '01875', 'Barra Do Quarai');
INSERT INTO mun VALUES (4680, 'RS', '43', '01909', 'Barra Do Ribeiro');
INSERT INTO mun VALUES (4681, 'RS', '43', '01925', 'Barra Do Rio Azul');
INSERT INTO mun VALUES (1896, 'BA', '29', '03102', 'Barra Do Rocha');
INSERT INTO mun VALUES (1788, 'SE', '28', '00605', 'Barra Dos Coqueiros');
INSERT INTO mun VALUES (3364, 'SP', '35', '05401', 'Barra Do Turvo');
INSERT INTO mun VALUES (4682, 'RS', '43', '01958', 'Barra Funda');
INSERT INTO mun VALUES (2338, 'MG', '31', '05707', 'Barra Longa');
INSERT INTO mun VALUES (3217, 'RJ', '33', '00407', 'Barra Mansa');
INSERT INTO mun VALUES (712, 'PI', '22', '01200', 'Barras');
INSERT INTO mun VALUES (4380, 'SC', '42', '02107', 'Barra Velha');
INSERT INTO mun VALUES (940, 'CE', '23', '01950', 'Barreira');
INSERT INTO mun VALUES (1897, 'BA', '29', '03201', 'Barreiras');
INSERT INTO mun VALUES (713, 'PI', '22', '01309', 'Barreiras Do Piaui');
INSERT INTO mun VALUES (104, 'AM', '13', '00508', 'Barreirinha');
INSERT INTO mun VALUES (502, 'MA', '21', '01707', 'Barreirinhas');
INSERT INTO mun VALUES (1509, 'PE', '26', '01409', 'Barreiros');
INSERT INTO mun VALUES (3365, 'SP', '35', '05500', 'Barretos');
INSERT INTO mun VALUES (3366, 'SP', '35', '05609', 'Barrinha');
INSERT INTO mun VALUES (1786, 'SE', '28', '00407', 'Araua');
INSERT INTO mun VALUES (2313, 'MG', '31', '03405', 'Araçuai');
INSERT INTO mun VALUES (3970, 'PR', '41', '01804', 'Araucaria');
INSERT INTO mun VALUES (2319, 'MG', '31', '03900', 'Araujos');
INSERT INTO mun VALUES (2320, 'MG', '31', '04007', 'Araxa');
INSERT INTO mun VALUES (2321, 'MG', '31', '04106', 'Arceburgo');
INSERT INTO mun VALUES (3341, 'SP', '35', '03356', 'Arco-iris');
INSERT INTO mun VALUES (2322, 'MG', '31', '04205', 'Arcos');
INSERT INTO mun VALUES (1507, 'PE', '26', '01201', 'Arcoverde');
INSERT INTO mun VALUES (2323, 'MG', '31', '04304', 'Areado');
INSERT INTO mun VALUES (3213, 'RJ', '33', '00225', 'Areal');
INSERT INTO mun VALUES (3342, 'SP', '35', '03406', 'Arealva');
INSERT INTO mun VALUES (1284, 'PB', '25', '01104', 'Areia');
INSERT INTO mun VALUES (1787, 'SE', '28', '00506', 'Areia Branca');
INSERT INTO mun VALUES (1112, 'RN', '24', '01107', 'Areia Branca');
INSERT INTO mun VALUES (1285, 'PB', '25', '01153', 'Areia De Baraunas');
INSERT INTO mun VALUES (1286, 'PB', '25', '01203', 'Areial');
INSERT INTO mun VALUES (3343, 'SP', '35', '03505', 'Areias');
INSERT INTO mun VALUES (3344, 'SP', '35', '03604', 'Areiopolis');
INSERT INTO mun VALUES (5231, 'MT', '51', '01308', 'Arenapolis');
INSERT INTO mun VALUES (5384, 'GO', '52', '02353', 'Arenopolis');
INSERT INTO mun VALUES (1113, 'RN', '24', '01206', 'Ares');
INSERT INTO mun VALUES (2324, 'MG', '31', '04403', 'Argirita');
INSERT INTO mun VALUES (2325, 'MG', '31', '04452', 'Aricanduva');
INSERT INTO mun VALUES (2326, 'MG', '31', '04502', 'Arinos');
INSERT INTO mun VALUES (5232, 'MT', '51', '01407', 'Aripuanã');
INSERT INTO mun VALUES (21, 'RO', '11', '00023', 'Ariquemes');
INSERT INTO mun VALUES (11306, 'RO', '11', 'TR013', 'Ariquemes - RO');
INSERT INTO mun VALUES (3345, 'SP', '35', '03703', 'Ariranha');
INSERT INTO mun VALUES (3971, 'PR', '41', '01853', 'Ariranha Do Ivai');
INSERT INTO mun VALUES (3214, 'RJ', '33', '00233', 'Armação Dos Buzios');
INSERT INTO mun VALUES (4368, 'SC', '42', '01505', 'Armazem');
INSERT INTO mun VALUES (934, 'CE', '23', '01505', 'Arneiroz');
INSERT INTO mun VALUES (706, 'PI', '22', '00905', 'Aroazes');
INSERT INTO mun VALUES (1287, 'PB', '25', '01302', 'Aroeiras');
INSERT INTO mun VALUES (707, 'PI', '22', '01002', 'Arraial');
INSERT INTO mun VALUES (3215, 'RJ', '33', '00258', 'Arraial Do Cabo');
INSERT INTO mun VALUES (351, 'TO', '17', '02406', 'Arraias');
INSERT INTO mun VALUES (4663, 'RS', '43', '01008', 'Arroio Do Meio');
INSERT INTO mun VALUES (4665, 'RS', '43', '01073', 'Arroio Do Padre');
INSERT INTO mun VALUES (4664, 'RS', '43', '01057', 'Arroio Do Sal');
INSERT INTO mun VALUES (4666, 'RS', '43', '01107', 'Arroio Dos Ratos');
INSERT INTO mun VALUES (4667, 'RS', '43', '01206', 'Arroio Do Tigre');
INSERT INTO mun VALUES (4668, 'RS', '43', '01305', 'Arroio Grande');
INSERT INTO mun VALUES (4369, 'SC', '42', '01604', 'Arroio Trinta');
INSERT INTO mun VALUES (3346, 'SP', '35', '03802', 'Artur Nogueira');
INSERT INTO mun VALUES (5385, 'GO', '52', '02502', 'Aruanã');
INSERT INTO mun VALUES (3347, 'SP', '35', '03901', 'Aruja');
INSERT INTO mun VALUES (4370, 'SC', '42', '01653', 'Arvoredo');
INSERT INTO mun VALUES (4669, 'RS', '43', '01404', 'Arvorezinha');
INSERT INTO mun VALUES (4371, 'SC', '42', '01703', 'Ascurra');
INSERT INTO mun VALUES (3348, 'SP', '35', '03950', 'Aspasia');
INSERT INTO mun VALUES (3972, 'PR', '41', '01903', 'Assai');
INSERT INTO mun VALUES (935, 'CE', '23', '01604', 'Assare');
INSERT INTO mun VALUES (3349, 'SP', '35', '04008', 'Assis');
INSERT INTO mun VALUES (74, 'AC', '12', '00054', 'Assis Brasil');
INSERT INTO mun VALUES (3973, 'PR', '41', '02000', 'Assis Chateaubriand');
INSERT INTO mun VALUES (1288, 'PB', '25', '01351', 'Assunção');
INSERT INTO mun VALUES (708, 'PI', '22', '01051', 'Assunção Do Piaui');
INSERT INTO mun VALUES (2327, 'MG', '31', '04601', 'Astolfo Dutra');
INSERT INTO mun VALUES (3974, 'PR', '41', '02109', 'Astorga');
INSERT INTO mun VALUES (1683, 'AL', '27', '00409', 'Atalaia');
INSERT INTO mun VALUES (3975, 'PR', '41', '02208', 'Atalaia');
INSERT INTO mun VALUES (101, 'AM', '13', '00201', 'Atalaia Do Norte');
INSERT INTO mun VALUES (4372, 'SC', '42', '01802', 'Atalanta');
INSERT INTO mun VALUES (2328, 'MG', '31', '04700', 'Ataleia');
INSERT INTO mun VALUES (3350, 'SP', '35', '04107', 'Atibaia');
INSERT INTO mun VALUES (3140, 'ES', '32', '00706', 'Atilio Vivacqua');
INSERT INTO mun VALUES (1103, 'RN', '24', '00208', 'Açu');
INSERT INTO mun VALUES (2281, 'MG', '31', '00500', 'Açucena');
INSERT INTO mun VALUES (352, 'TO', '17', '02554', 'Augustinopolis');
INSERT INTO mun VALUES (186, 'PA', '15', '00909', 'Augusto Correa');
INSERT INTO mun VALUES (2329, 'MG', '31', '04809', 'Augusto De Lima');
INSERT INTO mun VALUES (4670, 'RS', '43', '01503', 'Augusto Pestana');
INSERT INTO mun VALUES (1114, 'RN', '24', '01305', 'Augusto Severo');
INSERT INTO mun VALUES (11307, 'RN', '24', 'TR014', 'Açu-Mossoró  RN');
INSERT INTO mun VALUES (4671, 'RS', '43', '01552', 'Aurea');
INSERT INTO mun VALUES (1888, 'BA', '29', '02401', 'Aurelino Leal');
INSERT INTO mun VALUES (3351, 'SP', '35', '04206', 'Auriflama');
INSERT INTO mun VALUES (5386, 'GO', '52', '02601', 'Aurilandia');
INSERT INTO mun VALUES (936, 'CE', '23', '01703', 'Aurora');
INSERT INTO mun VALUES (4373, 'SC', '42', '01901', 'Aurora');
INSERT INTO mun VALUES (187, 'PA', '15', '00958', 'Aurora Do Para');
INSERT INTO mun VALUES (353, 'TO', '17', '02703', 'Aurora Do Tocantins');
INSERT INTO mun VALUES (102, 'AM', '13', '00300', 'Autazes');
INSERT INTO mun VALUES (3352, 'SP', '35', '04305', 'Avai');
INSERT INTO mun VALUES (3353, 'SP', '35', '04404', 'Avanhandava');
INSERT INTO mun VALUES (3354, 'SP', '35', '04503', 'Avare');
INSERT INTO mun VALUES (188, 'PA', '15', '01006', 'Aveiro');
INSERT INTO mun VALUES (709, 'PI', '22', '01101', 'Avelino Lopes');
INSERT INTO mun VALUES (5387, 'GO', '52', '02809', 'Avelinopolis');
INSERT INTO mun VALUES (494, 'MA', '21', '01103', 'Axixa');
INSERT INTO mun VALUES (354, 'TO', '17', '02901', 'Axixa Do Tocantins');
INSERT INTO mun VALUES (355, 'TO', '17', '03008', 'Babaçulandia');
INSERT INTO mun VALUES (495, 'MA', '21', '01202', 'Bacabal');
INSERT INTO mun VALUES (496, 'MA', '21', '01251', 'Bacabeira');
INSERT INTO mun VALUES (497, 'MA', '21', '01301', 'Bacuri');
INSERT INTO mun VALUES (498, 'MA', '21', '01350', 'Bacurituba');
INSERT INTO mun VALUES (3355, 'SP', '35', '04602', 'Bady Bassitt');
INSERT INTO mun VALUES (2330, 'MG', '31', '04908', 'Baependi');
INSERT INTO mun VALUES (4672, 'RS', '43', '01602', 'Bage');
INSERT INTO mun VALUES (4658, 'RS', '43', '00703', 'Anta Gorda');
INSERT INTO mun VALUES (1877, 'BA', '29', '01601', 'Antas');
INSERT INTO mun VALUES (3963, 'PR', '41', '01200', 'Antonina');
INSERT INTO mun VALUES (926, 'CE', '23', '00804', 'Antonina Do Norte');
INSERT INTO mun VALUES (705, 'PI', '22', '00806', 'Antonio Almeida');
INSERT INTO mun VALUES (1878, 'BA', '29', '01700', 'Antonio Cardoso');
INSERT INTO mun VALUES (4363, 'SC', '42', '01208', 'Antonio Carlos');
INSERT INTO mun VALUES (2308, 'MG', '31', '02902', 'Antonio Carlos');
INSERT INTO mun VALUES (2309, 'MG', '31', '03009', 'Antonio Dias');
INSERT INTO mun VALUES (1879, 'BA', '29', '01809', 'Antonio Gonçalves');
INSERT INTO mun VALUES (5147, 'MS', '50', '00906', 'Antonio João');
INSERT INTO mun VALUES (1110, 'RN', '24', '00901', 'Antonio Martins');
INSERT INTO mun VALUES (3964, 'PR', '41', '01309', 'Antonio Olinto');
INSERT INTO mun VALUES (4659, 'RS', '43', '00802', 'Antonio Prado');
INSERT INTO mun VALUES (2310, 'MG', '31', '03108', 'Antonio Prado De Minas');
INSERT INTO mun VALUES (11305, 'TO', '17', 'TR012', 'Apa Cantão - TO');
INSERT INTO mun VALUES (3330, 'SP', '35', '02507', 'Aparecida');
INSERT INTO mun VALUES (1280, 'PB', '25', '00775', 'Aparecida');
INSERT INTO mun VALUES (5377, 'GO', '52', '01405', 'Aparecida De Goiania');
INSERT INTO mun VALUES (5378, 'GO', '52', '01454', 'Aparecida Do Rio Doce');
INSERT INTO mun VALUES (343, 'TO', '17', '01101', 'Aparecida Do Rio Negro');
INSERT INTO mun VALUES (5148, 'MS', '50', '01003', 'Aparecida Do Taboado');
INSERT INTO mun VALUES (3211, 'RJ', '33', '00159', 'Aperibe');
INSERT INTO mun VALUES (3138, 'ES', '32', '00508', 'Apiaca');
INSERT INTO mun VALUES (5227, 'MT', '51', '00805', 'Apiacas');
INSERT INTO mun VALUES (3332, 'SP', '35', '02705', 'Apiai');
INSERT INTO mun VALUES (489, 'MA', '21', '00832', 'Apicum-açu');
INSERT INTO mun VALUES (4364, 'SC', '42', '01257', 'Apiuna');
INSERT INTO mun VALUES (1111, 'RN', '24', '01008', 'Apodi');
INSERT INTO mun VALUES (1880, 'BA', '29', '01908', 'Apora');
INSERT INTO mun VALUES (5379, 'GO', '52', '01504', 'Apore');
INSERT INTO mun VALUES (1881, 'BA', '29', '01957', 'Apuarema');
INSERT INTO mun VALUES (3965, 'PR', '41', '01408', 'Apucarana');
INSERT INTO mun VALUES (100, 'AM', '13', '00144', 'Apui');
INSERT INTO mun VALUES (927, 'CE', '23', '00903', 'Apuiares');
INSERT INTO mun VALUES (1784, 'SE', '28', '00209', 'Aquidabã');
INSERT INTO mun VALUES (5149, 'MS', '50', '01102', 'Aquidauana');
INSERT INTO mun VALUES (928, 'CE', '23', '01000', 'Aquiraz');
INSERT INTO mun VALUES (1281, 'PB', '25', '00809', 'Araçagi');
INSERT INTO mun VALUES (2311, 'MG', '31', '03207', 'Araçai');
INSERT INTO mun VALUES (3333, 'SP', '35', '02754', 'Araçariguama');
INSERT INTO mun VALUES (1883, 'BA', '29', '02054', 'Araças');
INSERT INTO mun VALUES (3334, 'SP', '35', '02804', 'Araçatuba');
INSERT INTO mun VALUES (4365, 'SC', '42', '01273', 'Arabutã');
INSERT INTO mun VALUES (1785, 'SE', '28', '00308', 'Aracaju');
INSERT INTO mun VALUES (929, 'CE', '23', '01109', 'Aracati');
INSERT INTO mun VALUES (1882, 'BA', '29', '02005', 'Aracatu');
INSERT INTO mun VALUES (1884, 'BA', '29', '02104', 'Araci');
INSERT INTO mun VALUES (2312, 'MG', '31', '03306', 'Aracitaba');
INSERT INTO mun VALUES (930, 'CE', '23', '01208', 'Aracoiaba');
INSERT INTO mun VALUES (3139, 'ES', '32', '00607', 'Aracruz');
INSERT INTO mun VALUES (5381, 'GO', '52', '01702', 'Aragarças');
INSERT INTO mun VALUES (5382, 'GO', '52', '01801', 'Aragoiania');
INSERT INTO mun VALUES (344, 'TO', '17', '01309', 'Aragominas');
INSERT INTO mun VALUES (345, 'TO', '17', '01903', 'Araguacema');
INSERT INTO mun VALUES (5228, 'MT', '51', '01001', 'Araguaiana');
INSERT INTO mun VALUES (347, 'TO', '17', '02109', 'Araguaina');
INSERT INTO mun VALUES (5229, 'MT', '51', '01209', 'Araguainha');
INSERT INTO mun VALUES (490, 'MA', '21', '00873', 'Araguanã');
INSERT INTO mun VALUES (348, 'TO', '17', '02158', 'Araguanã');
INSERT INTO mun VALUES (5383, 'GO', '52', '02155', 'Araguapaz');
INSERT INTO mun VALUES (2314, 'MG', '31', '03504', 'Araguari');
INSERT INTO mun VALUES (349, 'TO', '17', '02208', 'Araguatins');
INSERT INTO mun VALUES (346, 'TO', '17', '02000', 'Araguaçu');
INSERT INTO mun VALUES (491, 'MA', '21', '00907', 'Araioses');
INSERT INTO mun VALUES (5150, 'MS', '50', '01243', 'Aral Moreira');
INSERT INTO mun VALUES (1885, 'BA', '29', '02203', 'Aramari');
INSERT INTO mun VALUES (4660, 'RS', '43', '00851', 'Arambare');
INSERT INTO mun VALUES (492, 'MA', '21', '00956', 'Arame');
INSERT INTO mun VALUES (3336, 'SP', '35', '03000', 'Aramina');
INSERT INTO mun VALUES (3337, 'SP', '35', '03109', 'Arandu');
INSERT INTO mun VALUES (2315, 'MG', '31', '03603', 'Arantina');
INSERT INTO mun VALUES (1505, 'PE', '26', '01052', 'Araçoiaba');
INSERT INTO mun VALUES (3335, 'SP', '35', '02903', 'Araçoiaba Da Serra');
INSERT INTO mun VALUES (3338, 'SP', '35', '03158', 'Arapei');
INSERT INTO mun VALUES (1682, 'AL', '27', '00300', 'Arapiraca');
INSERT INTO mun VALUES (350, 'TO', '17', '02307', 'Arapoema');
INSERT INTO mun VALUES (2316, 'MG', '31', '03702', 'Araponga');
INSERT INTO mun VALUES (3966, 'PR', '41', '01507', 'Arapongas');
INSERT INTO mun VALUES (2317, 'MG', '31', '03751', 'Araporã');
INSERT INTO mun VALUES (3967, 'PR', '41', '01606', 'Arapoti');
INSERT INTO mun VALUES (3968, 'PR', '41', '01655', 'Arapuã');
INSERT INTO mun VALUES (2318, 'MG', '31', '03801', 'Arapua');
INSERT INTO mun VALUES (5230, 'MT', '51', '01258', 'Araputanga');
INSERT INTO mun VALUES (4366, 'SC', '42', '01307', 'Araquari');
INSERT INTO mun VALUES (1282, 'PB', '25', '00908', 'Arara');
INSERT INTO mun VALUES (4367, 'SC', '42', '01406', 'Ararangua');
INSERT INTO mun VALUES (3339, 'SP', '35', '03208', 'Araraquara');
INSERT INTO mun VALUES (3340, 'SP', '35', '03307', 'Araras');
INSERT INTO mun VALUES (931, 'CE', '23', '01257', 'Ararenda');
INSERT INTO mun VALUES (493, 'MA', '21', '01004', 'Arari');
INSERT INTO mun VALUES (4661, 'RS', '43', '00877', 'Ararica');
INSERT INTO mun VALUES (932, 'CE', '23', '01307', 'Araripe');
INSERT INTO mun VALUES (1506, 'PE', '26', '01102', 'Araripina');
INSERT INTO mun VALUES (3212, 'RJ', '33', '00209', 'Araruama');
INSERT INTO mun VALUES (1283, 'PB', '25', '01005', 'Araruna');
INSERT INTO mun VALUES (3969, 'PR', '41', '01705', 'Araruna');
INSERT INTO mun VALUES (1886, 'BA', '29', '02252', 'Arataca');
INSERT INTO mun VALUES (4662, 'RS', '43', '00901', 'Aratiba');
INSERT INTO mun VALUES (933, 'CE', '23', '01406', 'Aratuba');
INSERT INTO mun VALUES (1887, 'BA', '29', '02302', 'Aratuipe');
INSERT INTO mun VALUES (5380, 'GO', '52', '01603', 'Araçu');
INSERT INTO mun VALUES (3955, 'PR', '41', '00608', 'Alto Parana');
INSERT INTO mun VALUES (484, 'MA', '21', '00501', 'Alto Parnaiba');
INSERT INTO mun VALUES (3956, 'PR', '41', '00707', 'Alto Piquiri');
INSERT INTO mun VALUES (2299, 'MG', '31', '02100', 'Alto Rio Doce');
INSERT INTO mun VALUES (3136, 'ES', '32', '00359', 'Alto Rio Novo');
INSERT INTO mun VALUES (11299, 'MG', '31', 'TR006', 'Alto Rio Pardo - MG');
INSERT INTO mun VALUES (700, 'PI', '22', '00400', 'Altos');
INSERT INTO mun VALUES (924, 'CE', '23', '00705', 'Alto Santo');
INSERT INTO mun VALUES (11300, 'SE', '28', 'TR007', 'Alto Sertão - SE');
INSERT INTO mun VALUES (5226, 'MT', '51', '00607', 'Alto Taquari');
INSERT INTO mun VALUES (1378, 'PB', '25', '08703', 'MÃe D''agua');
INSERT INTO mun VALUES (11301, 'RS', '43', 'TR008', 'Alto Uruguai - RS');
INSERT INTO mun VALUES (11302, 'SC', '42', 'TR009', 'Alto Uruguai - SC');
INSERT INTO mun VALUES (11303, 'SC', '42', 'TR010', 'Alto Vale -SC');
INSERT INTO mun VALUES (3316, 'SP', '35', '01152', 'Aluminio');
INSERT INTO mun VALUES (2300, 'MG', '31', '02209', 'Alvarenga');
INSERT INTO mun VALUES (96, 'AM', '13', '00029', 'Alvarães');
INSERT INTO mun VALUES (3317, 'SP', '35', '01202', 'Alvares Florence');
INSERT INTO mun VALUES (3318, 'SP', '35', '01301', 'Alvares Machado');
INSERT INTO mun VALUES (3319, 'SP', '35', '01400', 'Alvaro De Carvalho');
INSERT INTO mun VALUES (3320, 'SP', '35', '01509', 'Alvinlandia');
INSERT INTO mun VALUES (2301, 'MG', '31', '02308', 'Alvinopolis');
INSERT INTO mun VALUES (4654, 'RS', '43', '00604', 'Alvorada');
INSERT INTO mun VALUES (340, 'TO', '17', '00707', 'Alvorada');
INSERT INTO mun VALUES (2302, 'MG', '31', '02407', 'Alvorada De Minas');
INSERT INTO mun VALUES (44, 'RO', '11', '00346', 'Alvorada Doeste');
INSERT INTO mun VALUES (701, 'PI', '22', '00459', 'Alvorada Do Gurgueia');
INSERT INTO mun VALUES (5370, 'GO', '52', '00803', 'Alvorada Do Norte');
INSERT INTO mun VALUES (3957, 'PR', '41', '00806', 'Alvorada Do Sul');
INSERT INTO mun VALUES (159, 'RR', '14', '00027', 'Amajari');
INSERT INTO mun VALUES (5143, 'MS', '50', '00609', 'Amambai');
INSERT INTO mun VALUES (318, 'AP', '16', '00000', 'Amapá');
INSERT INTO mun VALUES (320, 'AP', '16', '00105', 'Amapa');
INSERT INTO mun VALUES (485, 'MA', '21', '00550', 'Amapa Do Maranhão');
INSERT INTO mun VALUES (3958, 'PR', '41', '00905', 'Amaporã');
INSERT INTO mun VALUES (1503, 'PE', '26', '00906', 'Amaraji');
INSERT INTO mun VALUES (4655, 'RS', '43', '00638', 'Amaral Ferrador');
INSERT INTO mun VALUES (5371, 'GO', '52', '00829', 'Amaralina');
INSERT INTO mun VALUES (702, 'PI', '22', '00509', 'Amarante');
INSERT INTO mun VALUES (486, 'MA', '21', '00600', 'Amarante Do Maranhão');
INSERT INTO mun VALUES (1869, 'BA', '29', '01007', 'Amargosa');
INSERT INTO mun VALUES (97, 'AM', '13', '00060', 'Amatura');
INSERT INTO mun VALUES (95, 'AM', '13', '00000', 'Amazonas');
INSERT INTO mun VALUES (1870, 'BA', '29', '01106', 'Amelia Rodrigues');
INSERT INTO mun VALUES (1871, 'BA', '29', '01155', 'America Dourada');
INSERT INTO mun VALUES (3321, 'SP', '35', '01608', 'Americana');
INSERT INTO mun VALUES (5372, 'GO', '52', '00852', 'Americano Do Brasil');
INSERT INTO mun VALUES (3322, 'SP', '35', '01707', 'Americo Brasiliense');
INSERT INTO mun VALUES (3323, 'SP', '35', '01806', 'Americo De Campos');
INSERT INTO mun VALUES (4656, 'RS', '43', '00646', 'Ametista Do Sul');
INSERT INTO mun VALUES (925, 'CE', '23', '00754', 'Amontada');
INSERT INTO mun VALUES (4046, 'PR', '41', '07157', 'Diamante D''oeste');
INSERT INTO mun VALUES (5373, 'GO', '52', '00902', 'Amorinopolis');
INSERT INTO mun VALUES (3324, 'SP', '35', '01905', 'Amparo');
INSERT INTO mun VALUES (1279, 'PB', '25', '00734', 'Amparo');
INSERT INTO mun VALUES (1783, 'SE', '28', '00100', 'Amparo De São Francisco');
INSERT INTO mun VALUES (2303, 'MG', '31', '02506', 'Amparo Do Serra');
INSERT INTO mun VALUES (3959, 'PR', '41', '01002', 'Ampere');
INSERT INTO mun VALUES (1681, 'AL', '27', '00201', 'Anadia');
INSERT INTO mun VALUES (1872, 'BA', '29', '01205', 'Anage');
INSERT INTO mun VALUES (3960, 'PR', '41', '01051', 'Anahy');
INSERT INTO mun VALUES (183, 'PA', '15', '00701', 'Anajas');
INSERT INTO mun VALUES (487, 'MA', '21', '00709', 'Anajatuba');
INSERT INTO mun VALUES (3325, 'SP', '35', '02002', 'Analandia');
INSERT INTO mun VALUES (98, 'AM', '13', '00086', 'Anamã');
INSERT INTO mun VALUES (341, 'TO', '17', '01002', 'Ananas');
INSERT INTO mun VALUES (184, 'PA', '15', '00800', 'Ananindeua');
INSERT INTO mun VALUES (5374, 'GO', '52', '01108', 'Anapolis');
INSERT INTO mun VALUES (185, 'PA', '15', '00859', 'Anapu');
INSERT INTO mun VALUES (488, 'MA', '21', '00808', 'Anapurus');
INSERT INTO mun VALUES (5144, 'MS', '50', '00708', 'Anastacio');
INSERT INTO mun VALUES (5145, 'MS', '50', '00807', 'Anaurilandia');
INSERT INTO mun VALUES (3137, 'ES', '32', '00409', 'Anchieta');
INSERT INTO mun VALUES (4359, 'SC', '42', '00804', 'Anchieta');
INSERT INTO mun VALUES (1873, 'BA', '29', '01304', 'Andarai');
INSERT INTO mun VALUES (3961, 'PR', '41', '01101', 'Andira');
INSERT INTO mun VALUES (1874, 'BA', '29', '01353', 'Andorinha');
INSERT INTO mun VALUES (2304, 'MG', '31', '02605', 'Andradas');
INSERT INTO mun VALUES (3326, 'SP', '35', '02101', 'Andradina');
INSERT INTO mun VALUES (11304, 'SP', '35', 'TR011', 'Andradina - SP');
INSERT INTO mun VALUES (4657, 'RS', '43', '00661', 'Andre Da Rocha');
INSERT INTO mun VALUES (2306, 'MG', '31', '02803', 'Andrelandia');
INSERT INTO mun VALUES (3327, 'SP', '35', '02200', 'Angatuba');
INSERT INTO mun VALUES (2307, 'MG', '31', '02852', 'Angelandia');
INSERT INTO mun VALUES (5146, 'MS', '50', '00856', 'Angelica');
INSERT INTO mun VALUES (1504, 'PE', '26', '01003', 'Angelim');
INSERT INTO mun VALUES (4360, 'SC', '42', '00903', 'Angelina');
INSERT INTO mun VALUES (1875, 'BA', '29', '01403', 'Angical');
INSERT INTO mun VALUES (703, 'PI', '22', '00608', 'Angical Do Piaui');
INSERT INTO mun VALUES (342, 'TO', '17', '01051', 'Angico');
INSERT INTO mun VALUES (1109, 'RN', '24', '00802', 'Angicos');
INSERT INTO mun VALUES (3210, 'RJ', '33', '00100', 'Angra Dos Reis');
INSERT INTO mun VALUES (1876, 'BA', '29', '01502', 'Anguera');
INSERT INTO mun VALUES (3962, 'PR', '41', '01150', 'Angulo');
INSERT INTO mun VALUES (5375, 'GO', '52', '01207', 'Anhanguera');
INSERT INTO mun VALUES (3328, 'SP', '35', '02309', 'Anhembi');
INSERT INTO mun VALUES (3329, 'SP', '35', '02408', 'Anhumas');
INSERT INTO mun VALUES (5376, 'GO', '52', '01306', 'Anicuns');
INSERT INTO mun VALUES (704, 'PI', '22', '00707', 'Anisio De Abreu');
INSERT INTO mun VALUES (4361, 'SC', '42', '01000', 'Anita Garibaldi');
INSERT INTO mun VALUES (4362, 'SC', '42', '01109', 'Anitapolis');
INSERT INTO mun VALUES (99, 'AM', '13', '00102', 'Anori');
INSERT INTO mun VALUES (4354, 'SC', '42', '00507', 'Aguas De Chapeco');
INSERT INTO mun VALUES (3307, 'SP', '35', '00501', 'Aguas De Lindoia');
INSERT INTO mun VALUES (3308, 'SP', '35', '00550', 'Aguas De Santa Barbara');
INSERT INTO mun VALUES (3309, 'SP', '35', '00600', 'Aguas De São Pedro');
INSERT INTO mun VALUES (2285, 'MG', '31', '00906', 'Aguas Formosas');
INSERT INTO mun VALUES (4355, 'SC', '42', '00556', 'Aguas Frias');
INSERT INTO mun VALUES (5365, 'GO', '52', '00258', 'Aguas Lindas De Goias');
INSERT INTO mun VALUES (4356, 'SC', '42', '00606', 'Aguas Mornas');
INSERT INTO mun VALUES (2286, 'MG', '31', '01003', 'Aguas Vermelhas');
INSERT INTO mun VALUES (4645, 'RS', '43', '00109', 'Agudo');
INSERT INTO mun VALUES (3310, 'SP', '35', '00709', 'Agudos');
INSERT INTO mun VALUES (3951, 'PR', '41', '00301', 'Agudos Do Sul');
INSERT INTO mun VALUES (3132, 'ES', '32', '00136', 'Aguia Branca');
INSERT INTO mun VALUES (1271, 'PB', '25', '00205', 'Aguiar');
INSERT INTO mun VALUES (337, 'TO', '17', '00301', 'Aguiarnopolis');
INSERT INTO mun VALUES (2287, 'MG', '31', '01102', 'Aimores');
INSERT INTO mun VALUES (1865, 'BA', '29', '00603', 'Aiquara');
INSERT INTO mun VALUES (921, 'CE', '23', '00408', 'Aiuaba');
INSERT INTO mun VALUES (2288, 'MG', '31', '01201', 'Aiuruoca');
INSERT INTO mun VALUES (4646, 'RS', '43', '00208', 'Ajuricaba');
INSERT INTO mun VALUES (2289, 'MG', '31', '01300', 'Alagoa');
INSERT INTO mun VALUES (1272, 'PB', '25', '00304', 'Alagoa Grande');
INSERT INTO mun VALUES (1273, 'PB', '25', '00403', 'Alagoa Nova');
INSERT INTO mun VALUES (1679, 'AL', '27', '00000', 'Alagoas');
INSERT INTO mun VALUES (1274, 'PB', '25', '00502', 'Alagoinha');
INSERT INTO mun VALUES (1500, 'PE', '26', '00609', 'Alagoinha');
INSERT INTO mun VALUES (697, 'PI', '22', '00251', 'Alagoinha Do Piaui');
INSERT INTO mun VALUES (1866, 'BA', '29', '00702', 'Alagoinhas');
INSERT INTO mun VALUES (3311, 'SP', '35', '00758', 'Alambari');
INSERT INTO mun VALUES (2290, 'MG', '31', '01409', 'Albertina');
INSERT INTO mun VALUES (479, 'MA', '21', '00204', 'Alcantara');
INSERT INTO mun VALUES (922, 'CE', '23', '00507', 'Alcantaras');
INSERT INTO mun VALUES (1275, 'PB', '25', '00536', 'Alcantil');
INSERT INTO mun VALUES (5142, 'MS', '50', '00252', 'Alcinopolis');
INSERT INTO mun VALUES (1867, 'BA', '29', '00801', 'Alcobaça');
INSERT INTO mun VALUES (480, 'MA', '21', '00303', 'Aldeias Altas');
INSERT INTO mun VALUES (4647, 'RS', '43', '00307', 'Alecrim');
INSERT INTO mun VALUES (3134, 'ES', '32', '00201', 'Alegre');
INSERT INTO mun VALUES (4648, 'RS', '43', '00406', 'Alegrete');
INSERT INTO mun VALUES (698, 'PI', '22', '00277', 'Alegrete Do Piaui');
INSERT INTO mun VALUES (4649, 'RS', '43', '00455', 'Alegria');
INSERT INTO mun VALUES (2291, 'MG', '31', '01508', 'Alem Paraiba');
INSERT INTO mun VALUES (180, 'PA', '15', '00404', 'Alenquer');
INSERT INTO mun VALUES (1106, 'RN', '24', '00505', 'Alexandria');
INSERT INTO mun VALUES (5366, 'GO', '52', '00308', 'Alexania');
INSERT INTO mun VALUES (2292, 'MG', '31', '01607', 'Alfenas');
INSERT INTO mun VALUES (3135, 'ES', '32', '00300', 'Alfredo Chaves');
INSERT INTO mun VALUES (3312, 'SP', '35', '00808', 'Alfredo Marcondes');
INSERT INTO mun VALUES (2293, 'MG', '31', '01631', 'Alfredo Vasconcelos');
INSERT INTO mun VALUES (4357, 'SC', '42', '00705', 'Alfredo Wagner');
INSERT INTO mun VALUES (1276, 'PB', '25', '00577', 'Algodão De Jandaira');
INSERT INTO mun VALUES (1277, 'PB', '25', '00601', 'Alhandra');
INSERT INTO mun VALUES (1501, 'PE', '26', '00708', 'Aliança');
INSERT INTO mun VALUES (338, 'TO', '17', '00350', 'Aliança Do Tocantins');
INSERT INTO mun VALUES (1868, 'BA', '29', '00900', 'Almadina');
INSERT INTO mun VALUES (339, 'TO', '17', '00400', 'Almas');
INSERT INTO mun VALUES (181, 'PA', '15', '00503', 'Almeirim');
INSERT INTO mun VALUES (2294, 'MG', '31', '01706', 'Almenara');
INSERT INTO mun VALUES (1107, 'RN', '24', '00604', 'Almino Afonso');
INSERT INTO mun VALUES (3952, 'PR', '41', '00400', 'Almirante Tamandare');
INSERT INTO mun VALUES (4650, 'RS', '43', '00471', 'Almirante Tamandare Do S');
INSERT INTO mun VALUES (5367, 'GO', '52', '00506', 'Aloandia');
INSERT INTO mun VALUES (2295, 'MG', '31', '01805', 'Alpercata');
INSERT INTO mun VALUES (4651, 'RS', '43', '00505', 'Alpestre');
INSERT INTO mun VALUES (2296, 'MG', '31', '01904', 'Alpinopolis');
INSERT INTO mun VALUES (5221, 'MT', '51', '00250', 'Alta Floresta');
INSERT INTO mun VALUES (20, 'RO', '11', '00015', 'Alta Floresta Doeste');
INSERT INTO mun VALUES (3313, 'SP', '35', '00907', 'Altair');
INSERT INTO mun VALUES (182, 'PA', '15', '00602', 'Altamira');
INSERT INTO mun VALUES (481, 'MA', '21', '00402', 'Altamira Do Maranhão');
INSERT INTO mun VALUES (3953, 'PR', '41', '00459', 'Altamira Do Parana');
INSERT INTO mun VALUES (923, 'CE', '23', '00606', 'Altaneira');
INSERT INTO mun VALUES (2297, 'MG', '31', '02001', 'Alterosa');
INSERT INTO mun VALUES (1502, 'PE', '26', '00807', 'Altinho');
INSERT INTO mun VALUES (3314, 'SP', '35', '01004', 'Altinopolis');
INSERT INTO mun VALUES (11296, 'AC', '12', 'TR003', 'Alto Acre e Capixaba - AC');
INSERT INTO mun VALUES (4652, 'RS', '43', '00554', 'Alto Alegre');
INSERT INTO mun VALUES (3315, 'SP', '35', '01103', 'Alto Alegre');
INSERT INTO mun VALUES (160, 'RR', '14', '00050', 'Alto Alegre');
INSERT INTO mun VALUES (482, 'MA', '21', '00436', 'Alto Alegre Do Maranhão');
INSERT INTO mun VALUES (483, 'MA', '21', '00477', 'Alto Alegre Do Pindare');
INSERT INTO mun VALUES (45, 'RO', '11', '00379', 'Alto Alegre Dos Parecis');
INSERT INTO mun VALUES (5222, 'MT', '51', '00300', 'Alto Araguaia');
INSERT INTO mun VALUES (4358, 'SC', '42', '00754', 'Alto Bela Vista');
INSERT INTO mun VALUES (5223, 'MT', '51', '00359', 'Alto Boa Vista');
INSERT INTO mun VALUES (2298, 'MG', '31', '02050', 'Alto Caparao');
INSERT INTO mun VALUES (1108, 'RN', '24', '00703', 'Alto Do Rodrigues');
INSERT INTO mun VALUES (4653, 'RS', '43', '00570', 'Alto Feliz');
INSERT INTO mun VALUES (5224, 'MT', '51', '00409', 'Alto Garças');
INSERT INTO mun VALUES (5368, 'GO', '52', '00555', 'Alto Horizonte');
INSERT INTO mun VALUES (2900, 'MG', '31', '53509', 'Alto Jequitiba');
INSERT INTO mun VALUES (11297, 'MG', '31', 'TR004', 'Alto Jequitinhonha - MG');
INSERT INTO mun VALUES (11298, 'AM', '13', 'TR005', 'Alto Juruá - AM');
INSERT INTO mun VALUES (699, 'PI', '22', '00301', 'Alto Longa');
INSERT INTO mun VALUES (3954, 'PR', '41', '00509', 'Altonia');
INSERT INTO mun VALUES (5225, 'MT', '51', '00508', 'Alto Paraguai');
INSERT INTO mun VALUES (46, 'RO', '11', '00403', 'Alto Paraiso');
INSERT INTO mun VALUES (5369, 'GO', '52', '00605', 'Alto Paraiso De Goias');
INSERT INTO mun VALUES (476, 'MA', '21', '00055', 'Açailandia');
INSERT INTO mun VALUES (5359, 'GO', '52', '00050', 'Abadia De Goias');
INSERT INTO mun VALUES (2277, 'MG', '31', '00104', 'Abadia Dos Dourados');
INSERT INTO mun VALUES (5360, 'GO', '52', '00100', 'Abadiania');
INSERT INTO mun VALUES (2278, 'MG', '31', '00203', 'Abaete');
INSERT INTO mun VALUES (175, 'PA', '15', '00107', 'Abaetetuba');
INSERT INTO mun VALUES (917, 'CE', '23', '00101', 'Abaiara');
INSERT INTO mun VALUES (1859, 'BA', '29', '00108', 'Abaira');
INSERT INTO mun VALUES (1860, 'BA', '29', '00207', 'Abare');
INSERT INTO mun VALUES (3949, 'PR', '41', '00103', 'Abatia');
INSERT INTO mun VALUES (4349, 'SC', '42', '00051', 'Abdon Batista');
INSERT INTO mun VALUES (4350, 'SC', '42', '00101', 'Abelardo Luz');
INSERT INTO mun VALUES (1193, 'RN', '24', '08409', 'Olho-d''agua Do Borges');
INSERT INTO mun VALUES (176, 'PA', '15', '00131', 'Abel Figueiredo');
INSERT INTO mun VALUES (2279, 'MG', '31', '00302', 'Abre Campo');
INSERT INTO mun VALUES (1494, 'PE', '26', '00054', 'Abreu E Lima');
INSERT INTO mun VALUES (336, 'TO', '17', '00251', 'Abreulandia');
INSERT INTO mun VALUES (2280, 'MG', '31', '00401', 'Acaiaca');
INSERT INTO mun VALUES (1861, 'BA', '29', '00306', 'Acajutiba');
INSERT INTO mun VALUES (177, 'PA', '15', '00206', 'Acara');
INSERT INTO mun VALUES (918, 'CE', '23', '00150', 'Acarape');
INSERT INTO mun VALUES (919, 'CE', '23', '00200', 'Acarau');
INSERT INTO mun VALUES (1102, 'RN', '24', '00109', 'Acari');
INSERT INTO mun VALUES (694, 'PI', '22', '00053', 'Acauã');
INSERT INTO mun VALUES (4643, 'RS', '43', '00034', 'Acegua');
INSERT INTO mun VALUES (920, 'CE', '23', '00309', 'Acopiara');
INSERT INTO mun VALUES (5219, 'MT', '51', '00102', 'Acorizal');
INSERT INTO mun VALUES (72, 'AC', '12', '00000', 'Acre');
INSERT INTO mun VALUES (73, 'AC', '12', '00013', 'Acrelandia');
INSERT INTO mun VALUES (5361, 'GO', '52', '00134', 'Acreuna');
INSERT INTO mun VALUES (3303, 'SP', '35', '00105', 'Adamantina');
INSERT INTO mun VALUES (5362, 'GO', '52', '00159', 'Adelandia');
INSERT INTO mun VALUES (3304, 'SP', '35', '00204', 'Adolfo');
INSERT INTO mun VALUES (3950, 'PR', '41', '00202', 'Adrianopolis');
INSERT INTO mun VALUES (1862, 'BA', '29', '00355', 'Adustina');
INSERT INTO mun VALUES (1495, 'PE', '26', '00104', 'Afogados Da Ingazeira');
INSERT INTO mun VALUES (1104, 'RN', '24', '00307', 'Afonso Bezerra');
INSERT INTO mun VALUES (3131, 'ES', '32', '00102', 'Afonso Claudio');
INSERT INTO mun VALUES (477, 'MA', '21', '00105', 'Afonso Cunha');
INSERT INTO mun VALUES (1496, 'PE', '26', '00203', 'Afranio');
INSERT INTO mun VALUES (178, 'PA', '15', '00305', 'Afua');
INSERT INTO mun VALUES (11294, 'PE', '26', 'TR001', 'Agreste Central - PE');
INSERT INTO mun VALUES (11295, 'PE', '26', 'TR002', 'Agreste - PE');
INSERT INTO mun VALUES (1497, 'PE', '26', '00302', 'Agrestina');
INSERT INTO mun VALUES (695, 'PI', '22', '00103', 'Agricolandia');
INSERT INTO mun VALUES (4351, 'SC', '42', '00200', 'Agrolandia');
INSERT INTO mun VALUES (4352, 'SC', '42', '00309', 'Agronomica');
INSERT INTO mun VALUES (179, 'PA', '15', '00347', 'Agua Azul Do Norte');
INSERT INTO mun VALUES (5220, 'MT', '51', '00201', 'Agua Boa');
INSERT INTO mun VALUES (2282, 'MG', '31', '00609', 'Agua Boa');
INSERT INTO mun VALUES (1270, 'PB', '25', '00106', 'Agua Branca');
INSERT INTO mun VALUES (1680, 'AL', '27', '00102', 'Agua Branca');
INSERT INTO mun VALUES (696, 'PI', '22', '00202', 'Agua Branca');
INSERT INTO mun VALUES (5141, 'MS', '50', '00203', 'Agua Clara');
INSERT INTO mun VALUES (2283, 'MG', '31', '00708', 'Agua Comprida');
INSERT INTO mun VALUES (4353, 'SC', '42', '00408', 'Agua Doce');
INSERT INTO mun VALUES (478, 'MA', '21', '00154', 'Agua Doce Do Maranhão');
INSERT INTO mun VALUES (3133, 'ES', '32', '00169', 'Agua Doce Do Norte');
INSERT INTO mun VALUES (1863, 'BA', '29', '00405', 'Agua Fria');
INSERT INTO mun VALUES (5363, 'GO', '52', '00175', 'Agua Fria De Goias');
INSERT INTO mun VALUES (3305, 'SP', '35', '00303', 'Aguai');
INSERT INTO mun VALUES (5364, 'GO', '52', '00209', 'Agua Limpa');
INSERT INTO mun VALUES (2284, 'MG', '31', '00807', 'Aguanil');
INSERT INTO mun VALUES (1105, 'RN', '24', '00406', 'Agua Nova');
INSERT INTO mun VALUES (1498, 'PE', '26', '00401', 'Agua Preta');
INSERT INTO mun VALUES (4644, 'RS', '43', '00059', 'Agua Santa');
INSERT INTO mun VALUES (1499, 'PE', '26', '00500', 'Aguas Belas');
INSERT INTO mun VALUES (3306, 'SP', '35', '00402', 'Aguas Da Prata');
INSERT INTO mun VALUES (5079, 'RS', '43', '20800', 'Soledade');
INSERT INTO mun VALUES (2795, 'MG', '31', '44706', 'Nova Era');
INSERT INTO mun VALUES (2406, 'MG', '31', '12000', 'Candeias');
INSERT INTO mun VALUES (11363, 'RN', '24', 'TR070', 'Seridó RN');
INSERT INTO mun VALUES (11364, 'PI', '22', 'TR071', 'Serra da Capivara  PI');
INSERT INTO mun VALUES (11365, 'MG', '31', 'TR072', 'Serra do Brigadeiro  MG');
INSERT INTO mun VALUES (11366, 'MG', '31', 'TR073', 'Serra Geral MG');
INSERT INTO mun VALUES (11367, 'CE', '23', 'TR074', 'Sertões de Canindé  CE');
INSERT INTO mun VALUES (11368, 'CE', '23', 'TR075', 'Sertão Central CE');
INSERT INTO mun VALUES (11369, 'PE', '26', 'TR076', 'Sertão do Araripe  PE');
INSERT INTO mun VALUES (11370, 'PE', '26', 'TR077', 'Sertão do Pajeú  PE');
INSERT INTO mun VALUES (11374, 'PA', '15', 'TR081', 'Sudeste Paraense PA');
INSERT INTO mun VALUES (11375, 'PR', '41', 'TR082', 'Sudoeste PR');


--
-- Data for TOC entry 535 (OID 962415)
-- Name: var; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO var VALUES (10, 'vloctemplate', '/sistemas/modelos', 11, 'Variável de localização dos arquivos relacionados aos templates.');
INSERT INTO var VALUES (11, 'vlocupload', '/arquivos', 11, 'Variável de localização dos arquivos de uploads dos conteúdos.');


--
-- Data for TOC entry 547 (OID 962514)
-- Name: msg; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO msg VALUES (1, 'Variável não declarada', 'ER', 'A variável utilizada pelo script não foi declarada.', 'undefined variable');
INSERT INTO msg VALUES (2, 'Erro de inserção de registro', 'ER', 'O registro não pode ser adicionado porque existem campos vazios.', 'add null value');
INSERT INTO msg VALUES (4, 'Problemas na exclusão do registro', 'NT', 'A exclusão não pode ser realizada porque esta informação está sendo utilizada em outro sistema.', 'referential integrity violation');
INSERT INTO msg VALUES (5, 'Divisão por zero', 'ER', 'Alguma operação do sistema retornou divisão por zero.', 'division by zero');
INSERT INTO msg VALUES (3, 'Problemas na inserção dos dados', 'AV', 'A inserção não foi possível porque esta informação já existe.', 'duplicate key');


--
-- Data for TOC entry 551 (OID 962542)
-- Name: pfu; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO pfu VALUES (1, 1, 'Administrador', 'Administrador do sistema');
INSERT INTO pfu VALUES (2, 11, 'Administrador', 'Administrador do sistema');
INSERT INTO pfu VALUES (3, 3, 'Administrador', 'Administrador do sistema');


--
-- Data for TOC entry 552 (OID 962550)
-- Name: dap; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO dap VALUES (23, 3, 147);
INSERT INTO dap VALUES (24, 3, 151);
INSERT INTO dap VALUES (25, 3, 166);
INSERT INTO dap VALUES (26, 3, 148);
INSERT INTO dap VALUES (27, 3, 81);
INSERT INTO dap VALUES (28, 3, 99);
INSERT INTO dap VALUES (29, 3, 149);
INSERT INTO dap VALUES (30, 3, 78);
INSERT INTO dap VALUES (31, 3, 162);
INSERT INTO dap VALUES (32, 3, 71);
INSERT INTO dap VALUES (33, 3, 38);
INSERT INTO dap VALUES (34, 3, 74);
INSERT INTO dap VALUES (35, 3, 72);
INSERT INTO dap VALUES (36, 3, 73);
INSERT INTO dap VALUES (37, 3, 163);
INSERT INTO dap VALUES (38, 2, 185);
INSERT INTO dap VALUES (39, 2, 186);
INSERT INTO dap VALUES (40, 2, 193);
INSERT INTO dap VALUES (41, 2, 183);
INSERT INTO dap VALUES (42, 2, 195);
INSERT INTO dap VALUES (43, 2, 219);
INSERT INTO dap VALUES (46, 2, 189);
INSERT INTO dap VALUES (48, 2, 190);
INSERT INTO dap VALUES (49, 2, 191);
INSERT INTO dap VALUES (50, 2, 207);
INSERT INTO dap VALUES (51, 2, 197);
INSERT INTO dap VALUES (52, 2, 198);
INSERT INTO dap VALUES (1, 1, 9);
INSERT INTO dap VALUES (2, 1, 3);
INSERT INTO dap VALUES (3, 1, 2);
INSERT INTO dap VALUES (4, 1, 334);
INSERT INTO dap VALUES (5, 1, 28);
INSERT INTO dap VALUES (6, 1, 30);
INSERT INTO dap VALUES (7, 1, 262);
INSERT INTO dap VALUES (8, 1, 5);
INSERT INTO dap VALUES (9, 1, 164);
INSERT INTO dap VALUES (10, 1, 4);
INSERT INTO dap VALUES (11, 1, 170);


--
-- Data for TOC entry 558 (OID 962596)
-- Name: dmn; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO dmn VALUES (1, NULL, 2, 'Intranet', 'Domínio pessoal', 'http://10.0.102.248/final/intranet', true, '1', '/arquivos', '{DOCUMENT_ROOT}/meu_dominio');


--
-- Data for TOC entry 564 (OID 962635)
-- Name: scc; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO scc VALUES (1, 1, NULL, NULL, 21, 21, '', true, 'Sistemas', '', NULL, '1', NULL);
INSERT INTO scc VALUES (2, 1, 1, NULL, 21, 21, '', true, 'SISAU', '', NULL, '1.0001', 'sisau.php');


--
-- Data for TOC entry 21 (OID 1821473)
-- Name: ctu; Type: TABLE DATA; Schema: public; Owner: ederson
--

INSERT INTO ctu VALUES (2, 1, now(), NULL, 'SISAU', 'MDA', NULL, '&nbsp;', true, true, true, 'AT', now(), NULL);
INSERT INTO ctu VALUES (1, 1, now(), NULL, 'Principal', 'MDA', NULL, '&nbsp;', true, true, true, 'AT', now(), NULL);


--
-- Data for TOC entry 14 (OID 1821557)
-- Name: cts; Type: TABLE DATA; Schema: public; Owner: ederson
--

INSERT INTO cts VALUES (1, 1, 1, NULL, NULL, 1);
INSERT INTO cts VALUES (2, 2, 2, NULL, NULL, 2);


--
-- Data for TOC entry 565 (OID 962643)
-- Name: tam; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO tam VALUES (5, 'SXW - Arquivo de Texto OpenOffice.org', 'sxw', 'TX', 'O SWX é o formato de arquivo padrão do editor de texto do conjunto de aplicativos OpenOffice.org.', 'ico_swx.gif');
INSERT INTO tam VALUES (4, 'RTF - Arquivo de Texto RTF', 'rtf', 'TX', 'O RTF, Rich Text Format, é um formato que permite uma formatação muito elaborada sendo lido e escrito corretamente por uma grande variedade de processadores de texto.', 'ico_rtf.gif');
INSERT INTO tam VALUES (1, 'PDF - Portable Document Format', 'pdf', 'TX', 'O PDF, Portable Document Format, é um formato largamente utilizado pela internet. O programa que faz a leitura deste tipo de arquivo de mídia mais conhecido é o Acrobat Reader.', 'ico_pdf.gif');
INSERT INTO tam VALUES (3, 'Galeria de imagens JPG', 'jpg', 'AI', 'O JPG é um formato largamente utilizado pela internet por reduzir o tamanho das imagens sem perder um padrão de qualidade aceitável. ', 'imagem.jpg');
INSERT INTO tam VALUES (2, 'Arquivos de áudio MP3', 'mp3', 'AU', 'O MP3 é um formato largamente utilizado pela internet. O programa que faz a leitura deste tipo de arquivo de mídia mais conhecido é o Winamp.', 'ico_audio.gif');
INSERT INTO tam VALUES (8, 'XLS - Arquivo de Planilha Microsoft Excel', 'xls', 'TX', 'O XLS é o formato de arquivo padrão do editor de planilha eletrônica Microsoft Excel.', 'ico_documentos.gif');
INSERT INTO tam VALUES (10, 'PPT - Arquivo de Planilha Microsoft Power Point', 'ppt', 'TX', 'O PPT é o formato de arquivo padrão do editor de apresentações Microsoft Power Point.
', 'ico_documentos.gif');
INSERT INTO tam VALUES (6, 'DOC - Arquivo de Texto Microsoft Word', 'doc', 'TX', 'O DOC é o formato de arquivo padrão do editor de texto Microsoft Word.', 'ico_documentos.gif');


--
-- Data for TOC entry 566 (OID 962652)
-- Name: tpc; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO tpc VALUES (1, 'Padrão', 'PD');
INSERT INTO tpc VALUES (3, 'Boletim', 'BO');
INSERT INTO tpc VALUES (2, 'Notícia', 'NT');
INSERT INTO tpc VALUES (4, 'Evento', 'EV');
INSERT INTO tpc VALUES (5, 'Ofício', 'OF');
INSERT INTO tpc VALUES (6, 'Contato', 'CT');
INSERT INTO tpc VALUES (7, 'Ajuda', 'AJ');
INSERT INTO tpc VALUES (8, 'Mapa do Site', 'MS');
INSERT INTO tpc VALUES (9, 'Busca Avançada', 'BA');
INSERT INTO tpc VALUES (10, 'Destaque', 'DQ');
INSERT INTO tpc VALUES (11, 'Serviço', 'SR');
INSERT INTO tpc VALUES (12, 'Legislação', 'LG');
INSERT INTO tpc VALUES (13, 'Programa', 'PG');


--
-- Data for TOC entry 566 (OID 962652)
-- Name: css; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO css VALUES (1, 'CSS Padrão de Visualização', 'vizualizar.css', 'TL', 'CSS padrão de visualização');
INSERT INTO css VALUES (2, 'CSS Padrão de Impressão', 'imprimir.css', 'TL', 'CSS padrão de impressão');


--
-- Data for TOC entry 566 (OID 962652)
-- Name: mop; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO mop VALUES (7, 'Modelo de Exibição de Home Page', 'Modelo de Exibição de Home Page
', 'home_modelo.html', 2, 1, 'home.php');
INSERT INTO mop VALUES (1, 'Modelo Padrão', 'Modelo padrão de visualização dos conteúdos', 'conteudo.html', 2, 1, 'conteudo.php');
INSERT INTO mop VALUES (2, 'Modelo de Exibição das Notícias em Destaque', 'Modelo de Exibição das Notícias em Destaque.', 'home_modelo.html', 2, 1, 'noticias.php');
INSERT INTO mop VALUES (3, 'Modelo de Exibição do Conteúdo de Ajuda', 'Modelo de Exibição do Conteúdo de Ajuda', 'ajuda.html', 2, 1, 'ajuda.php');
INSERT INTO mop VALUES (12, 'Modelo de Exibição do Conteúdo de Contato', 'Modelo de Exibição do Conteúdo de Contato', 'contato.html', 2, 1, 'contato.php');
INSERT INTO mop VALUES (15, 'Modelo de Exibição do Mapa do Site', 'Modelo de Exipiração do Mapa do Site', 'mapa-do-site.html', 2, 1, 'mapa-do-site.php');
INSERT INTO mop VALUES (17, 'Modelo de Exibição de Busca Avançada', 'Modelo de Exibição de Busca Avançada', 'busca_avancada.html', 2, 1, 'busca_avancada.php');
INSERT INTO mop VALUES (8, 'Modelo de Exibição dos Boletins de Rádio', 'Modelo de Exibição dos Boletins de Rádio', 'boltins_radio.html', 2, 1, 'boletins_radio.php');
INSERT INTO mop VALUES (16, 'Modelo de Exibição de Galeria de Imagem', 'Modelo de Exibição de Galeria de Imagem', 'galeria.html', 2, 1, 'galeria.php');
INSERT INTO mop VALUES (21, 'Modelo de Exibição da Intranet', 'Modelo de Exibição da Intranet', 'home_modelo_intranet.html', 2, 1, 'home_intranet.php');


--
-- TOC entry 430 (OID 968494)
-- Name: unq_acs; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_acs ON acs USING btree (acsmenid, acsusrid);


--
-- TOC entry 449 (OID 968495)
-- Name: unq_satid; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_satid ON ate USING btree (atesatid);


--
-- TOC entry 455 (OID 968496)
-- Name: unq_sre; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_sre ON sre USING btree (sretsvid, sreateid);


--
-- TOC entry 457 (OID 968497)
-- Name: unq_srvnome; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_srvnome ON tsv USING btree (tsvnome);


--
-- TOC entry 459 (OID 968498)
-- Name: unq_urdemail; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_urdemail ON urd USING btree (urdemail);


--
-- TOC entry 461 (OID 968499)
-- Name: unq_pas; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_pas ON pas USING btree (pasid, passeq);


--
-- TOC entry 447 (OID 968500)
-- Name: unq_atdurdid; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_atdurdid ON atd USING btree (atdurdid);


--
-- TOC entry 465 (OID 968501)
-- Name: unq_cgrsigla; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_cgrsigla ON cgr USING btree (cgrsigla);


--
-- TOC entry 466 (OID 968502)
-- Name: unq_cgrurdid; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_cgrurdid ON cgr USING btree (cgrurdid);


--
-- TOC entry 469 (OID 968503)
-- Name: unq_pse; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_pse ON pse USING btree (psesreid, psepasid);


--
-- TOC entry 471 (OID 968504)
-- Name: unq_pfunome; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_pfunome ON pfu USING btree (pfunome, pfusisid);


--
-- TOC entry 473 (OID 968505)
-- Name: unq_dap; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_dap ON dap USING btree (dapmenid, dappfuid);


--
-- TOC entry 480 (OID 968506)
-- Name: unq_dmnnome; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_dmnnome ON dmn USING btree (dmnnome);


--
-- TOC entry 483 (OID 968507)
-- Name: unq_lpc; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_lpc ON lpc USING btree (lpcctuid, lpcplcid);


--
-- TOC entry 487 (OID 968508)
-- Name: unq_plcdesc; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_plcdesc ON plc USING btree (plcdesc);


--
-- TOC entry 492 (OID 968509)
-- Name: unq_cts; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unq_cts ON cts USING btree (ctssccid, ctsctuid);


--
-- TOC entry 429 (OID 968510)
-- Name: pk_acs; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY acs
    ADD CONSTRAINT pk_acs PRIMARY KEY (acsid);


--
-- TOC entry 431 (OID 968512)
-- Name: pk_log; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY log
    ADD CONSTRAINT pk_log PRIMARY KEY (logid);


--
-- TOC entry 432 (OID 968514)
-- Name: pk_men; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY men
    ADD CONSTRAINT pk_men PRIMARY KEY (menid);


--
-- TOC entry 433 (OID 968516)
-- Name: pk_sis; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY sis
    ADD CONSTRAINT pk_sis PRIMARY KEY (sisid);


--
-- TOC entry 434 (OID 968518)
-- Name: pk_usr; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY usr
    ADD CONSTRAINT pk_usr PRIMARY KEY (usrid);


--
-- TOC entry 435 (OID 968520)
-- Name: pga_graphs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pga_graphs
    ADD CONSTRAINT pga_graphs_pkey PRIMARY KEY (graphname);


--
-- TOC entry 436 (OID 968522)
-- Name: pga_layout_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pga_layout
    ADD CONSTRAINT pga_layout_pkey PRIMARY KEY (tablename);


--
-- TOC entry 437 (OID 968524)
-- Name: pga_images_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pga_images
    ADD CONSTRAINT pga_images_pkey PRIMARY KEY (imagename);


--
-- TOC entry 438 (OID 968526)
-- Name: pga_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pga_queries
    ADD CONSTRAINT pga_queries_pkey PRIMARY KEY (queryname);


--
-- TOC entry 439 (OID 968528)
-- Name: pga_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pga_reports
    ADD CONSTRAINT pga_reports_pkey PRIMARY KEY (reportname);


--
-- TOC entry 440 (OID 968530)
-- Name: pga_forms_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pga_forms
    ADD CONSTRAINT pga_forms_pkey PRIMARY KEY (formname);


--
-- TOC entry 441 (OID 968532)
-- Name: pga_diagrams_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pga_diagrams
    ADD CONSTRAINT pga_diagrams_pkey PRIMARY KEY (diagramname);


--
-- TOC entry 442 (OID 968534)
-- Name: pga_scripts_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pga_scripts
    ADD CONSTRAINT pga_scripts_pkey PRIMARY KEY (scriptname);


--
-- TOC entry 443 (OID 968536)
-- Name: pk_mun; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY mun
    ADD CONSTRAINT pk_mun PRIMARY KEY (munid);


--
-- TOC entry 444 (OID 968538)
-- Name: pk_und; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY und
    ADD CONSTRAINT pk_und PRIMARY KEY (undid);


--
-- TOC entry 445 (OID 968540)
-- Name: pk_var; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY var
    ADD CONSTRAINT pk_var PRIMARY KEY (varid);


--
-- TOC entry 446 (OID 968542)
-- Name: pk_atd; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY atd
    ADD CONSTRAINT pk_atd PRIMARY KEY (atdid);


--
-- TOC entry 448 (OID 968544)
-- Name: pk_ate; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY ate
    ADD CONSTRAINT pk_ate PRIMARY KEY (ateid);


--
-- TOC entry 450 (OID 968546)
-- Name: pk_dgn; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dgn
    ADD CONSTRAINT pk_dgn PRIMARY KEY (dgnid);


--
-- TOC entry 451 (OID 968548)
-- Name: pk_dvs; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dvs
    ADD CONSTRAINT pk_dvs PRIMARY KEY (dvsid);


--
-- TOC entry 452 (OID 968550)
-- Name: pk_hat; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY hat
    ADD CONSTRAINT pk_hat PRIMARY KEY (hatid);


--
-- TOC entry 453 (OID 968552)
-- Name: pk_sat; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY sat
    ADD CONSTRAINT pk_sat PRIMARY KEY (satid);


--
-- TOC entry 454 (OID 968554)
-- Name: pk_sre; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY sre
    ADD CONSTRAINT pk_sre PRIMARY KEY (sreid);


--
-- TOC entry 456 (OID 968556)
-- Name: pk_tsv; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY tsv
    ADD CONSTRAINT pk_tsv PRIMARY KEY (tsvid);


--
-- TOC entry 458 (OID 968558)
-- Name: pk_urd; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY urd
    ADD CONSTRAINT pk_urd PRIMARY KEY (urdid);


--
-- TOC entry 460 (OID 968560)
-- Name: pk_pas; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pas
    ADD CONSTRAINT pk_pas PRIMARY KEY (pasid);


--
-- TOC entry 462 (OID 968562)
-- Name: pk_pgi; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pgi
    ADD CONSTRAINT pk_pgi PRIMARY KEY (pgiid);


--
-- TOC entry 463 (OID 968564)
-- Name: pk_msg; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY msg
    ADD CONSTRAINT pk_msg PRIMARY KEY (msgid);


--
-- TOC entry 464 (OID 968566)
-- Name: pk_cgr; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY cgr
    ADD CONSTRAINT pk_cgr PRIMARY KEY (cgrid);


--
-- TOC entry 467 (OID 968568)
-- Name: pk_cld; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY cld
    ADD CONSTRAINT pk_cld PRIMARY KEY (cldid);


--
-- TOC entry 468 (OID 968570)
-- Name: pk_pse; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pse
    ADD CONSTRAINT pk_pse PRIMARY KEY (pseid);


--
-- TOC entry 470 (OID 968572)
-- Name: pk_pfu; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pfu
    ADD CONSTRAINT pk_pfu PRIMARY KEY (pfuid);


--
-- TOC entry 472 (OID 968574)
-- Name: pk_dap; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dap
    ADD CONSTRAINT pk_dap PRIMARY KEY (dapid);


--
-- TOC entry 474 (OID 968576)
-- Name: pk_pac; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pac
    ADD CONSTRAINT pk_pac PRIMARY KEY (pacid);


--
-- TOC entry 475 (OID 968578)
-- Name: pk_msa; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY msa
    ADD CONSTRAINT pk_msa PRIMARY KEY (msaid);


--
-- TOC entry 476 (OID 968580)
-- Name: pk_anc; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY anc
    ADD CONSTRAINT pk_anc PRIMARY KEY (ancid);


--
-- TOC entry 477 (OID 968582)
-- Name: pk_css; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY css
    ADD CONSTRAINT pk_css PRIMARY KEY (cssid);


--
-- TOC entry 478 (OID 968584)
-- Name: pk_ctu; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY ctu
    ADD CONSTRAINT pk_ctu PRIMARY KEY (ctuid);


--
-- TOC entry 479 (OID 968586)
-- Name: pk_dmn; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dmn
    ADD CONSTRAINT pk_dmn PRIMARY KEY (dmnid);


--
-- TOC entry 481 (OID 968588)
-- Name: pk_grm; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY grm
    ADD CONSTRAINT pk_grm PRIMARY KEY (grmid);


--
-- TOC entry 482 (OID 968590)
-- Name: pk_lpc; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY lpc
    ADD CONSTRAINT pk_lpc PRIMARY KEY (lpcid);


--
-- TOC entry 484 (OID 968592)
-- Name: pk_mlg; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY mlg
    ADD CONSTRAINT pk_mlg PRIMARY KEY (mlgid);


--
-- TOC entry 485 (OID 968594)
-- Name: pk_mop; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY mop
    ADD CONSTRAINT pk_mop PRIMARY KEY (mopid);


--
-- TOC entry 486 (OID 968596)
-- Name: pk_plc; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY plc
    ADD CONSTRAINT pk_plc PRIMARY KEY (plcid);


--
-- TOC entry 488 (OID 968598)
-- Name: pk_scc; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY scc
    ADD CONSTRAINT pk_scc PRIMARY KEY (sccid);


--
-- TOC entry 489 (OID 968600)
-- Name: pk_tam; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY tam
    ADD CONSTRAINT pk_tam PRIMARY KEY (tamid);


--
-- TOC entry 490 (OID 968602)
-- Name: pk_tpc; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY tpc
    ADD CONSTRAINT pk_tpc PRIMARY KEY (tpcid);


--
-- TOC entry 491 (OID 968604)
-- Name: pk_cts; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY cts
    ADD CONSTRAINT pk_cts PRIMARY KEY (ctsid);


--
-- TOC entry 493 (OID 968606)
-- Name: pk_abp; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY abp
    ADD CONSTRAINT pk_abp PRIMARY KEY (abpid);


--
-- TOC entry 494 (OID 968608)
-- Name: pk_bnn; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY bnn
    ADD CONSTRAINT pk_bnn PRIMARY KEY (bnnid);


--
-- TOC entry 495 (OID 968610)
-- Name: pk_bns; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY bns
    ADD CONSTRAINT pk_bns PRIMARY KEY (bnsid);


--
-- TOC entry 496 (OID 968612)
-- Name: pk_ppb; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY ppb
    ADD CONSTRAINT pk_ppb PRIMARY KEY (ppbid);


--
-- TOC entry 497 (OID 968614)
-- Name: pk_mss; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY mss
    ADD CONSTRAINT pk_mss PRIMARY KEY (mssid);


--
-- TOC entry 576 (OID 968616)
-- Name: fk_log_sis; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY log
    ADD CONSTRAINT fk_log_sis FOREIGN KEY (logsisid) REFERENCES sis(sisid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 578 (OID 968620)
-- Name: fk_men_sis; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY men
    ADD CONSTRAINT fk_men_sis FOREIGN KEY (mensisid) REFERENCES sis(sisid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 582 (OID 968624)
-- Name: fk_var_sis; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY var
    ADD CONSTRAINT fk_var_sis FOREIGN KEY (varsisid) REFERENCES sis(sisid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 583 (OID 968628)
-- Name: fk_atd_dvs; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY atd
    ADD CONSTRAINT fk_atd_dvs FOREIGN KEY (atddvsid) REFERENCES dvs(dvsid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 584 (OID 968632)
-- Name: fk_atd_urd; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY atd
    ADD CONSTRAINT fk_atd_urd FOREIGN KEY (atdurdid) REFERENCES urd(urdid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 585 (OID 968636)
-- Name: fk_ate_atd; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY ate
    ADD CONSTRAINT fk_ate_atd FOREIGN KEY (ateatdid) REFERENCES atd(atdid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 586 (OID 968640)
-- Name: fk_ate_sat; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY ate
    ADD CONSTRAINT fk_ate_sat FOREIGN KEY (atesatid) REFERENCES sat(satid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 593 (OID 968644)
-- Name: fk_hat_ate; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY hat
    ADD CONSTRAINT fk_hat_ate FOREIGN KEY (hatateid) REFERENCES ate(ateid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 594 (OID 968648)
-- Name: fk_hat_atd; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY hat
    ADD CONSTRAINT fk_hat_atd FOREIGN KEY (hatatdid) REFERENCES atd(atdid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 595 (OID 968652)
-- Name: fk_sat_urd; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY sat
    ADD CONSTRAINT fk_sat_urd FOREIGN KEY (saturdid) REFERENCES urd(urdid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 596 (OID 968656)
-- Name: fk_sat_dgn; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY sat
    ADD CONSTRAINT fk_sat_dgn FOREIGN KEY (satdgnid) REFERENCES dgn(dgnid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 597 (OID 968660)
-- Name: fk_sre_atd; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY sre
    ADD CONSTRAINT fk_sre_atd FOREIGN KEY (sreatdid) REFERENCES atd(atdid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 598 (OID 968664)
-- Name: fk_sre_ate; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY sre
    ADD CONSTRAINT fk_sre_ate FOREIGN KEY (sreateid) REFERENCES ate(ateid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 599 (OID 968668)
-- Name: fk_sre_srv; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY sre
    ADD CONSTRAINT fk_sre_srv FOREIGN KEY (sretsvid) REFERENCES tsv(tsvid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 601 (OID 968672)
-- Name: fk_urd_mun; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY urd
    ADD CONSTRAINT fk_urd_mun FOREIGN KEY (urdmunid) REFERENCES mun(munid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 602 (OID 968676)
-- Name: fk_urd_und; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY urd
    ADD CONSTRAINT fk_urd_und FOREIGN KEY (urdundid) REFERENCES und(undid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 579 (OID 968680)
-- Name: fk_usr_urd; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY usr
    ADD CONSTRAINT fk_usr_urd FOREIGN KEY (usrurdid) REFERENCES urd(urdid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 588 (OID 968684)
-- Name: fk_dgn_dvs; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dgn
    ADD CONSTRAINT fk_dgn_dvs FOREIGN KEY (dgndvsid) REFERENCES dvs(dvsid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 591 (OID 968688)
-- Name: fk_dvs_urd; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dvs
    ADD CONSTRAINT fk_dvs_urd FOREIGN KEY (dvsurdid) REFERENCES urd(urdid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 587 (OID 968692)
-- Name: fk_ate_dgn; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY ate
    ADD CONSTRAINT fk_ate_dgn FOREIGN KEY (atedgnid) REFERENCES dgn(dgnid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 604 (OID 968696)
-- Name: fk_pgi_sis; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pgi
    ADD CONSTRAINT fk_pgi_sis FOREIGN KEY (pgisisid) REFERENCES sis(sisid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 605 (OID 968700)
-- Name: fk_pgi_usr; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pgi
    ADD CONSTRAINT fk_pgi_usr FOREIGN KEY (pgiusrid) REFERENCES usr(usrid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 606 (OID 968704)
-- Name: fk_pgi_men; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pgi
    ADD CONSTRAINT fk_pgi_men FOREIGN KEY (pgimenid) REFERENCES men(menid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 607 (OID 968708)
-- Name: fk_cgr_urd; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY cgr
    ADD CONSTRAINT fk_cgr_urd FOREIGN KEY (cgrurdid) REFERENCES urd(urdid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 589 (OID 968712)
-- Name: fk_dgn_tsv; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dgn
    ADD CONSTRAINT fk_dgn_tsv FOREIGN KEY (dgntsvid) REFERENCES tsv(tsvid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 592 (OID 968720)
-- Name: fk_dvs_cgr; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dvs
    ADD CONSTRAINT fk_dvs_cgr FOREIGN KEY (dvscgrid) REFERENCES cgr(cgrid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 609 (OID 968724)
-- Name: fk_pse_pas; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pse
    ADD CONSTRAINT fk_pse_pas FOREIGN KEY (psepasid) REFERENCES pas(pasid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 611 (OID 968728)
-- Name: fk_pfu_sis; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pfu
    ADD CONSTRAINT fk_pfu_sis FOREIGN KEY (pfusisid) REFERENCES sis(sisid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 612 (OID 968732)
-- Name: fk_dap_pfu; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dap
    ADD CONSTRAINT fk_dap_pfu FOREIGN KEY (dappfuid) REFERENCES pfu(pfuid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 614 (OID 968736)
-- Name: fk_pac_pfu; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pac
    ADD CONSTRAINT fk_pac_pfu FOREIGN KEY (pacpfuid) REFERENCES pfu(pfuid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 574 (OID 968740)
-- Name: fk_acs_usr; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY acs
    ADD CONSTRAINT fk_acs_usr FOREIGN KEY (acsusrid) REFERENCES usr(usrid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 577 (OID 968744)
-- Name: fk_log_usr; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY log
    ADD CONSTRAINT fk_log_usr FOREIGN KEY (logusrid) REFERENCES usr(usrid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 615 (OID 968748)
-- Name: fk_pac_usr; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pac
    ADD CONSTRAINT fk_pac_usr FOREIGN KEY (pacusrid) REFERENCES usr(usrid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 603 (OID 968752)
-- Name: fk_pas_tsv; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pas
    ADD CONSTRAINT fk_pas_tsv FOREIGN KEY (pastsvid) REFERENCES tsv(tsvid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 610 (OID 968756)
-- Name: fk_pse_sre; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pse
    ADD CONSTRAINT fk_pse_sre FOREIGN KEY (psesreid) REFERENCES sre(sreid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 575 (OID 968760)
-- Name: fk_acs_men; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY acs
    ADD CONSTRAINT fk_acs_men FOREIGN KEY (acsmenid) REFERENCES men(menid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 616 (OID 968764)
-- Name: fk_msa_ate; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY msa
    ADD CONSTRAINT fk_msa_ate FOREIGN KEY (msaateid) REFERENCES ate(ateid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 600 (OID 968768)
-- Name: fk_tsv_dgn; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY tsv
    ADD CONSTRAINT fk_tsv_dgn FOREIGN KEY (tsvdgnid) REFERENCES dgn(dgnid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 608 (OID 968772)
-- Name: fk_cld_cgr; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY cld
    ADD CONSTRAINT fk_cld_cgr FOREIGN KEY (cldcgrid) REFERENCES cgr(cgrid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 613 (OID 968776)
-- Name: fk_dap_men; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dap
    ADD CONSTRAINT fk_dap_men FOREIGN KEY (dapmenid) REFERENCES men(menid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 580 (OID 968780)
-- Name: fk_und_mun; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY und
    ADD CONSTRAINT fk_und_mun FOREIGN KEY (undmunid) REFERENCES mun(munid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 619 (OID 968784)
-- Name: fk_anc_tam; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY anc
    ADD CONSTRAINT fk_anc_tam FOREIGN KEY (anctamid) REFERENCES tam(tamid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 621 (OID 968788)
-- Name: fk_ctu_tpc; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY ctu
    ADD CONSTRAINT fk_ctu_tpc FOREIGN KEY (ctutpcid) REFERENCES tpc(tpcid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 622 (OID 968792)
-- Name: fk_dmn_dmn; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dmn
    ADD CONSTRAINT fk_dmn_dmn FOREIGN KEY (dmndmnid) REFERENCES dmn(dmnid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 623 (OID 968796)
-- Name: fk_dmn_scc; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dmn
    ADD CONSTRAINT fk_dmn_scc FOREIGN KEY (dmnsccid) REFERENCES scc(sccid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 624 (OID 968800)
-- Name: fk_lpc_plc; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY lpc
    ADD CONSTRAINT fk_lpc_plc FOREIGN KEY (lpcplcid) REFERENCES plc(plcid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 626 (OID 968804)
-- Name: fk_mlg_grm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY mlg
    ADD CONSTRAINT fk_mlg_grm FOREIGN KEY (mlggrmid) REFERENCES grm(grmid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 627 (OID 968808)
-- Name: fk_mop_imp_css; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY mop
    ADD CONSTRAINT fk_mop_imp_css FOREIGN KEY (mopcssidimp) REFERENCES css(cssid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 628 (OID 968812)
-- Name: fk_mop_tl_css; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY mop
    ADD CONSTRAINT fk_mop_tl_css FOREIGN KEY (mopcssidtl) REFERENCES css(cssid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 629 (OID 968816)
-- Name: fk_scc_dmn; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY scc
    ADD CONSTRAINT fk_scc_dmn FOREIGN KEY (sccdmnid) REFERENCES dmn(dmnid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 630 (OID 968820)
-- Name: fk_scc_env_mop; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY scc
    ADD CONSTRAINT fk_scc_env_mop FOREIGN KEY (sccmopidenv) REFERENCES mop(mopid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 631 (OID 968824)
-- Name: fk_scc_scc; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY scc
    ADD CONSTRAINT fk_scc_scc FOREIGN KEY (sccsccid) REFERENCES scc(sccid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 632 (OID 968828)
-- Name: fk_scc_pfu; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY scc
    ADD CONSTRAINT fk_scc_pfu FOREIGN KEY (sccpfuid) REFERENCES pfu(pfuid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 633 (OID 968832)
-- Name: fk_scc_vis_mop; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY scc
    ADD CONSTRAINT fk_scc_vis_mop FOREIGN KEY (sccmopidvis) REFERENCES mop(mopid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 581 (OID 968836)
-- Name: fk_und_und; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY und
    ADD CONSTRAINT fk_und_und FOREIGN KEY (undundidvch) REFERENCES und(undid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 635 (OID 968840)
-- Name: fk_cts_vis_mop; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY cts
    ADD CONSTRAINT fk_cts_vis_mop FOREIGN KEY (ctsmopidvis) REFERENCES mop(mopid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 636 (OID 968844)
-- Name: fk_cts_env_mop; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY cts
    ADD CONSTRAINT fk_cts_env_mop FOREIGN KEY (ctsmopidenv) REFERENCES mop(mopid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 639 (OID 968848)
-- Name: fk_abp_scc; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY abp
    ADD CONSTRAINT fk_abp_scc FOREIGN KEY (abpsccid) REFERENCES scc(sccid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 640 (OID 968852)
-- Name: fk_abp_usr; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY abp
    ADD CONSTRAINT fk_abp_usr FOREIGN KEY (abpusrid) REFERENCES usr(usrid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 641 (OID 968856)
-- Name: fk_bnn_dmn; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY bnn
    ADD CONSTRAINT fk_bnn_dmn FOREIGN KEY (bnndmnid) REFERENCES dmn(dmnid) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 642 (OID 968860)
-- Name: fk_bns_bnn; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY bns
    ADD CONSTRAINT fk_bns_bnn FOREIGN KEY (bnsbnnid) REFERENCES bnn(bnnid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 643 (OID 968864)
-- Name: fk_bns_scc; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY bns
    ADD CONSTRAINT fk_bns_scc FOREIGN KEY (bnssccid) REFERENCES scc(sccid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 634 (OID 968868)
-- Name: fk_scc_tpc; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY scc
    ADD CONSTRAINT fk_scc_tpc FOREIGN KEY (scctpcid) REFERENCES tpc(tpcid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 637 (OID 968872)
-- Name: fk_cts_ctu; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY cts
    ADD CONSTRAINT fk_cts_ctu FOREIGN KEY (ctsctuid) REFERENCES ctu(ctuid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 620 (OID 968876)
-- Name: fk_anc_ctu; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY anc
    ADD CONSTRAINT fk_anc_ctu FOREIGN KEY (ancctuid) REFERENCES ctu(ctuid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 625 (OID 968880)
-- Name: fk_lpc_ctu; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY lpc
    ADD CONSTRAINT fk_lpc_ctu FOREIGN KEY (lpcctuid) REFERENCES ctu(ctuid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 644 (OID 968884)
-- Name: fk_ppb_tpc; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY ppb
    ADD CONSTRAINT fk_ppb_tpc FOREIGN KEY (ppbtpcid) REFERENCES tpc(tpcid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 645 (OID 968888)
-- Name: fk_ppb_urdofc; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY ppb
    ADD CONSTRAINT fk_ppb_urdofc FOREIGN KEY (ppburdidorg) REFERENCES urd(urdid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 646 (OID 968892)
-- Name: fk_ppb_urdrep; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY ppb
    ADD CONSTRAINT fk_ppb_urdrep FOREIGN KEY (ppburdidrep) REFERENCES urd(urdid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 638 (OID 968896)
-- Name: fk_cts_scc; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY cts
    ADD CONSTRAINT fk_cts_scc FOREIGN KEY (ctssccid) REFERENCES scc(sccid) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 617 (OID 968900)
-- Name: fk_msa_urd_rem; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY msa
    ADD CONSTRAINT fk_msa_urd_rem FOREIGN KEY (msaurdidrem) REFERENCES urd(urdid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 618 (OID 968904)
-- Name: fk_msa_urd_des; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY msa
    ADD CONSTRAINT fk_msa_urd_des FOREIGN KEY (msaurdiddes) REFERENCES urd(urdid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 647 (OID 968908)
-- Name: fk_mss_urd_des; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY mss
    ADD CONSTRAINT fk_mss_urd_des FOREIGN KEY (mssurdiddes) REFERENCES urd(urdid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 648 (OID 968912)
-- Name: fk_mss_urd_rem; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY mss
    ADD CONSTRAINT fk_mss_urd_rem FOREIGN KEY (mssurdidrem) REFERENCES urd(urdid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 590 (OID 1017140)
-- Name: fk_dgn_cld; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dgn
    ADD CONSTRAINT fk_dgn_cld FOREIGN KEY (dgncldid) REFERENCES cld(cldid) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 651 (OID 968916)
-- Name: RI_ConstraintTrigger_968916; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_log_sis
    AFTER INSERT OR UPDATE ON log
    FROM sis
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_log_sis', 'log', 'sis', 'UNSPECIFIED', 'logsisid', 'sisid');


--
-- TOC entry 660 (OID 968917)
-- Name: RI_ConstraintTrigger_968917; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_log_sis
    AFTER DELETE ON sis
    FROM log
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_log_sis', 'log', 'sis', 'UNSPECIFIED', 'logsisid', 'sisid');


--
-- TOC entry 661 (OID 968918)
-- Name: RI_ConstraintTrigger_968918; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_log_sis
    AFTER UPDATE ON sis
    FROM log
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_log_sis', 'log', 'sis', 'UNSPECIFIED', 'logsisid', 'sisid');


--
-- TOC entry 653 (OID 968919)
-- Name: RI_ConstraintTrigger_968919; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_men_sis
    AFTER INSERT OR UPDATE ON men
    FROM sis
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_men_sis', 'men', 'sis', 'UNSPECIFIED', 'mensisid', 'sisid');


--
-- TOC entry 662 (OID 968920)
-- Name: RI_ConstraintTrigger_968920; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_men_sis
    AFTER DELETE ON sis
    FROM men
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_men_sis', 'men', 'sis', 'UNSPECIFIED', 'mensisid', 'sisid');


--
-- TOC entry 663 (OID 968921)
-- Name: RI_ConstraintTrigger_968921; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_men_sis
    AFTER UPDATE ON sis
    FROM men
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_men_sis', 'men', 'sis', 'UNSPECIFIED', 'mensisid', 'sisid');


--
-- TOC entry 689 (OID 968922)
-- Name: RI_ConstraintTrigger_968922; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_var_sis
    AFTER INSERT OR UPDATE ON var
    FROM sis
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_var_sis', 'var', 'sis', 'UNSPECIFIED', 'varsisid', 'sisid');


--
-- TOC entry 664 (OID 968923)
-- Name: RI_ConstraintTrigger_968923; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_var_sis
    AFTER DELETE ON sis
    FROM var
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_var_sis', 'var', 'sis', 'UNSPECIFIED', 'varsisid', 'sisid');


--
-- TOC entry 665 (OID 968924)
-- Name: RI_ConstraintTrigger_968924; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_var_sis
    AFTER UPDATE ON sis
    FROM var
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_var_sis', 'var', 'sis', 'UNSPECIFIED', 'varsisid', 'sisid');


--
-- TOC entry 690 (OID 968925)
-- Name: RI_ConstraintTrigger_968925; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_atd_dvs
    AFTER INSERT OR UPDATE ON atd
    FROM dvs
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_atd_dvs', 'atd', 'dvs', 'UNSPECIFIED', 'atddvsid', 'dvsid');


--
-- TOC entry 718 (OID 968926)
-- Name: RI_ConstraintTrigger_968926; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_atd_dvs
    AFTER DELETE ON dvs
    FROM atd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_atd_dvs', 'atd', 'dvs', 'UNSPECIFIED', 'atddvsid', 'dvsid');


--
-- TOC entry 719 (OID 968927)
-- Name: RI_ConstraintTrigger_968927; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_atd_dvs
    AFTER UPDATE ON dvs
    FROM atd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_atd_dvs', 'atd', 'dvs', 'UNSPECIFIED', 'atddvsid', 'dvsid');


--
-- TOC entry 691 (OID 968928)
-- Name: RI_ConstraintTrigger_968928; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_atd_urd
    AFTER INSERT OR UPDATE ON atd
    FROM urd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_atd_urd', 'atd', 'urd', 'UNSPECIFIED', 'atdurdid', 'urdid');


--
-- TOC entry 742 (OID 968929)
-- Name: RI_ConstraintTrigger_968929; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_atd_urd
    AFTER DELETE ON urd
    FROM atd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_atd_urd', 'atd', 'urd', 'UNSPECIFIED', 'atdurdid', 'urdid');


--
-- TOC entry 743 (OID 968930)
-- Name: RI_ConstraintTrigger_968930; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_atd_urd
    AFTER UPDATE ON urd
    FROM atd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_atd_urd', 'atd', 'urd', 'UNSPECIFIED', 'atdurdid', 'urdid');


--
-- TOC entry 698 (OID 968931)
-- Name: RI_ConstraintTrigger_968931; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_ate_atd
    AFTER INSERT OR UPDATE ON ate
    FROM atd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_ate_atd', 'ate', 'atd', 'UNSPECIFIED', 'ateatdid', 'atdid');


--
-- TOC entry 692 (OID 968932)
-- Name: RI_ConstraintTrigger_968932; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_ate_atd
    AFTER DELETE ON atd
    FROM ate
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_ate_atd', 'ate', 'atd', 'UNSPECIFIED', 'ateatdid', 'atdid');


--
-- TOC entry 693 (OID 968933)
-- Name: RI_ConstraintTrigger_968933; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_ate_atd
    AFTER UPDATE ON atd
    FROM ate
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_ate_atd', 'ate', 'atd', 'UNSPECIFIED', 'ateatdid', 'atdid');


--
-- TOC entry 699 (OID 968934)
-- Name: RI_ConstraintTrigger_968934; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_ate_sat
    AFTER INSERT OR UPDATE ON ate
    FROM sat
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_ate_sat', 'ate', 'sat', 'UNSPECIFIED', 'atesatid', 'satid');


--
-- TOC entry 726 (OID 968935)
-- Name: RI_ConstraintTrigger_968935; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_ate_sat
    AFTER DELETE ON sat
    FROM ate
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_ate_sat', 'ate', 'sat', 'UNSPECIFIED', 'atesatid', 'satid');


--
-- TOC entry 727 (OID 968936)
-- Name: RI_ConstraintTrigger_968936; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_ate_sat
    AFTER UPDATE ON sat
    FROM ate
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_ate_sat', 'ate', 'sat', 'UNSPECIFIED', 'atesatid', 'satid');


--
-- TOC entry 724 (OID 968937)
-- Name: RI_ConstraintTrigger_968937; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_hat_ate
    AFTER INSERT OR UPDATE ON hat
    FROM ate
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_hat_ate', 'hat', 'ate', 'UNSPECIFIED', 'hatateid', 'ateid');


--
-- TOC entry 700 (OID 968938)
-- Name: RI_ConstraintTrigger_968938; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_hat_ate
    AFTER DELETE ON ate
    FROM hat
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_hat_ate', 'hat', 'ate', 'UNSPECIFIED', 'hatateid', 'ateid');


--
-- TOC entry 701 (OID 968939)
-- Name: RI_ConstraintTrigger_968939; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_hat_ate
    AFTER UPDATE ON ate
    FROM hat
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_hat_ate', 'hat', 'ate', 'UNSPECIFIED', 'hatateid', 'ateid');


--
-- TOC entry 725 (OID 968940)
-- Name: RI_ConstraintTrigger_968940; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_hat_atd
    AFTER INSERT OR UPDATE ON hat
    FROM atd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_hat_atd', 'hat', 'atd', 'UNSPECIFIED', 'hatatdid', 'atdid');


--
-- TOC entry 694 (OID 968941)
-- Name: RI_ConstraintTrigger_968941; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_hat_atd
    AFTER DELETE ON atd
    FROM hat
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_hat_atd', 'hat', 'atd', 'UNSPECIFIED', 'hatatdid', 'atdid');


--
-- TOC entry 695 (OID 968942)
-- Name: RI_ConstraintTrigger_968942; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_hat_atd
    AFTER UPDATE ON atd
    FROM hat
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_hat_atd', 'hat', 'atd', 'UNSPECIFIED', 'hatatdid', 'atdid');


--
-- TOC entry 728 (OID 968943)
-- Name: RI_ConstraintTrigger_968943; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sat_urd
    AFTER INSERT OR UPDATE ON sat
    FROM urd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_sat_urd', 'sat', 'urd', 'UNSPECIFIED', 'saturdid', 'urdid');


--
-- TOC entry 744 (OID 968944)
-- Name: RI_ConstraintTrigger_968944; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sat_urd
    AFTER DELETE ON urd
    FROM sat
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_sat_urd', 'sat', 'urd', 'UNSPECIFIED', 'saturdid', 'urdid');


--
-- TOC entry 745 (OID 968945)
-- Name: RI_ConstraintTrigger_968945; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sat_urd
    AFTER UPDATE ON urd
    FROM sat
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_sat_urd', 'sat', 'urd', 'UNSPECIFIED', 'saturdid', 'urdid');


--
-- TOC entry 729 (OID 968946)
-- Name: RI_ConstraintTrigger_968946; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sat_dgn
    AFTER INSERT OR UPDATE ON sat
    FROM dgn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_sat_dgn', 'sat', 'dgn', 'UNSPECIFIED', 'satdgnid', 'dgnid');


--
-- TOC entry 709 (OID 968947)
-- Name: RI_ConstraintTrigger_968947; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sat_dgn
    AFTER DELETE ON dgn
    FROM sat
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_sat_dgn', 'sat', 'dgn', 'UNSPECIFIED', 'satdgnid', 'dgnid');


--
-- TOC entry 710 (OID 968948)
-- Name: RI_ConstraintTrigger_968948; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sat_dgn
    AFTER UPDATE ON dgn
    FROM sat
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_sat_dgn', 'sat', 'dgn', 'UNSPECIFIED', 'satdgnid', 'dgnid');


--
-- TOC entry 730 (OID 968949)
-- Name: RI_ConstraintTrigger_968949; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sre_atd
    AFTER INSERT OR UPDATE ON sre
    FROM atd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_sre_atd', 'sre', 'atd', 'UNSPECIFIED', 'sreatdid', 'atdid');


--
-- TOC entry 696 (OID 968950)
-- Name: RI_ConstraintTrigger_968950; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sre_atd
    AFTER DELETE ON atd
    FROM sre
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_sre_atd', 'sre', 'atd', 'UNSPECIFIED', 'sreatdid', 'atdid');


--
-- TOC entry 697 (OID 968951)
-- Name: RI_ConstraintTrigger_968951; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sre_atd
    AFTER UPDATE ON atd
    FROM sre
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_sre_atd', 'sre', 'atd', 'UNSPECIFIED', 'sreatdid', 'atdid');


--
-- TOC entry 731 (OID 968952)
-- Name: RI_ConstraintTrigger_968952; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sre_ate
    AFTER INSERT OR UPDATE ON sre
    FROM ate
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_sre_ate', 'sre', 'ate', 'UNSPECIFIED', 'sreateid', 'ateid');


--
-- TOC entry 702 (OID 968953)
-- Name: RI_ConstraintTrigger_968953; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sre_ate
    AFTER DELETE ON ate
    FROM sre
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_sre_ate', 'sre', 'ate', 'UNSPECIFIED', 'sreateid', 'ateid');


--
-- TOC entry 703 (OID 968954)
-- Name: RI_ConstraintTrigger_968954; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sre_ate
    AFTER UPDATE ON ate
    FROM sre
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_sre_ate', 'sre', 'ate', 'UNSPECIFIED', 'sreateid', 'ateid');


--
-- TOC entry 732 (OID 968955)
-- Name: RI_ConstraintTrigger_968955; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sre_srv
    AFTER INSERT OR UPDATE ON sre
    FROM tsv
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_sre_srv', 'sre', 'tsv', 'UNSPECIFIED', 'sretsvid', 'tsvid');


--
-- TOC entry 735 (OID 968956)
-- Name: RI_ConstraintTrigger_968956; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sre_srv
    AFTER DELETE ON tsv
    FROM sre
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_sre_srv', 'sre', 'tsv', 'UNSPECIFIED', 'sretsvid', 'tsvid');


--
-- TOC entry 736 (OID 968957)
-- Name: RI_ConstraintTrigger_968957; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_sre_srv
    AFTER UPDATE ON tsv
    FROM sre
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_sre_srv', 'sre', 'tsv', 'UNSPECIFIED', 'sretsvid', 'tsvid');


--
-- TOC entry 746 (OID 968958)
-- Name: RI_ConstraintTrigger_968958; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_urd_mun
    AFTER INSERT OR UPDATE ON urd
    FROM mun
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_urd_mun', 'urd', 'mun', 'UNSPECIFIED', 'urdmunid', 'munid');


--
-- TOC entry 679 (OID 968959)
-- Name: RI_ConstraintTrigger_968959; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_urd_mun
    AFTER DELETE ON mun
    FROM urd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_urd_mun', 'urd', 'mun', 'UNSPECIFIED', 'urdmunid', 'munid');


--
-- TOC entry 680 (OID 968960)
-- Name: RI_ConstraintTrigger_968960; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_urd_mun
    AFTER UPDATE ON mun
    FROM urd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_urd_mun', 'urd', 'mun', 'UNSPECIFIED', 'urdmunid', 'munid');


--
-- TOC entry 747 (OID 968961)
-- Name: RI_ConstraintTrigger_968961; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_urd_und
    AFTER INSERT OR UPDATE ON urd
    FROM und
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_urd_und', 'urd', 'und', 'UNSPECIFIED', 'urdundid', 'undid');


--
-- TOC entry 683 (OID 968962)
-- Name: RI_ConstraintTrigger_968962; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_urd_und
    AFTER DELETE ON und
    FROM urd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_urd_und', 'urd', 'und', 'UNSPECIFIED', 'urdundid', 'undid');


--
-- TOC entry 684 (OID 968963)
-- Name: RI_ConstraintTrigger_968963; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_urd_und
    AFTER UPDATE ON und
    FROM urd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_urd_und', 'urd', 'und', 'UNSPECIFIED', 'urdundid', 'undid');


--
-- TOC entry 670 (OID 968964)
-- Name: RI_ConstraintTrigger_968964; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_usr_urd
    AFTER INSERT OR UPDATE ON usr
    FROM urd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_usr_urd', 'usr', 'urd', 'UNSPECIFIED', 'usrurdid', 'urdid');


--
-- TOC entry 748 (OID 968965)
-- Name: RI_ConstraintTrigger_968965; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_usr_urd
    AFTER DELETE ON urd
    FROM usr
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_usr_urd', 'usr', 'urd', 'UNSPECIFIED', 'usrurdid', 'urdid');


--
-- TOC entry 749 (OID 968966)
-- Name: RI_ConstraintTrigger_968966; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_usr_urd
    AFTER UPDATE ON urd
    FROM usr
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_usr_urd', 'usr', 'urd', 'UNSPECIFIED', 'usrurdid', 'urdid');


--
-- TOC entry 711 (OID 968967)
-- Name: RI_ConstraintTrigger_968967; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dgn_dvs
    AFTER INSERT OR UPDATE ON dgn
    FROM dvs
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_dgn_dvs', 'dgn', 'dvs', 'UNSPECIFIED', 'dgndvsid', 'dvsid');


--
-- TOC entry 720 (OID 968968)
-- Name: RI_ConstraintTrigger_968968; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dgn_dvs
    AFTER DELETE ON dvs
    FROM dgn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_dgn_dvs', 'dgn', 'dvs', 'UNSPECIFIED', 'dgndvsid', 'dvsid');


--
-- TOC entry 721 (OID 968969)
-- Name: RI_ConstraintTrigger_968969; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dgn_dvs
    AFTER UPDATE ON dvs
    FROM dgn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_dgn_dvs', 'dgn', 'dvs', 'UNSPECIFIED', 'dgndvsid', 'dvsid');


--
-- TOC entry 722 (OID 968970)
-- Name: RI_ConstraintTrigger_968970; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dvs_urd
    AFTER INSERT OR UPDATE ON dvs
    FROM urd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_dvs_urd', 'dvs', 'urd', 'UNSPECIFIED', 'dvsurdid', 'urdid');


--
-- TOC entry 750 (OID 968971)
-- Name: RI_ConstraintTrigger_968971; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dvs_urd
    AFTER DELETE ON urd
    FROM dvs
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_dvs_urd', 'dvs', 'urd', 'UNSPECIFIED', 'dvsurdid', 'urdid');


--
-- TOC entry 751 (OID 968972)
-- Name: RI_ConstraintTrigger_968972; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dvs_urd
    AFTER UPDATE ON urd
    FROM dvs
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_dvs_urd', 'dvs', 'urd', 'UNSPECIFIED', 'dvsurdid', 'urdid');


--
-- TOC entry 704 (OID 968973)
-- Name: RI_ConstraintTrigger_968973; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_ate_dgn
    AFTER INSERT OR UPDATE ON ate
    FROM dgn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_ate_dgn', 'ate', 'dgn', 'UNSPECIFIED', 'atedgnid', 'dgnid');


--
-- TOC entry 712 (OID 968974)
-- Name: RI_ConstraintTrigger_968974; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_ate_dgn
    AFTER DELETE ON dgn
    FROM ate
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_ate_dgn', 'ate', 'dgn', 'UNSPECIFIED', 'atedgnid', 'dgnid');


--
-- TOC entry 713 (OID 968975)
-- Name: RI_ConstraintTrigger_968975; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_ate_dgn
    AFTER UPDATE ON dgn
    FROM ate
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_ate_dgn', 'ate', 'dgn', 'UNSPECIFIED', 'atedgnid', 'dgnid');


--
-- TOC entry 757 (OID 968976)
-- Name: RI_ConstraintTrigger_968976; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pgi_sis
    AFTER INSERT OR UPDATE ON pgi
    FROM sis
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_pgi_sis', 'pgi', 'sis', 'UNSPECIFIED', 'pgisisid', 'sisid');


--
-- TOC entry 666 (OID 968977)
-- Name: RI_ConstraintTrigger_968977; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pgi_sis
    AFTER DELETE ON sis
    FROM pgi
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_pgi_sis', 'pgi', 'sis', 'UNSPECIFIED', 'pgisisid', 'sisid');


--
-- TOC entry 667 (OID 968978)
-- Name: RI_ConstraintTrigger_968978; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pgi_sis
    AFTER UPDATE ON sis
    FROM pgi
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_pgi_sis', 'pgi', 'sis', 'UNSPECIFIED', 'pgisisid', 'sisid');


--
-- TOC entry 758 (OID 968979)
-- Name: RI_ConstraintTrigger_968979; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pgi_usr
    AFTER INSERT OR UPDATE ON pgi
    FROM usr
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_pgi_usr', 'pgi', 'usr', 'UNSPECIFIED', 'pgiusrid', 'usrid');


--
-- TOC entry 671 (OID 968980)
-- Name: RI_ConstraintTrigger_968980; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pgi_usr
    AFTER DELETE ON usr
    FROM pgi
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_pgi_usr', 'pgi', 'usr', 'UNSPECIFIED', 'pgiusrid', 'usrid');


--
-- TOC entry 672 (OID 968981)
-- Name: RI_ConstraintTrigger_968981; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pgi_usr
    AFTER UPDATE ON usr
    FROM pgi
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_pgi_usr', 'pgi', 'usr', 'UNSPECIFIED', 'pgiusrid', 'usrid');


--
-- TOC entry 759 (OID 968982)
-- Name: RI_ConstraintTrigger_968982; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pgi_men
    AFTER INSERT OR UPDATE ON pgi
    FROM men
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_pgi_men', 'pgi', 'men', 'UNSPECIFIED', 'pgimenid', 'menid');


--
-- TOC entry 654 (OID 968983)
-- Name: RI_ConstraintTrigger_968983; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pgi_men
    AFTER DELETE ON men
    FROM pgi
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_pgi_men', 'pgi', 'men', 'UNSPECIFIED', 'pgimenid', 'menid');


--
-- TOC entry 655 (OID 968984)
-- Name: RI_ConstraintTrigger_968984; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pgi_men
    AFTER UPDATE ON men
    FROM pgi
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_pgi_men', 'pgi', 'men', 'UNSPECIFIED', 'pgimenid', 'menid');


--
-- TOC entry 760 (OID 968985)
-- Name: RI_ConstraintTrigger_968985; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_cgr_urd
    AFTER INSERT OR UPDATE ON cgr
    FROM urd
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_cgr_urd', 'cgr', 'urd', 'UNSPECIFIED', 'cgrurdid', 'urdid');


--
-- TOC entry 752 (OID 968986)
-- Name: RI_ConstraintTrigger_968986; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_cgr_urd
    AFTER DELETE ON urd
    FROM cgr
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_cgr_urd', 'cgr', 'urd', 'UNSPECIFIED', 'cgrurdid', 'urdid');


--
-- TOC entry 753 (OID 968987)
-- Name: RI_ConstraintTrigger_968987; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_cgr_urd
    AFTER UPDATE ON urd
    FROM cgr
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_cgr_urd', 'cgr', 'urd', 'UNSPECIFIED', 'cgrurdid', 'urdid');


--
-- TOC entry 714 (OID 968988)
-- Name: RI_ConstraintTrigger_968988; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dgn_tsv
    AFTER INSERT OR UPDATE ON dgn
    FROM tsv
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_dgn_tsv', 'dgn', 'tsv', 'UNSPECIFIED', 'dgntsvid', 'tsvid');


--
-- TOC entry 737 (OID 968989)
-- Name: RI_ConstraintTrigger_968989; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dgn_tsv
    AFTER DELETE ON tsv
    FROM dgn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_dgn_tsv', 'dgn', 'tsv', 'UNSPECIFIED', 'dgntsvid', 'tsvid');


--
-- TOC entry 738 (OID 968990)
-- Name: RI_ConstraintTrigger_968990; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dgn_tsv
    AFTER UPDATE ON tsv
    FROM dgn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_dgn_tsv', 'dgn', 'tsv', 'UNSPECIFIED', 'dgntsvid', 'tsvid');


--
-- TOC entry 715 (OID 968991)
-- Name: RI_ConstraintTrigger_968991; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dgn_cld
    AFTER INSERT OR UPDATE ON dgn
    FROM cld
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_dgn_cld', 'dgn', 'cld', 'UNSPECIFIED', 'dgncldid', 'cldid');


--
-- TOC entry 765 (OID 968992)
-- Name: RI_ConstraintTrigger_968992; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dgn_cld
    AFTER DELETE ON cld
    FROM dgn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_dgn_cld', 'dgn', 'cld', 'UNSPECIFIED', 'dgncldid', 'cldid');


--
-- TOC entry 766 (OID 968993)
-- Name: RI_ConstraintTrigger_968993; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dgn_cld
    AFTER UPDATE ON cld
    FROM dgn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_dgn_cld', 'dgn', 'cld', 'UNSPECIFIED', 'dgncldid', 'cldid');


--
-- TOC entry 723 (OID 968994)
-- Name: RI_ConstraintTrigger_968994; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dvs_cgr
    AFTER INSERT OR UPDATE ON dvs
    FROM cgr
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_dvs_cgr', 'dvs', 'cgr', 'UNSPECIFIED', 'dvscgrid', 'cgrid');


--
-- TOC entry 761 (OID 968995)
-- Name: RI_ConstraintTrigger_968995; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dvs_cgr
    AFTER DELETE ON cgr
    FROM dvs
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_dvs_cgr', 'dvs', 'cgr', 'UNSPECIFIED', 'dvscgrid', 'cgrid');


--
-- TOC entry 762 (OID 968996)
-- Name: RI_ConstraintTrigger_968996; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dvs_cgr
    AFTER UPDATE ON cgr
    FROM dvs
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_dvs_cgr', 'dvs', 'cgr', 'UNSPECIFIED', 'dvscgrid', 'cgrid');


--
-- TOC entry 768 (OID 968997)
-- Name: RI_ConstraintTrigger_968997; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pse_pas
    AFTER INSERT OR UPDATE ON pse
    FROM pas
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_pse_pas', 'pse', 'pas', 'UNSPECIFIED', 'psepasid', 'pasid');


--
-- TOC entry 754 (OID 968998)
-- Name: RI_ConstraintTrigger_968998; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pse_pas
    AFTER DELETE ON pas
    FROM pse
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_pse_pas', 'pse', 'pas', 'UNSPECIFIED', 'psepasid', 'pasid');


--
-- TOC entry 755 (OID 968999)
-- Name: RI_ConstraintTrigger_968999; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pse_pas
    AFTER UPDATE ON pas
    FROM pse
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_pse_pas', 'pse', 'pas', 'UNSPECIFIED', 'psepasid', 'pasid');


--
-- TOC entry 770 (OID 969000)
-- Name: RI_ConstraintTrigger_969000; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pfu_sis
    AFTER INSERT OR UPDATE ON pfu
    FROM sis
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_pfu_sis', 'pfu', 'sis', 'UNSPECIFIED', 'pfusisid', 'sisid');


--
-- TOC entry 668 (OID 969001)
-- Name: RI_ConstraintTrigger_969001; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pfu_sis
    AFTER DELETE ON sis
    FROM pfu
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_pfu_sis', 'pfu', 'sis', 'UNSPECIFIED', 'pfusisid', 'sisid');


--
-- TOC entry 669 (OID 969002)
-- Name: RI_ConstraintTrigger_969002; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pfu_sis
    AFTER UPDATE ON sis
    FROM pfu
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_pfu_sis', 'pfu', 'sis', 'UNSPECIFIED', 'pfusisid', 'sisid');


--
-- TOC entry 777 (OID 969003)
-- Name: RI_ConstraintTrigger_969003; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dap_pfu
    AFTER INSERT OR UPDATE ON dap
    FROM pfu
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_dap_pfu', 'dap', 'pfu', 'UNSPECIFIED', 'dappfuid', 'pfuid');


--
-- TOC entry 771 (OID 969004)
-- Name: RI_ConstraintTrigger_969004; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dap_pfu
    AFTER DELETE ON pfu
    FROM dap
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_dap_pfu', 'dap', 'pfu', 'UNSPECIFIED', 'dappfuid', 'pfuid');


--
-- TOC entry 772 (OID 969005)
-- Name: RI_ConstraintTrigger_969005; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dap_pfu
    AFTER UPDATE ON pfu
    FROM dap
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_dap_pfu', 'dap', 'pfu', 'UNSPECIFIED', 'dappfuid', 'pfuid');


--
-- TOC entry 779 (OID 969006)
-- Name: RI_ConstraintTrigger_969006; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pac_pfu
    AFTER INSERT OR UPDATE ON pac
    FROM pfu
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_pac_pfu', 'pac', 'pfu', 'UNSPECIFIED', 'pacpfuid', 'pfuid');


--
-- TOC entry 773 (OID 969007)
-- Name: RI_ConstraintTrigger_969007; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pac_pfu
    AFTER DELETE ON pfu
    FROM pac
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_pac_pfu', 'pac', 'pfu', 'UNSPECIFIED', 'pacpfuid', 'pfuid');


--
-- TOC entry 774 (OID 969008)
-- Name: RI_ConstraintTrigger_969008; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pac_pfu
    AFTER UPDATE ON pfu
    FROM pac
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_pac_pfu', 'pac', 'pfu', 'UNSPECIFIED', 'pacpfuid', 'pfuid');


--
-- TOC entry 649 (OID 969009)
-- Name: RI_ConstraintTrigger_969009; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_acs_usr
    AFTER INSERT OR UPDATE ON acs
    FROM usr
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_acs_usr', 'acs', 'usr', 'UNSPECIFIED', 'acsusrid', 'usrid');


--
-- TOC entry 673 (OID 969010)
-- Name: RI_ConstraintTrigger_969010; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_acs_usr
    AFTER DELETE ON usr
    FROM acs
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_cascade_del"('fk_acs_usr', 'acs', 'usr', 'UNSPECIFIED', 'acsusrid', 'usrid');


--
-- TOC entry 674 (OID 969011)
-- Name: RI_ConstraintTrigger_969011; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_acs_usr
    AFTER UPDATE ON usr
    FROM acs
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_acs_usr', 'acs', 'usr', 'UNSPECIFIED', 'acsusrid', 'usrid');


--
-- TOC entry 652 (OID 969012)
-- Name: RI_ConstraintTrigger_969012; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_log_usr
    AFTER INSERT OR UPDATE ON log
    FROM usr
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_log_usr', 'log', 'usr', 'UNSPECIFIED', 'logusrid', 'usrid');


--
-- TOC entry 675 (OID 969013)
-- Name: RI_ConstraintTrigger_969013; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_log_usr
    AFTER DELETE ON usr
    FROM log
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_cascade_del"('fk_log_usr', 'log', 'usr', 'UNSPECIFIED', 'logusrid', 'usrid');


--
-- TOC entry 676 (OID 969014)
-- Name: RI_ConstraintTrigger_969014; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_log_usr
    AFTER UPDATE ON usr
    FROM log
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_log_usr', 'log', 'usr', 'UNSPECIFIED', 'logusrid', 'usrid');


--
-- TOC entry 780 (OID 969015)
-- Name: RI_ConstraintTrigger_969015; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pac_usr
    AFTER INSERT OR UPDATE ON pac
    FROM usr
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_pac_usr', 'pac', 'usr', 'UNSPECIFIED', 'pacusrid', 'usrid');


--
-- TOC entry 677 (OID 969016)
-- Name: RI_ConstraintTrigger_969016; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pac_usr
    AFTER DELETE ON usr
    FROM pac
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_cascade_del"('fk_pac_usr', 'pac', 'usr', 'UNSPECIFIED', 'pacusrid', 'usrid');


--
-- TOC entry 678 (OID 969017)
-- Name: RI_ConstraintTrigger_969017; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pac_usr
    AFTER UPDATE ON usr
    FROM pac
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_pac_usr', 'pac', 'usr', 'UNSPECIFIED', 'pacusrid', 'usrid');


--
-- TOC entry 756 (OID 969018)
-- Name: RI_ConstraintTrigger_969018; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pas_tsv
    AFTER INSERT OR UPDATE ON pas
    FROM tsv
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_pas_tsv', 'pas', 'tsv', 'UNSPECIFIED', 'pastsvid', 'tsvid');


--
-- TOC entry 739 (OID 969019)
-- Name: RI_ConstraintTrigger_969019; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pas_tsv
    AFTER DELETE ON tsv
    FROM pas
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_cascade_del"('fk_pas_tsv', 'pas', 'tsv', 'UNSPECIFIED', 'pastsvid', 'tsvid');


--
-- TOC entry 740 (OID 969020)
-- Name: RI_ConstraintTrigger_969020; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pas_tsv
    AFTER UPDATE ON tsv
    FROM pas
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_pas_tsv', 'pas', 'tsv', 'UNSPECIFIED', 'pastsvid', 'tsvid');


--
-- TOC entry 769 (OID 969021)
-- Name: RI_ConstraintTrigger_969021; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pse_sre
    AFTER INSERT OR UPDATE ON pse
    FROM sre
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_pse_sre', 'pse', 'sre', 'UNSPECIFIED', 'psesreid', 'sreid');


--
-- TOC entry 733 (OID 969022)
-- Name: RI_ConstraintTrigger_969022; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pse_sre
    AFTER DELETE ON sre
    FROM pse
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_cascade_del"('fk_pse_sre', 'pse', 'sre', 'UNSPECIFIED', 'psesreid', 'sreid');


--
-- TOC entry 734 (OID 969023)
-- Name: RI_ConstraintTrigger_969023; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_pse_sre
    AFTER UPDATE ON sre
    FROM pse
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_pse_sre', 'pse', 'sre', 'UNSPECIFIED', 'psesreid', 'sreid');


--
-- TOC entry 650 (OID 969024)
-- Name: RI_ConstraintTrigger_969024; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_acs_men
    AFTER INSERT OR UPDATE ON acs
    FROM men
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_acs_men', 'acs', 'men', 'UNSPECIFIED', 'acsmenid', 'menid');


--
-- TOC entry 656 (OID 969025)
-- Name: RI_ConstraintTrigger_969025; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_acs_men
    AFTER DELETE ON men
    FROM acs
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_cascade_del"('fk_acs_men', 'acs', 'men', 'UNSPECIFIED', 'acsmenid', 'menid');


--
-- TOC entry 657 (OID 969026)
-- Name: RI_ConstraintTrigger_969026; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_acs_men
    AFTER UPDATE ON men
    FROM acs
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_acs_men', 'acs', 'men', 'UNSPECIFIED', 'acsmenid', 'menid');


--
-- TOC entry 781 (OID 969027)
-- Name: RI_ConstraintTrigger_969027; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_msa_ate
    AFTER INSERT OR UPDATE ON msa
    FROM ate
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_msa_ate', 'msa', 'ate', 'UNSPECIFIED', 'msaateid', 'ateid');


--
-- TOC entry 705 (OID 969028)
-- Name: RI_ConstraintTrigger_969028; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_msa_ate
    AFTER DELETE ON ate
    FROM msa
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_msa_ate', 'msa', 'ate', 'UNSPECIFIED', 'msaateid', 'ateid');


--
-- TOC entry 706 (OID 969029)
-- Name: RI_ConstraintTrigger_969029; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_msa_ate
    AFTER UPDATE ON ate
    FROM msa
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_msa_ate', 'msa', 'ate', 'UNSPECIFIED', 'msaateid', 'ateid');


--
-- TOC entry 741 (OID 969030)
-- Name: RI_ConstraintTrigger_969030; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_tsv_dgn
    AFTER INSERT OR UPDATE ON tsv
    FROM dgn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_tsv_dgn', 'tsv', 'dgn', 'UNSPECIFIED', 'tsvdgnid', 'dgnid');


--
-- TOC entry 716 (OID 969031)
-- Name: RI_ConstraintTrigger_969031; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_tsv_dgn
    AFTER DELETE ON dgn
    FROM tsv
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_tsv_dgn', 'tsv', 'dgn', 'UNSPECIFIED', 'tsvdgnid', 'dgnid');


--
-- TOC entry 717 (OID 969032)
-- Name: RI_ConstraintTrigger_969032; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_tsv_dgn
    AFTER UPDATE ON dgn
    FROM tsv
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_tsv_dgn', 'tsv', 'dgn', 'UNSPECIFIED', 'tsvdgnid', 'dgnid');


--
-- TOC entry 767 (OID 969033)
-- Name: RI_ConstraintTrigger_969033; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_cld_cgr
    AFTER INSERT OR UPDATE ON cld
    FROM cgr
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_cld_cgr', 'cld', 'cgr', 'UNSPECIFIED', 'cldcgrid', 'cgrid');


--
-- TOC entry 763 (OID 969034)
-- Name: RI_ConstraintTrigger_969034; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_cld_cgr
    AFTER DELETE ON cgr
    FROM cld
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_cld_cgr', 'cld', 'cgr', 'UNSPECIFIED', 'cldcgrid', 'cgrid');


--
-- TOC entry 764 (OID 969035)
-- Name: RI_ConstraintTrigger_969035; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_cld_cgr
    AFTER UPDATE ON cgr
    FROM cld
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_cld_cgr', 'cld', 'cgr', 'UNSPECIFIED', 'cldcgrid', 'cgrid');


--
-- TOC entry 778 (OID 969036)
-- Name: RI_ConstraintTrigger_969036; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dap_men
    AFTER INSERT OR UPDATE ON dap
    FROM men
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_dap_men', 'dap', 'men', 'UNSPECIFIED', 'dapmenid', 'menid');


--
-- TOC entry 658 (OID 969037)
-- Name: RI_ConstraintTrigger_969037; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dap_men
    AFTER DELETE ON men
    FROM dap
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_cascade_del"('fk_dap_men', 'dap', 'men', 'UNSPECIFIED', 'dapmenid', 'menid');


--
-- TOC entry 659 (OID 969038)
-- Name: RI_ConstraintTrigger_969038; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dap_men
    AFTER UPDATE ON men
    FROM dap
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_dap_men', 'dap', 'men', 'UNSPECIFIED', 'dapmenid', 'menid');


--
-- TOC entry 685 (OID 969039)
-- Name: RI_ConstraintTrigger_969039; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_und_mun
    AFTER INSERT OR UPDATE ON und
    FROM mun
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_und_mun', 'und', 'mun', 'UNSPECIFIED', 'undmunid', 'munid');


--
-- TOC entry 681 (OID 969040)
-- Name: RI_ConstraintTrigger_969040; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_und_mun
    AFTER DELETE ON mun
    FROM und
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_und_mun', 'und', 'mun', 'UNSPECIFIED', 'undmunid', 'munid');


--
-- TOC entry 682 (OID 969041)
-- Name: RI_ConstraintTrigger_969041; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_und_mun
    AFTER UPDATE ON mun
    FROM und
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_und_mun', 'und', 'mun', 'UNSPECIFIED', 'undmunid', 'munid');


--
-- TOC entry 782 (OID 969042)
-- Name: RI_ConstraintTrigger_969042; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_anc_tam
    AFTER INSERT OR UPDATE ON anc
    FROM tam
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_anc_tam', 'anc', 'tam', 'UNSPECIFIED', 'anctamid', 'tamid');


--
-- TOC entry 827 (OID 969043)
-- Name: RI_ConstraintTrigger_969043; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_anc_tam
    AFTER DELETE ON tam
    FROM anc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_anc_tam', 'anc', 'tam', 'UNSPECIFIED', 'anctamid', 'tamid');


--
-- TOC entry 828 (OID 969044)
-- Name: RI_ConstraintTrigger_969044; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_anc_tam
    AFTER UPDATE ON tam
    FROM anc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_anc_tam', 'anc', 'tam', 'UNSPECIFIED', 'anctamid', 'tamid');


--
-- TOC entry 783 (OID 969045)
-- Name: RI_ConstraintTrigger_969045; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_anc_ctu
    AFTER INSERT OR UPDATE ON anc
    FROM ctu
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_anc_ctu', 'anc', 'ctu', 'UNSPECIFIED', 'ancctuid', 'ctuid');


--
-- TOC entry 790 (OID 969046)
-- Name: RI_ConstraintTrigger_969046; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_anc_ctu
    AFTER DELETE ON ctu
    FROM anc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_cascade_del"('fk_anc_ctu', 'anc', 'ctu', 'UNSPECIFIED', 'ancctuid', 'ctuid');


--
-- TOC entry 791 (OID 969047)
-- Name: RI_ConstraintTrigger_969047; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_anc_ctu
    AFTER UPDATE ON ctu
    FROM anc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_anc_ctu', 'anc', 'ctu', 'UNSPECIFIED', 'ancctuid', 'ctuid');


--
-- TOC entry 792 (OID 969048)
-- Name: RI_ConstraintTrigger_969048; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_ctu_tpc
    AFTER INSERT OR UPDATE ON ctu
    FROM tpc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_ctu_tpc', 'ctu', 'tpc', 'UNSPECIFIED', 'ctutpcid', 'tpcid');


--
-- TOC entry 829 (OID 969049)
-- Name: RI_ConstraintTrigger_969049; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_ctu_tpc
    AFTER DELETE ON tpc
    FROM ctu
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_ctu_tpc', 'ctu', 'tpc', 'UNSPECIFIED', 'ctutpcid', 'tpcid');


--
-- TOC entry 830 (OID 969050)
-- Name: RI_ConstraintTrigger_969050; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_ctu_tpc
    AFTER UPDATE ON tpc
    FROM ctu
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_ctu_tpc', 'ctu', 'tpc', 'UNSPECIFIED', 'ctutpcid', 'tpcid');


--
-- TOC entry 795 (OID 969051)
-- Name: RI_ConstraintTrigger_969051; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dmn_dmn
    AFTER INSERT OR UPDATE ON dmn
    FROM dmn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_dmn_dmn', 'dmn', 'dmn', 'UNSPECIFIED', 'dmndmnid', 'dmnid');


--
-- TOC entry 796 (OID 969052)
-- Name: RI_ConstraintTrigger_969052; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dmn_dmn
    AFTER DELETE ON dmn
    FROM dmn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_dmn_dmn', 'dmn', 'dmn', 'UNSPECIFIED', 'dmndmnid', 'dmnid');


--
-- TOC entry 797 (OID 969053)
-- Name: RI_ConstraintTrigger_969053; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dmn_dmn
    AFTER UPDATE ON dmn
    FROM dmn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_dmn_dmn', 'dmn', 'dmn', 'UNSPECIFIED', 'dmndmnid', 'dmnid');


--
-- TOC entry 798 (OID 969054)
-- Name: RI_ConstraintTrigger_969054; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dmn_scc
    AFTER INSERT OR UPDATE ON dmn
    FROM scc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_dmn_scc', 'dmn', 'scc', 'UNSPECIFIED', 'dmnsccid', 'sccid');


--
-- TOC entry 816 (OID 969055)
-- Name: RI_ConstraintTrigger_969055; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dmn_scc
    AFTER DELETE ON scc
    FROM dmn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_dmn_scc', 'dmn', 'scc', 'UNSPECIFIED', 'dmnsccid', 'sccid');


--
-- TOC entry 817 (OID 969056)
-- Name: RI_ConstraintTrigger_969056; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_dmn_scc
    AFTER UPDATE ON scc
    FROM dmn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_dmn_scc', 'dmn', 'scc', 'UNSPECIFIED', 'dmnsccid', 'sccid');


--
-- TOC entry 805 (OID 969057)
-- Name: RI_ConstraintTrigger_969057; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_lpc_ctu
    AFTER INSERT OR UPDATE ON lpc
    FROM ctu
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_lpc_ctu', 'lpc', 'ctu', 'UNSPECIFIED', 'lpcctuid', 'ctuid');


--
-- TOC entry 793 (OID 969058)
-- Name: RI_ConstraintTrigger_969058; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_lpc_ctu
    AFTER DELETE ON ctu
    FROM lpc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_cascade_del"('fk_lpc_ctu', 'lpc', 'ctu', 'UNSPECIFIED', 'lpcctuid', 'ctuid');


--
-- TOC entry 794 (OID 969059)
-- Name: RI_ConstraintTrigger_969059; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_lpc_ctu
    AFTER UPDATE ON ctu
    FROM lpc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_lpc_ctu', 'lpc', 'ctu', 'UNSPECIFIED', 'lpcctuid', 'ctuid');


--
-- TOC entry 806 (OID 969060)
-- Name: RI_ConstraintTrigger_969060; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_lpc_plc
    AFTER INSERT OR UPDATE ON lpc
    FROM plc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_lpc_plc', 'lpc', 'plc', 'UNSPECIFIED', 'lpcplcid', 'plcid');


--
-- TOC entry 814 (OID 969061)
-- Name: RI_ConstraintTrigger_969061; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_lpc_plc
    AFTER DELETE ON plc
    FROM lpc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_lpc_plc', 'lpc', 'plc', 'UNSPECIFIED', 'lpcplcid', 'plcid');


--
-- TOC entry 815 (OID 969062)
-- Name: RI_ConstraintTrigger_969062; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_lpc_plc
    AFTER UPDATE ON plc
    FROM lpc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_lpc_plc', 'lpc', 'plc', 'UNSPECIFIED', 'lpcplcid', 'plcid');


--
-- TOC entry 807 (OID 969063)
-- Name: RI_ConstraintTrigger_969063; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_mlg_grm
    AFTER INSERT OR UPDATE ON mlg
    FROM grm
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_mlg_grm', 'mlg', 'grm', 'UNSPECIFIED', 'mlggrmid', 'grmid');


--
-- TOC entry 803 (OID 969064)
-- Name: RI_ConstraintTrigger_969064; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_mlg_grm
    AFTER DELETE ON grm
    FROM mlg
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_mlg_grm', 'mlg', 'grm', 'UNSPECIFIED', 'mlggrmid', 'grmid');


--
-- TOC entry 804 (OID 969065)
-- Name: RI_ConstraintTrigger_969065; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_mlg_grm
    AFTER UPDATE ON grm
    FROM mlg
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_mlg_grm', 'mlg', 'grm', 'UNSPECIFIED', 'mlggrmid', 'grmid');


--
-- TOC entry 808 (OID 969066)
-- Name: RI_ConstraintTrigger_969066; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_mop_imp_css
    AFTER INSERT OR UPDATE ON mop
    FROM css
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_mop_imp_css', 'mop', 'css', 'UNSPECIFIED', 'mopcssidimp', 'cssid');


--
-- TOC entry 786 (OID 969067)
-- Name: RI_ConstraintTrigger_969067; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_mop_imp_css
    AFTER DELETE ON css
    FROM mop
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_mop_imp_css', 'mop', 'css', 'UNSPECIFIED', 'mopcssidimp', 'cssid');


--
-- TOC entry 787 (OID 969068)
-- Name: RI_ConstraintTrigger_969068; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_mop_imp_css
    AFTER UPDATE ON css
    FROM mop
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_mop_imp_css', 'mop', 'css', 'UNSPECIFIED', 'mopcssidimp', 'cssid');


--
-- TOC entry 809 (OID 969069)
-- Name: RI_ConstraintTrigger_969069; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_mop_tl_css
    AFTER INSERT OR UPDATE ON mop
    FROM css
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_mop_tl_css', 'mop', 'css', 'UNSPECIFIED', 'mopcssidtl', 'cssid');


--
-- TOC entry 788 (OID 969070)
-- Name: RI_ConstraintTrigger_969070; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_mop_tl_css
    AFTER DELETE ON css
    FROM mop
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_mop_tl_css', 'mop', 'css', 'UNSPECIFIED', 'mopcssidtl', 'cssid');


--
-- TOC entry 789 (OID 969071)
-- Name: RI_ConstraintTrigger_969071; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_mop_tl_css
    AFTER UPDATE ON css
    FROM mop
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_mop_tl_css', 'mop', 'css', 'UNSPECIFIED', 'mopcssidtl', 'cssid');


--
-- TOC entry 818 (OID 969072)
-- Name: RI_ConstraintTrigger_969072; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_dmn
    AFTER INSERT OR UPDATE ON scc
    FROM dmn
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_scc_dmn', 'scc', 'dmn', 'UNSPECIFIED', 'sccdmnid', 'dmnid');


--
-- TOC entry 799 (OID 969073)
-- Name: RI_ConstraintTrigger_969073; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_dmn
    AFTER DELETE ON dmn
    FROM scc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_scc_dmn', 'scc', 'dmn', 'UNSPECIFIED', 'sccdmnid', 'dmnid');


--
-- TOC entry 800 (OID 969074)
-- Name: RI_ConstraintTrigger_969074; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_dmn
    AFTER UPDATE ON dmn
    FROM scc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_scc_dmn', 'scc', 'dmn', 'UNSPECIFIED', 'sccdmnid', 'dmnid');


--
-- TOC entry 819 (OID 969075)
-- Name: RI_ConstraintTrigger_969075; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_env_mop
    AFTER INSERT OR UPDATE ON scc
    FROM mop
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_scc_env_mop', 'scc', 'mop', 'UNSPECIFIED', 'sccmopidenv', 'mopid');


--
-- TOC entry 810 (OID 969076)
-- Name: RI_ConstraintTrigger_969076; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_env_mop
    AFTER DELETE ON mop
    FROM scc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_scc_env_mop', 'scc', 'mop', 'UNSPECIFIED', 'sccmopidenv', 'mopid');


--
-- TOC entry 811 (OID 969077)
-- Name: RI_ConstraintTrigger_969077; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_env_mop
    AFTER UPDATE ON mop
    FROM scc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_scc_env_mop', 'scc', 'mop', 'UNSPECIFIED', 'sccmopidenv', 'mopid');


--
-- TOC entry 820 (OID 969078)
-- Name: RI_ConstraintTrigger_969078; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_scc
    AFTER INSERT OR UPDATE ON scc
    FROM scc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_scc_scc', 'scc', 'scc', 'UNSPECIFIED', 'sccsccid', 'sccid');


--
-- TOC entry 821 (OID 969079)
-- Name: RI_ConstraintTrigger_969079; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_scc
    AFTER DELETE ON scc
    FROM scc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_scc_scc', 'scc', 'scc', 'UNSPECIFIED', 'sccsccid', 'sccid');


--
-- TOC entry 822 (OID 969080)
-- Name: RI_ConstraintTrigger_969080; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_scc
    AFTER UPDATE ON scc
    FROM scc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_scc_scc', 'scc', 'scc', 'UNSPECIFIED', 'sccsccid', 'sccid');


--
-- TOC entry 823 (OID 969081)
-- Name: RI_ConstraintTrigger_969081; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_pfu
    AFTER INSERT OR UPDATE ON scc
    FROM pfu
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_scc_pfu', 'scc', 'pfu', 'UNSPECIFIED', 'sccpfuid', 'pfuid');


--
-- TOC entry 775 (OID 969082)
-- Name: RI_ConstraintTrigger_969082; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_pfu
    AFTER DELETE ON pfu
    FROM scc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_scc_pfu', 'scc', 'pfu', 'UNSPECIFIED', 'sccpfuid', 'pfuid');


--
-- TOC entry 776 (OID 969083)
-- Name: RI_ConstraintTrigger_969083; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_pfu
    AFTER UPDATE ON pfu
    FROM scc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_scc_pfu', 'scc', 'pfu', 'UNSPECIFIED', 'sccpfuid', 'pfuid');


--
-- TOC entry 824 (OID 969084)
-- Name: RI_ConstraintTrigger_969084; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_vis_mop
    AFTER INSERT OR UPDATE ON scc
    FROM mop
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_scc_vis_mop', 'scc', 'mop', 'UNSPECIFIED', 'sccmopidvis', 'mopid');


--
-- TOC entry 812 (OID 969085)
-- Name: RI_ConstraintTrigger_969085; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_vis_mop
    AFTER DELETE ON mop
    FROM scc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_scc_vis_mop', 'scc', 'mop', 'UNSPECIFIED', 'sccmopidvis', 'mopid');


--
-- TOC entry 813 (OID 969086)
-- Name: RI_ConstraintTrigger_969086; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_scc_vis_mop
    AFTER UPDATE ON mop
    FROM scc
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_scc_vis_mop', 'scc', 'mop', 'UNSPECIFIED', 'sccmopidvis', 'mopid');


--
-- TOC entry 686 (OID 969087)
-- Name: RI_ConstraintTrigger_969087; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_und_und
    AFTER INSERT OR UPDATE ON und
    FROM und
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_check_ins"('fk_und_und', 'und', 'und', 'UNSPECIFIED', 'undundidvch', 'undid');


--
-- TOC entry 687 (OID 969088)
-- Name: RI_ConstraintTrigger_969088; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_und_und
    AFTER DELETE ON und
    FROM und
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_del"('fk_und_und', 'und', 'und', 'UNSPECIFIED', 'undundidvch', 'undid');


--
-- TOC entry 688 (OID 969089)
-- Name: RI_ConstraintTrigger_969089; Type: TRIGGER; Schema: public; Owner: root
--

CREATE CONSTRAINT TRIGGER fk_und_und
    AFTER UPDATE ON und
    FROM und
    NOT DEFERRABLE INITIALLY IMMEDIATE
    FOR EACH ROW
    EXECUTE PROCEDURE "RI_FKey_restrict_upd"('fk_und_und', 'und', 'und', 'UNSPECIFIED', 'undundidvch', 'undid');


--
-- TOC entry 707 (OID 969090)
-- Name: tgr_atlz_hist_ate; Type: TRIGGER; Schema: public; Owner: root
--

CREATE TRIGGER tgr_atlz_hist_ate
    AFTER INSERT OR UPDATE ON ate
    FOR EACH ROW
    EXECUTE PROCEDURE atlz_hist_ate();


--
-- TOC entry 831 (OID 969091)
-- Name: tgr_cts_prx_ordem; Type: TRIGGER; Schema: public; Owner: root
--

CREATE TRIGGER tgr_cts_prx_ordem
    AFTER INSERT ON cts
    FOR EACH ROW
    EXECUTE PROCEDURE cts_prx_ordem();


--
-- TOC entry 801 (OID 969092)
-- Name: tgr_dmn_prx_nivel; Type: TRIGGER; Schema: public; Owner: root
--

CREATE TRIGGER tgr_dmn_prx_nivel
    AFTER INSERT ON dmn
    FOR EACH ROW
    EXECUTE PROCEDURE dmn_prx_nivel();


--
-- TOC entry 784 (OID 969093)
-- Name: tgr_anc_prx_ordem; Type: TRIGGER; Schema: public; Owner: root
--

CREATE TRIGGER tgr_anc_prx_ordem
    AFTER INSERT ON anc
    FOR EACH ROW
    EXECUTE PROCEDURE anc_prx_ordem();


--
-- TOC entry 825 (OID 969094)
-- Name: tgr_scc_prx_nivel; Type: TRIGGER; Schema: public; Owner: root
--

CREATE TRIGGER tgr_scc_prx_nivel
    AFTER INSERT ON scc
    FOR EACH ROW
    EXECUTE PROCEDURE scc_prx_nivel();


--
-- TOC entry 3 (OID 2200)
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'Standard public schema';


--
-- TOC entry 20 (OID 962328)
-- Name: TABLE acs; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE acs IS 'Tabelas de acessos aos menus';


--
-- TOC entry 21 (OID 962328)
-- Name: COLUMN acs.acsid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN acs.acsid IS 'Código identificador do acesso';


--
-- TOC entry 22 (OID 962328)
-- Name: COLUMN acs.acsmenid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN acs.acsmenid IS 'Menu de acesso';


--
-- TOC entry 23 (OID 962328)
-- Name: COLUMN acs.acsusrid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN acs.acsusrid IS 'Usuario do acesso';


--
-- TOC entry 24 (OID 962328)
-- Name: COLUMN acs.acsadic; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN acs.acsadic IS 'Permissao para inclusao de resgistros';


--
-- TOC entry 25 (OID 962328)
-- Name: COLUMN acs.acsalt; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN acs.acsalt IS 'Permissao para alteracao de registros';


--
-- TOC entry 26 (OID 962328)
-- Name: COLUMN acs.acsexc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN acs.acsexc IS 'Permissao para exclusao de registros';


--
-- TOC entry 27 (OID 962328)
-- Name: COLUMN acs.acscns; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN acs.acscns IS 'Permissao para consulta/visualizacao de registros';


--
-- TOC entry 29 (OID 962333)
-- Name: TABLE log; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE log IS 'Tabela de Logs de Usuários';


--
-- TOC entry 30 (OID 962333)
-- Name: COLUMN log.logid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN log.logid IS 'Código identificador do Log';


--
-- TOC entry 31 (OID 962333)
-- Name: COLUMN log.logobs; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN log.logobs IS 'Observações de detalhamento do log';


--
-- TOC entry 32 (OID 962333)
-- Name: COLUMN log.logsisid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN log.logsisid IS 'Sistema onde foi registrado o log';


--
-- TOC entry 33 (OID 962333)
-- Name: COLUMN log.logusrid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN log.logusrid IS 'Usuário que efetuou o log';


--
-- TOC entry 34 (OID 962333)
-- Name: COLUMN log.logdthr; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN log.logdthr IS 'Data e hora de incusão do log';


--
-- TOC entry 35 (OID 962333)
-- Name: COLUMN log.logschema; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN log.logschema IS 'Schema da tabela';


--
-- TOC entry 37 (OID 962342)
-- Name: TABLE men; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE men IS 'Tabela de Menus';


--
-- TOC entry 38 (OID 962342)
-- Name: COLUMN men.menid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN men.menid IS 'Codigo do menu';


--
-- TOC entry 39 (OID 962342)
-- Name: COLUMN men.mensisid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN men.mensisid IS 'Sistema a qual pertence o menu';


--
-- TOC entry 40 (OID 962342)
-- Name: COLUMN men.menpai; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN men.menpai IS 'Código do menu pai';


--
-- TOC entry 41 (OID 962342)
-- Name: COLUMN men.menlink; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN men.menlink IS 'Url do script a ser executado';


--
-- TOC entry 42 (OID 962342)
-- Name: COLUMN men.menquadro; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN men.menquadro IS 'Quadro de destino onde o link relacionado será visualizado.';


--
-- TOC entry 43 (OID 962342)
-- Name: COLUMN men.menobs; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN men.menobs IS 'Observações da utilização do item de menu';


--
-- TOC entry 44 (OID 962342)
-- Name: COLUMN men.menordem; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN men.menordem IS 'Ordem de visualização do menu';


--
-- TOC entry 45 (OID 962342)
-- Name: COLUMN men.menopcao; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN men.menopcao IS 'Descrição da opção de menu';


--
-- TOC entry 46 (OID 962342)
-- Name: COLUMN men.menimg; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN men.menimg IS 'Imagem utilizada pelo item de menu';


--
-- TOC entry 48 (OID 962351)
-- Name: TABLE sis; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE sis IS 'Tabela de Sistemas';


--
-- TOC entry 49 (OID 962351)
-- Name: COLUMN sis.sisid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sis.sisid IS 'Codigo do sistema';


--
-- TOC entry 50 (OID 962351)
-- Name: COLUMN sis.sisnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sis.sisnome IS 'Nome do sistema';


--
-- TOC entry 51 (OID 962351)
-- Name: COLUMN sis.sisdesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sis.sisdesc IS 'Descricao do sistema';


--
-- TOC entry 52 (OID 962351)
-- Name: COLUMN sis.sisversao; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sis.sisversao IS 'Versão em que o sistema se encontra';


--
-- TOC entry 53 (OID 962351)
-- Name: COLUMN sis.sisdircls; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sis.sisdircls IS 'Diretório de armazenagem dos scripts do sistema';


--
-- TOC entry 54 (OID 962351)
-- Name: COLUMN sis.sisdirimg; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sis.sisdirimg IS 'Diretório de armazenamento das imagens do sistema';


--
-- TOC entry 55 (OID 962351)
-- Name: COLUMN sis.sismenid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sis.sismenid IS 'Código identificador do menu padrão do sistema';


--
-- TOC entry 56 (OID 962351)
-- Name: COLUMN sis.sissts; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sis.sissts IS 'Situação do sistema';


--
-- TOC entry 57 (OID 962351)
-- Name: COLUMN sis.sissobre; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sis.sissobre IS 'Informações sobre o sistema';


--
-- TOC entry 59 (OID 962360)
-- Name: TABLE usr; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE usr IS 'Tabela de usuários';


--
-- TOC entry 60 (OID 962360)
-- Name: COLUMN usr.usrid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN usr.usrid IS 'Codigo do usuario';


--
-- TOC entry 61 (OID 962360)
-- Name: COLUMN usr.usrsenha; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN usr.usrsenha IS 'Senha do usuário';


--
-- TOC entry 71 (OID 962405)
-- Name: TABLE mun; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE mun IS 'Tabela de municípios';


--
-- TOC entry 72 (OID 962405)
-- Name: COLUMN mun.munid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mun.munid IS 'Código identificador da cidade';


--
-- TOC entry 73 (OID 962405)
-- Name: COLUMN mun.munuf; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mun.munuf IS 'Unidade da federação da cidade';


--
-- TOC entry 74 (OID 962405)
-- Name: COLUMN mun.munnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mun.munnome IS 'Nome da cidade';


--
-- TOC entry 76 (OID 962410)
-- Name: TABLE und; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE und IS 'Tabela de unidades vinculadas do MDA';


--
-- TOC entry 77 (OID 962410)
-- Name: COLUMN und.undid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN und.undid IS 'Código identificador da unidade de trabalho';


--
-- TOC entry 78 (OID 962410)
-- Name: COLUMN und.undnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN und.undnome IS 'Nome da unidade de trabalho';


--
-- TOC entry 79 (OID 962410)
-- Name: COLUMN und.undsigla; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN und.undsigla IS 'Sigla de referência da unidade de trabalho';


--
-- TOC entry 80 (OID 962410)
-- Name: COLUMN und.undresp; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN und.undresp IS 'Responsável pela unidade ministerial';


--
-- TOC entry 81 (OID 962410)
-- Name: COLUMN und.undend; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN und.undend IS 'Edereço da unidade ministerial';


--
-- TOC entry 82 (OID 962410)
-- Name: COLUMN und.undmunid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN und.undmunid IS 'Código identificador da cidade';


--
-- TOC entry 83 (OID 962410)
-- Name: COLUMN und.undundidvch; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN und.undundidvch IS 'Código identificador da unidade liberadora dos vouchers';


--
-- TOC entry 85 (OID 962415)
-- Name: TABLE var; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE var IS 'Tabela de variáveis de ambiente de sistemas';


--
-- TOC entry 86 (OID 962415)
-- Name: COLUMN var.varid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN var.varid IS 'Código identificador da variável';


--
-- TOC entry 87 (OID 962415)
-- Name: COLUMN var.varnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN var.varnome IS 'Nome da variável de ambiente';


--
-- TOC entry 88 (OID 962415)
-- Name: COLUMN var.varvalor; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN var.varvalor IS 'Valor da variável de ambiente';


--
-- TOC entry 89 (OID 962415)
-- Name: COLUMN var.varsisid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN var.varsisid IS 'Código de identificação do sistema';


--
-- TOC entry 90 (OID 962415)
-- Name: COLUMN var.vardesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN var.vardesc IS 'Descrição da finalidade da variável';


--
-- TOC entry 501 (OID 962421)
-- Name: FUNCTION cnf_aval_cmp(); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION cnf_aval_cmp() IS 'Gatilho para atualização dos registros de cumprimento de meta como avaliados no mês de referência';


--
-- TOC entry 92 (OID 962424)
-- Name: TABLE atd; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE atd IS 'Tabela de atendentes';


--
-- TOC entry 93 (OID 962424)
-- Name: COLUMN atd.atdid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN atd.atdid IS 'Código identificador do atendente';


--
-- TOC entry 94 (OID 962424)
-- Name: COLUMN atd.atddvsid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN atd.atddvsid IS 'Código da divisão do atendente';


--
-- TOC entry 95 (OID 962424)
-- Name: COLUMN atd.atdurdid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN atd.atdurdid IS 'Código do usuário da rede';


--
-- TOC entry 97 (OID 962429)
-- Name: TABLE ate; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE ate IS 'Tabela de atendimentos';


--
-- TOC entry 98 (OID 962429)
-- Name: COLUMN ate.ateid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ate.ateid IS 'Número do atendimento';


--
-- TOC entry 99 (OID 962429)
-- Name: COLUMN ate.atedthrab; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ate.atedthrab IS 'Data e hora de abertura do atendimento';


--
-- TOC entry 100 (OID 962429)
-- Name: COLUMN ate.atetipo; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ate.atetipo IS 'Tipo do atendimento (In lock ou Help Desk)';


--
-- TOC entry 101 (OID 962429)
-- Name: COLUMN ate.ateatdid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ate.ateatdid IS 'Código do atendente';


--
-- TOC entry 102 (OID 962429)
-- Name: COLUMN ate.atesatid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ate.atesatid IS 'Código identificador da solicitação de atendimento';


--
-- TOC entry 103 (OID 962429)
-- Name: COLUMN ate.ateobs; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ate.ateobs IS 'Observações do atendimento';


--
-- TOC entry 104 (OID 962429)
-- Name: COLUMN ate.atests; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ate.atests IS 'Status do atendimento';


--
-- TOC entry 105 (OID 962429)
-- Name: COLUMN ate.atedthrfc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ate.atedthrfc IS 'Data e hora de fechamento do atendimento';


--
-- TOC entry 106 (OID 962429)
-- Name: COLUMN ate.atepriori; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ate.atepriori IS 'Define a prioridade do atendimento baseada no diagnóstico detectado';


--
-- TOC entry 108 (OID 962439)
-- Name: TABLE dgn; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE dgn IS 'Tabela de diagnósticos';


--
-- TOC entry 109 (OID 962439)
-- Name: COLUMN dgn.dgnid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dgn.dgnid IS 'Código identificador do diagnóstico';


--
-- TOC entry 110 (OID 962439)
-- Name: COLUMN dgn.dgndesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dgn.dgndesc IS 'Descrição do serviço';


--
-- TOC entry 111 (OID 962439)
-- Name: COLUMN dgn.dgnnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dgn.dgnnome IS 'Nome do diagnóstico';


--
-- TOC entry 112 (OID 962439)
-- Name: COLUMN dgn.dgntsvid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dgn.dgntsvid IS 'Código identificador do tipo de serviço padrão para o diagnóstico';


--
-- TOC entry 113 (OID 962439)
-- Name: COLUMN dgn.dgncldid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dgn.dgncldid IS 'Código identificador da classificação de diagnóstico';


--
-- TOC entry 114 (OID 962439)
-- Name: COLUMN dgn.dgnpriori; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dgn.dgnpriori IS 'Prioridade de resolução do diagnóstico';


--
-- TOC entry 116 (OID 962447)
-- Name: TABLE dvs; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE dvs IS 'Tabela de divisões de atendimento';


--
-- TOC entry 117 (OID 962447)
-- Name: COLUMN dvs.dvsid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dvs.dvsid IS 'Código identificador da divisão de atendimento';


--
-- TOC entry 118 (OID 962447)
-- Name: COLUMN dvs.dvsurdid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dvs.dvsurdid IS 'Código identificador do usuário da rede';


--
-- TOC entry 119 (OID 962447)
-- Name: COLUMN dvs.dvsnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dvs.dvsnome IS 'Nome da divisão de atendimento';


--
-- TOC entry 120 (OID 962447)
-- Name: COLUMN dvs.dvscgrid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dvs.dvscgrid IS 'Código identificador da coordenação geral';


--
-- TOC entry 122 (OID 962452)
-- Name: TABLE hat; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE hat IS 'Tabela de histórico dos atendimentos';


--
-- TOC entry 123 (OID 962452)
-- Name: COLUMN hat.hatid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN hat.hatid IS 'Código identificador do histórico de atendimento';


--
-- TOC entry 124 (OID 962452)
-- Name: COLUMN hat.hatateid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN hat.hatateid IS 'Código identificador do atendimento';


--
-- TOC entry 125 (OID 962452)
-- Name: COLUMN hat.hatatdid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN hat.hatatdid IS 'Código identificador do atendente';


--
-- TOC entry 126 (OID 962452)
-- Name: COLUMN hat.hatsts; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN hat.hatsts IS 'Status do atendimento';


--
-- TOC entry 127 (OID 962452)
-- Name: COLUMN hat.hatobs; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN hat.hatobs IS 'Observações do histórico sobre o atendimento';


--
-- TOC entry 128 (OID 962452)
-- Name: COLUMN hat.hatdthr; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN hat.hatdthr IS 'Data e hora do histórico de atendimento';


--
-- TOC entry 130 (OID 962460)
-- Name: TABLE sat; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE sat IS 'Tabela de solicitações de atendimentos';


--
-- TOC entry 131 (OID 962460)
-- Name: COLUMN sat.satid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sat.satid IS 'Código identificador da solicitação de atendimento';


--
-- TOC entry 132 (OID 962460)
-- Name: COLUMN sat.satdthr; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sat.satdthr IS 'Data e hora da solicitação de atendimento';


--
-- TOC entry 133 (OID 962460)
-- Name: COLUMN sat.satpriori; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sat.satpriori IS 'Prioridade da solicitação de atendimento';


--
-- TOC entry 134 (OID 962460)
-- Name: COLUMN sat.satsts; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sat.satsts IS 'Status da solicitação de atendimento';


--
-- TOC entry 135 (OID 962460)
-- Name: COLUMN sat.satdesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sat.satdesc IS 'Descrição dos problemas para solicitação de atendimento';


--
-- TOC entry 136 (OID 962460)
-- Name: COLUMN sat.saturdid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sat.saturdid IS 'Código do usuário da rede';


--
-- TOC entry 137 (OID 962460)
-- Name: COLUMN sat.satdgnid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sat.satdgnid IS 'Código do diagnóstico';


--
-- TOC entry 139 (OID 962470)
-- Name: TABLE sre; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE sre IS 'Tabela de serviços executados';


--
-- TOC entry 140 (OID 962470)
-- Name: COLUMN sre.sreid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sre.sreid IS 'Código identificador do serviço executado';


--
-- TOC entry 141 (OID 962470)
-- Name: COLUMN sre.sretsvid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sre.sretsvid IS 'Código do serviço executado';


--
-- TOC entry 142 (OID 962470)
-- Name: COLUMN sre.sreateid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sre.sreateid IS 'Número do atendimento';


--
-- TOC entry 143 (OID 962470)
-- Name: COLUMN sre.sreatdid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sre.sreatdid IS 'Código identificador do atendente';


--
-- TOC entry 144 (OID 962470)
-- Name: COLUMN sre.sredesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sre.sredesc IS 'Descrição detalhada do serviço executado';


--
-- TOC entry 145 (OID 962470)
-- Name: COLUMN sre.sredthr; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN sre.sredthr IS 'Data e hora da execução do serviço';


--
-- TOC entry 147 (OID 962478)
-- Name: TABLE tsv; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE tsv IS 'Tabela de tipos de serviço';


--
-- TOC entry 148 (OID 962478)
-- Name: COLUMN tsv.tsvid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN tsv.tsvid IS 'Código identificador do tipo de serviço';


--
-- TOC entry 149 (OID 962478)
-- Name: COLUMN tsv.tsvdgnid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN tsv.tsvdgnid IS 'Código do diagnóstico';


--
-- TOC entry 150 (OID 962478)
-- Name: COLUMN tsv.tsvnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN tsv.tsvnome IS 'Nome do serviço';


--
-- TOC entry 151 (OID 962478)
-- Name: COLUMN tsv.tsvdesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN tsv.tsvdesc IS 'Descrição do serviço';


--
-- TOC entry 153 (OID 962486)
-- Name: TABLE urd; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE urd IS 'Tabela de usuários da rede';


--
-- TOC entry 154 (OID 962486)
-- Name: COLUMN urd.urdid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urdid IS 'Código identificador do usuário da rede';


--
-- TOC entry 155 (OID 962486)
-- Name: COLUMN urd.urdnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urdnome IS 'Nome do usuário da rede';


--
-- TOC entry 156 (OID 962486)
-- Name: COLUMN urd.urdmunid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urdmunid IS 'Código identificador da cidade';


--
-- TOC entry 157 (OID 962486)
-- Name: COLUMN urd.urdundid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urdundid IS 'Código identificador da unidade de trabalho';


--
-- TOC entry 158 (OID 962486)
-- Name: COLUMN urd.urdcargo; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urdcargo IS 'Cargo exercido pelo usuário da rede';


--
-- TOC entry 159 (OID 962486)
-- Name: COLUMN urd.urdramal; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urdramal IS 'Ramal para contato com o usuário da rede';


--
-- TOC entry 160 (OID 962486)
-- Name: COLUMN urd.urdemail; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urdemail IS 'Conta de email do usuário da rede';


--
-- TOC entry 161 (OID 962486)
-- Name: COLUMN urd.urdend; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urdend IS 'Endereço de trabalho do usuário da rede';


--
-- TOC entry 162 (OID 962486)
-- Name: COLUMN urd.urdsexo; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urdsexo IS 'Sexo do usuário da rede';


--
-- TOC entry 163 (OID 962486)
-- Name: COLUMN urd.urdlogin; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urdlogin IS 'Login do usuário na rede';


--
-- TOC entry 164 (OID 962486)
-- Name: COLUMN urd.urddepto; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urddepto IS 'Departamento onde o usuário da rede está lotado';


--
-- TOC entry 165 (OID 962486)
-- Name: COLUMN urd.urdsenha; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urdsenha IS 'Senha do usuário na rede';


--
-- TOC entry 166 (OID 962486)
-- Name: COLUMN urd.urdobs; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urdobs IS 'Observações referentes ao usuário da rede';


--
-- TOC entry 167 (OID 962486)
-- Name: COLUMN urd.urddtinc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urddtinc IS 'Data de inclusão do usuário na rede';


--
-- TOC entry 168 (OID 962486)
-- Name: COLUMN urd.urddtaltsen; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN urd.urddtaltsen IS 'Data da última alteração de senha do usuário de rede';


--
-- TOC entry 503 (OID 962494)
-- Name: FUNCTION atlz_hist_ate(); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION atlz_hist_ate() IS 'Gatilho para arquivo dos históricos do atendimento referente ao seus responsáveis';


--
-- TOC entry 505 (OID 962497)
-- Name: FUNCTION atlz_hist_cev(); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION atlz_hist_cev() IS 'Função para arquivo dos históricos dos status referentes aos convites de eventos e seus responsáveis';


--
-- TOC entry 507 (OID 962498)
-- Name: FUNCTION atlz_hist_dce(); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION atlz_hist_dce() IS 'Função para arquivo dos históricos dos status referentes aos documentos de eventos e seus responsáveis';


--
-- TOC entry 170 (OID 962501)
-- Name: TABLE pas; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE pas IS 'Tabela  de passos para execução do serviço';


--
-- TOC entry 171 (OID 962501)
-- Name: COLUMN pas.pasid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pas.pasid IS 'Código identificador do passo';


--
-- TOC entry 172 (OID 962501)
-- Name: COLUMN pas.pastsvid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pas.pastsvid IS 'Código identificador do tipo de serviço';


--
-- TOC entry 173 (OID 962501)
-- Name: COLUMN pas.pasnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pas.pasnome IS 'Nome do passo';


--
-- TOC entry 174 (OID 962501)
-- Name: COLUMN pas.pasdesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pas.pasdesc IS 'Descrição do passo';


--
-- TOC entry 175 (OID 962501)
-- Name: COLUMN pas.passeq; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pas.passeq IS 'Sequência do passo';


--
-- TOC entry 177 (OID 962509)
-- Name: TABLE pgi; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE pgi IS 'Tabela de páginas iniciais';


--
-- TOC entry 178 (OID 962509)
-- Name: COLUMN pgi.pgiid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pgi.pgiid IS 'Código identificador da página inicial';


--
-- TOC entry 179 (OID 962509)
-- Name: COLUMN pgi.pgisisid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pgi.pgisisid IS 'Código identificador do sistema';


--
-- TOC entry 180 (OID 962509)
-- Name: COLUMN pgi.pgiusrid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pgi.pgiusrid IS 'Código identificador do usuário';


--
-- TOC entry 181 (OID 962509)
-- Name: COLUMN pgi.pgimenid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pgi.pgimenid IS 'Código identificador da opção de menu';


--
-- TOC entry 183 (OID 962514)
-- Name: TABLE msg; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE msg IS 'Tabela de mensagens de erro';


--
-- TOC entry 184 (OID 962514)
-- Name: COLUMN msg.msgid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN msg.msgid IS 'Código identificador da mensagem';


--
-- TOC entry 185 (OID 962514)
-- Name: COLUMN msg.msgtitulo; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN msg.msgtitulo IS 'Título a ser exibido na mensagem';


--
-- TOC entry 186 (OID 962514)
-- Name: COLUMN msg.msgtipo; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN msg.msgtipo IS 'Tipo da mensagem (Advertência, Erro, etc.)';


--
-- TOC entry 187 (OID 962514)
-- Name: COLUMN msg.msgcorpo; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN msg.msgcorpo IS 'Texto a ser exibido na mensagem';


--
-- TOC entry 188 (OID 962514)
-- Name: COLUMN msg.msgorig; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN msg.msgorig IS 'Texto original da mensagem de erro';


--
-- TOC entry 509 (OID 962521)
-- Name: FUNCTION atlz_hist_cmp(); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION atlz_hist_cmp() IS 'Gatilho para arquivo dos históricos de cumprimento de metas referente ao seus responsáveis';


--
-- TOC entry 190 (OID 962524)
-- Name: TABLE cgr; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE cgr IS 'Tabela de Coordenações Gerais';


--
-- TOC entry 191 (OID 962524)
-- Name: COLUMN cgr.cgrid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN cgr.cgrid IS 'Código identificador da coordenação geral';


--
-- TOC entry 192 (OID 962524)
-- Name: COLUMN cgr.cgrurdid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN cgr.cgrurdid IS 'Código identificador do usuário da rede';


--
-- TOC entry 193 (OID 962524)
-- Name: COLUMN cgr.cgrnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN cgr.cgrnome IS 'Nome da coordenação geral';


--
-- TOC entry 194 (OID 962524)
-- Name: COLUMN cgr.cgrsigla; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN cgr.cgrsigla IS 'Sigla da coordenação geral';


--
-- TOC entry 196 (OID 962529)
-- Name: TABLE cld; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE cld IS 'Tabela de classificação de diagnósticos';


--
-- TOC entry 197 (OID 962529)
-- Name: COLUMN cld.cldid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN cld.cldid IS 'Código identificador da classificação de diagnóstico';


--
-- TOC entry 198 (OID 962529)
-- Name: COLUMN cld.cldnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN cld.cldnome IS 'Nome da classificação de diagnósticos';


--
-- TOC entry 199 (OID 962529)
-- Name: COLUMN cld.clddesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN cld.clddesc IS 'Descrição da classificação de diagnósticos';


--
-- TOC entry 200 (OID 962529)
-- Name: COLUMN cld.cldcgrid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN cld.cldcgrid IS 'Código identificador da coordenação geral';


--
-- TOC entry 202 (OID 962537)
-- Name: TABLE pse; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE pse IS 'Tabela de passos executados';


--
-- TOC entry 203 (OID 962537)
-- Name: COLUMN pse.pseid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pse.pseid IS 'Código identificador do passo executado';


--
-- TOC entry 204 (OID 962537)
-- Name: COLUMN pse.psepasid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pse.psepasid IS 'Código identificador do passo';


--
-- TOC entry 205 (OID 962537)
-- Name: COLUMN pse.psesreid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pse.psesreid IS 'Código identificador do serviço executado';


--
-- TOC entry 207 (OID 962542)
-- Name: TABLE pfu; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE pfu IS 'Tabela de perfis de usuário';


--
-- TOC entry 208 (OID 962542)
-- Name: COLUMN pfu.pfuid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pfu.pfuid IS 'Código identificador do perfil de usuário';


--
-- TOC entry 209 (OID 962542)
-- Name: COLUMN pfu.pfusisid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pfu.pfusisid IS 'Codigo do sistema';


--
-- TOC entry 210 (OID 962542)
-- Name: COLUMN pfu.pfunome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pfu.pfunome IS 'Nome do perfil de usuário';


--
-- TOC entry 211 (OID 962542)
-- Name: COLUMN pfu.pfudesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pfu.pfudesc IS 'Descrição do perfil de usuário';


--
-- TOC entry 213 (OID 962550)
-- Name: TABLE dap; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE dap IS 'Tabela de domínio de acesso do perfil';


--
-- TOC entry 214 (OID 962550)
-- Name: COLUMN dap.dapid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dap.dapid IS 'Código identificador do domínio de acesso do perfil';


--
-- TOC entry 215 (OID 962550)
-- Name: COLUMN dap.dappfuid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dap.dappfuid IS 'Código identificador do perfil de usuário';


--
-- TOC entry 216 (OID 962550)
-- Name: COLUMN dap.dapmenid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dap.dapmenid IS 'Codigo do menu';


--
-- TOC entry 218 (OID 962555)
-- Name: TABLE pac; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE pac IS 'Tabela de perfis acessíveis pelo usuário';


--
-- TOC entry 219 (OID 962555)
-- Name: COLUMN pac.pacid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pac.pacid IS 'Código identificador do perfil acessível pelo usuário';


--
-- TOC entry 220 (OID 962555)
-- Name: COLUMN pac.pacusrid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pac.pacusrid IS 'Codigo do usuario';


--
-- TOC entry 221 (OID 962555)
-- Name: COLUMN pac.pacpfuid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN pac.pacpfuid IS 'Código identificador do perfil de usuário';


--
-- TOC entry 223 (OID 962560)
-- Name: TABLE msa; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE msa IS 'Tabela de mensagens de atendimento';


--
-- TOC entry 224 (OID 962560)
-- Name: COLUMN msa.msaid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN msa.msaid IS 'Código identificador da mensagem de atendimento';


--
-- TOC entry 225 (OID 962560)
-- Name: COLUMN msa.msaateid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN msa.msaateid IS 'Número do atendimento';


--
-- TOC entry 226 (OID 962560)
-- Name: COLUMN msa.msacnt; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN msa.msacnt IS 'Conteúdo da mensagem de atendimento';


--
-- TOC entry 227 (OID 962560)
-- Name: COLUMN msa.msaassunto; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN msa.msaassunto IS 'Assunto da mensagem de atendimento';


--
-- TOC entry 228 (OID 962560)
-- Name: COLUMN msa.msadthr; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN msa.msadthr IS 'Data e hora da mensagem de atendimento';


--
-- TOC entry 229 (OID 962560)
-- Name: COLUMN msa.msasts; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN msa.msasts IS 'Situação da mensagem de atendimento';


--
-- TOC entry 230 (OID 962560)
-- Name: COLUMN msa.msaurdidrem; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN msa.msaurdidrem IS 'Código identificador do usuário remetente';


--
-- TOC entry 231 (OID 962560)
-- Name: COLUMN msa.msaurdiddes; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN msa.msaurdiddes IS 'Código identificador do usuário de destino';


--
-- TOC entry 232 (OID 962560)
-- Name: COLUMN msa.msatipo; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN msa.msatipo IS 'Tipo da mensagem de atendimento';


--
-- TOC entry 234 (OID 962570)
-- Name: TABLE anc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE anc IS 'Tabela de anexos de conteúdo';


--
-- TOC entry 235 (OID 962570)
-- Name: COLUMN anc.ancid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN anc.ancid IS 'Código identificador do anexo de conteúdo';


--
-- TOC entry 236 (OID 962570)
-- Name: COLUMN anc.ancctuid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN anc.ancctuid IS 'Código identificador do conteúdo';


--
-- TOC entry 237 (OID 962570)
-- Name: COLUMN anc.anctamid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN anc.anctamid IS 'Código identificador do tipo de arquivo de mídia';


--
-- TOC entry 238 (OID 962570)
-- Name: COLUMN anc.ancarq; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN anc.ancarq IS 'Arquivo anexo de conteúdo';


--
-- TOC entry 239 (OID 962570)
-- Name: COLUMN anc.anclegenda; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN anc.anclegenda IS 'Legenda do anexo de conteúdo';


--
-- TOC entry 240 (OID 962570)
-- Name: COLUMN anc.anccredito; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN anc.anccredito IS 'Crédito do anexo de conteúdo';


--
-- TOC entry 241 (OID 962570)
-- Name: COLUMN anc.ancordem; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN anc.ancordem IS 'Ordem de visualização do anexo de conteúdo';


--
-- TOC entry 242 (OID 962570)
-- Name: COLUMN anc.anctpacss; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN anc.anctpacss IS 'Tipo de acesso ao anexo de conteúdo';


--
-- TOC entry 243 (OID 962570)
-- Name: COLUMN anc.ancprincipal; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN anc.ancprincipal IS 'Flag para setar se o anexo como principal';


--
-- TOC entry 244 (OID 962570)
-- Name: COLUMN anc.anctitulo; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN anc.anctitulo IS 'Título do arquivo anexo de conteúdo';


--
-- TOC entry 246 (OID 962578)
-- Name: TABLE css; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE css IS 'Tabela de estilos';


--
-- TOC entry 247 (OID 962578)
-- Name: COLUMN css.cssid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN css.cssid IS 'Código identificador da folha de estilo';


--
-- TOC entry 248 (OID 962578)
-- Name: COLUMN css.cssnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN css.cssnome IS 'Nome da folha de estilo';


--
-- TOC entry 249 (OID 962578)
-- Name: COLUMN css.cssarq; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN css.cssarq IS 'Arquivo de folha de estilo';


--
-- TOC entry 250 (OID 962578)
-- Name: COLUMN css.cssmidia; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN css.cssmidia IS 'Tipo de midia da folha de estilo';


--
-- TOC entry 251 (OID 962578)
-- Name: COLUMN css.cssdesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN css.cssdesc IS 'Descrição da folha de estilos';


--
-- TOC entry 253 (OID 962587)
-- Name: TABLE ctu; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE ctu IS 'Tabela de conteúdos';


--
-- TOC entry 254 (OID 962587)
-- Name: COLUMN ctu.ctuid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ctu.ctuid IS 'Código identificador do conteúdo';


--
-- TOC entry 255 (OID 962587)
-- Name: COLUMN ctu.ctutpcid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ctu.ctutpcid IS 'Código identificador do tipo de conteúdo';


--
-- TOC entry 256 (OID 962587)
-- Name: COLUMN ctu.ctudthrpub; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ctu.ctudthrpub IS 'Data e hora de publicação do conteúdo';


--
-- TOC entry 257 (OID 962587)
-- Name: COLUMN ctu.ctudthrexp; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ctu.ctudthrexp IS 'Data e hora de expiração do conteúdo';


--
-- TOC entry 258 (OID 962587)
-- Name: COLUMN ctu.ctutitulo; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ctu.ctutitulo IS 'Título ou nome do conteúdo';


--
-- TOC entry 259 (OID 962587)
-- Name: COLUMN ctu.ctuautor; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ctu.ctuautor IS 'Autor do conteúdo';


--
-- TOC entry 260 (OID 962587)
-- Name: COLUMN ctu.cturesumo; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ctu.cturesumo IS 'Resumo ou chamada do conteúdo';


--
-- TOC entry 261 (OID 962587)
-- Name: COLUMN ctu.ctutexto; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ctu.ctutexto IS 'Texto do conteúdo';


--
-- TOC entry 262 (OID 962587)
-- Name: COLUMN ctu.ctutpacss; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ctu.ctutpacss IS 'Tipo de acesso ao conteúdo';


--
-- TOC entry 263 (OID 962587)
-- Name: COLUMN ctu.ctuprpferr; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ctu.ctuprpferr IS 'Propriedade para visualização da barra de ferramentas';


--
-- TOC entry 264 (OID 962587)
-- Name: COLUMN ctu.ctuprprelac; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ctu.ctuprprelac IS 'Propriedade para visualização de conteúdos relacionados';


--
-- TOC entry 265 (OID 962587)
-- Name: COLUMN ctu.ctusts; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ctu.ctusts IS 'Status do conteúdo se ativo ou não';


--
-- TOC entry 266 (OID 962587)
-- Name: COLUMN ctu.ctudthr; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ctu.ctudthr IS 'Data e hora do conteúdo';


--
-- TOC entry 267 (OID 962587)
-- Name: COLUMN ctu.ctudestaque; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ctu.ctudestaque IS 'Campo temporário para identificação do tipo de destaque';


--
-- TOC entry 269 (OID 962596)
-- Name: TABLE dmn; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE dmn IS 'Tabela de domínios';


--
-- TOC entry 270 (OID 962596)
-- Name: COLUMN dmn.dmnid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dmn.dmnid IS 'Código identificador do domínio';


--
-- TOC entry 271 (OID 962596)
-- Name: COLUMN dmn.dmndmnid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dmn.dmndmnid IS 'Código identificador do domínio pai';


--
-- TOC entry 272 (OID 962596)
-- Name: COLUMN dmn.dmnsccid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dmn.dmnsccid IS 'Código identificador da seção de conteúdo principal do domínio';


--
-- TOC entry 273 (OID 962596)
-- Name: COLUMN dmn.dmnnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dmn.dmnnome IS 'Nome do domínio';


--
-- TOC entry 274 (OID 962596)
-- Name: COLUMN dmn.dmndesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dmn.dmndesc IS 'Descrição do domínio';


--
-- TOC entry 275 (OID 962596)
-- Name: COLUMN dmn.dmnurl; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dmn.dmnurl IS 'URL do domínio';


--
-- TOC entry 276 (OID 962596)
-- Name: COLUMN dmn.dmnsts; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dmn.dmnsts IS 'Status do domínio';


--
-- TOC entry 277 (OID 962596)
-- Name: COLUMN dmn.dmnnivel; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dmn.dmnnivel IS 'Nível do domínio na estrutura';


--
-- TOC entry 278 (OID 962596)
-- Name: COLUMN dmn.dmnlocup; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dmn.dmnlocup IS 'Local para upload de arquivos no domínio';


--
-- TOC entry 279 (OID 962596)
-- Name: COLUMN dmn.dmnraiz; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN dmn.dmnraiz IS 'Raiz de diretório do domínio';


--
-- TOC entry 281 (OID 962604)
-- Name: TABLE grm; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE grm IS 'Tabela de grupos de mailling';


--
-- TOC entry 282 (OID 962604)
-- Name: COLUMN grm.grmid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN grm.grmid IS 'Código identificador do grupo de mailling';


--
-- TOC entry 283 (OID 962604)
-- Name: COLUMN grm.grmnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN grm.grmnome IS 'Nome do grupo de mailling';


--
-- TOC entry 284 (OID 962604)
-- Name: COLUMN grm.grmdesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN grm.grmdesc IS 'Descrição do grupo de mailling';


--
-- TOC entry 286 (OID 962612)
-- Name: TABLE lpc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE lpc IS 'Tabela da lista de palavras-chave dos conteúdos';


--
-- TOC entry 287 (OID 962612)
-- Name: COLUMN lpc.lpcid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN lpc.lpcid IS 'Código identificador do item da lista de palavras-chave dos conteúdos';


--
-- TOC entry 288 (OID 962612)
-- Name: COLUMN lpc.lpcctuid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN lpc.lpcctuid IS 'Código identificador do conteúdo';


--
-- TOC entry 289 (OID 962612)
-- Name: COLUMN lpc.lpcplcid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN lpc.lpcplcid IS 'Código identificador da palavra-chave';


--
-- TOC entry 291 (OID 962617)
-- Name: TABLE mlg; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE mlg IS 'Tabela de mailling';


--
-- TOC entry 292 (OID 962617)
-- Name: COLUMN mlg.mlgid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mlg.mlgid IS 'Código identificador do mailling';


--
-- TOC entry 293 (OID 962617)
-- Name: COLUMN mlg.mlggrmid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mlg.mlggrmid IS 'Código identificador do grupo de mailling';


--
-- TOC entry 294 (OID 962617)
-- Name: COLUMN mlg.mlgnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mlg.mlgnome IS 'Nome do contato por email';


--
-- TOC entry 295 (OID 962617)
-- Name: COLUMN mlg.mlgemail; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mlg.mlgemail IS 'Email de contato';


--
-- TOC entry 296 (OID 962617)
-- Name: COLUMN mlg.mlginst; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mlg.mlginst IS 'Instituição do email';


--
-- TOC entry 297 (OID 962617)
-- Name: COLUMN mlg.mlgbol; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mlg.mlgbol IS 'Flag para recebimento do boletim';


--
-- TOC entry 298 (OID 962617)
-- Name: COLUMN mlg.mlgnot; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mlg.mlgnot IS 'Flag para recebimento de notícias';


--
-- TOC entry 300 (OID 962622)
-- Name: TABLE mop; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE mop IS 'Tabela de modelos de página';


--
-- TOC entry 301 (OID 962622)
-- Name: COLUMN mop.mopid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mop.mopid IS 'Código identificador do modelo de página';


--
-- TOC entry 302 (OID 962622)
-- Name: COLUMN mop.mopnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mop.mopnome IS 'Nome do modelo de página';


--
-- TOC entry 303 (OID 962622)
-- Name: COLUMN mop.mopdesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mop.mopdesc IS 'Descrição do modelo de página';


--
-- TOC entry 304 (OID 962622)
-- Name: COLUMN mop.moparq; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mop.moparq IS 'Arquivo do modelo de página';


--
-- TOC entry 305 (OID 962622)
-- Name: COLUMN mop.mopcssidimp; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mop.mopcssidimp IS 'CSS de impressão do modelo de página';


--
-- TOC entry 306 (OID 962622)
-- Name: COLUMN mop.mopcssidtl; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mop.mopcssidtl IS 'CSS de tela do modelo de página';


--
-- TOC entry 307 (OID 962622)
-- Name: COLUMN mop.mopscript; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mop.mopscript IS 'Script de geração da página';


--
-- TOC entry 309 (OID 962630)
-- Name: TABLE plc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE plc IS 'Tabela de palavras-chave';


--
-- TOC entry 310 (OID 962630)
-- Name: COLUMN plc.plcid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN plc.plcid IS 'Código identificador da palavra-chave';


--
-- TOC entry 311 (OID 962630)
-- Name: COLUMN plc.plcdesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN plc.plcdesc IS 'Descrição da palavra-chave';


--
-- TOC entry 313 (OID 962635)
-- Name: TABLE scc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE scc IS 'Tabela de seções de conteúdo';


--
-- TOC entry 314 (OID 962635)
-- Name: COLUMN scc.sccid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN scc.sccid IS 'Código identificador da seção de conteúdo';


--
-- TOC entry 315 (OID 962635)
-- Name: COLUMN scc.sccdmnid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN scc.sccdmnid IS 'Código identificador do domínio';


--
-- TOC entry 316 (OID 962635)
-- Name: COLUMN scc.sccsccid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN scc.sccsccid IS 'Código identificador da seção de conteúdo pai';


--
-- TOC entry 317 (OID 962635)
-- Name: COLUMN scc.sccpfuid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN scc.sccpfuid IS 'Código identificador do perfil de usuário';


--
-- TOC entry 318 (OID 962635)
-- Name: COLUMN scc.sccmopidvis; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN scc.sccmopidvis IS 'Código identificador do modelo de página para visualização';


--
-- TOC entry 319 (OID 962635)
-- Name: COLUMN scc.sccmopidenv; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN scc.sccmopidenv IS 'Código identificador do modelo de página para envio por email';


--
-- TOC entry 320 (OID 962635)
-- Name: COLUMN scc.sccdesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN scc.sccdesc IS 'Descrição da seção de conteúdo';


--
-- TOC entry 321 (OID 962635)
-- Name: COLUMN scc.sccsts; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN scc.sccsts IS 'Status da seção de conteúdo';


--
-- TOC entry 322 (OID 962635)
-- Name: COLUMN scc.sccurl; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN scc.sccurl IS 'Link URL da seção';


--
-- TOC entry 323 (OID 962635)
-- Name: COLUMN scc.scctpcid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN scc.scctpcid IS 'Código identificador do tipo de conteúdo';


--
-- TOC entry 324 (OID 962635)
-- Name: COLUMN scc.sccnivel; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN scc.sccnivel IS 'Nível da seção de conteúdo dentro de seu domínio';


--
-- TOC entry 325 (OID 962635)
-- Name: COLUMN scc.sccframe; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN scc.sccframe IS 'campo para setar nome do frame';


--
-- TOC entry 327 (OID 962643)
-- Name: TABLE tam; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE tam IS 'Tabela de tipos de arquivos de mídia';


--
-- TOC entry 328 (OID 962643)
-- Name: COLUMN tam.tamid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN tam.tamid IS 'Código identificador do tipo de arquivo de mídia';


--
-- TOC entry 329 (OID 962643)
-- Name: COLUMN tam.tamnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN tam.tamnome IS 'Nome do tipo de arquivo de mídia';


--
-- TOC entry 330 (OID 962643)
-- Name: COLUMN tam.tamext; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN tam.tamext IS 'Extensão do tipo de arquivo de mídia';


--
-- TOC entry 331 (OID 962643)
-- Name: COLUMN tam.tamtipo; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN tam.tamtipo IS 'Tipo de arquivo de mídia';


--
-- TOC entry 332 (OID 962643)
-- Name: COLUMN tam.tamdesc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN tam.tamdesc IS 'Descrição do tipo de arquivo de mídia';


--
-- TOC entry 333 (OID 962643)
-- Name: COLUMN tam.tamimg; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN tam.tamimg IS 'Imagem do tipo de arquivo de mídia';


--
-- TOC entry 335 (OID 962652)
-- Name: TABLE tpc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE tpc IS 'Tabela de tipos de conteúdo';


--
-- TOC entry 336 (OID 962652)
-- Name: COLUMN tpc.tpcid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN tpc.tpcid IS 'Código identificador do tipo de conteúdo';


--
-- TOC entry 337 (OID 962652)
-- Name: COLUMN tpc.tpcnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN tpc.tpcnome IS 'Nome do tipo de conteúdo';


--
-- TOC entry 338 (OID 962652)
-- Name: COLUMN tpc.tpcsigla; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN tpc.tpcsigla IS 'Sigla do tipo de conteúdo';


--
-- TOC entry 519 (OID 962655)
-- Name: FUNCTION scc_prx_nivel(); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION scc_prx_nivel() IS 'Gatilho para geração da próxima seção do próximo nível do domínio';


--
-- TOC entry 511 (OID 962666)
-- Name: FUNCTION dce_prx_num(); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION dce_prx_num() IS 'Gatilho para geração do próximo número de protocolo de documentos de convites de eventos';


--
-- TOC entry 340 (OID 962671)
-- Name: TABLE cts; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE cts IS 'Tabela de conteúdo das seções';


--
-- TOC entry 341 (OID 962671)
-- Name: COLUMN cts.ctsid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN cts.ctsid IS 'Código identificador do conteúdo da seção';


--
-- TOC entry 342 (OID 962671)
-- Name: COLUMN cts.ctssccid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN cts.ctssccid IS 'Código identificador da seção de conteúdo';


--
-- TOC entry 343 (OID 962671)
-- Name: COLUMN cts.ctsctuid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN cts.ctsctuid IS 'Código identificador do conteúdo';


--
-- TOC entry 344 (OID 962671)
-- Name: COLUMN cts.ctsmopidvis; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN cts.ctsmopidvis IS 'Código identificador do modelo de página para visualização';


--
-- TOC entry 345 (OID 962671)
-- Name: COLUMN cts.ctsmopidenv; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN cts.ctsmopidenv IS 'Código identificador do modelo de página para envio por email';


--
-- TOC entry 346 (OID 962671)
-- Name: COLUMN cts.ctsordem; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN cts.ctsordem IS 'Ordem do conteúdo na seção';


--
-- TOC entry 348 (OID 962676)
-- Name: TABLE abp; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE abp IS 'Tabela de abrangência de publicação';


--
-- TOC entry 349 (OID 962676)
-- Name: COLUMN abp.abpid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN abp.abpid IS 'Código identificador do acesso à seção de conteúdo';


--
-- TOC entry 350 (OID 962676)
-- Name: COLUMN abp.abpusrid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN abp.abpusrid IS 'Código identificador do usuário';


--
-- TOC entry 351 (OID 962676)
-- Name: COLUMN abp.abpsccid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN abp.abpsccid IS 'Código identificador da seção de conteúdo';


--
-- TOC entry 353 (OID 962681)
-- Name: TABLE bnn; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE bnn IS 'Tabela de banners';


--
-- TOC entry 354 (OID 962681)
-- Name: COLUMN bnn.bnnid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN bnn.bnnid IS 'Código identificador do banner';


--
-- TOC entry 355 (OID 962681)
-- Name: COLUMN bnn.bnndmnid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN bnn.bnndmnid IS 'Código identificador do domínio';


--
-- TOC entry 356 (OID 962681)
-- Name: COLUMN bnn.bnnarq; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN bnn.bnnarq IS 'Nome do arquivo do banner';


--
-- TOC entry 357 (OID 962681)
-- Name: COLUMN bnn.bnnnome; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN bnn.bnnnome IS 'Nome do banner';


--
-- TOC entry 358 (OID 962681)
-- Name: COLUMN bnn.bnnlink; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN bnn.bnnlink IS 'Link de destino do banner';


--
-- TOC entry 359 (OID 962681)
-- Name: COLUMN bnn.bnnsts; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN bnn.bnnsts IS 'Status do banner';


--
-- TOC entry 361 (OID 962686)
-- Name: TABLE bns; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE bns IS 'Tabela de banners da seção';


--
-- TOC entry 362 (OID 962686)
-- Name: COLUMN bns.bnsid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN bns.bnsid IS 'Identificador do banner da seção';


--
-- TOC entry 363 (OID 962686)
-- Name: COLUMN bns.bnsbnnid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN bns.bnsbnnid IS 'Código identificador do banner';


--
-- TOC entry 364 (OID 962686)
-- Name: COLUMN bns.bnssccid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN bns.bnssccid IS 'Código identificador da seção de conteúdo';


--
-- TOC entry 513 (OID 962689)
-- Name: FUNCTION cts_prx_ordem(); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION cts_prx_ordem() IS 'Gatilho para geração da próxima ordem do conteúdo na seção';


--
-- TOC entry 515 (OID 962690)
-- Name: FUNCTION dmn_prx_nivel(); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION dmn_prx_nivel() IS 'Gatilho para geração do próximo nível do domínio';


--
-- TOC entry 517 (OID 962691)
-- Name: FUNCTION anc_prx_ordem(); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION anc_prx_ordem() IS 'Gatilho para geração da próxima ordem do anexo de conteúdo';


--
-- TOC entry 366 (OID 962694)
-- Name: TABLE ppb; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE ppb IS 'Tabela de permissões de publicação';


--
-- TOC entry 367 (OID 962694)
-- Name: COLUMN ppb.ppbid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ppb.ppbid IS 'Código identificador da permissão de publicação';


--
-- TOC entry 368 (OID 962694)
-- Name: COLUMN ppb.ppbtpcid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ppb.ppbtpcid IS 'Código identificador do tipo de conteúdo';


--
-- TOC entry 369 (OID 962694)
-- Name: COLUMN ppb.ppburdidorg; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ppb.ppburdidorg IS 'Código identificador do usuário da rede que está delegando permissão';


--
-- TOC entry 370 (OID 962694)
-- Name: COLUMN ppb.ppburdidrep; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN ppb.ppburdidrep IS 'Código identificador do usuário da rede que representa o usuário original';


--
-- TOC entry 372 (OID 962697)
-- Name: TABLE aju; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE aju IS 'Tabela de ajuda ';


--
-- TOC entry 374 (OID 962704)
-- Name: TABLE mss; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE mss IS 'Tabela de mensagens de sistema';


--
-- TOC entry 375 (OID 962704)
-- Name: COLUMN mss.mssid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mss.mssid IS 'Código identificador da mensagem de atendimento';


--
-- TOC entry 376 (OID 962704)
-- Name: COLUMN mss.msscnt; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mss.msscnt IS 'Conteúdo da mensagem de atendimento';


--
-- TOC entry 377 (OID 962704)
-- Name: COLUMN mss.mssassunto; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mss.mssassunto IS 'Assunto da mensagem de atendimento';


--
-- TOC entry 378 (OID 962704)
-- Name: COLUMN mss.mssdthr; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mss.mssdthr IS 'Data e hora da mensagem de atendimento';


--
-- TOC entry 379 (OID 962704)
-- Name: COLUMN mss.msssts; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mss.msssts IS 'Situação da mensagem de atendimento';


--
-- TOC entry 380 (OID 962704)
-- Name: COLUMN mss.mssurdidrem; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mss.mssurdidrem IS 'Código identificador do usuário remetente';


--
-- TOC entry 381 (OID 962704)
-- Name: COLUMN mss.mssurdiddes; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mss.mssurdiddes IS 'Código identificador do usuário de destino';


--
-- TOC entry 382 (OID 962704)
-- Name: COLUMN mss.msstipo; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mss.msstipo IS 'Tipo da mensagem de atendimento';


--
-- TOC entry 383 (OID 962704)
-- Name: COLUMN mss.mssoid; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN mss.mssoid IS 'Objeto identificador do registro de mensagem';


--
-- TOC entry 708 (OID 969090)
-- Name: TRIGGER tgr_atlz_hist_ate ON ate; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TRIGGER tgr_atlz_hist_ate ON ate IS 'Gatilho para arquivo dos históricos do atendimento referente ao seus responsáveis';


--
-- TOC entry 832 (OID 969091)
-- Name: TRIGGER tgr_cts_prx_ordem ON cts; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TRIGGER tgr_cts_prx_ordem ON cts IS 'Gatilho para geração da próxima ordem do conteúdo na seção';


--
-- TOC entry 802 (OID 969092)
-- Name: TRIGGER tgr_dmn_prx_nivel ON dmn; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TRIGGER tgr_dmn_prx_nivel ON dmn IS 'Gatilho para geração do próximo nível do domínio';


--
-- TOC entry 785 (OID 969093)
-- Name: TRIGGER tgr_anc_prx_ordem ON anc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TRIGGER tgr_anc_prx_ordem ON anc IS 'Gatilho para geração da próxima ordem do anexo de conteúdo';


--
-- TOC entry 826 (OID 969094)
-- Name: TRIGGER tgr_scc_prx_nivel ON scc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TRIGGER tgr_scc_prx_nivel ON scc IS 'Gatilho para geração da próxima seção do próximo nível do domínio';

SELECT pg_catalog.setval('men_menid_seq', ( select max( menid ) from men ), true);

SELECT pg_catalog.setval('sis_sisid_seq', ( select max( sisid ) from sis ), true);

SELECT pg_catalog.setval('mun_munid_seq', ( select max( munid ) from mun ), true);

SELECT pg_catalog.setval('var_varid_seq', ( select max( varid ) from var ), true);

SELECT pg_catalog.setval('msg_msgid_seq', ( select max( msgid ) from msg ), true);

SELECT pg_catalog.setval('pfu_pfuid_seq', ( select max( pfuid ) from pfu ), true);

SELECT pg_catalog.setval('dap_dapid_seq', ( select max( dapid ) from dap ), true);

SELECT pg_catalog.setval('dmn_dmnid_seq', ( select max( dmnid ) from dmn ), true);

SELECT pg_catalog.setval('scc_sccid_seq', ( select max( sccid ) from scc ), true);

SELECT pg_catalog.setval('tam_tamid_seq', ( select max( tamid ) from tam ), true);

SELECT pg_catalog.setval('tpc_tpcid_seq', ( select max( tpcid ) from tpc ), true);

SELECT pg_catalog.setval('css_cssid_seq', ( select max( cssid ) from css ), true);

SELECT pg_catalog.setval('mop_mopid_seq', ( select max( mopid ) from mop ), true);
