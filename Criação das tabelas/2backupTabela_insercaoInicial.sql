--
-- PostgreSQL database cluster dump
--

-- Started on 2023-10-28 22:26:26 -03

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:5TKo1Ge8aZxKnkLljzEobw==$PXSzhkhP7/l1sMh9L5vCHEKTP6TN2d6QkvJYBhB3ikQ=:RXo5Yt90uK47ODTAH1pz+l9rjZU+AUIM0itM/AgxpWQ=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Ubuntu 16.0-1.pgdg20.04+1)
-- Dumped by pg_dump version 16.0 (Ubuntu 16.0-1.pgdg20.04+1)

-- Started on 2023-10-28 22:26:26 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2023-10-28 22:26:27 -03

--
-- PostgreSQL database dump complete
--

--
-- Database "SKYRIM_SBD" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Ubuntu 16.0-1.pgdg20.04+1)
-- Dumped by pg_dump version 16.0 (Ubuntu 16.0-1.pgdg20.04+1)

-- Started on 2023-10-28 22:26:27 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3637 (class 1262 OID 16388)
-- Name: SKYRIM_SBD; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "SKYRIM_SBD" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';


ALTER DATABASE "SKYRIM_SBD" OWNER TO postgres;

\connect "SKYRIM_SBD"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 243 (class 1259 OID 19894)
-- Name: arma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.arma (
    id_arma character(7) NOT NULL,
    nome character(20) NOT NULL,
    valor integer NOT NULL,
    peso double precision,
    tipo_arma character(20),
    "num_mãos" integer,
    custo_stamina integer,
    eqp_status boolean,
    CONSTRAINT arma_custo_stamina_check CHECK ((custo_stamina >= 0)),
    CONSTRAINT "arma_num_mãos_check" CHECK ((("num_mãos" >= 1) AND ("num_mãos" <= 2))),
    CONSTRAINT arma_peso_check CHECK ((peso > (0)::double precision))
);


ALTER TABLE public.arma OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 19726)
-- Name: besta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.besta (
    id_besta character(8) NOT NULL,
    mod_defesa_frio integer,
    mod_defesa_fogo integer,
    mod_defesa_raio integer
);


ALTER TABLE public.besta OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 19883)
-- Name: consumivel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consumivel (
    id_consumivel character(7) NOT NULL,
    nome character(20) NOT NULL,
    valor integer NOT NULL,
    peso double precision,
    tipo_consumivel character(20),
    aumento integer NOT NULL,
    CONSTRAINT consumivel_peso_check CHECK ((peso > (0)::double precision))
);


ALTER TABLE public.consumivel OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 19772)
-- Name: cumpre_missao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cumpre_missao (
    id_missao character(7) NOT NULL,
    id_play_character character(8) NOT NULL,
    status character(20)
);


ALTER TABLE public.cumpre_missao OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 19787)
-- Name: dialogos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dialogos (
    id_dialogo character(7) NOT NULL,
    id_personagem character(8) NOT NULL,
    dialogo character(50),
    missao character(7),
    CONSTRAINT dialogos_id_dialogo_check CHECK (((id_dialogo ~~ 'DIA%'::text) AND ((("substring"((id_dialogo)::text, 4, 4))::integer >= 0) AND (("substring"((id_dialogo)::text, 4, 4))::integer <= 9999)) AND (length(id_dialogo) = 7)))
);


ALTER TABLE public.dialogos OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 19907)
-- Name: encantamento_arma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.encantamento_arma (
    id_encantamento character(8) NOT NULL,
    id_arma character(7),
    elemento character(20) NOT NULL,
    dano integer NOT NULL,
    CONSTRAINT encantamento_arma_id_encantamento_check CHECK (((id_encantamento ~~ 'ENCA%'::text) AND ((("substring"((id_encantamento)::text, 5, 3))::integer >= 0) AND (("substring"((id_encantamento)::text, 5, 3))::integer <= 999)) AND (length(id_encantamento) = 7)))
);


ALTER TABLE public.encantamento_arma OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 19872)
-- Name: encantamento_vestimenta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.encantamento_vestimenta (
    id_encantamento character(7) NOT NULL,
    id_vestimenta character(7) NOT NULL,
    elemento character(20) NOT NULL,
    resistencia integer NOT NULL,
    CONSTRAINT encantamento_vestimenta_id_encantamento_check CHECK (((id_encantamento ~~ 'ENCV%'::text) AND ((("substring"((id_encantamento)::text, 5, 3))::integer >= 0) AND (("substring"((id_encantamento)::text, 5, 3))::integer <= 999)) AND (length(id_encantamento) = 7)))
);


ALTER TABLE public.encantamento_vestimenta OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 19610)
-- Name: especie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.especie (
    id_especie character(7) NOT NULL,
    nome character(20) NOT NULL,
    id_habilidade character(7),
    CONSTRAINT verificar_id_especie CHECK (((id_especie ~~ 'ESPEC%'::text) AND ((("substring"((id_especie)::text, 6, 2))::integer >= 0) AND (("substring"((id_especie)::text, 6, 2))::integer <= 99)) AND (length(id_especie) = 7)))
);


ALTER TABLE public.especie OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 19718)
-- Name: golpes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.golpes (
    id_golpe character(7) NOT NULL,
    nome character(20) NOT NULL,
    dano integer,
    elemento integer,
    CONSTRAINT golpes_dano_check CHECK (((dano >= 0) AND (dano <= 100))),
    CONSTRAINT golpes_elemento_check CHECK (((elemento >= 0) AND (elemento <= 100))),
    CONSTRAINT golpes_id_golpe_check CHECK (((id_golpe ~~ 'STRO%'::text) AND ((("substring"((id_golpe)::text, 5, 3))::integer >= 0) AND (("substring"((id_golpe)::text, 5, 3))::integer <= 999)) AND (length(id_golpe) = 7)))
);


ALTER TABLE public.golpes OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 19736)
-- Name: golpes_besta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.golpes_besta (
    id_golpe character(7) NOT NULL,
    id_besta character(8) NOT NULL
);


ALTER TABLE public.golpes_besta OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 19596)
-- Name: habilidade_especie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.habilidade_especie (
    id_habilidade character(7) NOT NULL,
    nome character(20) NOT NULL,
    mod_vida integer,
    mod_stamina integer,
    mod_mana integer,
    mod_defesa_frio integer,
    mod_defesa_fogo integer,
    mod_defesa_eletr integer,
    CONSTRAINT habilidade_especie_mod_defesa_eletr_check CHECK (((mod_defesa_eletr >= 0) AND (mod_defesa_eletr <= 100))),
    CONSTRAINT habilidade_especie_mod_defesa_fogo_check CHECK (((mod_defesa_fogo >= 0) AND (mod_defesa_fogo <= 100))),
    CONSTRAINT habilidade_especie_mod_defesa_frio_check CHECK (((mod_defesa_frio >= 0) AND (mod_defesa_frio <= 100))),
    CONSTRAINT habilidade_especie_mod_mana_check CHECK (((mod_mana >= 0) AND (mod_mana <= 100))),
    CONSTRAINT habilidade_especie_mod_stamina_check CHECK (((mod_stamina >= 0) AND (mod_stamina <= 100))),
    CONSTRAINT habilidade_especie_mod_vida_check CHECK (((mod_vida >= 0) AND (mod_vida <= 100))),
    CONSTRAINT verificar_id_habilidade CHECK (((id_habilidade ~~ 'HAB%'::text) AND ((("substring"((id_habilidade)::text, 4, 4))::integer >= 0) AND (("substring"((id_habilidade)::text, 4, 4))::integer <= 9999)) AND (length(id_habilidade) = 7)))
);


ALTER TABLE public.habilidade_especie OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 19751)
-- Name: hostilidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hostilidade (
    id_personagem1 character(8) NOT NULL,
    id_personagem2 character(8) NOT NULL,
    hostil boolean
);


ALTER TABLE public.hostilidade OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 19623)
-- Name: humanoide; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.humanoide (
    id_humanoide character(8) NOT NULL,
    eqp_bota boolean,
    eqp_luva boolean,
    "eqp_calça" boolean,
    eqp_colar boolean,
    eqp_peitoral boolean,
    eqp_anel boolean,
    "eqp_cabeça" boolean,
    "mão_esq" boolean,
    "mão_dir" boolean,
    stamina_max integer,
    mana_max integer,
    id_especie character(7),
    CONSTRAINT humanoide_mana_max_check CHECK (((mana_max >= 0) AND (mana_max <= 100))),
    CONSTRAINT humanoide_stamina_max_check CHECK (((stamina_max >= 0) AND (stamina_max <= 100)))
);


ALTER TABLE public.humanoide OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 19845)
-- Name: instancia_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instancia_item (
    id_instancia_item character(8) NOT NULL,
    id_item character(7) NOT NULL,
    tipo_lugar character(30) NOT NULL,
    id_lugar character(7),
    CONSTRAINT instancia_item_id_instancia_item_check CHECK (((id_instancia_item ~~ 'IITEM%'::text) AND ((("substring"((id_instancia_item)::text, 6, 3))::integer >= 0) AND (("substring"((id_instancia_item)::text, 6, 3))::integer <= 999)) AND (length(id_instancia_item) = 7)))
);


ALTER TABLE public.instancia_item OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 19700)
-- Name: instancia_npc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instancia_npc (
    id_instancia_npc character(8) NOT NULL,
    id_npc character(8),
    vida_atual integer,
    mana_atual integer,
    stamina_atual integer,
    id_sala character(7),
    CONSTRAINT instancia_npc_mana_atual_check CHECK (((mana_atual >= 0) AND (mana_atual <= 100))),
    CONSTRAINT instancia_npc_stamina_atual_check CHECK (((stamina_atual >= 0) AND (stamina_atual <= 100))),
    CONSTRAINT instancia_npc_vida_atual_check CHECK (((vida_atual >= 0) AND (vida_atual <= 100)))
);


ALTER TABLE public.instancia_npc OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 19803)
-- Name: inventario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventario (
    id_dono character(8) NOT NULL,
    id_inventario character(7) NOT NULL,
    peso_maximo double precision,
    carteira integer,
    eh_loja boolean,
    CONSTRAINT inventario_id_inventario_check CHECK (((id_inventario ~~ 'INV%'::text) AND ((("substring"((id_inventario)::text, 4, 4))::integer >= 0) AND (("substring"((id_inventario)::text, 4, 4))::integer <= 9999)) AND (length(id_inventario) = 7)))
);


ALTER TABLE public.inventario OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 19537)
-- Name: local; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.local (
    id_local character(7) NOT NULL,
    nome_local character(30) NOT NULL,
    id_regiao character(7),
    CONSTRAINT verificar_id_local CHECK (((id_local ~~ 'LOC%'::text) AND ((("substring"((id_local)::text, 4, 4))::integer >= 0) AND (("substring"((id_local)::text, 4, 4))::integer <= 9999)) AND (length(id_local) = 7)))
);


ALTER TABLE public.local OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 19662)
-- Name: magia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.magia (
    id_magia character(7) NOT NULL,
    elemento character(20) NOT NULL,
    dano integer,
    nivel integer,
    custo_mana integer,
    CONSTRAINT magia_custo_mana_check CHECK (((custo_mana >= 0) AND (custo_mana <= 100))),
    CONSTRAINT magia_dano_check CHECK (((dano >= 0) AND (dano <= 100))),
    CONSTRAINT magia_nivel_check CHECK (((nivel >= 0) AND (nivel <= 100))),
    CONSTRAINT verificar_id_habilidade CHECK (((id_magia ~~ 'MAG%'::text) AND ((("substring"((id_magia)::text, 4, 4))::integer >= 0) AND (("substring"((id_magia)::text, 4, 4))::integer <= 9999)) AND (length(id_magia) = 7)))
);


ALTER TABLE public.magia OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 19671)
-- Name: magia_humanoide; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.magia_humanoide (
    id_humanoide character(8) NOT NULL,
    id_magia character(7) NOT NULL
);


ALTER TABLE public.magia_humanoide OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 19816)
-- Name: missao_matar_npc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.missao_matar_npc (
    id_missao character(7) NOT NULL,
    nome_missao character(20) NOT NULL,
    id_pre_requisito character(7),
    id_instancia_npc character(8),
    vida_atual_instancia integer,
    nivel integer,
    CONSTRAINT missao_matar_npc_nivel_check CHECK (((nivel >= 0) AND (nivel <= 100)))
);


ALTER TABLE public.missao_matar_npc OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 19686)
-- Name: not_play_character; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.not_play_character (
    id_npc character(8) NOT NULL,
    nome character(20) NOT NULL,
    nivel integer,
    xp integer,
    CONSTRAINT not_play_character_nivel_check CHECK (((nivel >= 1) AND (nivel <= 30))),
    CONSTRAINT not_play_character_xp_check CHECK (((xp >= 0) AND (xp <= 100)))
);


ALTER TABLE public.not_play_character OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 19640)
-- Name: play_character; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.play_character (
    id_play_character character(8) NOT NULL,
    nome character(20) NOT NULL,
    nivel integer,
    xp integer,
    vida_atual integer,
    mana_atual integer,
    stamina_atual integer,
    id_sala character(7),
    CONSTRAINT play_character_mana_atual_check CHECK (((mana_atual >= 0) AND (mana_atual <= 100))),
    CONSTRAINT play_character_nivel_check CHECK (((nivel >= 1) AND (nivel <= 30))),
    CONSTRAINT play_character_stamina_atual_check CHECK (((stamina_atual >= 0) AND (stamina_atual <= 100))),
    CONSTRAINT play_character_vida_atual_check CHECK (((vida_atual >= 0) AND (vida_atual <= 100))),
    CONSTRAINT play_character_xp_check CHECK (((xp >= 0) AND (xp <= 100)))
);


ALTER TABLE public.play_character OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 19529)
-- Name: regiao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regiao (
    id_regiao character(7) NOT NULL,
    nome character(30) NOT NULL,
    CONSTRAINT verificar_id_regiao CHECK (((id_regiao ~~ 'REG%'::text) AND ((("substring"((id_regiao)::text, 4, 4))::integer >= 0) AND (("substring"((id_regiao)::text, 4, 4))::integer <= 9999)) AND (length(id_regiao) = 7)))
);


ALTER TABLE public.regiao OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 19550)
-- Name: sala; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sala (
    id_sala character(7) NOT NULL,
    nome_sala character(40) NOT NULL,
    id_local character(7),
    CONSTRAINT verificar_id_sala CHECK (((id_sala ~~ 'ROOM%'::text) AND ((("substring"((id_sala)::text, 5, 3))::integer >= 0) AND (("substring"((id_sala)::text, 5, 3))::integer <= 999)) AND (length(id_sala) = 7)))
);


ALTER TABLE public.sala OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 19839)
-- Name: tipo_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_item (
    id_item character(7) NOT NULL,
    tipo_item character(20) NOT NULL,
    CONSTRAINT tipo_item_id_item_check CHECK (((id_item ~~ 'ITEM%'::text) AND ((("substring"((id_item)::text, 5, 3))::integer >= 0) AND (("substring"((id_item)::text, 5, 3))::integer <= 999)) AND (length(id_item) = 7)))
);


ALTER TABLE public.tipo_item OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 19766)
-- Name: tipo_missao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_missao (
    id_missao character(7) NOT NULL,
    tipo_objetivo character(40),
    obrigatoria boolean,
    CONSTRAINT tipo_missao_id_missao_check CHECK (((id_missao ~~ 'MIS%'::text) AND ((("substring"((id_missao)::text, 4, 4))::integer >= 0) AND (("substring"((id_missao)::text, 4, 4))::integer <= 9999)) AND (length(id_missao) = 7)))
);


ALTER TABLE public.tipo_missao OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 19577)
-- Name: tipo_personagem_historia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_personagem_historia (
    id_personagem character(8) NOT NULL,
    jogavel boolean,
    CONSTRAINT verificar_id_personagem CHECK (((id_personagem ~~ 'CHAR%'::text) AND ((("substring"((id_personagem)::text, 5, 4))::integer >= 0) AND (("substring"((id_personagem)::text, 5, 4))::integer <= 9999)) AND (length(id_personagem) = 8)))
);


ALTER TABLE public.tipo_personagem_historia OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 19861)
-- Name: vestimenta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vestimenta (
    id_vestimenta character(7) NOT NULL,
    nome character(20) NOT NULL,
    valor integer NOT NULL,
    peso double precision,
    tipo_vestimenta character(20) NOT NULL,
    resistencia integer NOT NULL,
    parte_corpo character(20) NOT NULL,
    eqp_status boolean NOT NULL,
    CONSTRAINT vestimenta_peso_check CHECK ((peso > (0)::double precision))
);


ALTER TABLE public.vestimenta OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 19561)
-- Name: viagem_salas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.viagem_salas (
    id_viagem character(7) NOT NULL,
    sala_origem character(7),
    sala_destino character(7),
    CONSTRAINT viagem_salas_id_viagem_check CHECK (((id_viagem ~~ 'V%'::text) AND ((("substring"((id_viagem)::text, 2, 6))::integer >= 0) AND (("substring"((id_viagem)::text, 2, 6))::integer <= 999999)) AND (length(id_viagem) = 7)))
);


ALTER TABLE public.viagem_salas OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 19583)
-- Name: vida_personagem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vida_personagem (
    id_personagem character(8) NOT NULL,
    vida_maxima integer,
    mana_max integer,
    stamina_max integer,
    CONSTRAINT vida_personagem_mana_max_check CHECK (((mana_max >= 0) AND (mana_max <= 100))),
    CONSTRAINT vida_personagem_stamina_max_check CHECK (((stamina_max >= 0) AND (stamina_max <= 100))),
    CONSTRAINT vida_personagem_vida_maxima_check CHECK (((vida_maxima >= 0) AND (vida_maxima <= 100)))
);


ALTER TABLE public.vida_personagem OWNER TO postgres;

--
-- TOC entry 3630 (class 0 OID 19894)
-- Dependencies: 243
-- Data for Name: arma; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.arma (id_arma, nome, valor, peso, tipo_arma, "num_mãos", custo_stamina, eqp_status) FROM stdin;
\.


--
-- TOC entry 3617 (class 0 OID 19726)
-- Dependencies: 230
-- Data for Name: besta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.besta (id_besta, mod_defesa_frio, mod_defesa_fogo, mod_defesa_raio) FROM stdin;
\.


--
-- TOC entry 3629 (class 0 OID 19883)
-- Dependencies: 242
-- Data for Name: consumivel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.consumivel (id_consumivel, nome, valor, peso, tipo_consumivel, aumento) FROM stdin;
\.


--
-- TOC entry 3621 (class 0 OID 19772)
-- Dependencies: 234
-- Data for Name: cumpre_missao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cumpre_missao (id_missao, id_play_character, status) FROM stdin;
\.


--
-- TOC entry 3622 (class 0 OID 19787)
-- Dependencies: 235
-- Data for Name: dialogos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dialogos (id_dialogo, id_personagem, dialogo, missao) FROM stdin;
\.


--
-- TOC entry 3631 (class 0 OID 19907)
-- Dependencies: 244
-- Data for Name: encantamento_arma; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.encantamento_arma (id_encantamento, id_arma, elemento, dano) FROM stdin;
\.


--
-- TOC entry 3628 (class 0 OID 19872)
-- Dependencies: 241
-- Data for Name: encantamento_vestimenta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.encantamento_vestimenta (id_encantamento, id_vestimenta, elemento, resistencia) FROM stdin;
\.


--
-- TOC entry 3609 (class 0 OID 19610)
-- Dependencies: 222
-- Data for Name: especie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.especie (id_especie, nome, id_habilidade) FROM stdin;
\.


--
-- TOC entry 3616 (class 0 OID 19718)
-- Dependencies: 229
-- Data for Name: golpes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.golpes (id_golpe, nome, dano, elemento) FROM stdin;
\.


--
-- TOC entry 3618 (class 0 OID 19736)
-- Dependencies: 231
-- Data for Name: golpes_besta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.golpes_besta (id_golpe, id_besta) FROM stdin;
\.


--
-- TOC entry 3608 (class 0 OID 19596)
-- Dependencies: 221
-- Data for Name: habilidade_especie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.habilidade_especie (id_habilidade, nome, mod_vida, mod_stamina, mod_mana, mod_defesa_frio, mod_defesa_fogo, mod_defesa_eletr) FROM stdin;
\.


--
-- TOC entry 3619 (class 0 OID 19751)
-- Dependencies: 232
-- Data for Name: hostilidade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hostilidade (id_personagem1, id_personagem2, hostil) FROM stdin;
\.


--
-- TOC entry 3610 (class 0 OID 19623)
-- Dependencies: 223
-- Data for Name: humanoide; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.humanoide (id_humanoide, eqp_bota, eqp_luva, "eqp_calça", eqp_colar, eqp_peitoral, eqp_anel, "eqp_cabeça", "mão_esq", "mão_dir", stamina_max, mana_max, id_especie) FROM stdin;
\.


--
-- TOC entry 3626 (class 0 OID 19845)
-- Dependencies: 239
-- Data for Name: instancia_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instancia_item (id_instancia_item, id_item, tipo_lugar, id_lugar) FROM stdin;
\.


--
-- TOC entry 3615 (class 0 OID 19700)
-- Dependencies: 228
-- Data for Name: instancia_npc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instancia_npc (id_instancia_npc, id_npc, vida_atual, mana_atual, stamina_atual, id_sala) FROM stdin;
\.


--
-- TOC entry 3623 (class 0 OID 19803)
-- Dependencies: 236
-- Data for Name: inventario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventario (id_dono, id_inventario, peso_maximo, carteira, eh_loja) FROM stdin;
\.


--
-- TOC entry 3603 (class 0 OID 19537)
-- Dependencies: 216
-- Data for Name: local; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.local (id_local, nome_local, id_regiao) FROM stdin;
LOC0001	Whiterun                      	REG0001
LOC0002	Riverwood                     	REG0001
LOC0003	Whitewatch Tower              	REG0001
LOC0004	Redoran Retreat               	REG0001
LOC0005	Halted Stream Camp            	REG0001
LOC0006	Rorikstead                    	REG0001
LOC0007	Loreius Farm                  	REG0001
LOC0008	Sleeping Tree Camp            	REG0001
LOC0009	Nix Forest                    	REG0002
LOC0010	Hauntalia                     	REG0002
LOC0011	Emberhold                     	REG0002
LOC0012	HavenSand                     	REG0002
LOC0013	Shifting Moon                 	REG0002
LOC0014	Leolei                        	REG0002
LOC0015	Bugass                        	REG0002
LOC0016	Runight                       	REG0002
LOC0017	Riften                        	REG0003
LOC0018	Ivarstead                     	REG0003
LOC0019	Misty Mountains               	REG0003
LOC0020	Whitespring                   	REG0003
LOC0021	Goldenglow Estate             	REG0003
LOC0022	Ragged Flagon                 	REG0003
LOC0023	Shor,s Stone                  	REG0003
LOC0024	Raven Rock                    	REG0003
LOC0025	Solitude                      	REG0004
LOC0026	Haafingar                     	REG0004
LOC0027	Dainty Sload                  	REG0004
LOC0028	Northwatch Keep               	REG0004
LOC0029	Hjaalmarch                    	REG0004
LOC0030	Pinefrost Tower               	REG0004
LOC0031	Broken Oar Grotto             	REG0004
LOC0032	East Empire Company Warehouse 	REG0004
LOC0033	Dragonsreach                  	REG0005
LOC0034	High Hrothgar                 	REG0005
LOC0035	Bleak Falls Barrow            	REG0005
LOC0036	Dragonsreach Balcony          	REG0005
LOC0037	Whiterun Watchtower           	REG0005
LOC0038	Throat of the World           	REG0005
LOC0039	Skyborn Altar                 	REG0005
LOC0040	Mirmulnir,s Roost             	REG0005
\.


--
-- TOC entry 3612 (class 0 OID 19662)
-- Dependencies: 225
-- Data for Name: magia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.magia (id_magia, elemento, dano, nivel, custo_mana) FROM stdin;
\.


--
-- TOC entry 3613 (class 0 OID 19671)
-- Dependencies: 226
-- Data for Name: magia_humanoide; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.magia_humanoide (id_humanoide, id_magia) FROM stdin;
\.


--
-- TOC entry 3624 (class 0 OID 19816)
-- Dependencies: 237
-- Data for Name: missao_matar_npc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.missao_matar_npc (id_missao, nome_missao, id_pre_requisito, id_instancia_npc, vida_atual_instancia, nivel) FROM stdin;
\.


--
-- TOC entry 3614 (class 0 OID 19686)
-- Dependencies: 227
-- Data for Name: not_play_character; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.not_play_character (id_npc, nome, nivel, xp) FROM stdin;
\.


--
-- TOC entry 3611 (class 0 OID 19640)
-- Dependencies: 224
-- Data for Name: play_character; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.play_character (id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, id_sala) FROM stdin;
\.


--
-- TOC entry 3602 (class 0 OID 19529)
-- Dependencies: 215
-- Data for Name: regiao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regiao (id_regiao, nome) FROM stdin;
REG0001	Whiterun Hold                 
REG0002	Falkreath Forest              
REG0003	Riften Marshlands             
REG0004	Solitude Shores               
REG0005	Dragonsreach Plateau          
\.


--
-- TOC entry 3604 (class 0 OID 19550)
-- Dependencies: 217
-- Data for Name: sala; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sala (id_sala, nome_sala, id_local) FROM stdin;
ROOM001	Dragonreach Hall                        	LOC0001
ROOM002	Warmaiden s Smithy                      	LOC0001
ROOM003	Jorrvaskr Mead Hall                     	LOC0001
ROOM004	Temple of Kynareth                      	LOC0001
ROOM005	Riverwood Inn                           	LOC0002
ROOM006	Riverwood Trader                        	LOC0002
ROOM007	Alvor House                             	LOC0002
ROOM008	Gerdur House                            	LOC0002
ROOM009	Whitewatch Tower Top                    	LOC0003
ROOM010	Whitewatch Tower Base                   	LOC0003
ROOM011	Whitewatch Guard Barracks               	LOC0003
ROOM012	Whitewatch Stables                      	LOC0003
ROOM013	Redoran Retreat Main Hall               	LOC0004
ROOM014	Redoran Retreat Bedroom                 	LOC0004
ROOM015	Redoran Retreat Cavern                  	LOC0004
ROOM016	Redoran Retreat Secret Passage          	LOC0004
ROOM017	Halted Stream Camp Cavern               	LOC0005
ROOM018	Halted Stream Camp Longhouse            	LOC0005
ROOM019	Halted Stream Camp Watchtower           	LOC0005
ROOM020	Halted Stream Camp Cave                 	LOC0005
ROOM021	Rorikstead Inn                          	LOC0006
ROOM022	Rorikstead Blacksmith                   	LOC0006
ROOM023	Lemkil House                            	LOC0006
ROOM024	Froki Shack                             	LOC0006
ROOM025	Loreius Farmhouse                       	LOC0007
ROOM026	Loreius Farm Barn                       	LOC0007
ROOM027	Loreius Farm Field                      	LOC0007
ROOM028	Loreius Farm Stable                     	LOC0007
ROOM029	Sleeping Tree Camp Chief Tent           	LOC0008
ROOM030	Sleeping Tree Camp Hunter Tent          	LOC0008
ROOM031	Sleeping Tree Camp Shaman Tent          	LOC0008
ROOM032	Sleeping Tree Camp Firepit              	LOC0008
ROOM033	Nix Forest Grove                        	LOC0009
ROOM034	Hauntalia Clearing                      	LOC0009
ROOM035	Emberhold Glade                         	LOC0009
ROOM036	HavenSand Retreat                       	LOC0009
ROOM037	Hauntalia Altar                         	LOC0010
ROOM038	Emberhold Lodge                         	LOC0010
ROOM039	HavenSand Cliff                         	LOC0010
ROOM040	Shifting Moon Valley                    	LOC0010
ROOM041	Emberhold Cave                          	LOC0011
ROOM042	HavenSand Oasis                         	LOC0011
ROOM043	Shifting Moon Hollow                    	LOC0011
ROOM044	Leolei Grove                            	LOC0011
ROOM045	HavenSand Hideout                       	LOC0012
ROOM046	Shifting Moon Ruins                     	LOC0012
ROOM047	Leolei Cavern                           	LOC0012
ROOM048	Bugass Lair                             	LOC0012
ROOM049	Shifting Moon Cave                      	LOC0013
ROOM050	Leolei Retreat                          	LOC0013
ROOM051	Bugass Nest                             	LOC0013
ROOM052	Runight Grove                           	LOC0013
ROOM053	Leolei Altar                            	LOC0014
ROOM054	Bugass Glade                            	LOC0014
ROOM055	Runight Clearing                        	LOC0014
ROOM056	Riften                                  	LOC0014
ROOM057	Bugass Canyon                           	LOC0015
ROOM058	Runight Waterfall                       	LOC0015
ROOM059	Riverbed Cave                           	LOC0015
ROOM060	Forest Hollow                           	LOC0015
ROOM061	Runight Altar                           	LOC0016
ROOM062	Mossy Glen                              	LOC0016
ROOM063	Thicket Haven                           	LOC0016
ROOM064	Raven Rock Overlook                     	LOC0016
ROOM065	Riften Market                           	LOC0017
ROOM066	Ivarstead Inn                           	LOC0017
ROOM067	Misty Mountains Cave                    	LOC0017
ROOM068	Whitespring Lodge                       	LOC0017
ROOM069	Ivarstead Bridge                        	LOC0018
ROOM070	Misty Mountains Pass                    	LOC0018
ROOM071	Whitespring Falls                       	LOC0018
ROOM072	Goldenglow Cellar                       	LOC0018
ROOM077	Whitespring Mansion                     	LOC0020
ROOM078	Frozen Lake Cottage                     	LOC0020
ROOM079	Goldenglow Manor                        	LOC0020
ROOM080	Snowy Woods Cabin                       	LOC0020
ROOM081	Goldenglow Warehouse                    	LOC0021
ROOM082	Secret Tunnels                          	LOC0021
ROOM083	Goldenglow Cave                         	LOC0021
ROOM084	Luxury Villa                            	LOC0021
ROOM085	Thieves Guild Hideout                   	LOC0022
ROOM086	Black-Briar Meadery                     	LOC0022
ROOM087	Cistern Entrance                        	LOC0022
ROOM088	The Ratway                              	LOC0022
ROOM089	Shors House                             	LOC0023
ROOM090	Stone Quarry                            	LOC0023
ROOM091	Miners Shack                            	LOC0023
ROOM092	Entrance Mine                           	LOC0023
ROOM093	Raven Rock Inn                          	LOC0024
ROOM094	Frostmoon Crag                          	LOC0024
ROOM095	Bloodskal Barrow                        	LOC0024
ROOM096	Ash Spawn Lair                          	LOC0024
ROOM097	Blue Palace                             	LOC0025
ROOM098	Proudspire Manor                        	LOC0025
ROOM099	The Winking Skeever                     	LOC0025
ROOM100	Solitude Sawmill                        	LOC0025
ROOM101	Castle Volkihar                         	LOC0026
ROOM102	Cave of the Abused                      	LOC0026
ROOM103	Broken Oar Grotto                       	LOC0026
ROOM104	Dragon Bridge Lumber Camp               	LOC0026
ROOM105	Dainty Sload                            	LOC0027
ROOM106	Pirate Cove                             	LOC0027
ROOM107	Abandoned Cabin                         	LOC0027
ROOM108	Lost Prospect Mine                      	LOC0027
ROOM109	Northwatch Keep                         	LOC0028
ROOM110	Prisoner Cells                          	LOC0028
ROOM111	Northwatch Keep Balcony                 	LOC0028
ROOM112	Prisoner Quarters                       	LOC0028
ROOM113	Hjaalmarch Stormcloak Camp              	LOC0029
ROOM114	Hjaalmarch Imperial Camp                	LOC0029
ROOM115	Sightless Pit                           	LOC0029
ROOM116	Old Hroldan Inn                         	LOC0029
ROOM117	Pinefrost Tower                         	LOC0030
ROOM118	Bards Leap Summit                       	LOC0030
ROOM119	Fort Hraggstad                          	LOC0030
ROOM120	Ustengrav                               	LOC0030
ROOM121	Broken Oar Grotto                       	LOC0031
ROOM122	Bonechill Passage                       	LOC0031
ROOM123	Hall of Rumination                      	LOC0031
ROOM124	Dormant Centurion                       	LOC0031
ROOM125	East Empire Company Warehouse           	LOC0032
ROOM126	Fort Frostmoth                          	LOC0032
ROOM127	Jolgeirr Barrow                         	LOC0032
ROOM128	Dwarven Ship                            	LOC0032
ROOM129	Dragonsreach Great Porch                	LOC0033
ROOM130	Dragonsreach Jarl,s Quarters            	LOC0033
ROOM131	Dragonsreach Dungeon                    	LOC0033
ROOM132	Dragonsreach Main Hall                  	LOC0033
ROOM133	High Hrothgar Courtyard                 	LOC0034
ROOM134	High Hrothgar Hall of Valor             	LOC0034
ROOM135	High Hrothgar Inner Sanctum             	LOC0034
ROOM136	High Hrothgar Pilgrim,s Trench          	LOC0034
ROOM137	Bleak Falls Barrow Main Chamber         	LOC0035
ROOM138	Bleak Falls Barrow Sanctum              	LOC0035
ROOM139	Bleak Falls Barrow Catacombs            	LOC0035
ROOM140	Bleak Falls Barrow Puzzle Room          	LOC0035
ROOM141	Dragonsreach Balcony Overlook           	LOC0036
ROOM142	Dragonsreach Balcony                    	LOC0036
ROOM143	Whiterun Overlook                       	LOC0036
ROOM144	Balcony Gardens                         	LOC0036
ROOM145	Whiterun Watchtower Interior            	LOC0037
ROOM146	Watchtower Balcony                      	LOC0037
ROOM147	Watchtower Storeroom                    	LOC0037
ROOM148	Watchtower Garrison                     	LOC0037
ROOM149	Throat of the World Summit              	LOC0038
ROOM150	Paarthurnax,s Perch                     	LOC0038
ROOM151	Clear Skies Peak                        	LOC0038
ROOM152	Highwind Summit                         	LOC0038
ROOM153	Skyborn Altar Peak                      	LOC0039
ROOM154	Ancient Sacrificial Chamber             	LOC0039
ROOM155	Altar of the Dragon                     	LOC0039
ROOM156	Alduin,s Portal                         	LOC0039
ROOM157	Mirmulnir,s Roost Cliffs                	LOC0040
ROOM158	Roost Cavern                            	LOC0040
ROOM159	Dragon Roost Perch                      	LOC0040
ROOM160	Shriekwind Bastion                      	LOC0040
\.


--
-- TOC entry 3625 (class 0 OID 19839)
-- Dependencies: 238
-- Data for Name: tipo_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_item (id_item, tipo_item) FROM stdin;
\.


--
-- TOC entry 3620 (class 0 OID 19766)
-- Dependencies: 233
-- Data for Name: tipo_missao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_missao (id_missao, tipo_objetivo, obrigatoria) FROM stdin;
\.


--
-- TOC entry 3606 (class 0 OID 19577)
-- Dependencies: 219
-- Data for Name: tipo_personagem_historia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_personagem_historia (id_personagem, jogavel) FROM stdin;
\.


--
-- TOC entry 3627 (class 0 OID 19861)
-- Dependencies: 240
-- Data for Name: vestimenta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vestimenta (id_vestimenta, nome, valor, peso, tipo_vestimenta, resistencia, parte_corpo, eqp_status) FROM stdin;
\.


--
-- TOC entry 3605 (class 0 OID 19561)
-- Dependencies: 218
-- Data for Name: viagem_salas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.viagem_salas (id_viagem, sala_origem, sala_destino) FROM stdin;
V000001	ROOM001	ROOM002
V000002	ROOM001	ROOM003
V000003	ROOM001	ROOM004
V000004	ROOM002	ROOM003
V000005	ROOM002	ROOM004
V000006	ROOM003	ROOM004
V000007	ROOM002	ROOM005
V000008	ROOM006	ROOM009
V000009	ROOM005	ROOM006
V000010	ROOM005	ROOM007
V000011	ROOM005	ROOM008
V000012	ROOM006	ROOM005
V000013	ROOM006	ROOM007
V000014	ROOM006	ROOM008
V000015	ROOM007	ROOM005
V000016	ROOM007	ROOM006
V000017	ROOM007	ROOM008
V000018	ROOM008	ROOM005
V000019	ROOM008	ROOM006
V000020	ROOM008	ROOM007
V000021	ROOM009	ROOM010
V000022	ROOM010	ROOM009
V000023	ROOM010	ROOM011
V000024	ROOM011	ROOM010
V000025	ROOM011	ROOM012
V000026	ROOM012	ROOM011
V000027	ROOM013	ROOM014
V000028	ROOM014	ROOM013
V000029	ROOM014	ROOM015
V000030	ROOM015	ROOM014
V000031	ROOM015	ROOM016
V000032	ROOM016	ROOM015
V000033	ROOM015	ROOM017
V000034	ROOM016	ROOM017
V000035	ROOM017	ROOM018
V000036	ROOM018	ROOM017
V000037	ROOM018	ROOM019
V000038	ROOM019	ROOM018
V000039	ROOM019	ROOM020
V000040	ROOM020	ROOM019
V000041	ROOM018	ROOM023
V000042	ROOM020	ROOM021
V000043	ROOM021	ROOM022
V000044	ROOM022	ROOM021
V000045	ROOM022	ROOM023
V000046	ROOM023	ROOM022
V000047	ROOM023	ROOM024
V000048	ROOM024	ROOM023
V000049	ROOM022	ROOM027
V000050	ROOM032	ROOM026
V000051	ROOM024	ROOM025
V000052	ROOM025	ROOM026
V000053	ROOM026	ROOM025
V000054	ROOM026	ROOM027
V000055	ROOM027	ROOM026
V000056	ROOM027	ROOM028
V000057	ROOM028	ROOM027
V000058	ROOM028	ROOM029
V000059	ROOM027	ROOM029
V000060	ROOM029	ROOM038
V000061	ROOM030	ROOM037
V000062	ROOM031	ROOM040
V000063	ROOM032	ROOM033
V000064	ROOM029	ROOM030
V000065	ROOM030	ROOM029
V000066	ROOM030	ROOM031
V000067	ROOM031	ROOM030
V000068	ROOM032	ROOM031
V000069	ROOM032	ROOM030
V000070	ROOM033	ROOM034
V000071	ROOM034	ROOM033
V000072	ROOM034	ROOM035
V000073	ROOM035	ROOM034
V000074	ROOM036	ROOM035
V000075	ROOM036	ROOM033
V000076	ROOM037	ROOM038
V000077	ROOM038	ROOM037
V000078	ROOM038	ROOM039
V000079	ROOM039	ROOM038
V000080	ROOM040	ROOM037
V000081	ROOM040	ROOM039
V000082	ROOM041	ROOM042
V000083	ROOM042	ROOM041
V000084	ROOM042	ROOM043
V000085	ROOM043	ROOM042
V000086	ROOM044	ROOM041
V000087	ROOM044	ROOM043
V000088	ROOM045	ROOM046
V000089	ROOM046	ROOM047
V000090	ROOM047	ROOM048
V000091	ROOM049	ROOM050
V000092	ROOM050	ROOM051
V000093	ROOM051	ROOM052
V000094	ROOM053	ROOM054
V000095	ROOM054	ROOM055
V000096	ROOM055	ROOM056
V000097	ROOM057	ROOM058
V000098	ROOM058	ROOM059
V000099	ROOM059	ROOM060
V000100	ROOM061	ROOM062
V000101	ROOM062	ROOM063
V000102	ROOM063	ROOM064
V000103	ROOM065	ROOM066
V000104	ROOM066	ROOM067
V000105	ROOM067	ROOM068
V000106	ROOM069	ROOM070
V000107	ROOM070	ROOM071
V000108	ROOM071	ROOM072
V000109	ROOM077	ROOM078
V000110	ROOM078	ROOM079
V000111	ROOM079	ROOM080
V000112	ROOM081	ROOM082
V000113	ROOM082	ROOM083
V000114	ROOM083	ROOM084
V000115	ROOM085	ROOM086
V000116	ROOM086	ROOM087
V000117	ROOM087	ROOM088
V000118	ROOM089	ROOM090
V000119	ROOM090	ROOM091
V000120	ROOM091	ROOM092
V000121	ROOM093	ROOM094
V000122	ROOM094	ROOM095
V000123	ROOM095	ROOM096
V000124	ROOM097	ROOM098
V000125	ROOM098	ROOM099
V000126	ROOM099	ROOM100
V000127	ROOM101	ROOM102
V000128	ROOM102	ROOM103
V000129	ROOM103	ROOM104
V000130	ROOM105	ROOM106
V000131	ROOM106	ROOM107
V000132	ROOM107	ROOM108
V000133	ROOM109	ROOM110
V000134	ROOM110	ROOM111
V000135	ROOM111	ROOM112
V000136	ROOM113	ROOM114
V000137	ROOM114	ROOM115
V000138	ROOM115	ROOM116
V000139	ROOM117	ROOM118
V000140	ROOM118	ROOM119
V000141	ROOM119	ROOM120
V000142	ROOM064	ROOM065
V000143	ROOM065	ROOM045
V000144	ROOM046	ROOM057
V000145	ROOM060	ROOM066
V000146	ROOM068	ROOM077
V000147	ROOM071	ROOM079
V000148	ROOM084	ROOM085
V000149	ROOM104	ROOM105
V000150	ROOM120	ROOM064
V000151	ROOM121	ROOM122
V000152	ROOM121	ROOM123
V000153	ROOM122	ROOM121
V000154	ROOM122	ROOM123
V000155	ROOM122	ROOM124
V000156	ROOM123	ROOM121
V000157	ROOM123	ROOM122
V000158	ROOM123	ROOM124
V000159	ROOM124	ROOM122
V000160	ROOM124	ROOM123
V000161	ROOM125	ROOM126
V000162	ROOM125	ROOM127
V000163	ROOM126	ROOM125
V000164	ROOM126	ROOM127
V000165	ROOM126	ROOM128
V000166	ROOM127	ROOM125
V000167	ROOM127	ROOM126
V000168	ROOM127	ROOM128
V000169	ROOM128	ROOM126
V000170	ROOM128	ROOM127
V000171	ROOM129	ROOM130
V000172	ROOM129	ROOM131
V000173	ROOM130	ROOM129
V000174	ROOM130	ROOM131
V000175	ROOM130	ROOM132
V000176	ROOM131	ROOM129
V000177	ROOM131	ROOM130
V000178	ROOM131	ROOM132
V000179	ROOM132	ROOM130
V000180	ROOM132	ROOM131
V000181	ROOM133	ROOM134
V000182	ROOM133	ROOM135
V000183	ROOM134	ROOM133
V000184	ROOM134	ROOM135
V000185	ROOM134	ROOM136
V000186	ROOM135	ROOM133
V000187	ROOM135	ROOM134
V000188	ROOM135	ROOM136
V000189	ROOM136	ROOM134
V000190	ROOM136	ROOM135
V000191	ROOM137	ROOM138
V000192	ROOM137	ROOM139
V000193	ROOM138	ROOM137
V000194	ROOM138	ROOM139
V000195	ROOM138	ROOM140
V000196	ROOM139	ROOM137
V000197	ROOM139	ROOM138
V000198	ROOM139	ROOM140
V000199	ROOM140	ROOM138
V000200	ROOM140	ROOM139
V000201	ROOM140	ROOM138
V000202	ROOM140	ROOM139
V000203	ROOM141	ROOM142
V000204	ROOM141	ROOM143
V000205	ROOM142	ROOM141
V000206	ROOM142	ROOM143
V000207	ROOM142	ROOM144
V000208	ROOM143	ROOM141
V000209	ROOM143	ROOM142
V000210	ROOM143	ROOM144
V000211	ROOM144	ROOM142
V000212	ROOM144	ROOM143
V000213	ROOM145	ROOM146
V000214	ROOM145	ROOM147
V000215	ROOM146	ROOM145
V000216	ROOM146	ROOM147
V000217	ROOM146	ROOM148
V000218	ROOM147	ROOM145
V000219	ROOM147	ROOM146
V000220	ROOM147	ROOM148
V000221	ROOM148	ROOM146
V000222	ROOM148	ROOM147
V000223	ROOM149	ROOM150
V000224	ROOM149	ROOM151
V000225	ROOM150	ROOM149
V000226	ROOM150	ROOM151
V000227	ROOM150	ROOM152
V000228	ROOM151	ROOM149
V000229	ROOM151	ROOM150
V000230	ROOM151	ROOM152
V000231	ROOM152	ROOM150
V000232	ROOM152	ROOM151
V000233	ROOM153	ROOM154
V000234	ROOM153	ROOM155
V000235	ROOM154	ROOM153
V000236	ROOM154	ROOM155
V000237	ROOM154	ROOM156
V000238	ROOM155	ROOM153
V000239	ROOM155	ROOM154
V000240	ROOM155	ROOM156
V000241	ROOM156	ROOM154
V000242	ROOM156	ROOM155
V000243	ROOM157	ROOM158
V000244	ROOM157	ROOM159
V000245	ROOM158	ROOM157
V000246	ROOM158	ROOM159
V000247	ROOM158	ROOM160
V000248	ROOM159	ROOM157
V000249	ROOM159	ROOM158
V000250	ROOM159	ROOM160
V000251	ROOM160	ROOM159
\.


--
-- TOC entry 3607 (class 0 OID 19583)
-- Dependencies: 220
-- Data for Name: vida_personagem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vida_personagem (id_personagem, vida_maxima, mana_max, stamina_max) FROM stdin;
\.


--
-- TOC entry 3421 (class 2606 OID 19901)
-- Name: arma arma_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arma
    ADD CONSTRAINT arma_pkey PRIMARY KEY (id_arma);


--
-- TOC entry 3391 (class 2606 OID 19730)
-- Name: besta besta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.besta
    ADD CONSTRAINT besta_pkey PRIMARY KEY (id_besta);


--
-- TOC entry 3419 (class 2606 OID 19888)
-- Name: consumivel consumivel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consumivel
    ADD CONSTRAINT consumivel_pkey PRIMARY KEY (id_consumivel);


--
-- TOC entry 3399 (class 2606 OID 19776)
-- Name: cumpre_missao cumpre_missao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cumpre_missao
    ADD CONSTRAINT cumpre_missao_pkey PRIMARY KEY (id_missao, id_play_character);


--
-- TOC entry 3401 (class 2606 OID 19792)
-- Name: dialogos dialogos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dialogos
    ADD CONSTRAINT dialogos_pkey PRIMARY KEY (id_dialogo, id_personagem);


--
-- TOC entry 3423 (class 2606 OID 19912)
-- Name: encantamento_arma encantamento_arma_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encantamento_arma
    ADD CONSTRAINT encantamento_arma_pkey PRIMARY KEY (id_encantamento);


--
-- TOC entry 3417 (class 2606 OID 19877)
-- Name: encantamento_vestimenta encantamento_vestimenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encantamento_vestimenta
    ADD CONSTRAINT encantamento_vestimenta_pkey PRIMARY KEY (id_encantamento);


--
-- TOC entry 3369 (class 2606 OID 19617)
-- Name: especie especie_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especie
    ADD CONSTRAINT especie_nome_key UNIQUE (nome);


--
-- TOC entry 3371 (class 2606 OID 19615)
-- Name: especie especie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especie
    ADD CONSTRAINT especie_pkey PRIMARY KEY (id_especie);


--
-- TOC entry 3393 (class 2606 OID 19740)
-- Name: golpes_besta golpes_besta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.golpes_besta
    ADD CONSTRAINT golpes_besta_pkey PRIMARY KEY (id_golpe, id_besta);


--
-- TOC entry 3389 (class 2606 OID 19725)
-- Name: golpes golpes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.golpes
    ADD CONSTRAINT golpes_pkey PRIMARY KEY (id_golpe);


--
-- TOC entry 3365 (class 2606 OID 19609)
-- Name: habilidade_especie habilidade_especie_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habilidade_especie
    ADD CONSTRAINT habilidade_especie_nome_key UNIQUE (nome);


--
-- TOC entry 3367 (class 2606 OID 19607)
-- Name: habilidade_especie habilidade_especie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habilidade_especie
    ADD CONSTRAINT habilidade_especie_pkey PRIMARY KEY (id_habilidade);


--
-- TOC entry 3395 (class 2606 OID 19755)
-- Name: hostilidade hostilidade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hostilidade
    ADD CONSTRAINT hostilidade_pkey PRIMARY KEY (id_personagem1, id_personagem2);


--
-- TOC entry 3373 (class 2606 OID 19629)
-- Name: humanoide humanoide_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.humanoide
    ADD CONSTRAINT humanoide_pkey PRIMARY KEY (id_humanoide);


--
-- TOC entry 3413 (class 2606 OID 19850)
-- Name: instancia_item instancia_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instancia_item
    ADD CONSTRAINT instancia_item_pkey PRIMARY KEY (id_instancia_item, id_item);


--
-- TOC entry 3387 (class 2606 OID 19707)
-- Name: instancia_npc instancia_npc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instancia_npc
    ADD CONSTRAINT instancia_npc_pkey PRIMARY KEY (id_instancia_npc);


--
-- TOC entry 3403 (class 2606 OID 19810)
-- Name: inventario inventario_id_dono_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_id_dono_key UNIQUE (id_dono);


--
-- TOC entry 3405 (class 2606 OID 19808)
-- Name: inventario inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (id_inventario);


--
-- TOC entry 3353 (class 2606 OID 19544)
-- Name: local local_nome_local_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.local
    ADD CONSTRAINT local_nome_local_key UNIQUE (nome_local);


--
-- TOC entry 3355 (class 2606 OID 19542)
-- Name: local local_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.local
    ADD CONSTRAINT local_pkey PRIMARY KEY (id_local);


--
-- TOC entry 3381 (class 2606 OID 19675)
-- Name: magia_humanoide magia_humanoide_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.magia_humanoide
    ADD CONSTRAINT magia_humanoide_pkey PRIMARY KEY (id_humanoide, id_magia);


--
-- TOC entry 3379 (class 2606 OID 19670)
-- Name: magia magia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.magia
    ADD CONSTRAINT magia_pkey PRIMARY KEY (id_magia);


--
-- TOC entry 3407 (class 2606 OID 19823)
-- Name: missao_matar_npc missao_matar_npc_nome_missao_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missao_matar_npc
    ADD CONSTRAINT missao_matar_npc_nome_missao_key UNIQUE (nome_missao);


--
-- TOC entry 3409 (class 2606 OID 19821)
-- Name: missao_matar_npc missao_matar_npc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missao_matar_npc
    ADD CONSTRAINT missao_matar_npc_pkey PRIMARY KEY (id_missao);


--
-- TOC entry 3383 (class 2606 OID 19694)
-- Name: not_play_character not_play_character_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.not_play_character
    ADD CONSTRAINT not_play_character_nome_key UNIQUE (nome);


--
-- TOC entry 3385 (class 2606 OID 19692)
-- Name: not_play_character not_play_character_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.not_play_character
    ADD CONSTRAINT not_play_character_pkey PRIMARY KEY (id_npc);


--
-- TOC entry 3375 (class 2606 OID 19651)
-- Name: play_character play_character_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.play_character
    ADD CONSTRAINT play_character_nome_key UNIQUE (nome);


--
-- TOC entry 3377 (class 2606 OID 19649)
-- Name: play_character play_character_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.play_character
    ADD CONSTRAINT play_character_pkey PRIMARY KEY (id_play_character);


--
-- TOC entry 3349 (class 2606 OID 19536)
-- Name: regiao regiao_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiao
    ADD CONSTRAINT regiao_nome_key UNIQUE (nome);


--
-- TOC entry 3351 (class 2606 OID 19534)
-- Name: regiao regiao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regiao
    ADD CONSTRAINT regiao_pkey PRIMARY KEY (id_regiao);


--
-- TOC entry 3357 (class 2606 OID 19555)
-- Name: sala sala_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sala
    ADD CONSTRAINT sala_pkey PRIMARY KEY (id_sala);


--
-- TOC entry 3411 (class 2606 OID 19844)
-- Name: tipo_item tipo_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_item
    ADD CONSTRAINT tipo_item_pkey PRIMARY KEY (id_item);


--
-- TOC entry 3397 (class 2606 OID 19771)
-- Name: tipo_missao tipo_missao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_missao
    ADD CONSTRAINT tipo_missao_pkey PRIMARY KEY (id_missao);


--
-- TOC entry 3361 (class 2606 OID 19582)
-- Name: tipo_personagem_historia tipo_personagem_historia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_personagem_historia
    ADD CONSTRAINT tipo_personagem_historia_pkey PRIMARY KEY (id_personagem);


--
-- TOC entry 3415 (class 2606 OID 19866)
-- Name: vestimenta vestimenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vestimenta
    ADD CONSTRAINT vestimenta_pkey PRIMARY KEY (id_vestimenta);


--
-- TOC entry 3359 (class 2606 OID 19566)
-- Name: viagem_salas viagem_salas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viagem_salas
    ADD CONSTRAINT viagem_salas_pkey PRIMARY KEY (id_viagem);


--
-- TOC entry 3363 (class 2606 OID 19590)
-- Name: vida_personagem vida_personagem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vida_personagem
    ADD CONSTRAINT vida_personagem_pkey PRIMARY KEY (id_personagem);


--
-- TOC entry 3439 (class 2606 OID 19731)
-- Name: besta besta_id_besta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.besta
    ADD CONSTRAINT besta_id_besta_fkey FOREIGN KEY (id_besta) REFERENCES public.tipo_personagem_historia(id_personagem) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3444 (class 2606 OID 19777)
-- Name: cumpre_missao cumpre_missao_id_missao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cumpre_missao
    ADD CONSTRAINT cumpre_missao_id_missao_fkey FOREIGN KEY (id_missao) REFERENCES public.tipo_missao(id_missao) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3445 (class 2606 OID 19782)
-- Name: cumpre_missao cumpre_missao_id_play_character_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cumpre_missao
    ADD CONSTRAINT cumpre_missao_id_play_character_fkey FOREIGN KEY (id_play_character) REFERENCES public.play_character(id_play_character) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3446 (class 2606 OID 19793)
-- Name: dialogos dialogos_id_personagem_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dialogos
    ADD CONSTRAINT dialogos_id_personagem_fkey FOREIGN KEY (id_personagem) REFERENCES public.tipo_personagem_historia(id_personagem) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3447 (class 2606 OID 19798)
-- Name: dialogos dialogos_missao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dialogos
    ADD CONSTRAINT dialogos_missao_fkey FOREIGN KEY (missao) REFERENCES public.tipo_missao(id_missao) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3448 (class 2606 OID 19811)
-- Name: inventario fk_dono; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT fk_dono FOREIGN KEY (id_dono) REFERENCES public.tipo_personagem_historia(id_personagem) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3458 (class 2606 OID 19913)
-- Name: encantamento_arma fk_id_arma; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encantamento_arma
    ADD CONSTRAINT fk_id_arma FOREIGN KEY (id_arma) REFERENCES public.arma(id_arma) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3430 (class 2606 OID 19635)
-- Name: humanoide fk_id_especie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.humanoide
    ADD CONSTRAINT fk_id_especie FOREIGN KEY (id_especie) REFERENCES public.especie(id_especie) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3429 (class 2606 OID 19618)
-- Name: especie fk_id_habilidade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especie
    ADD CONSTRAINT fk_id_habilidade FOREIGN KEY (id_habilidade) REFERENCES public.habilidade_especie(id_habilidade) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3431 (class 2606 OID 19630)
-- Name: humanoide fk_id_humanoide; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.humanoide
    ADD CONSTRAINT fk_id_humanoide FOREIGN KEY (id_humanoide) REFERENCES public.tipo_personagem_historia(id_personagem) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3428 (class 2606 OID 19591)
-- Name: vida_personagem fk_id_id_personagem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vida_personagem
    ADD CONSTRAINT fk_id_id_personagem FOREIGN KEY (id_personagem) REFERENCES public.tipo_personagem_historia(id_personagem) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3449 (class 2606 OID 19834)
-- Name: missao_matar_npc fk_id_instancia_npc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missao_matar_npc
    ADD CONSTRAINT fk_id_instancia_npc FOREIGN KEY (id_instancia_npc) REFERENCES public.instancia_npc(id_instancia_npc) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3452 (class 2606 OID 19851)
-- Name: instancia_item fk_id_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instancia_item
    ADD CONSTRAINT fk_id_item FOREIGN KEY (id_item) REFERENCES public.tipo_item(id_item) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3456 (class 2606 OID 19889)
-- Name: consumivel fk_id_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consumivel
    ADD CONSTRAINT fk_id_item FOREIGN KEY (id_consumivel) REFERENCES public.tipo_item(id_item) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3457 (class 2606 OID 19902)
-- Name: arma fk_id_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arma
    ADD CONSTRAINT fk_id_item FOREIGN KEY (id_arma) REFERENCES public.tipo_item(id_item) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3424 (class 2606 OID 19545)
-- Name: local fk_id_local; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.local
    ADD CONSTRAINT fk_id_local FOREIGN KEY (id_regiao) REFERENCES public.regiao(id_regiao) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3453 (class 2606 OID 19856)
-- Name: instancia_item fk_id_lugar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instancia_item
    ADD CONSTRAINT fk_id_lugar FOREIGN KEY (id_lugar) REFERENCES public.inventario(id_inventario) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3450 (class 2606 OID 19824)
-- Name: missao_matar_npc fk_id_missao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missao_matar_npc
    ADD CONSTRAINT fk_id_missao FOREIGN KEY (id_missao) REFERENCES public.tipo_missao(id_missao) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3436 (class 2606 OID 19695)
-- Name: not_play_character fk_id_npc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.not_play_character
    ADD CONSTRAINT fk_id_npc FOREIGN KEY (id_npc) REFERENCES public.tipo_personagem_historia(id_personagem) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3437 (class 2606 OID 19708)
-- Name: instancia_npc fk_id_npc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instancia_npc
    ADD CONSTRAINT fk_id_npc FOREIGN KEY (id_npc) REFERENCES public.not_play_character(id_npc) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3432 (class 2606 OID 19652)
-- Name: play_character fk_id_play_character; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.play_character
    ADD CONSTRAINT fk_id_play_character FOREIGN KEY (id_play_character) REFERENCES public.tipo_personagem_historia(id_personagem) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3451 (class 2606 OID 19829)
-- Name: missao_matar_npc fk_id_pre_requisito; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missao_matar_npc
    ADD CONSTRAINT fk_id_pre_requisito FOREIGN KEY (id_pre_requisito) REFERENCES public.tipo_missao(id_missao) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3425 (class 2606 OID 19556)
-- Name: sala fk_id_sala; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sala
    ADD CONSTRAINT fk_id_sala FOREIGN KEY (id_local) REFERENCES public.local(id_local) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3433 (class 2606 OID 19657)
-- Name: play_character fk_id_sala; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.play_character
    ADD CONSTRAINT fk_id_sala FOREIGN KEY (id_sala) REFERENCES public.sala(id_sala) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3438 (class 2606 OID 19713)
-- Name: instancia_npc fk_id_sala; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instancia_npc
    ADD CONSTRAINT fk_id_sala FOREIGN KEY (id_sala) REFERENCES public.sala(id_sala) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3454 (class 2606 OID 19867)
-- Name: vestimenta fk_id_vestimenta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vestimenta
    ADD CONSTRAINT fk_id_vestimenta FOREIGN KEY (id_vestimenta) REFERENCES public.tipo_item(id_item) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3455 (class 2606 OID 19878)
-- Name: encantamento_vestimenta fk_id_vestimenta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encantamento_vestimenta
    ADD CONSTRAINT fk_id_vestimenta FOREIGN KEY (id_vestimenta) REFERENCES public.vestimenta(id_vestimenta) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3426 (class 2606 OID 19572)
-- Name: viagem_salas fk_sala_destino; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viagem_salas
    ADD CONSTRAINT fk_sala_destino FOREIGN KEY (sala_destino) REFERENCES public.sala(id_sala) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3427 (class 2606 OID 19567)
-- Name: viagem_salas fk_sala_origem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.viagem_salas
    ADD CONSTRAINT fk_sala_origem FOREIGN KEY (sala_origem) REFERENCES public.sala(id_sala) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3440 (class 2606 OID 19746)
-- Name: golpes_besta golpes_besta_id_besta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.golpes_besta
    ADD CONSTRAINT golpes_besta_id_besta_fkey FOREIGN KEY (id_besta) REFERENCES public.besta(id_besta) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3441 (class 2606 OID 19741)
-- Name: golpes_besta golpes_besta_id_golpe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.golpes_besta
    ADD CONSTRAINT golpes_besta_id_golpe_fkey FOREIGN KEY (id_golpe) REFERENCES public.golpes(id_golpe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3442 (class 2606 OID 19756)
-- Name: hostilidade hostilidade_id_personagem1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hostilidade
    ADD CONSTRAINT hostilidade_id_personagem1_fkey FOREIGN KEY (id_personagem1) REFERENCES public.tipo_personagem_historia(id_personagem) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3443 (class 2606 OID 19761)
-- Name: hostilidade hostilidade_id_personagem2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hostilidade
    ADD CONSTRAINT hostilidade_id_personagem2_fkey FOREIGN KEY (id_personagem2) REFERENCES public.tipo_personagem_historia(id_personagem) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3434 (class 2606 OID 19676)
-- Name: magia_humanoide magia_humanoide_id_humanoide_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.magia_humanoide
    ADD CONSTRAINT magia_humanoide_id_humanoide_fkey FOREIGN KEY (id_humanoide) REFERENCES public.humanoide(id_humanoide) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3435 (class 2606 OID 19681)
-- Name: magia_humanoide magia_humanoide_id_magia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.magia_humanoide
    ADD CONSTRAINT magia_humanoide_id_magia_fkey FOREIGN KEY (id_magia) REFERENCES public.magia(id_magia) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2023-10-28 22:26:27 -03

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Ubuntu 16.0-1.pgdg20.04+1)
-- Dumped by pg_dump version 16.0 (Ubuntu 16.0-1.pgdg20.04+1)

-- Started on 2023-10-28 22:26:27 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2023-10-28 22:26:27 -03

--
-- PostgreSQL database dump complete
--

-- Completed on 2023-10-28 22:26:27 -03

--
-- PostgreSQL database cluster dump complete
--

