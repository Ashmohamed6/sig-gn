--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: audit; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA audit;


ALTER SCHEMA audit OWNER TO postgres;

--
-- Name: core; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA core;


ALTER SCHEMA core OWNER TO postgres;

--
-- Name: import; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA import;


ALTER SCHEMA import OWNER TO postgres;

--
-- Name: marts; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA marts;


ALTER SCHEMA marts OWNER TO postgres;

--
-- Name: qa; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA qa;


ALTER SCHEMA qa OWNER TO postgres;

--
-- Name: ref; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA ref;


ALTER SCHEMA ref OWNER TO postgres;

--
-- Name: security; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA security;


ALTER SCHEMA security OWNER TO postgres;

--
-- Name: stage; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA stage;


ALTER SCHEMA stage OWNER TO postgres;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO postgres;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO postgres;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: address_standardizer; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS address_standardizer WITH SCHEMA public;


--
-- Name: EXTENSION address_standardizer; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION address_standardizer IS 'Used to parse an address into constituent elements. Generally used to support geocoding address normalization step.';


--
-- Name: address_standardizer_data_us; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS address_standardizer_data_us WITH SCHEMA public;


--
-- Name: EXTENSION address_standardizer_data_us; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION address_standardizer_data_us IS 'Address Standardizer US dataset example';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: h3; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS h3 WITH SCHEMA public;


--
-- Name: EXTENSION h3; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION h3 IS 'H3 bindings for PostgreSQL';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: postgis_raster; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_raster WITH SCHEMA public;


--
-- Name: EXTENSION postgis_raster; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_raster IS 'PostGIS raster types and functions';


--
-- Name: h3_postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS h3_postgis WITH SCHEMA public;


--
-- Name: EXTENSION h3_postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION h3_postgis IS 'H3 PostGIS integration';


--
-- Name: ogr_fdw; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS ogr_fdw WITH SCHEMA public;


--
-- Name: EXTENSION ogr_fdw; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ogr_fdw IS 'foreign-data wrapper for GIS data access';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgrouting; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgrouting WITH SCHEMA public;


--
-- Name: EXTENSION pgrouting; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgrouting IS 'pgRouting Extension';


--
-- Name: pointcloud; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pointcloud WITH SCHEMA public;


--
-- Name: EXTENSION pointcloud; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pointcloud IS 'data type for lidar point clouds';


--
-- Name: pointcloud_postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pointcloud_postgis WITH SCHEMA public;


--
-- Name: EXTENSION pointcloud_postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pointcloud_postgis IS 'integration for pointcloud LIDAR data and PostGIS geometry data';


--
-- Name: postgis_sfcgal; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_sfcgal WITH SCHEMA public;


--
-- Name: EXTENSION postgis_sfcgal; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_sfcgal IS 'PostGIS SFCGAL functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


--
-- Name: can_see_project(uuid); Type: FUNCTION; Schema: security; Owner: postgres
--

CREATE FUNCTION security.can_see_project(p_project_id uuid) RETURNS boolean
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1
        FROM security.user_project up
        WHERE up.user_email = current_setting('app.current_user_email', true)
          AND up.project_id = p_project_id
    );
END;
$$;


ALTER FUNCTION security.can_see_project(p_project_id uuid) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: etl_run; Type: TABLE; Schema: audit; Owner: postgres
--

CREATE TABLE audit.etl_run (
    run_id uuid DEFAULT gen_random_uuid() NOT NULL,
    trigger text NOT NULL,
    project_id uuid,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    ended_at timestamp with time zone,
    status text,
    errors_cnt integer,
    messages text
);


ALTER TABLE audit.etl_run OWNER TO postgres;

--
-- Name: import_log; Type: TABLE; Schema: audit; Owner: postgres
--

CREATE TABLE audit.import_log (
    import_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_id uuid,
    dataset text NOT NULL,
    rows_total integer,
    rows_ok integer,
    rows_error integer,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    ended_at timestamp with time zone,
    status text,
    message text
);


ALTER TABLE audit.import_log OWNER TO postgres;

--
-- Name: acteur_participation; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.acteur_participation (
    participation_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    type_acteur text,
    type_acteur_autres text,
    est_entreprise_fiere text,
    id_ent text,
    nom_acteur text,
    date_derniere_part date,
    type_participation text,
    type_participation_autres text,
    statut_convention text,
    intitule_dispositif text,
    objet_participation text,
    objet_participation_autres text,
    nb_part_12m integer,
    frequence_particip text,
    niveau_implication text,
    satisfaction_globale text,
    resultats_obtenus text,
    contraintes_particip text,
    obs_participation text,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE core.acteur_participation OWNER TO postgres;

--
-- Name: agr_comite; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.agr_comite (
    comite_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    id_comite text NOT NULL,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    type_comite text,
    type_comite_autres text,
    nom_comite text,
    annee_creation integer,
    themes_comite_codes text[],
    themes_comite_autres text,
    statut_comite text,
    zone_couverture text,
    nb_membres_total integer,
    nb_membres_femmes integer,
    nb_membres_jeunes integer,
    nb_reunions_12m integer,
    nb_sensib_12m integer,
    principaux_resultats text,
    contraintes_fonctionnement text,
    suit_conflits text,
    nb_conflits_12m integer,
    nb_conflits_regles integer,
    types_conflits_codes text[],
    types_conflits_autres text,
    conflits_details text,
    nb_techniciens_total integer,
    type_techniciens_codes text[],
    type_techniciens_autres text,
    obs_techniciens text,
    obs_comite text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE core.agr_comite OWNER TO postgres;

--
-- Name: agr_menage; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.agr_menage (
    menage_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    id_menage text NOT NULL,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    nom_chef_menage text,
    type_menage text,
    type_menage_autres text,
    nb_personnes integer,
    nb_enfants_u5 integer,
    themes_sensibilisation_codes text[],
    themes_sensibilisation_autres text,
    nb_seances_total integer,
    source_information_codes text[],
    source_information_autres text,
    producteur_informe_intrants text,
    obs_sensib text,
    menage_prat_agroeco text,
    pratiques_agro_codes text[],
    pratiques_agro_autres text,
    utilise_intrants_chimiques text,
    applique_bonnes_pratiques_intrants text,
    utilise_foyer_ameliore text,
    type_foyer_principal text,
    type_foyer_principal_autres text,
    annees_utilisation_foyer integer,
    obs_foyer text,
    applique_bonnes_prat_nutrition text,
    pratiques_nutrition_codes text[],
    pratiques_nutrition_autres text,
    frequence_pratiques_nutrition text,
    obs_nutrition text,
    obs_menage text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE core.agr_menage OWNER TO postgres;

--
-- Name: agr_organisation; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.agr_organisation (
    org_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    id_org text NOT NULL,
    nom_org text,
    type_org text,
    type_org_autres text,
    statut_juridique text,
    statut_autres text,
    annee_creation integer,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    nb_membres_total integer,
    nb_membres_femmes integer,
    nb_membres_jeunes integer,
    activites_principales_codes text[],
    activites_principales_autres text,
    filieres_principales_codes text[],
    filieres_autres text,
    pratiques_adoptees text,
    pratiques_agro_adoptees_codes text[],
    pratiques_agro_autres text,
    nb_planteurs_accompagnes integer,
    nb_producteurs_semenciers integer,
    nb_banques_semences integer,
    nb_bovins integer,
    nb_ovins integer,
    nb_caprins integer,
    autres_especes_autres text,
    nb_ruches_ken integer,
    nb_ruches_lang integer,
    nb_ruches_autres integer,
    nb_emplois_verts integer,
    desc_emplois_verts text,
    obs_org text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE core.agr_organisation OWNER TO postgres;

--
-- Name: beneficiaire; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.beneficiaire (
    beneficiaire_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_id uuid NOT NULL,
    id_beneficiaire text NOT NULL,
    sexe text,
    tranche_age text,
    groupe_vulnerable boolean,
    id_commune text NOT NULL,
    organisation_uuid uuid,
    is_active boolean DEFAULT true NOT NULL,
    record_source text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT beneficiaire_sexe_check CHECK (((sexe = ANY (ARRAY['F'::text, 'M'::text])) OR (sexe IS NULL)))
);


ALTER TABLE core.beneficiaire OWNER TO postgres;

--
-- Name: cep_parcelle; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.cep_parcelle (
    cep_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_code text NOT NULL,
    id_cep text NOT NULL,
    filiere text NOT NULL,
    campagne_yyyy integer NOT NULL,
    id_commune text NOT NULL,
    surface_decl numeric(12,2),
    rendement numeric(12,2),
    menages_beneficiaires integer,
    geom public.geometry(Polygon,4326),
    is_active boolean DEFAULT true NOT NULL,
    valid_from timestamp with time zone DEFAULT now() NOT NULL,
    valid_to timestamp with time zone,
    record_source text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    pratiques_agroeco_codes text[],
    pratiques_autres text,
    CONSTRAINT cep_parcelle_campagne_yyyy_check CHECK (((campagne_yyyy >= 2000) AND (campagne_yyyy <= 2100))),
    CONSTRAINT cep_parcelle_menages_beneficiaires_check CHECK ((menages_beneficiaires >= 0)),
    CONSTRAINT cep_parcelle_rendement_check CHECK ((rendement >= (0)::numeric)),
    CONSTRAINT cep_parcelle_surface_decl_check CHECK ((surface_decl >= (0)::numeric))
);


ALTER TABLE core.cep_parcelle OWNER TO postgres;

--
-- Name: cluster; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.cluster (
    cluster_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_id uuid NOT NULL,
    id_cluster text NOT NULL,
    filiere text,
    type_cluster text,
    id_commune text NOT NULL,
    description text,
    geom public.geometry(Point,4326),
    valid_from timestamp with time zone DEFAULT now() NOT NULL,
    valid_to timestamp with time zone,
    record_source text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE core.cluster OWNER TO postgres;

--
-- Name: cluster_organisation; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.cluster_organisation (
    cluster_uuid uuid NOT NULL,
    organisation_uuid uuid NOT NULL,
    role text,
    since date,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE core.cluster_organisation OWNER TO postgres;

--
-- Name: couloir; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.couloir (
    couloir_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_code text NOT NULL,
    id_couloir text NOT NULL,
    nom_couloir text,
    id_commune text NOT NULL,
    id_prefecture text NOT NULL,
    id_region text NOT NULL,
    geom public.geometry(LineString,4326),
    type_couloir text,
    longueur_km numeric,
    largeur_m numeric,
    especes_codes text[],
    especes_autres text,
    saison_usage text,
    saison_usage_autres text,
    statut_couloir text,
    localites_traversees text,
    infra_codes text[],
    infra_autres text,
    types_conflits_codes text[],
    types_conflits_autres text,
    conflits_details text,
    appreciation_globale text,
    obs_couloir text,
    is_active boolean DEFAULT true,
    valid_from date NOT NULL,
    valid_to date,
    record_source text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE core.couloir OWNER TO postgres;

--
-- Name: ent_emploi; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.ent_emploi (
    emploi_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    id_ent text NOT NULL,
    raison_sociale text,
    annee_ref integer,
    periode_ref text,
    periode_ref_autres text,
    emplois_total integer,
    emplois_femmes integer,
    emplois_jeunes integer,
    obs_emploi_ins text,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE core.ent_emploi OWNER TO postgres;

--
-- Name: ent_emploi_dom; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.ent_emploi_dom (
    emploi_dom_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    emploi_uuid uuid NOT NULL,
    domaine_code text,
    domaine_autre text,
    nb_empl_dom integer,
    nb_empl_fem_dom integer,
    nb_empl_jeunes_dom integer,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    nb_empl_pvh_dom integer,
    emploi_vert_dom text
);


ALTER TABLE core.ent_emploi_dom OWNER TO postgres;

--
-- Name: ent_insertion; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.ent_insertion (
    insertion_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    id_ent text NOT NULL,
    raison_sociale text,
    annee_ref integer,
    periode_ref text,
    periode_ref_autres text,
    insert_total integer,
    insert_femmes integer,
    insert_jeunes integer,
    obs_emploi_ins text,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE core.ent_insertion OWNER TO postgres;

--
-- Name: ent_insertion_dom; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.ent_insertion_dom (
    insertion_dom_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    insertion_uuid uuid NOT NULL,
    domaine_code text,
    domaine_autre text,
    type_insertion_code text,
    type_insertion_autres text,
    nb_ins_dom integer,
    nb_ins_fem_dom integer,
    nb_ins_jeunes_dom integer,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    duree_insertion_mois numeric(6,2),
    nb_ins_pvh_dom integer,
    insertion_verte_dom text
);


ALTER TABLE core.ent_insertion_dom OWNER TO postgres;

--
-- Name: entreprise; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.entreprise (
    entreprise_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_id uuid NOT NULL,
    id_entreprise text NOT NULL,
    raison_sociale text NOT NULL,
    organisation_type text,
    filiere text,
    type_cluster text,
    id_commune text NOT NULL,
    contact text,
    ca_annee numeric(14,2),
    emplois_h integer,
    emplois_f integer,
    emplois_jeunes integer,
    geom public.geometry(Point,4326),
    valid_from timestamp with time zone DEFAULT now() NOT NULL,
    valid_to timestamp with time zone,
    record_source text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT entreprise_ca_annee_check CHECK ((ca_annee >= (0)::numeric)),
    CONSTRAINT entreprise_emplois_f_check CHECK ((emplois_f >= 0)),
    CONSTRAINT entreprise_emplois_h_check CHECK ((emplois_h >= 0)),
    CONSTRAINT entreprise_emplois_jeunes_check CHECK ((emplois_jeunes >= 0))
);


ALTER TABLE core.entreprise OWNER TO postgres;

--
-- Name: entreprise_econ; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.entreprise_econ (
    ent_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    id_ent text NOT NULL,
    raison_sociale text,
    nom_commercial text,
    statut_juridique text,
    statut_juridique_autres text,
    annee_creation integer,
    forme_propriete text,
    forme_propriete_autres text,
    secteur_principal text,
    secteur_principal_autres text,
    secteurs_secondaires_codes text[],
    secteurs_secondaires_autres text,
    activite_detaillee text,
    taille_entreprise text,
    effectif_total integer,
    ca_approx numeric(18,2),
    marche_principal text,
    enregistre_formel text,
    num_registre text,
    nom_responsable text,
    contact_telephon text,
    contact_email text,
    mpme_appuyee_fiere text,
    type_appui text,
    type_appui_autres text,
    obs_entreprise text,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE core.entreprise_econ OWNER TO postgres;

--
-- Name: fiere_suivi_sortant; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.fiere_suivi_sortant (
    suivi_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    id_formation text,
    intitule_formation text,
    centre_formation text,
    date_fin_formation date,
    filiere_principale text,
    filiere_principale_autres text,
    domaine_formation text,
    domaine_formation_autres text,
    id_sortant text NOT NULL,
    nom_sortant text,
    sexe text,
    age integer,
    pvh text,
    niveau_etude text,
    telephone text,
    periode_suivi text,
    periode_suivi_autres text,
    date_suivi date,
    insere text,
    type_insertion text,
    type_insertion_autres text,
    domaine_emploi text,
    domaine_emploi_autres text,
    employeur_ou_activite text,
    emploi_en_lien_formation text,
    revenu_mensuel numeric,
    satisfaction_insertion text,
    raison_non_insertion text,
    obs_suivi text,
    obs_generales text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE core.fiere_suivi_sortant OWNER TO postgres;

--
-- Name: formation_eco; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.formation_eco (
    formation_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    formation_liee_ent text,
    id_ent text,
    raison_sociale text,
    org_beneficiaire text,
    id_formation text NOT NULL,
    intitule_formation text,
    organisme_formateur text,
    type_formation text,
    type_formation_autres text,
    modalite_formation text,
    date_debut date,
    date_fin date,
    duree_jours integer,
    filiere_principale text,
    filiere_principale_autres text,
    domaine_formation text,
    domaine_formation_autres text,
    participants_total integer,
    participants_femmes integer,
    participants_jeunes integer,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    participants_pvh integer,
    participants_pvh_femmes integer,
    participants_pvh_jeunes integer,
    participants_inscrits integer,
    participants_acheve integer
);


ALTER TABLE core.formation_eco OWNER TO postgres;

--
-- Name: formation_part_cat; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.formation_part_cat (
    formation_part_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    formation_uuid uuid NOT NULL,
    categorie_code text,
    categorie_autre text,
    nb_part_cat integer,
    nb_part_fem_cat integer,
    nb_part_jeunes_cat integer,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE core.formation_part_cat OWNER TO postgres;

--
-- Name: insertion; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.insertion (
    insertion_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_id uuid NOT NULL,
    id_insertion text NOT NULL,
    beneficiaire_uuid uuid,
    entreprise_uuid uuid,
    organisation_uuid uuid,
    type_contrat text,
    statut text,
    date_debut date,
    date_fin date,
    remuneration_classe text,
    metier text,
    pieces_url text,
    record_source text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE core.insertion OWNER TO postgres;

--
-- Name: intrant_distribution; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.intrant_distribution (
    intrant_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid,
    project_code text NOT NULL,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    filiere text NOT NULL,
    type_intrant text NOT NULL,
    intrant_autres text,
    campagne_yyyy integer,
    quantite numeric(14,2),
    unite_intrant text,
    menages_beneficiaires integer,
    source_intrant text,
    intrant_conforme text,
    motif_non_conf text,
    obs_intrant text,
    is_active boolean DEFAULT true,
    valid_from date NOT NULL,
    valid_to date,
    record_source text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE core.intrant_distribution OWNER TO postgres;

--
-- Name: kit_distribution; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.kit_distribution (
    kit_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_id uuid NOT NULL,
    id_kit text NOT NULL,
    kit_type text NOT NULL,
    beneficiaire_uuid uuid,
    organisation_uuid uuid,
    quantite integer,
    date_dotation date NOT NULL,
    pieces_url text,
    record_source text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT kit_distribution_quantite_check CHECK ((quantite >= 0))
);


ALTER TABLE core.kit_distribution OWNER TO postgres;

--
-- Name: marche; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.marche (
    marche_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid,
    project_code text NOT NULL,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    nom_comptoir text,
    filiere text,
    filiere_autres text,
    type_comptoir text,
    frequence_marche text,
    gestionnaire text,
    obs_comptoir text,
    is_active boolean DEFAULT true,
    valid_from date NOT NULL,
    valid_to date,
    record_source text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE core.marche OWNER TO postgres;

--
-- Name: meteo_mesure; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.meteo_mesure (
    mesure_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    station_uuid uuid,
    code_station text,
    date_obs date,
    pluie_mm numeric(14,2),
    t_min numeric(14,2),
    t_max numeric(14,2),
    obs_pluie text,
    id_commune text,
    id_prefecture text,
    id_region text,
    geom public.geometry(Point,4326),
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE core.meteo_mesure OWNER TO postgres;

--
-- Name: meteo_station; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.meteo_station (
    station_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    code_station text NOT NULL,
    nom_station text,
    type_station text,
    type_station_autres text,
    proprietaire text,
    proprietaire_autres text,
    statut_station text,
    date_mise_service date,
    frequence_mesure text,
    type_releve text,
    etat_equipements text,
    obs_station text,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE core.meteo_station OWNER TO postgres;

--
-- Name: org_acteur; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.org_acteur (
    org_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    id_commune uuid,
    localite text,
    geom public.geometry(Point,4326),
    enumerator_id text,
    type_org_code text,
    type_org_autres text,
    id_org text,
    nom_org text,
    statut_juridique_code text,
    statut_autres text,
    annee_creation integer,
    nb_membres_total integer,
    nb_membres_femmes integer,
    nb_membres_jeunes integer,
    activites_codes text[],
    activites_principales_autres text,
    filieres_codes text[],
    filieres_autres text,
    pratiques_adoptees text,
    pratiques_agro_codes text[],
    pratiques_agro_autres text,
    nb_planteurs_accompagnes integer,
    nb_producteurs_semenciers integer,
    nb_banques_semences integer,
    nb_bovins integer,
    nb_ovins integer,
    nb_caprins integer,
    autres_especes_autres text,
    nb_ruches_ken integer,
    nb_ruches_lang integer,
    nb_ruches_autres integer,
    nb_emplois_verts integer,
    desc_emplois_verts text,
    obs_org text,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text DEFAULT 'kobo_agr_org'::text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE core.org_acteur OWNER TO postgres;

--
-- Name: organisation; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.organisation (
    organisation_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_id uuid NOT NULL,
    id_organisation text NOT NULL,
    type_organisation text NOT NULL,
    nom text NOT NULL,
    id_commune text NOT NULL,
    adresse text,
    contact text,
    geom public.geometry(Point,4326),
    is_active boolean DEFAULT true NOT NULL,
    valid_from timestamp with time zone DEFAULT now() NOT NULL,
    valid_to timestamp with time zone,
    record_source text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE core.organisation OWNER TO postgres;

--
-- Name: ouvrage; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.ouvrage (
    ouvrage_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid,
    project_code text NOT NULL,
    id_ouvrage text,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    type_ouvrages_codes text[],
    autre_ouv_preciser text,
    longueur_anti_m numeric(14,2),
    etat_anti text,
    surface_couv_ha numeric(14,2),
    etat_couv text,
    obs_ouvr text,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    code_ouvrage text
);


ALTER TABLE core.ouvrage OWNER TO postgres;

--
-- Name: participation_formation; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.participation_formation (
    participation_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_id uuid NOT NULL,
    session_uuid uuid NOT NULL,
    beneficiaire_uuid uuid,
    organisation_uuid uuid,
    heures_suivies numeric(6,2),
    attestation boolean,
    observations text,
    record_source text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT participation_formation_heures_suivies_check CHECK ((heures_suivies >= (0)::numeric))
);


ALTER TABLE core.participation_formation OWNER TO postgres;

--
-- Name: pratiques_agro_parcelle; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.pratiques_agro_parcelle (
    pratique_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    id_cep text,
    campagne_yyyy integer,
    culture_code text,
    culture_autre text,
    surface_ha numeric(14,2),
    production_totale_kg numeric(14,2),
    rendement_calc_kg_ha numeric(14,2),
    rendement_observe_kg_ha numeric(14,2),
    pratiques_appliquees boolean,
    pratiques_agroeco_codes text[],
    pratiques_autres text,
    nb_annees_pratiques integer,
    effet_rendement text,
    effet_sols text,
    obs_pratiques text,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE core.pratiques_agro_parcelle OWNER TO postgres;

--
-- Name: session_formation; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.session_formation (
    session_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_id uuid NOT NULL,
    id_session text NOT NULL,
    type_formation text NOT NULL,
    theme text NOT NULL,
    date_debut date NOT NULL,
    date_fin date,
    site_uuid uuid,
    id_commune text NOT NULL,
    nb_heures numeric(6,2),
    formateur text,
    pieces_url text,
    record_source text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT session_formation_nb_heures_check CHECK ((nb_heures >= (0)::numeric))
);


ALTER TABLE core.session_formation OWNER TO postgres;

--
-- Name: site; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.site (
    site_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_id uuid NOT NULL,
    id_site text NOT NULL,
    type_site text NOT NULL,
    nom text,
    id_commune text NOT NULL,
    geom public.geometry(Point,4326),
    is_active boolean DEFAULT true NOT NULL,
    valid_from timestamp with time zone DEFAULT now() NOT NULL,
    valid_to timestamp with time zone,
    record_source text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE core.site OWNER TO postgres;

--
-- Name: tete_source; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.tete_source (
    ts_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    id_ts text NOT NULL,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom public.geometry(Point,4326),
    type_source text,
    type_source_autres text,
    usage_principal text,
    pop_desservie integer,
    protection_exist text,
    type_protection_codes text[],
    protections_autres text,
    etat_fonctionnel text,
    annee_protection integer,
    entretien_regulier text,
    resp_entretien text,
    obs_ts text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE core.tete_source OWNER TO postgres;

--
-- Name: zone_degradee; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.zone_degradee (
    zone_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    raw_uuid uuid NOT NULL,
    project_code text NOT NULL,
    id_zone text NOT NULL,
    id_commune text NOT NULL,
    id_prefecture text,
    id_region text,
    localite text,
    geom_point public.geometry(Point,4326),
    geom_zone public.geometry(Polygon,4326),
    zone_degrad_pres text,
    type_degradation text,
    severite text,
    surface_degrad_ha numeric(14,2),
    cause_detail text,
    obs_degrad text,
    restauration_real text,
    type_intervention_codes text[],
    autre_interv_prec text,
    surface_restaur_ha numeric(14,2),
    nb_plants integer,
    densite_plants_ha numeric(14,2),
    especes_codes text[],
    especes_autres text,
    annee_plantation integer,
    suivi_plantation text,
    taux_survie_pct integer,
    surf_regen_ha numeric(14,2),
    pratiques_regen text,
    nb_terrasses integer,
    longueur_terr_m numeric(14,2),
    autre_interv_descr text,
    etat_restaur text,
    obs_restaur text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone,
    is_active boolean DEFAULT true,
    valid_from date,
    valid_to date,
    record_source text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE core.zone_degradee OWNER TO postgres;

--
-- Name: agglomeration; Type: TABLE; Schema: import; Owner: postgres
--

CREATE TABLE import.agglomeration (
    id integer NOT NULL,
    geom public.geometry(MultiPolygon,4326),
    fid bigint,
    osm_id character varying(12),
    code integer,
    fclass character varying(28),
    name character varying(100),
    french character varying(100),
    layer character varying,
    path character varying,
    admin1name character varying(255),
    admin1pcod character varying(255)
);


ALTER TABLE import.agglomeration OWNER TO postgres;

--
-- Name: agglomeration_id_seq; Type: SEQUENCE; Schema: import; Owner: postgres
--

CREATE SEQUENCE import.agglomeration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE import.agglomeration_id_seq OWNER TO postgres;

--
-- Name: agglomeration_id_seq; Type: SEQUENCE OWNED BY; Schema: import; Owner: postgres
--

ALTER SEQUENCE import.agglomeration_id_seq OWNED BY import.agglomeration.id;


--
-- Name: localite_osm; Type: TABLE; Schema: import; Owner: postgres
--

CREATE TABLE import.localite_osm (
    id integer NOT NULL,
    geom public.geometry(Point,4326),
    fid bigint,
    osm_id character varying(12),
    code integer,
    fclass character varying(28),
    population bigint,
    name character varying(100),
    french character varying(100),
    "admin1Name" character varying(255),
    "admin1Pcod" character varying(255),
    layer character varying,
    path character varying
);


ALTER TABLE import.localite_osm OWNER TO postgres;

--
-- Name: localite_osm_id_seq; Type: SEQUENCE; Schema: import; Owner: postgres
--

CREATE SEQUENCE import.localite_osm_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE import.localite_osm_id_seq OWNER TO postgres;

--
-- Name: localite_osm_id_seq; Type: SEQUENCE OWNED BY; Schema: import; Owner: postgres
--

ALTER SEQUENCE import.localite_osm_id_seq OWNED BY import.localite_osm.id;


--
-- Name: pref_adm2; Type: TABLE; Schema: import; Owner: postgres
--

CREATE TABLE import.pref_adm2 (
    id integer NOT NULL,
    geom public.geometry(MultiPolygon,4326),
    "OBJECTID" bigint,
    "admin2Name" character varying(50),
    "admin2Pcod" character varying(50),
    "admin2RefN" character varying(50),
    "admin2AltN" character varying(50),
    "admin2Al_1" character varying(50),
    "admin1Name" character varying(50),
    "admin1Pcod" character varying(50),
    "admin0Name" character varying(50),
    "admin0Pcod" character varying(50),
    date date,
    "validOn" date,
    "ValidTo" date,
    "Shape_Leng" double precision,
    "Shape_Area" double precision,
    layer character varying,
    path character varying
);


ALTER TABLE import.pref_adm2 OWNER TO postgres;

--
-- Name: pref_adm2_id_seq; Type: SEQUENCE; Schema: import; Owner: postgres
--

CREATE SEQUENCE import.pref_adm2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE import.pref_adm2_id_seq OWNER TO postgres;

--
-- Name: pref_adm2_id_seq; Type: SEQUENCE OWNED BY; Schema: import; Owner: postgres
--

ALTER SEQUENCE import.pref_adm2_id_seq OWNED BY import.pref_adm2.id;


--
-- Name: region_adm1; Type: TABLE; Schema: import; Owner: postgres
--

CREATE TABLE import.region_adm1 (
    id integer NOT NULL,
    geom public.geometry(MultiPolygon,4326),
    admin1name character varying(50),
    admin1pcod character varying(50),
    admin1refn character varying(50),
    admin1altn character varying(50),
    admin1al_1 character varying(50),
    admin0name character varying(50),
    admin0pcod character varying(50),
    date date,
    validon date,
    validto date,
    shape_leng double precision,
    shape_area double precision
);


ALTER TABLE import.region_adm1 OWNER TO postgres;

--
-- Name: region_adm1_id_seq; Type: SEQUENCE; Schema: import; Owner: postgres
--

CREATE SEQUENCE import.region_adm1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE import.region_adm1_id_seq OWNER TO postgres;

--
-- Name: region_adm1_id_seq; Type: SEQUENCE OWNED BY; Schema: import; Owner: postgres
--

ALTER SEQUENCE import.region_adm1_id_seq OWNED BY import.region_adm1.id;


--
-- Name: souspref_adm3; Type: TABLE; Schema: import; Owner: postgres
--

CREATE TABLE import.souspref_adm3 (
    id integer NOT NULL,
    geom public.geometry(MultiPolygon,4326),
    "OBJECTID" bigint,
    "admin3Name" character varying(50),
    "admin3Pcod" character varying(50),
    "admin3RefN" character varying(50),
    "admin3AltN" character varying(50),
    "admin3Al_1" character varying(50),
    "admin2Name" character varying(50),
    "admin2Pcod" character varying(50),
    "admin1Name" character varying(50),
    "admin1Pcod" character varying(50),
    "admin0Name" character varying(50),
    "admin0Pcod" character varying(50),
    date date,
    "validOn" date,
    "validTo" date,
    "Shape_Leng" double precision,
    "Shape_Area" double precision,
    layer character varying,
    path character varying
);


ALTER TABLE import.souspref_adm3 OWNER TO postgres;

--
-- Name: souspref_adm3_id_seq; Type: SEQUENCE; Schema: import; Owner: postgres
--

CREATE SEQUENCE import.souspref_adm3_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE import.souspref_adm3_id_seq OWNER TO postgres;

--
-- Name: souspref_adm3_id_seq; Type: SEQUENCE OWNED BY; Schema: import; Owner: postgres
--

ALTER SEQUENCE import.souspref_adm3_id_seq OWNED BY import.souspref_adm3.id;


--
-- Name: admin_commune; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.admin_commune (
    id_commune text NOT NULL,
    nom text NOT NULL,
    id_prefecture text NOT NULL,
    id_region text NOT NULL,
    admin0_pcod text NOT NULL,
    admin0_nom text NOT NULL,
    ref_name text,
    alt_name text,
    alt_name2 text,
    valid_from date,
    valid_to date,
    shape_leng double precision,
    shape_area double precision,
    geom public.geometry(MultiPolygon,4326) NOT NULL,
    CONSTRAINT admin_comm_geom_valid CHECK (public.st_isvalid(geom))
);


ALTER TABLE ref.admin_commune OWNER TO postgres;

--
-- Name: admin_prefecture; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.admin_prefecture (
    id_prefecture text NOT NULL,
    nom text NOT NULL,
    id_region text NOT NULL,
    admin0_pcod text NOT NULL,
    admin0_nom text NOT NULL,
    ref_name text,
    alt_name text,
    alt_name2 text,
    valid_from date,
    valid_to date,
    shape_leng double precision,
    shape_area double precision,
    geom public.geometry(MultiPolygon,4326) NOT NULL,
    CONSTRAINT admin_pref_geom_valid CHECK (public.st_isvalid(geom))
);


ALTER TABLE ref.admin_prefecture OWNER TO postgres;

--
-- Name: admin_region; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.admin_region (
    id_region text NOT NULL,
    nom text NOT NULL,
    admin0_pcod text NOT NULL,
    admin0_nom text NOT NULL,
    ref_name text,
    alt_name text,
    alt_name2 text,
    valid_from date,
    valid_to date,
    shape_leng double precision,
    shape_area double precision,
    geom public.geometry(MultiPolygon,4326) NOT NULL,
    CONSTRAINT admin_region_geom_valid CHECK (public.st_isvalid(geom))
);


ALTER TABLE ref.admin_region OWNER TO postgres;

--
-- Name: freq_participation; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.freq_participation (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.freq_participation OWNER TO postgres;

--
-- Name: niveau_implication; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.niveau_implication (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.niveau_implication OWNER TO postgres;

--
-- Name: objet_participation; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.objet_participation (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.objet_participation OWNER TO postgres;

--
-- Name: satisfaction_globale; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.satisfaction_globale (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.satisfaction_globale OWNER TO postgres;

--
-- Name: statut_convention_cfpa; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.statut_convention_cfpa (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.statut_convention_cfpa OWNER TO postgres;

--
-- Name: type_acteur; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_acteur (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_acteur OWNER TO postgres;

--
-- Name: type_participation; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_participation (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_participation OWNER TO postgres;

--
-- Name: vw_acteur_participation; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_acteur_participation AS
 SELECT p.participation_uuid,
    p.raw_uuid,
    p.project_code,
    p.type_acteur,
    ta.label_fr AS type_acteur_label,
    p.type_acteur_autres,
    p.est_entreprise_fiere,
    p.id_ent,
    p.nom_acteur,
    p.date_derniere_part,
    p.type_participation,
    tp.label_fr AS type_participation_label,
    p.type_participation_autres,
    p.statut_convention,
    sc.label_fr AS statut_convention_label,
    p.intitule_dispositif,
    p.objet_participation,
    op.label_fr AS objet_participation_label,
    p.objet_participation_autres,
    p.nb_part_12m,
    p.frequence_particip,
    fp.label_fr AS frequence_particip_label,
    p.niveau_implication,
    ni.label_fr AS niveau_implication_label,
    p.satisfaction_globale,
    sg.label_fr AS satisfaction_globale_label,
    p.resultats_obtenus,
    p.contraintes_particip,
    p.obs_participation,
        CASE
            WHEN ((p.type_participation = 'CONV_CFPA_ENT'::text) AND (p.statut_convention = 'ACTIVE'::text)) THEN true
            ELSE false
        END AS convention_cfpa_active,
    p.id_commune,
    ac.nom AS commune_nom,
    p.id_prefecture,
    ap.nom AS prefecture_nom,
    p.id_region,
    ar.nom AS region_nom,
    p.localite,
    p.geom,
    p.is_active,
    p.valid_from,
    p.valid_to,
    p.record_source,
    p.created_at,
    p.updated_at
   FROM ((((((((((core.acteur_participation p
     LEFT JOIN ref.type_acteur ta ON ((ta.code = p.type_acteur)))
     LEFT JOIN ref.type_participation tp ON ((tp.code = p.type_participation)))
     LEFT JOIN ref.objet_participation op ON ((op.code = p.objet_participation)))
     LEFT JOIN ref.freq_participation fp ON ((fp.code = p.frequence_particip)))
     LEFT JOIN ref.niveau_implication ni ON ((ni.code = p.niveau_implication)))
     LEFT JOIN ref.satisfaction_globale sg ON ((sg.code = p.satisfaction_globale)))
     LEFT JOIN ref.statut_convention_cfpa sc ON ((sc.code = p.statut_convention)))
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = p.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = p.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = p.id_region)));


ALTER VIEW marts.vw_acteur_participation OWNER TO postgres;

--
-- Name: statut_comite; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.statut_comite (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.statut_comite OWNER TO postgres;

--
-- Name: theme_comite; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.theme_comite (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.theme_comite OWNER TO postgres;

--
-- Name: type_comite; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_comite (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_comite OWNER TO postgres;

--
-- Name: type_conflit; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_conflit (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_conflit OWNER TO postgres;

--
-- Name: type_tech; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_tech (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_tech OWNER TO postgres;

--
-- Name: vw_agr_comite; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_agr_comite AS
 SELECT cmt.comite_uuid,
    cmt.raw_uuid,
    cmt.project_code,
    cmt.id_comite,
    cmt.nom_comite,
    cmt.type_comite,
    tc.label_fr AS type_comite_label,
    cmt.type_comite_autres,
    cmt.statut_comite,
    sc.label_fr AS statut_comite_label,
    cmt.annee_creation,
    cmt.zone_couverture,
    cmt.themes_comite_codes,
    th.themes_comite_labels,
    cmt.themes_comite_autres,
    cmt.nb_membres_total,
    cmt.nb_membres_femmes,
    cmt.nb_membres_jeunes,
    cmt.nb_reunions_12m,
    cmt.nb_sensib_12m,
    cmt.principaux_resultats,
    cmt.contraintes_fonctionnement,
    cmt.suit_conflits,
    cmt.nb_conflits_12m,
    cmt.nb_conflits_regles,
    cmt.types_conflits_codes,
    cf.types_conflits_labels,
    cmt.types_conflits_autres,
    cmt.conflits_details,
    cmt.nb_techniciens_total,
    cmt.type_techniciens_codes,
    tt.type_techniciens_labels,
    cmt.type_techniciens_autres,
    cmt.obs_techniciens,
    cmt.obs_comite,
    cmt.id_commune,
    ac.nom AS commune_nom,
    cmt.id_prefecture,
    ap.nom AS prefecture_nom,
    cmt.id_region,
    ar.nom AS region_nom,
    cmt.localite,
    cmt.geom,
    cmt.is_active,
    cmt.valid_from,
    cmt.valid_to,
    cmt.record_source,
    cmt.created_at,
    cmt.updated_at
   FROM ((((((((core.agr_comite cmt
     LEFT JOIN ref.type_comite tc ON ((tc.code = cmt.type_comite)))
     LEFT JOIN ref.statut_comite sc ON ((sc.code = cmt.statut_comite)))
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = cmt.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = cmt.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = cmt.id_region)))
     LEFT JOIN LATERAL ( SELECT string_agg(t.label_fr, ', '::text ORDER BY t.label_fr) AS themes_comite_labels
           FROM (unnest(cmt.themes_comite_codes) x(code)
             LEFT JOIN ref.theme_comite t ON ((t.code = x.code)))) th ON (true))
     LEFT JOIN LATERAL ( SELECT string_agg(cf2.label_fr, ', '::text ORDER BY cf2.label_fr) AS types_conflits_labels
           FROM (unnest(cmt.types_conflits_codes) x(code)
             LEFT JOIN ref.type_conflit cf2 ON ((cf2.code = x.code)))) cf ON (true))
     LEFT JOIN LATERAL ( SELECT string_agg(tt2.label_fr, ', '::text ORDER BY tt2.label_fr) AS type_techniciens_labels
           FROM (unnest(cmt.type_techniciens_codes) x(code)
             LEFT JOIN ref.type_tech tt2 ON ((tt2.code = x.code)))) tt ON (true));


ALTER VIEW marts.vw_agr_comite OWNER TO postgres;

--
-- Name: freq_pratique; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.freq_pratique (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.freq_pratique OWNER TO postgres;

--
-- Name: pratique_agro; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.pratique_agro (
    code text NOT NULL,
    libelle text NOT NULL,
    label_fr text,
    label_en text,
    actif boolean DEFAULT true,
    is_active boolean DEFAULT true
);


ALTER TABLE ref.pratique_agro OWNER TO postgres;

--
-- Name: pratique_nutrition; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.pratique_nutrition (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.pratique_nutrition OWNER TO postgres;

--
-- Name: source_info; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.source_info (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.source_info OWNER TO postgres;

--
-- Name: theme_sensib; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.theme_sensib (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.theme_sensib OWNER TO postgres;

--
-- Name: type_foyer; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_foyer (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_foyer OWNER TO postgres;

--
-- Name: type_menage; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_menage (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_menage OWNER TO postgres;

--
-- Name: vw_agr_menage; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_agr_menage AS
 SELECT m.menage_uuid,
    m.raw_uuid,
    m.project_code,
    m.id_menage,
    m.nom_chef_menage,
    m.type_menage,
    tm.label_fr AS type_menage_label,
    m.type_menage_autres,
    m.nb_personnes,
    m.nb_enfants_u5,
    m.themes_sensibilisation_codes,
    th.themes_sensibilisation_labels,
    m.themes_sensibilisation_autres,
    m.nb_seances_total,
    m.source_information_codes,
    src.source_information_labels,
    m.source_information_autres,
    m.producteur_informe_intrants,
    m.obs_sensib,
    m.menage_prat_agroeco,
    m.pratiques_agro_codes,
    pa.pratiques_agro_labels,
    m.pratiques_agro_autres,
    m.utilise_intrants_chimiques,
    m.applique_bonnes_pratiques_intrants,
    m.utilise_foyer_ameliore,
    m.type_foyer_principal,
    tf.label_fr AS type_foyer_principal_label,
    m.type_foyer_principal_autres,
    m.annees_utilisation_foyer,
    m.obs_foyer,
    m.applique_bonnes_prat_nutrition,
    m.pratiques_nutrition_codes,
    nut.pratiques_nutrition_labels,
    m.pratiques_nutrition_autres,
    m.frequence_pratiques_nutrition,
    fp.label_fr AS frequence_pratiques_nutrition_label,
    m.obs_nutrition,
    m.obs_menage,
    m.id_commune,
    ac.nom AS commune_nom,
    m.id_prefecture,
    ap.nom AS prefecture_nom,
    m.id_region,
    ar.nom AS region_nom,
    m.localite,
    m.geom,
    m.is_active,
    m.valid_from,
    m.valid_to,
    m.record_source,
    m.created_at,
    m.updated_at
   FROM ((((((((((core.agr_menage m
     LEFT JOIN ref.type_menage tm ON ((tm.code = m.type_menage)))
     LEFT JOIN ref.type_foyer tf ON ((tf.code = m.type_foyer_principal)))
     LEFT JOIN ref.freq_pratique fp ON ((fp.code = m.frequence_pratiques_nutrition)))
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = m.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = m.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = m.id_region)))
     LEFT JOIN LATERAL ( SELECT string_agg(ts.label_fr, ', '::text ORDER BY ts.label_fr) AS themes_sensibilisation_labels
           FROM (unnest(m.themes_sensibilisation_codes) x(code)
             LEFT JOIN ref.theme_sensib ts ON ((ts.code = x.code)))) th ON (true))
     LEFT JOIN LATERAL ( SELECT string_agg(si.label_fr, ', '::text ORDER BY si.label_fr) AS source_information_labels
           FROM (unnest(m.source_information_codes) x(code)
             LEFT JOIN ref.source_info si ON ((si.code = x.code)))) src ON (true))
     LEFT JOIN LATERAL ( SELECT string_agg(p.label_fr, ', '::text ORDER BY p.label_fr) AS pratiques_agro_labels
           FROM (unnest(m.pratiques_agro_codes) x(code)
             LEFT JOIN ref.pratique_agro p ON ((p.code = x.code)))) pa ON (true))
     LEFT JOIN LATERAL ( SELECT string_agg(n.label_fr, ', '::text ORDER BY n.label_fr) AS pratiques_nutrition_labels
           FROM (unnest(m.pratiques_nutrition_codes) x(code)
             LEFT JOIN ref.pratique_nutrition n ON ((n.code = x.code)))) nut ON (true));


ALTER VIEW marts.vw_agr_menage OWNER TO postgres;

--
-- Name: activite_organisation; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.activite_organisation (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.activite_organisation OWNER TO postgres;

--
-- Name: filiere; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.filiere (
    code text NOT NULL,
    libelle text NOT NULL,
    actif boolean DEFAULT true NOT NULL,
    label_fr text,
    label_en text,
    is_active boolean DEFAULT true
);


ALTER TABLE ref.filiere OWNER TO postgres;

--
-- Name: statut_juridique; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.statut_juridique (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.statut_juridique OWNER TO postgres;

--
-- Name: type_organisation; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_organisation (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_organisation OWNER TO postgres;

--
-- Name: vw_agr_organisation; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_agr_organisation AS
 SELECT o.org_uuid,
    o.raw_uuid,
    o.project_code,
    o.id_org,
    o.type_org,
    to_ref.label_fr AS type_org_label,
    o.type_org_autres,
    o.statut_juridique,
    sj.label_fr AS statut_juridique_label,
    o.statut_autres,
    o.annee_creation,
    o.nb_membres_total,
    o.nb_membres_femmes,
    o.nb_membres_jeunes,
    o.activites_principales_codes,
    act.activites_principales_labels,
    o.activites_principales_autres,
    o.filieres_principales_codes,
    fil.filieres_principales_labels,
    o.filieres_autres,
    o.pratiques_adoptees,
    o.pratiques_agro_adoptees_codes,
    pra.pratiques_agro_labels,
    o.pratiques_agro_autres,
    o.nb_planteurs_accompagnes,
    o.nb_producteurs_semenciers,
    o.nb_banques_semences,
    o.nb_bovins,
    o.nb_ovins,
    o.nb_caprins,
    o.autres_especes_autres,
    o.nb_ruches_ken,
    o.nb_ruches_lang,
    o.nb_ruches_autres,
    o.nb_emplois_verts,
    o.desc_emplois_verts,
    o.obs_org,
    o.id_commune,
    ac.nom AS commune_nom,
    o.id_prefecture,
    ap.nom AS prefecture_nom,
    o.id_region,
    ar.nom AS region_nom,
    o.localite,
    o.geom,
    o.is_active,
    o.valid_from,
    o.valid_to,
    o.record_source,
    o.created_at,
    o.updated_at
   FROM ((((((((core.agr_organisation o
     LEFT JOIN ref.type_organisation to_ref ON ((to_ref.code = o.type_org)))
     LEFT JOIN ref.statut_juridique sj ON ((sj.code = o.statut_juridique)))
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = o.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = o.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = o.id_region)))
     LEFT JOIN LATERAL ( SELECT string_agg(a.label_fr, ', '::text ORDER BY a.label_fr) AS activites_principales_labels
           FROM (unnest(o.activites_principales_codes) x(code)
             LEFT JOIN ref.activite_organisation a ON ((a.code = x.code)))) act ON (true))
     LEFT JOIN LATERAL ( SELECT string_agg(f.label_fr, ', '::text ORDER BY f.label_fr) AS filieres_principales_labels
           FROM (unnest(o.filieres_principales_codes) x(code)
             LEFT JOIN ref.filiere f ON ((f.code = x.code)))) fil ON (true))
     LEFT JOIN LATERAL ( SELECT string_agg(p.label_fr, ', '::text ORDER BY p.label_fr) AS pratiques_agro_labels
           FROM (unnest(o.pratiques_agro_adoptees_codes) x(code)
             LEFT JOIN ref.pratique_agro p ON ((p.code = x.code)))) pra ON (true));


ALTER VIEW marts.vw_agr_organisation OWNER TO postgres;

--
-- Name: vw_cep_parcelle; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_cep_parcelle AS
 SELECT c.cep_uuid,
    c.project_code,
    c.id_cep,
    c.filiere,
    f.libelle AS filiere_label,
    c.campagne_yyyy,
    c.id_commune,
    ac.nom AS commune_nom,
    ac.id_prefecture,
    ap.nom AS prefecture_nom,
    ac.id_region,
    ar.nom AS region_nom,
    c.surface_decl,
    c.rendement,
    c.menages_beneficiaires,
    c.geom,
    c.pratiques_agroeco_codes,
    pa.pratiques_agroeco_label,
    c.pratiques_autres,
    c.is_active,
    c.valid_from,
    c.valid_to,
    c.record_source,
    c.created_at,
    c.updated_at
   FROM (((((core.cep_parcelle c
     LEFT JOIN ref.filiere f ON ((f.code = c.filiere)))
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = c.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = ac.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = ac.id_region)))
     LEFT JOIN LATERAL ( SELECT string_agg(p.libelle, ', '::text ORDER BY p.libelle) AS pratiques_agroeco_label
           FROM (unnest(c.pratiques_agroeco_codes) u(code_val)
             LEFT JOIN ref.pratique_agro p ON ((p.code = u.code_val)))) pa ON (true));


ALTER VIEW marts.vw_cep_parcelle OWNER TO postgres;

--
-- Name: app_global; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.app_global (
    code text NOT NULL,
    libelle_fr text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.app_global OWNER TO postgres;

--
-- Name: espece_troupeau; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.espece_troupeau (
    code text NOT NULL,
    libelle_fr text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.espece_troupeau OWNER TO postgres;

--
-- Name: infra_pastorale; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.infra_pastorale (
    code text NOT NULL,
    libelle_fr text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.infra_pastorale OWNER TO postgres;

--
-- Name: saison_usage; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.saison_usage (
    code text NOT NULL,
    libelle_fr text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.saison_usage OWNER TO postgres;

--
-- Name: statut_couloir; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.statut_couloir (
    code text NOT NULL,
    libelle_fr text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.statut_couloir OWNER TO postgres;

--
-- Name: type_couloir; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_couloir (
    code text NOT NULL,
    libelle_fr text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_couloir OWNER TO postgres;

--
-- Name: types_conflit; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.types_conflit (
    code text NOT NULL,
    libelle_fr text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.types_conflit OWNER TO postgres;

--
-- Name: vw_couloir; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_couloir AS
 SELECT c.project_code,
    c.id_couloir,
    c.nom_couloir,
    c.id_commune,
    ac.nom AS commune_nom,
    c.id_prefecture,
    ap.nom AS prefecture_nom,
    c.id_region,
    ar.nom AS region_nom,
    c.geom,
    c.type_couloir,
    tc.libelle_fr AS type_couloir_label,
    c.longueur_km,
    c.largeur_m,
    c.especes_codes,
    sp.especes_label,
    c.especes_autres,
    c.saison_usage,
    su.libelle_fr AS saison_usage_label,
    c.saison_usage_autres,
    c.statut_couloir,
    sc.libelle_fr AS statut_couloir_label,
    c.localites_traversees,
    c.infra_codes,
    ip.infra_label,
    c.infra_autres,
    c.types_conflits_codes,
    tcx.types_conflits_label,
    c.types_conflits_autres,
    c.conflits_details,
    c.appreciation_globale,
    ag.libelle_fr AS appreciation_label,
    c.obs_couloir,
    c.is_active,
    c.valid_from,
    c.valid_to,
    c.record_source,
    c.created_at,
    c.updated_at
   FROM ((((((((((core.couloir c
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = c.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = ac.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = ac.id_region)))
     LEFT JOIN ref.type_couloir tc ON ((tc.code = c.type_couloir)))
     LEFT JOIN ref.saison_usage su ON ((su.code = c.saison_usage)))
     LEFT JOIN ref.statut_couloir sc ON ((sc.code = c.statut_couloir)))
     LEFT JOIN ref.app_global ag ON ((ag.code = c.appreciation_globale)))
     LEFT JOIN LATERAL ( SELECT string_agg(e.libelle_fr, ', '::text ORDER BY e.libelle_fr) AS especes_label
           FROM (unnest(c.especes_codes) s(code)
             LEFT JOIN ref.espece_troupeau e ON ((e.code = s.code)))) sp ON (true))
     LEFT JOIN LATERAL ( SELECT string_agg(i.libelle_fr, ', '::text ORDER BY i.libelle_fr) AS infra_label
           FROM (unnest(c.infra_codes) x(code)
             LEFT JOIN ref.infra_pastorale i ON ((i.code = x.code)))) ip ON (true))
     LEFT JOIN LATERAL ( SELECT string_agg(t.libelle_fr, ', '::text ORDER BY t.libelle_fr) AS types_conflits_label
           FROM (unnest(c.types_conflits_codes) y(code)
             LEFT JOIN ref.types_conflit t ON ((t.code = y.code)))) tcx ON (true));


ALTER VIEW marts.vw_couloir OWNER TO postgres;

--
-- Name: domaine_emploi; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.domaine_emploi (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.domaine_emploi OWNER TO postgres;

--
-- Name: periode_ref; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.periode_ref (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.periode_ref OWNER TO postgres;

--
-- Name: vw_ent_emploi_dom; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_ent_emploi_dom AS
 SELECT ed.emploi_dom_uuid,
    e.emploi_uuid,
    e.project_code,
    e.id_ent,
    e.raison_sociale,
    e.annee_ref,
    e.periode_ref,
    pr.label_fr AS periode_ref_label,
    e.emplois_total,
    e.emplois_femmes,
    e.emplois_jeunes,
    ed.domaine_code,
    de.label_fr AS domaine_label,
    ed.domaine_autre,
    ed.nb_empl_dom,
    ed.nb_empl_fem_dom,
    ed.nb_empl_jeunes_dom,
    ed.nb_empl_pvh_dom,
    ed.emploi_vert_dom,
    e.id_commune,
    ac.nom AS commune_nom,
    e.id_prefecture,
    ap.nom AS prefecture_nom,
    e.id_region,
    ar.nom AS region_nom,
    e.localite,
    e.geom,
    e.obs_emploi_ins,
    ed.is_active,
    ed.valid_from,
    ed.valid_to,
    ed.record_source,
    ed.created_at,
    ed.updated_at
   FROM ((((((core.ent_emploi_dom ed
     JOIN core.ent_emploi e ON ((e.emploi_uuid = ed.emploi_uuid)))
     LEFT JOIN ref.domaine_emploi de ON ((de.code = ed.domaine_code)))
     LEFT JOIN ref.periode_ref pr ON ((pr.code = e.periode_ref)))
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = e.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = e.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = e.id_region)));


ALTER VIEW marts.vw_ent_emploi_dom OWNER TO postgres;

--
-- Name: type_insertion; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_insertion (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_insertion OWNER TO postgres;

--
-- Name: vw_ent_insertion_dom; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_ent_insertion_dom AS
 SELECT id.insertion_dom_uuid,
    i.insertion_uuid,
    i.project_code,
    i.id_ent,
    i.raison_sociale,
    i.annee_ref,
    i.periode_ref,
    pr.label_fr AS periode_ref_label,
    i.insert_total,
    i.insert_femmes,
    i.insert_jeunes,
    id.domaine_code,
    de.label_fr AS domaine_label,
    id.domaine_autre,
    id.type_insertion_code,
    ti.label_fr AS type_insertion_label,
    id.type_insertion_autres,
    id.duree_insertion_mois,
    id.nb_ins_dom,
    id.nb_ins_fem_dom,
    id.nb_ins_jeunes_dom,
    id.nb_ins_pvh_dom,
    id.insertion_verte_dom,
    i.id_commune,
    ac.nom AS commune_nom,
    i.id_prefecture,
    ap.nom AS prefecture_nom,
    i.id_region,
    ar.nom AS region_nom,
    i.localite,
    i.geom,
    i.obs_emploi_ins,
    id.is_active,
    id.valid_from,
    id.valid_to,
    id.record_source,
    id.created_at,
    id.updated_at
   FROM (((((((core.ent_insertion_dom id
     JOIN core.ent_insertion i ON ((i.insertion_uuid = id.insertion_uuid)))
     LEFT JOIN ref.domaine_emploi de ON ((de.code = id.domaine_code)))
     LEFT JOIN ref.type_insertion ti ON ((ti.code = id.type_insertion_code)))
     LEFT JOIN ref.periode_ref pr ON ((pr.code = i.periode_ref)))
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = i.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = i.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = i.id_region)));


ALTER VIEW marts.vw_ent_insertion_dom OWNER TO postgres;

--
-- Name: forme_propriete_ent; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.forme_propriete_ent (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.forme_propriete_ent OWNER TO postgres;

--
-- Name: marche_principal; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.marche_principal (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.marche_principal OWNER TO postgres;

--
-- Name: secteur_eco; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.secteur_eco (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.secteur_eco OWNER TO postgres;

--
-- Name: statut_juridique_ent; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.statut_juridique_ent (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.statut_juridique_ent OWNER TO postgres;

--
-- Name: taille_entreprise; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.taille_entreprise (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.taille_entreprise OWNER TO postgres;

--
-- Name: type_appui_ent; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_appui_ent (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_appui_ent OWNER TO postgres;

--
-- Name: vw_entreprise_econ; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_entreprise_econ AS
 SELECT e.ent_uuid,
    e.raw_uuid,
    e.project_code,
    e.id_ent,
    e.raison_sociale,
    e.nom_commercial,
    e.statut_juridique,
    sj.label_fr AS statut_juridique_label,
    e.statut_juridique_autres,
    e.forme_propriete,
    fp.label_fr AS forme_propriete_label,
    e.forme_propriete_autres,
    e.annee_creation,
    e.secteur_principal,
    se.label_fr AS secteur_principal_label,
    e.secteur_principal_autres,
    e.secteurs_secondaires_codes,
    ss.secteurs_secondaires_labels,
    e.secteurs_secondaires_autres,
    e.activite_detaillee,
    e.taille_entreprise,
    te.label_fr AS taille_entreprise_label,
    e.effectif_total,
    e.ca_approx,
    e.marche_principal,
    mp.label_fr AS marche_principal_label,
    e.enregistre_formel,
    e.num_registre,
    e.nom_responsable,
    e.contact_telephon,
    e.contact_email,
    e.mpme_appuyee_fiere,
        CASE
            WHEN (e.mpme_appuyee_fiere = 'oui'::text) THEN true
            WHEN (e.mpme_appuyee_fiere = 'non'::text) THEN false
            ELSE NULL::boolean
        END AS est_mpme_appuyee_fiere,
    e.type_appui,
    ta.label_fr AS type_appui_label,
    e.type_appui_autres,
    e.obs_entreprise,
    e.id_commune,
    ac.nom AS commune_nom,
    e.id_prefecture,
    ap.nom AS prefecture_nom,
    e.id_region,
    ar.nom AS region_nom,
    e.localite,
    e.geom,
        CASE
            WHEN ((e.taille_entreprise = ANY (ARRAY['MINI'::text, 'PETITE'::text, 'MOYENNE'::text])) AND (e.enregistre_formel = 'oui'::text) AND (NULLIF(e.num_registre, ''::text) IS NOT NULL)) THEN true
            ELSE false
        END AS est_mpme_formalisee,
    e.is_active,
    e.valid_from,
    e.valid_to,
    e.record_source,
    e.created_at,
    e.updated_at
   FROM ((((((((((core.entreprise_econ e
     LEFT JOIN ref.statut_juridique_ent sj ON ((sj.code = e.statut_juridique)))
     LEFT JOIN ref.forme_propriete_ent fp ON ((fp.code = e.forme_propriete)))
     LEFT JOIN ref.secteur_eco se ON ((se.code = e.secteur_principal)))
     LEFT JOIN ref.taille_entreprise te ON ((te.code = e.taille_entreprise)))
     LEFT JOIN ref.marche_principal mp ON ((mp.code = e.marche_principal)))
     LEFT JOIN ref.type_appui_ent ta ON ((ta.code = e.type_appui)))
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = e.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = e.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = e.id_region)))
     LEFT JOIN LATERAL ( SELECT string_agg(s2.label_fr, ', '::text ORDER BY s2.label_fr) AS secteurs_secondaires_labels
           FROM (unnest(e.secteurs_secondaires_codes) sec(code)
             LEFT JOIN ref.secteur_eco s2 ON ((s2.code = sec.code)))) ss ON (true));


ALTER VIEW marts.vw_entreprise_econ OWNER TO postgres;

--
-- Name: domaine_formation; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.domaine_formation (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.domaine_formation OWNER TO postgres;

--
-- Name: niveau_etude; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.niveau_etude (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.niveau_etude OWNER TO postgres;

--
-- Name: periode_suivi; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.periode_suivi (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.periode_suivi OWNER TO postgres;

--
-- Name: sexe_sortant; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.sexe_sortant (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.sexe_sortant OWNER TO postgres;

--
-- Name: vw_fiere_suivi_sortant; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_fiere_suivi_sortant AS
 SELECT t.suivi_uuid,
    t.raw_uuid,
    t.project_code,
    t.id_formation,
    t.intitule_formation,
    t.centre_formation,
    t.date_fin_formation,
    t.filiere_principale,
    f.label_fr AS filiere_principale_label,
    t.filiere_principale_autres,
    t.domaine_formation,
    df.label_fr AS domaine_formation_label,
    t.domaine_formation_autres,
    t.id_sortant,
    t.nom_sortant,
    t.sexe,
    sx.label_fr AS sexe_label,
    t.age,
    t.pvh,
    t.niveau_etude,
    ne.label_fr AS niveau_etude_label,
    t.telephone,
    t.periode_suivi,
    ps.label_fr AS periode_suivi_label,
    t.periode_suivi_autres,
    t.date_suivi,
    t.insere,
    t.type_insertion,
    ti.label_fr AS type_insertion_label,
    t.type_insertion_autres,
    t.domaine_emploi,
    de.label_fr AS domaine_emploi_label,
    t.domaine_emploi_autres,
    t.employeur_ou_activite,
    t.emploi_en_lien_formation,
    t.revenu_mensuel,
    t.satisfaction_insertion,
    sg.label_fr AS satisfaction_insertion_label,
    t.raison_non_insertion,
    t.obs_suivi,
    t.obs_generales,
    t.id_commune,
    ac.nom AS commune_nom,
    t.id_prefecture,
    ap.nom AS prefecture_nom,
    t.id_region,
    ar.nom AS region_nom,
    t.localite,
    t.geom,
    t.is_active,
    t.valid_from,
    t.valid_to,
    t.record_source,
    t.created_at,
    t.updated_at
   FROM (((((((((((core.fiere_suivi_sortant t
     LEFT JOIN ref.filiere f ON ((f.code = t.filiere_principale)))
     LEFT JOIN ref.domaine_formation df ON ((df.code = t.domaine_formation)))
     LEFT JOIN ref.sexe_sortant sx ON ((sx.code = t.sexe)))
     LEFT JOIN ref.niveau_etude ne ON ((ne.code = t.niveau_etude)))
     LEFT JOIN ref.periode_suivi ps ON ((ps.code = t.periode_suivi)))
     LEFT JOIN ref.type_insertion ti ON ((ti.code = t.type_insertion)))
     LEFT JOIN ref.domaine_emploi de ON ((de.code = t.domaine_emploi)))
     LEFT JOIN ref.satisfaction_globale sg ON ((sg.code = t.satisfaction_insertion)))
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = t.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = t.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = t.id_region)));


ALTER VIEW marts.vw_fiere_suivi_sortant OWNER TO postgres;

--
-- Name: categorie_participant; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.categorie_participant (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.categorie_participant OWNER TO postgres;

--
-- Name: modalite_formation; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.modalite_formation (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.modalite_formation OWNER TO postgres;

--
-- Name: type_formation; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_formation (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_formation OWNER TO postgres;

--
-- Name: vw_formation_eco_cat; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_formation_eco_cat AS
 SELECT pc.formation_part_uuid,
    f.formation_uuid,
    f.raw_uuid,
    f.project_code,
    f.id_formation,
    f.intitule_formation,
    f.organisme_formateur,
    f.type_formation,
    tf.label_fr AS type_formation_label,
    f.type_formation_autres,
    f.modalite_formation,
    mf.label_fr AS modalite_formation_label,
    f.date_debut,
    f.date_fin,
    f.duree_jours,
    f.filiere_principale,
    se.label_fr AS filiere_principale_label,
    f.filiere_principale_autres,
    f.domaine_formation,
    df.label_fr AS domaine_formation_label,
    f.domaine_formation_autres,
    f.participants_total,
    f.participants_femmes,
    f.participants_jeunes,
    f.participants_pvh,
    f.participants_pvh_femmes,
    f.participants_pvh_jeunes,
    f.participants_inscrits,
    f.participants_acheve,
        CASE
            WHEN (f.participants_inscrits > 0) THEN round(((100.0 * (f.participants_acheve)::numeric) / (f.participants_inscrits)::numeric), 2)
            ELSE NULL::numeric
        END AS taux_achevement_pct,
        CASE
            WHEN (f.participants_total > 0) THEN round(((100.0 * (f.participants_femmes)::numeric) / (f.participants_total)::numeric), 2)
            ELSE NULL::numeric
        END AS part_femmes_pct,
        CASE
            WHEN (f.participants_total > 0) THEN round(((100.0 * (f.participants_jeunes)::numeric) / (f.participants_total)::numeric), 2)
            ELSE NULL::numeric
        END AS part_jeunes_pct,
        CASE
            WHEN (f.participants_total > 0) THEN round(((100.0 * (f.participants_pvh)::numeric) / (f.participants_total)::numeric), 2)
            ELSE NULL::numeric
        END AS part_pvh_pct,
    pc.categorie_code,
    cp.label_fr AS categorie_label,
    pc.categorie_autre,
    pc.nb_part_cat,
    pc.nb_part_fem_cat,
    pc.nb_part_jeunes_cat,
    f.formation_liee_ent,
    f.id_ent,
    f.raison_sociale,
    f.org_beneficiaire,
    f.id_commune,
    ac.nom AS commune_nom,
    f.id_prefecture,
    ap.nom AS prefecture_nom,
    f.id_region,
    ar.nom AS region_nom,
    f.localite,
    f.geom,
    f.is_active,
    f.valid_from,
    f.valid_to,
    f.record_source,
    f.created_at,
    f.updated_at
   FROM (((((((((core.formation_part_cat pc
     JOIN core.formation_eco f ON ((f.formation_uuid = pc.formation_uuid)))
     LEFT JOIN ref.type_formation tf ON ((tf.code = f.type_formation)))
     LEFT JOIN ref.modalite_formation mf ON ((mf.code = f.modalite_formation)))
     LEFT JOIN ref.secteur_eco se ON ((se.code = f.filiere_principale)))
     LEFT JOIN ref.domaine_formation df ON ((df.code = f.domaine_formation)))
     LEFT JOIN ref.categorie_participant cp ON ((cp.code = pc.categorie_code)))
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = f.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = f.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = f.id_region)));


ALTER VIEW marts.vw_formation_eco_cat OWNER TO postgres;

--
-- Name: projet; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.projet (
    project_id uuid DEFAULT gen_random_uuid() NOT NULL,
    code_kobo text NOT NULL,
    code_fonc text NOT NULL,
    libelle_public text NOT NULL,
    libelle_officiel text NOT NULL,
    date_debut date,
    date_fin date,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.projet OWNER TO postgres;

--
-- Name: vw_intrant_distribution; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_intrant_distribution AS
 SELECT d.intrant_uuid,
    d.raw_uuid,
    d.project_code,
    pr.libelle_public AS project_label,
    d.id_commune,
    ac.nom AS commune_nom,
    ac.id_prefecture,
    ap.nom AS prefecture_nom,
    ac.id_region,
    ar.nom AS region_nom,
    d.localite,
    d.geom,
    d.filiere,
    COALESCE(f.label_fr, f.libelle) AS filiere_label,
    d.type_intrant,
    d.intrant_autres,
    d.campagne_yyyy,
    d.quantite,
    d.unite_intrant,
    d.menages_beneficiaires,
    d.source_intrant,
    d.intrant_conforme,
    d.motif_non_conf,
    d.obs_intrant,
    d.is_active,
    d.valid_from,
    d.valid_to,
    d.record_source,
    d.created_at,
    d.updated_at
   FROM (((((core.intrant_distribution d
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = d.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = ac.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = ac.id_region)))
     LEFT JOIN ref.filiere f ON ((f.code = d.filiere)))
     LEFT JOIN ref.projet pr ON ((pr.code_kobo = d.project_code)));


ALTER VIEW marts.vw_intrant_distribution OWNER TO postgres;

--
-- Name: vw_marche; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_marche AS
 SELECT m.marche_uuid,
    m.raw_uuid,
    m.project_code,
    pr.libelle_public AS project_label,
    m.id_commune,
    ac.nom AS commune_nom,
    ac.id_prefecture,
    ap.nom AS prefecture_nom,
    ac.id_region,
    ar.nom AS region_nom,
    m.localite,
    m.geom,
    m.filiere,
    COALESCE(f.label_fr, f.libelle) AS filiere_label,
    m.filiere_autres,
    m.type_comptoir,
    m.frequence_marche,
    m.gestionnaire,
    m.obs_comptoir,
    m.is_active,
    m.valid_from,
    m.valid_to,
    m.record_source,
    m.created_at,
    m.updated_at
   FROM (((((core.marche m
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = m.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = ac.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = ac.id_region)))
     LEFT JOIN ref.filiere f ON ((f.code = m.filiere)))
     LEFT JOIN ref.projet pr ON ((pr.code_kobo = m.project_code)));


ALTER VIEW marts.vw_marche OWNER TO postgres;

--
-- Name: statut_station; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.statut_station (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.statut_station OWNER TO postgres;

--
-- Name: type_station; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_station (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_station OWNER TO postgres;

--
-- Name: vw_meteo_mesure; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_meteo_mesure AS
 SELECT m.mesure_uuid,
    m.raw_uuid,
    m.project_code,
    m.code_station,
    s.nom_station,
    s.type_station,
    ts.label_fr AS type_station_label,
    s.statut_station,
    ss.label_fr AS statut_station_label,
    m.date_obs,
    m.pluie_mm,
    m.t_min,
    m.t_max,
    m.obs_pluie,
    m.id_commune,
    ac.nom AS commune_nom,
    m.id_prefecture,
    ap.nom AS prefecture_nom,
    m.id_region,
    ar.nom AS region_nom,
    s.localite,
    m.geom,
    m.is_active,
    m.valid_from,
    m.valid_to,
    m.record_source,
    m.created_at,
    m.updated_at
   FROM ((((((core.meteo_mesure m
     LEFT JOIN core.meteo_station s ON ((s.station_uuid = m.station_uuid)))
     LEFT JOIN ref.type_station ts ON ((ts.code = s.type_station)))
     LEFT JOIN ref.statut_station ss ON ((ss.code = s.statut_station)))
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = m.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = m.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = m.id_region)));


ALTER VIEW marts.vw_meteo_mesure OWNER TO postgres;

--
-- Name: etat_equip; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.etat_equip (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.etat_equip OWNER TO postgres;

--
-- Name: freq_mesure; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.freq_mesure (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.freq_mesure OWNER TO postgres;

--
-- Name: proprietaire_station; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.proprietaire_station (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.proprietaire_station OWNER TO postgres;

--
-- Name: type_releve; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_releve (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_releve OWNER TO postgres;

--
-- Name: vw_meteo_station; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_meteo_station AS
 SELECT s.station_uuid,
    s.raw_uuid,
    s.project_code,
    s.code_station,
    s.nom_station,
    s.type_station,
    ts.label_fr AS type_station_label,
    s.type_station_autres,
    s.proprietaire,
    ps.label_fr AS proprietaire_label,
    s.proprietaire_autres,
    s.statut_station,
    ss.label_fr AS statut_station_label,
    s.date_mise_service,
    s.frequence_mesure,
    fm.label_fr AS frequence_mesure_label,
    s.type_releve,
    tr.label_fr AS type_releve_label,
    s.etat_equipements,
    ee.label_fr AS etat_equipements_label,
    s.obs_station,
    s.id_commune,
    ac.nom AS commune_nom,
    s.id_prefecture,
    ap.nom AS prefecture_nom,
    s.id_region,
    ar.nom AS region_nom,
    s.localite,
    s.geom,
    s.is_active,
    s.valid_from,
    s.valid_to,
    s.record_source,
    s.created_at,
    s.updated_at
   FROM (((((((((core.meteo_station s
     LEFT JOIN ref.type_station ts ON ((ts.code = s.type_station)))
     LEFT JOIN ref.proprietaire_station ps ON ((ps.code = s.proprietaire)))
     LEFT JOIN ref.statut_station ss ON ((ss.code = s.statut_station)))
     LEFT JOIN ref.freq_mesure fm ON ((fm.code = s.frequence_mesure)))
     LEFT JOIN ref.type_releve tr ON ((tr.code = s.type_releve)))
     LEFT JOIN ref.etat_equip ee ON ((ee.code = s.etat_equipements)))
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = s.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = s.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = s.id_region)));


ALTER VIEW marts.vw_meteo_station OWNER TO postgres;

--
-- Name: etat_ouvrage; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.etat_ouvrage (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true
);


ALTER TABLE ref.etat_ouvrage OWNER TO postgres;

--
-- Name: type_ouvrage; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_ouvrage (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true
);


ALTER TABLE ref.type_ouvrage OWNER TO postgres;

--
-- Name: vw_ouvrage; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_ouvrage AS
 SELECT o.ouvrage_uuid,
    o.raw_uuid,
    o.project_code,
    o.code_ouvrage,
    o.id_commune,
    ac.nom AS commune_nom,
    o.id_prefecture,
    ap.nom AS prefecture_nom,
    o.id_region,
    ar.nom AS region_nom,
    o.localite,
    o.geom,
    o.type_ouvrages_codes,
    ot.type_ouvrages_label,
    o.autre_ouv_preciser,
    o.longueur_anti_m,
    o.etat_anti,
    ea_anti.label_fr AS etat_anti_label,
    o.surface_couv_ha,
    o.etat_couv,
    ea_couv.label_fr AS etat_couv_label,
    o.obs_ouvr,
    o.is_active,
    o.valid_from,
    o.valid_to,
    o.record_source,
    o.created_at,
    o.updated_at
   FROM ((((((core.ouvrage o
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = o.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = ac.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = ac.id_region)))
     LEFT JOIN LATERAL ( SELECT string_agg(t.label_fr, ', '::text ORDER BY t.label_fr) AS type_ouvrages_label
           FROM (unnest(o.type_ouvrages_codes) u(code)
             LEFT JOIN ref.type_ouvrage t ON ((t.code = u.code)))) ot ON (true))
     LEFT JOIN ref.etat_ouvrage ea_anti ON ((ea_anti.code = o.etat_anti)))
     LEFT JOIN ref.etat_ouvrage ea_couv ON ((ea_couv.code = o.etat_couv)));


ALTER VIEW marts.vw_ouvrage OWNER TO postgres;

--
-- Name: culture; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.culture (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.culture OWNER TO postgres;

--
-- Name: effet_niveau; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.effet_niveau (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.effet_niveau OWNER TO postgres;

--
-- Name: vw_pratiques_agro_parcelle; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_pratiques_agro_parcelle AS
 SELECT p.pratique_uuid,
    p.raw_uuid,
    p.project_code,
    p.id_cep,
    p.campagne_yyyy,
    p.culture_code,
    cu.label_fr AS culture_label,
    p.culture_autre,
    p.surface_ha,
    p.production_totale_kg,
    p.rendement_calc_kg_ha,
    p.rendement_observe_kg_ha,
    p.pratiques_appliquees,
    p.pratiques_agroeco_codes,
    agg.pratiques_agroeco_label,
    p.pratiques_autres,
    p.nb_annees_pratiques,
    p.effet_rendement,
    er.label_fr AS effet_rendement_label,
    p.effet_sols,
    es.label_fr AS effet_sols_label,
    p.obs_pratiques,
    p.id_commune,
    ac.nom AS commune_nom,
    p.id_prefecture,
    ap.nom AS prefecture_nom,
    p.id_region,
    ar.nom AS region_nom,
    p.localite,
    p.geom,
    p.is_active,
    p.valid_from,
    p.valid_to,
    p.record_source,
    p.created_at,
    p.updated_at
   FROM (((((((core.pratiques_agro_parcelle p
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = p.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = p.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = p.id_region)))
     LEFT JOIN ref.culture cu ON ((cu.code = p.culture_code)))
     LEFT JOIN ref.effet_niveau er ON ((er.code = p.effet_rendement)))
     LEFT JOIN ref.effet_niveau es ON ((es.code = p.effet_sols)))
     LEFT JOIN LATERAL ( SELECT string_agg(pr.libelle, ', '::text ORDER BY pr.libelle) AS pratiques_agroeco_label
           FROM (unnest(p.pratiques_agroeco_codes) u(code)
             LEFT JOIN ref.pratique_agro pr ON ((pr.code = u.code)))) agg ON (true));


ALTER VIEW marts.vw_pratiques_agro_parcelle OWNER TO postgres;

--
-- Name: etat_fonctionnel; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.etat_fonctionnel (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.etat_fonctionnel OWNER TO postgres;

--
-- Name: type_protection; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_protection (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_protection OWNER TO postgres;

--
-- Name: type_source; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_source (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_source OWNER TO postgres;

--
-- Name: usage_source; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.usage_source (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.usage_source OWNER TO postgres;

--
-- Name: vw_tete_source; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_tete_source AS
 SELECT t.ts_uuid,
    t.raw_uuid,
    t.project_code,
    t.id_ts,
    t.type_source,
    ts.label_fr AS type_source_label,
    t.type_source_autres,
    t.usage_principal,
    us.label_fr AS usage_principal_label,
    t.pop_desservie,
    t.protection_exist,
    t.type_protection_codes,
    pa.type_protection_labels,
    t.protections_autres,
    t.etat_fonctionnel,
    ef.label_fr AS etat_fonctionnel_label,
    t.annee_protection,
    t.entretien_regulier,
    t.resp_entretien,
    t.obs_ts,
    t.id_commune,
    ac.nom AS commune_nom,
    t.id_prefecture,
    ap.nom AS prefecture_nom,
    t.id_region,
    ar.nom AS region_nom,
    t.localite,
    t.geom,
    t.is_active,
    t.valid_from,
    t.valid_to,
    t.record_source,
    t.created_at,
    t.updated_at
   FROM (((((((core.tete_source t
     LEFT JOIN ref.type_source ts ON ((ts.code = t.type_source)))
     LEFT JOIN ref.usage_source us ON ((us.code = t.usage_principal)))
     LEFT JOIN ref.etat_fonctionnel ef ON ((ef.code = t.etat_fonctionnel)))
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = t.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = t.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = t.id_region)))
     LEFT JOIN LATERAL ( SELECT string_agg(p.label_fr, ', '::text ORDER BY p.label_fr) AS type_protection_labels
           FROM (unnest(t.type_protection_codes) prot(code)
             LEFT JOIN ref.type_protection p ON ((p.code = prot.code)))) pa ON (true));


ALTER VIEW marts.vw_tete_source OWNER TO postgres;

--
-- Name: espece_reboisement; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.espece_reboisement (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.espece_reboisement OWNER TO postgres;

--
-- Name: etat_restaur; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.etat_restaur (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.etat_restaur OWNER TO postgres;

--
-- Name: severite_degradation; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.severite_degradation (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.severite_degradation OWNER TO postgres;

--
-- Name: type_degradation; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_degradation (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_degradation OWNER TO postgres;

--
-- Name: type_intervention; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_intervention (
    code text NOT NULL,
    label_fr text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_intervention OWNER TO postgres;

--
-- Name: vw_zone_degradee; Type: VIEW; Schema: marts; Owner: postgres
--

CREATE VIEW marts.vw_zone_degradee AS
 SELECT z.zone_uuid,
    z.raw_uuid,
    z.project_code,
    z.id_zone,
    z.zone_degrad_pres,
    z.type_degradation,
    td.label_fr AS type_degradation_label,
    z.severite,
    sv.label_fr AS severite_label,
    z.surface_degrad_ha,
    z.cause_detail,
    z.obs_degrad,
    z.restauration_real,
    z.type_intervention_codes,
    ti.type_intervention_labels,
    z.autre_interv_prec,
    z.surface_restaur_ha,
    z.nb_plants,
    z.densite_plants_ha,
    z.especes_codes,
    sp.especes_labels,
    z.especes_autres,
    z.annee_plantation,
    z.suivi_plantation,
    z.taux_survie_pct,
    z.surf_regen_ha,
    z.pratiques_regen,
    z.nb_terrasses,
    z.longueur_terr_m,
    z.autre_interv_descr,
    z.etat_restaur,
    er.label_fr AS etat_restaur_label,
    z.obs_restaur,
    z.id_commune,
    ac.nom AS commune_nom,
    z.id_prefecture,
    ap.nom AS prefecture_nom,
    z.id_region,
    ar.nom AS region_nom,
    z.localite,
    z.geom_point,
    z.geom_zone,
    z.is_active,
    z.valid_from,
    z.valid_to,
    z.record_source,
    z.created_at,
    z.updated_at
   FROM ((((((((core.zone_degradee z
     LEFT JOIN ref.type_degradation td ON ((td.code = z.type_degradation)))
     LEFT JOIN ref.severite_degradation sv ON ((sv.code = z.severite)))
     LEFT JOIN ref.etat_restaur er ON ((er.code = z.etat_restaur)))
     LEFT JOIN ref.admin_commune ac ON ((ac.id_commune = z.id_commune)))
     LEFT JOIN ref.admin_prefecture ap ON ((ap.id_prefecture = z.id_prefecture)))
     LEFT JOIN ref.admin_region ar ON ((ar.id_region = z.id_region)))
     LEFT JOIN LATERAL ( SELECT string_agg(t.label_fr, ', '::text ORDER BY t.label_fr) AS type_intervention_labels
           FROM (unnest(z.type_intervention_codes) ti_1(code)
             LEFT JOIN ref.type_intervention t ON ((t.code = ti_1.code)))) ti ON (true))
     LEFT JOIN LATERAL ( SELECT string_agg(e.label_fr, ', '::text ORDER BY e.label_fr) AS especes_labels
           FROM (unnest(z.especes_codes) es(code)
             LEFT JOIN ref.espece_reboisement e ON ((e.code = es.code)))) sp ON (true));


ALTER VIEW marts.vw_zone_degradee OWNER TO postgres;

--
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    role character varying(20) NOT NULL,
    default_project_id uuid,
    region_id character varying(50)
);


ALTER TABLE public.accounts_user OWNER TO postgres;

--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.accounts_user_groups OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.accounts_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.accounts_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_user_projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_projects (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    refproject_id uuid NOT NULL
);


ALTER TABLE public.accounts_user_projects OWNER TO postgres;

--
-- Name: accounts_user_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.accounts_user_projects ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.accounts_user_user_permissions OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.accounts_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: data_quality_report; Type: TABLE; Schema: qa; Owner: postgres
--

CREATE TABLE qa.data_quality_report (
    qa_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_id uuid,
    table_name text NOT NULL,
    rule_name text,
    errors_cnt integer,
    warning_cnt integer,
    generated_at timestamp with time zone DEFAULT now() NOT NULL,
    sample_ids jsonb
);


ALTER TABLE qa.data_quality_report OWNER TO postgres;

--
-- Name: run_metrics; Type: TABLE; Schema: qa; Owner: postgres
--

CREATE TABLE qa.run_metrics (
    run_id uuid NOT NULL,
    project_id uuid,
    table_name text,
    rows_scanned integer,
    duration_ms integer,
    errors_cnt integer,
    generated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE qa.run_metrics OWNER TO postgres;

--
-- Name: agglomeration; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.agglomeration (
    agglom_id bigint NOT NULL,
    osm_id bigint,
    code text,
    fclass text,
    nom text,
    nom_fr text,
    id_commune text,
    geom public.geometry(MultiPolygon,4326) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE ref.agglomeration OWNER TO postgres;

--
-- Name: agglomeration_agglom_id_seq; Type: SEQUENCE; Schema: ref; Owner: postgres
--

CREATE SEQUENCE ref.agglomeration_agglom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ref.agglomeration_agglom_id_seq OWNER TO postgres;

--
-- Name: agglomeration_agglom_id_seq; Type: SEQUENCE OWNED BY; Schema: ref; Owner: postgres
--

ALTER SEQUENCE ref.agglomeration_agglom_id_seq OWNED BY ref.agglomeration.agglom_id;


--
-- Name: aire_protegee; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.aire_protegee (
    ap_id bigint NOT NULL,
    osm_id bigint,
    code text,
    fclass text,
    nom text,
    nom_fr text,
    id_commune text,
    geom public.geometry(MultiPolygon,4326) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE ref.aire_protegee OWNER TO postgres;

--
-- Name: aire_protegee_ap_id_seq; Type: SEQUENCE; Schema: ref; Owner: postgres
--

CREATE SEQUENCE ref.aire_protegee_ap_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ref.aire_protegee_ap_id_seq OWNER TO postgres;

--
-- Name: aire_protegee_ap_id_seq; Type: SEQUENCE OWNED BY; Schema: ref; Owner: postgres
--

ALTER SEQUENCE ref.aire_protegee_ap_id_seq OWNED BY ref.aire_protegee.ap_id;


--
-- Name: appui_type; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.appui_type (
    code text NOT NULL,
    libelle text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.appui_type OWNER TO postgres;

--
-- Name: cluster_type; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.cluster_type (
    code text NOT NULL,
    libelle text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.cluster_type OWNER TO postgres;

--
-- Name: comptoir_type; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.comptoir_type (
    code text NOT NULL,
    libelle_fr text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.comptoir_type OWNER TO postgres;

--
-- Name: controle_resultat; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.controle_resultat (
    code text NOT NULL,
    libelle text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.controle_resultat OWNER TO postgres;

--
-- Name: couloir_appreciation; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.couloir_appreciation (
    code text NOT NULL,
    libelle text NOT NULL
);


ALTER TABLE ref.couloir_appreciation OWNER TO postgres;

--
-- Name: equipement; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.equipement (
    equip_id bigint NOT NULL,
    osm_id bigint,
    code text,
    fclass text,
    nom text,
    nom_fr text,
    id_commune text,
    geom public.geometry(Point,4326) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE ref.equipement OWNER TO postgres;

--
-- Name: equipement_equip_id_seq; Type: SEQUENCE; Schema: ref; Owner: postgres
--

CREATE SEQUENCE ref.equipement_equip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ref.equipement_equip_id_seq OWNER TO postgres;

--
-- Name: equipement_equip_id_seq; Type: SEQUENCE OWNED BY; Schema: ref; Owner: postgres
--

ALTER SEQUENCE ref.equipement_equip_id_seq OWNED BY ref.equipement.equip_id;


--
-- Name: formation_type; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.formation_type (
    code text NOT NULL,
    libelle text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.formation_type OWNER TO postgres;

--
-- Name: frequence_marche; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.frequence_marche (
    code text NOT NULL,
    libelle_fr text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.frequence_marche OWNER TO postgres;

--
-- Name: habitation_dispersee; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.habitation_dispersee (
    hab_id bigint NOT NULL,
    osm_id bigint,
    code text,
    fclass text,
    nom text,
    type_bat text,
    id_commune text,
    geom public.geometry(MultiPolygon,4326) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE ref.habitation_dispersee OWNER TO postgres;

--
-- Name: habitation_dispersee_hab_id_seq; Type: SEQUENCE; Schema: ref; Owner: postgres
--

CREATE SEQUENCE ref.habitation_dispersee_hab_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ref.habitation_dispersee_hab_id_seq OWNER TO postgres;

--
-- Name: habitation_dispersee_hab_id_seq; Type: SEQUENCE OWNED BY; Schema: ref; Owner: postgres
--

ALTER SEQUENCE ref.habitation_dispersee_hab_id_seq OWNED BY ref.habitation_dispersee.hab_id;


--
-- Name: hydrographie; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.hydrographie (
    id integer NOT NULL,
    geom public.geometry(Point,4326),
    fid bigint,
    osm_id character varying(12),
    code integer,
    fclass character varying(28),
    name character varying(100),
    french character varying(100)
);


ALTER TABLE ref.hydrographie OWNER TO postgres;

--
-- Name: hydrographie_id_seq; Type: SEQUENCE; Schema: ref; Owner: postgres
--

CREATE SEQUENCE ref.hydrographie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ref.hydrographie_id_seq OWNER TO postgres;

--
-- Name: hydrographie_id_seq; Type: SEQUENCE OWNED BY; Schema: ref; Owner: postgres
--

ALTER SEQUENCE ref.hydrographie_id_seq OWNED BY ref.hydrographie.id;


--
-- Name: intrant_conforme; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.intrant_conforme (
    code text NOT NULL,
    libelle_fr text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.intrant_conforme OWNER TO postgres;

--
-- Name: intrant_type; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.intrant_type (
    code text NOT NULL,
    libelle_fr text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.intrant_type OWNER TO postgres;

--
-- Name: kit_type; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.kit_type (
    code text NOT NULL,
    libelle text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.kit_type OWNER TO postgres;

--
-- Name: localite; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.localite (
    localite_id bigint NOT NULL,
    osm_id bigint,
    code text,
    fclass text,
    nom text,
    nom_fr text,
    population integer,
    id_commune text,
    geom public.geometry(Point,4326) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE ref.localite OWNER TO postgres;

--
-- Name: localite_localite_id_seq; Type: SEQUENCE; Schema: ref; Owner: postgres
--

CREATE SEQUENCE ref.localite_localite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ref.localite_localite_id_seq OWNER TO postgres;

--
-- Name: localite_localite_id_seq; Type: SEQUENCE OWNED BY; Schema: ref; Owner: postgres
--

ALTER SEQUENCE ref.localite_localite_id_seq OWNED BY ref.localite.localite_id;


--
-- Name: occupation_sol; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.occupation_sol (
    occsol_id bigint NOT NULL,
    code_2020 text,
    classe text,
    id_commune text,
    geom public.geometry(MultiPolygon,4326) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE ref.occupation_sol OWNER TO postgres;

--
-- Name: occupation_sol_occsol_id_seq; Type: SEQUENCE; Schema: ref; Owner: postgres
--

CREATE SEQUENCE ref.occupation_sol_occsol_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ref.occupation_sol_occsol_id_seq OWNER TO postgres;

--
-- Name: occupation_sol_occsol_id_seq; Type: SEQUENCE OWNED BY; Schema: ref; Owner: postgres
--

ALTER SEQUENCE ref.occupation_sol_occsol_id_seq OWNED BY ref.occupation_sol.occsol_id;


--
-- Name: organisation_type; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.organisation_type (
    code text NOT NULL,
    libelle text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.organisation_type OWNER TO postgres;

--
-- Name: reseau_routier; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.reseau_routier (
    id integer NOT NULL,
    geom public.geometry(MultiLineString,4326),
    fid bigint,
    osm_id bigint,
    osm_type character varying(80),
    highway character varying(80),
    blockage character varying(80),
    operator character varying(80),
    public_tra character varying(80),
    parking character varying(80),
    pump character varying(80),
    diameter character varying(80),
    landuse character varying(80),
    "natural" character varying(80),
    bridge character varying(80),
    building character varying(80),
    smoothness character varying(80),
    waterway character varying(80),
    depth character varying(80),
    covered character varying(80),
    surface character varying(80),
    tunnel character varying(80),
    water character varying(80),
    width character varying(80),
    railway character varying(80),
    oneway character varying(80),
    barrier character varying(80),
    capacity character varying(80),
    name character varying(80),
    aeroway character varying(80),
    layer character varying(80),
    amenity character varying(80),
    man_made character varying(80)
);


ALTER TABLE ref.reseau_routier OWNER TO postgres;

--
-- Name: reseau_routier_id_seq; Type: SEQUENCE; Schema: ref; Owner: postgres
--

CREATE SEQUENCE ref.reseau_routier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ref.reseau_routier_id_seq OWNER TO postgres;

--
-- Name: reseau_routier_id_seq; Type: SEQUENCE OWNED BY; Schema: ref; Owner: postgres
--

ALTER SEQUENCE ref.reseau_routier_id_seq OWNED BY ref.reseau_routier.id;


--
-- Name: type_intrant; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_intrant (
    code text NOT NULL,
    famille text,
    libelle text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_intrant OWNER TO postgres;

--
-- Name: type_site; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.type_site (
    code text NOT NULL,
    libelle text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.type_site OWNER TO postgres;

--
-- Name: unite_intrant; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.unite_intrant (
    code text NOT NULL,
    libelle_fr text NOT NULL,
    actif boolean DEFAULT true NOT NULL
);


ALTER TABLE ref.unite_intrant OWNER TO postgres;

--
-- Name: zone_humide; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.zone_humide (
    zh_id bigint NOT NULL,
    osm_id bigint,
    code text,
    fclass text,
    nom text,
    nom_fr text,
    id_commune text,
    geom public.geometry(MultiPolygon,4326) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE ref.zone_humide OWNER TO postgres;

--
-- Name: zone_humide_zh_id_seq; Type: SEQUENCE; Schema: ref; Owner: postgres
--

CREATE SEQUENCE ref.zone_humide_zh_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ref.zone_humide_zh_id_seq OWNER TO postgres;

--
-- Name: zone_humide_zh_id_seq; Type: SEQUENCE OWNED BY; Schema: ref; Owner: postgres
--

ALTER SEQUENCE ref.zone_humide_zh_id_seq OWNED BY ref.zone_humide.zh_id;


--
-- Name: zone_sableuse; Type: TABLE; Schema: ref; Owner: postgres
--

CREATE TABLE ref.zone_sableuse (
    zs_id bigint NOT NULL,
    osm_id bigint,
    code text,
    fclass text,
    nom text,
    nom_fr text,
    id_commune text,
    geom public.geometry(MultiPolygon,4326) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE ref.zone_sableuse OWNER TO postgres;

--
-- Name: zone_sableuse_zs_id_seq; Type: SEQUENCE; Schema: ref; Owner: postgres
--

CREATE SEQUENCE ref.zone_sableuse_zs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ref.zone_sableuse_zs_id_seq OWNER TO postgres;

--
-- Name: zone_sableuse_zs_id_seq; Type: SEQUENCE OWNED BY; Schema: ref; Owner: postgres
--

ALTER SEQUENCE ref.zone_sableuse_zs_id_seq OWNED BY ref.zone_sableuse.zs_id;


--
-- Name: user_project; Type: TABLE; Schema: security; Owner: postgres
--

CREATE TABLE security.user_project (
    user_email text NOT NULL,
    project_id uuid NOT NULL
);


ALTER TABLE security.user_project OWNER TO postgres;

--
-- Name: agr_cep_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.agr_cep_raw (
    id bigint NOT NULL,
    submission_uuid text,
    submission_time timestamp with time zone,
    enumerator_id text,
    deviceid text,
    project_code text,
    region text,
    prefecture text,
    commune text,
    localite text,
    geom public.geometry(Point,4326),
    id_cep text,
    filiere text,
    filiere_autres text,
    campagne text,
    menages_ben text,
    nb_paysans_relais text,
    surface_ha text,
    culture_princ text,
    cultures_assoc text,
    pratiques_agroeco text,
    pratiques_autres text,
    production_totale text,
    rendement_calc text,
    rendement_saisi text,
    contraintes text,
    observations text,
    raw_payload jsonb,
    created_at timestamp with time zone DEFAULT now(),
    _uuid text,
    _submission_time timestamp with time zone,
    start text,
    "end" text,
    today date,
    username text,
    _status text,
    _submitted_by text,
    __version__ text,
    _index text
);


ALTER TABLE stage.agr_cep_raw OWNER TO postgres;

--
-- Name: agr_cep_raw_id_seq; Type: SEQUENCE; Schema: stage; Owner: postgres
--

CREATE SEQUENCE stage.agr_cep_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE stage.agr_cep_raw_id_seq OWNER TO postgres;

--
-- Name: agr_cep_raw_id_seq; Type: SEQUENCE OWNED BY; Schema: stage; Owner: postgres
--

ALTER SEQUENCE stage.agr_cep_raw_id_seq OWNED BY stage.agr_cep_raw.id;


--
-- Name: agr_comite_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.agr_comite_raw (
    raw_uuid uuid NOT NULL,
    project_code text,
    today text,
    region text,
    prefecture text,
    commune text,
    localite text,
    geom public.geometry(Point,4326),
    type_comite text,
    type_comite_autres text,
    id_comite text,
    nom_comite text,
    annee_creation integer,
    themes_comite text,
    themes_comite_autres text,
    statut_comite text,
    zone_couverture text,
    nb_membres_total integer,
    nb_membres_femmes integer,
    nb_membres_jeunes integer,
    nb_reunions_12m integer,
    nb_sensib_12m integer,
    principaux_resultats text,
    contraintes_fonctionnement text,
    suit_conflits text,
    nb_conflits_12m integer,
    nb_conflits_regles integer,
    types_conflits text,
    types_conflits_autres text,
    conflits_details text,
    nb_techniciens_total integer,
    type_techniciens text,
    type_techniciens_autres text,
    obs_techniciens text,
    obs_comite text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone DEFAULT now()
);


ALTER TABLE stage.agr_comite_raw OWNER TO postgres;

--
-- Name: agr_menage_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.agr_menage_raw (
    raw_uuid uuid NOT NULL,
    project_code text,
    today text,
    region text,
    prefecture text,
    commune text,
    localite text,
    geom public.geometry(Point,4326),
    id_menage text,
    nom_chef_menage text,
    type_menage text,
    type_menage_autres text,
    nb_personnes integer,
    nb_enfants_u5 integer,
    themes_sensibilisation text,
    themes_sensibilisation_autres text,
    nb_seances_total integer,
    source_information text,
    source_information_autres text,
    producteur_informe_intrants text,
    obs_sensib text,
    menage_prat_agroeco text,
    pratiques_agro_menage text,
    pratiques_agro_autres text,
    utilise_intrants_chimiques text,
    applique_bonnes_pratiques_intrants text,
    utilise_foyer_ameliore text,
    type_foyer_principal text,
    type_foyer_principal_autres text,
    annees_utilisation_foyer integer,
    obs_foyer text,
    applique_bonnes_prat_nutrition text,
    pratiques_nutritionnelles text,
    pratiques_nutrition_autres text,
    frequence_pratiques_nutrition text,
    obs_nutrition text,
    obs_menage text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone DEFAULT now()
);


ALTER TABLE stage.agr_menage_raw OWNER TO postgres;

--
-- Name: agr_org_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.agr_org_raw (
    raw_uuid uuid NOT NULL,
    project_code text,
    today text,
    enumerator_id text,
    deviceid text,
    region text,
    prefecture text,
    commune text,
    localite text,
    geom public.geometry(Point,4326),
    type_org text,
    type_org_autres text,
    id_org text,
    nom_org text,
    statut_juridique text,
    statut_autres text,
    annee_creation integer,
    nb_membres_total integer,
    nb_membres_femmes integer,
    nb_membres_jeunes integer,
    activites_principales text,
    activites_principales_autres text,
    filieres_principales text,
    filieres_autres text,
    pratiques_adoptees text,
    pratiques_agro_adoptees text,
    pratiques_agro_autres text,
    nb_planteurs_accompagnes integer,
    nb_producteurs_semenciers integer,
    nb_banques_semences integer,
    nb_bovins integer,
    nb_ovins integer,
    nb_caprins integer,
    autres_especes_autres text,
    nb_ruches_ken integer,
    nb_ruches_lang integer,
    nb_ruches_autres integer,
    nb_emplois_verts integer,
    desc_emplois_verts text,
    obs_org text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone DEFAULT now()
);


ALTER TABLE stage.agr_org_raw OWNER TO postgres;

--
-- Name: cep_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.cep_raw (
    raw_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_code text NOT NULL,
    id_cep text,
    filiere text,
    campagne_yyyy integer,
    id_commune text,
    surface_decl numeric(12,2),
    rendement numeric(12,2),
    menages_beneficiaires integer,
    geom public.geometry(Polygon,4326),
    raw_payload jsonb,
    import_source text NOT NULL,
    import_batch text,
    imported_at timestamp with time zone DEFAULT now() NOT NULL,
    pratiques_agroeco_codes text[],
    pratiques_autres text
);


ALTER TABLE stage.cep_raw OWNER TO postgres;

--
-- Name: cluster_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.cluster_raw (
    raw_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_code text NOT NULL,
    id_cluster text,
    filiere text,
    type_cluster text,
    id_commune text,
    description text,
    geom public.geometry(Point,4326),
    raw_payload jsonb,
    import_source text NOT NULL,
    import_batch uuid,
    imported_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE stage.cluster_raw OWNER TO postgres;

--
-- Name: couloir_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.couloir_raw (
    raw_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    submission_uuid uuid,
    submission_time timestamp with time zone,
    enumerator_id text,
    deviceid text,
    project_code text,
    region text,
    prefecture text,
    commune text,
    localite text,
    geom public.geometry(LineString,4326),
    id_couloir text,
    nom_couloir text,
    type_couloir text,
    longueur_km numeric,
    largeur_m numeric,
    especes_troupeaux text,
    especes_troupeaux_autres text,
    saison_usage text,
    saison_usage_autres text,
    statut_couloir text,
    localites_traversees text,
    infra_exist text,
    infra_autres text,
    types_conflits text,
    types_conflits_autres text,
    conflits_details text,
    appreciation_globale text,
    photo_couloir text,
    obs_couloir text,
    raw_payload jsonb,
    import_source text DEFAULT 'kobo_couloir'::text,
    import_batch uuid DEFAULT gen_random_uuid(),
    imported_at timestamp with time zone DEFAULT now()
);


ALTER TABLE stage.couloir_raw OWNER TO postgres;

--
-- Name: entreprise_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.entreprise_raw (
    raw_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_code text NOT NULL,
    id_entreprise text,
    raison_sociale text,
    organisation_type text,
    filiere text,
    id_commune text,
    geom public.geometry(Point,4326),
    raw_payload jsonb,
    import_source text NOT NULL,
    import_batch uuid,
    imported_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE stage.entreprise_raw OWNER TO postgres;

--
-- Name: fiere_empins_ent_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.fiere_empins_ent_raw (
    raw_uuid uuid NOT NULL,
    project_code text,
    id_commune text,
    localite text,
    geom public.geometry(Point,4326),
    id_ent text,
    raison_sociale text,
    annee_ref integer,
    periode_ref text,
    periode_ref_autres text,
    enreg_type text,
    emplois_total integer,
    emplois_femmes integer,
    emplois_jeunes integer,
    insert_total integer,
    insert_femmes integer,
    insert_jeunes integer,
    obs_emploi_ins text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone DEFAULT now()
);


ALTER TABLE stage.fiere_empins_ent_raw OWNER TO postgres;

--
-- Name: fiere_emploi_dom_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.fiere_emploi_dom_raw (
    id integer NOT NULL,
    raw_uuid uuid NOT NULL,
    domaine_emploi text,
    domaine_emploi_autres text,
    nb_empl_dom integer,
    nb_empl_fem_dom integer,
    nb_empl_jeunes_dom integer,
    nb_empl_pvh_dom integer,
    emploi_vert_dom text
);


ALTER TABLE stage.fiere_emploi_dom_raw OWNER TO postgres;

--
-- Name: fiere_emploi_dom_raw_id_seq; Type: SEQUENCE; Schema: stage; Owner: postgres
--

CREATE SEQUENCE stage.fiere_emploi_dom_raw_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE stage.fiere_emploi_dom_raw_id_seq OWNER TO postgres;

--
-- Name: fiere_emploi_dom_raw_id_seq; Type: SEQUENCE OWNED BY; Schema: stage; Owner: postgres
--

ALTER SEQUENCE stage.fiere_emploi_dom_raw_id_seq OWNED BY stage.fiere_emploi_dom_raw.id;


--
-- Name: fiere_entreprise_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.fiere_entreprise_raw (
    raw_uuid uuid NOT NULL,
    project_code text,
    id_commune text,
    localite text,
    geom public.geometry(Point,4326),
    id_ent text,
    raison_sociale text,
    nom_commercial text,
    statut_juridique text,
    statut_juridique_autres text,
    annee_creation integer,
    forme_propriete text,
    forme_propriete_autres text,
    secteur_principal text,
    secteur_principal_autres text,
    secteurs_secondaires text,
    secteurs_secondaires_autres text,
    activite_detaillee text,
    taille_entreprise text,
    effectif_total integer,
    ca_approx numeric(18,2),
    marche_principal text,
    enregistre_formel text,
    num_registre text,
    nom_responsable text,
    contact_telephon text,
    contact_email text,
    mpme_appuyee_fiere text,
    type_appui text,
    type_appui_autres text,
    obs_entreprise text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone DEFAULT now()
);


ALTER TABLE stage.fiere_entreprise_raw OWNER TO postgres;

--
-- Name: fiere_formation_part_cat_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.fiere_formation_part_cat_raw (
    id integer NOT NULL,
    raw_uuid uuid NOT NULL,
    categorie_participant text,
    categorie_participant_autres text,
    nb_part_cat integer,
    nb_part_fem_cat integer,
    nb_part_jeunes_cat integer
);


ALTER TABLE stage.fiere_formation_part_cat_raw OWNER TO postgres;

--
-- Name: fiere_formation_part_cat_raw_id_seq; Type: SEQUENCE; Schema: stage; Owner: postgres
--

CREATE SEQUENCE stage.fiere_formation_part_cat_raw_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE stage.fiere_formation_part_cat_raw_id_seq OWNER TO postgres;

--
-- Name: fiere_formation_part_cat_raw_id_seq; Type: SEQUENCE OWNED BY; Schema: stage; Owner: postgres
--

ALTER SEQUENCE stage.fiere_formation_part_cat_raw_id_seq OWNED BY stage.fiere_formation_part_cat_raw.id;


--
-- Name: fiere_formation_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.fiere_formation_raw (
    raw_uuid uuid NOT NULL,
    project_code text,
    id_commune text,
    localite text,
    geom public.geometry(Point,4326),
    formation_liee_ent text,
    id_ent text,
    raison_sociale text,
    org_beneficiaire text,
    id_formation text,
    intitule_formation text,
    organisme_formateur text,
    type_formation text,
    type_formation_autres text,
    modalite_formation text,
    date_debut date,
    date_fin date,
    duree_jours integer,
    filiere_principale text,
    filiere_principale_autres text,
    domaine_formation text,
    domaine_formation_autres text,
    participants_total integer,
    participants_femmes integer,
    participants_jeunes integer,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone DEFAULT now(),
    today text,
    participants_pvh integer,
    participants_pvh_femmes integer,
    participants_pvh_jeunes integer,
    participants_inscrits integer,
    participants_acheve integer
);


ALTER TABLE stage.fiere_formation_raw OWNER TO postgres;

--
-- Name: fiere_insertion_dom_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.fiere_insertion_dom_raw (
    id integer NOT NULL,
    raw_uuid uuid NOT NULL,
    domaine_insertion text,
    domaine_insertion_autres text,
    type_insertion text,
    type_insertion_autres text,
    nb_ins_dom integer,
    nb_ins_fem_dom integer,
    nb_ins_jeunes_dom integer,
    duree_insertion_mois numeric(6,2),
    nb_ins_pvh_dom integer,
    insertion_verte_dom text
);


ALTER TABLE stage.fiere_insertion_dom_raw OWNER TO postgres;

--
-- Name: fiere_insertion_dom_raw_id_seq; Type: SEQUENCE; Schema: stage; Owner: postgres
--

CREATE SEQUENCE stage.fiere_insertion_dom_raw_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE stage.fiere_insertion_dom_raw_id_seq OWNER TO postgres;

--
-- Name: fiere_insertion_dom_raw_id_seq; Type: SEQUENCE OWNED BY; Schema: stage; Owner: postgres
--

ALTER SEQUENCE stage.fiere_insertion_dom_raw_id_seq OWNED BY stage.fiere_insertion_dom_raw.id;


--
-- Name: fiere_participation_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.fiere_participation_raw (
    raw_uuid uuid NOT NULL,
    project_code text,
    id_commune text,
    localite text,
    geom public.geometry(Point,4326),
    type_acteur text,
    type_acteur_autres text,
    est_entreprise_fiere text,
    id_ent text,
    nom_acteur text,
    date_derniere_part date,
    type_participation text,
    type_participation_autres text,
    statut_convention text,
    intitule_dispositif text,
    objet_participation text,
    objet_participation_autres text,
    nb_part_12m integer,
    frequence_particip text,
    niveau_implication text,
    satisfaction_globale text,
    resultats_obtenus text,
    contraintes_particip text,
    obs_participation text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone DEFAULT now()
);


ALTER TABLE stage.fiere_participation_raw OWNER TO postgres;

--
-- Name: fiere_suivi_sortant_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.fiere_suivi_sortant_raw (
    raw_uuid uuid NOT NULL,
    project_code text,
    today text,
    region text,
    prefecture text,
    commune text,
    localite text,
    geom public.geometry(Point,4326),
    id_formation text,
    intitule_formation text,
    centre_formation text,
    date_fin_formation date,
    filiere_principale text,
    filiere_principale_autres text,
    domaine_formation text,
    domaine_formation_autres text,
    id_sortant text,
    nom_sortant text,
    sexe text,
    age integer,
    pvh text,
    niveau_etude text,
    telephone text,
    periode_suivi text,
    periode_suivi_autres text,
    date_suivi date,
    insere text,
    type_insertion text,
    type_insertion_autres text,
    domaine_emploi text,
    domaine_emploi_autres text,
    employeur_ou_activite text,
    emploi_en_lien_formation text,
    revenu_mensuel numeric,
    satisfaction_insertion text,
    raison_non_insertion text,
    obs_suivi text,
    obs_generales text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone DEFAULT now()
);


ALTER TABLE stage.fiere_suivi_sortant_raw OWNER TO postgres;

--
-- Name: insertion_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.insertion_raw (
    raw_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_code text NOT NULL,
    id_insertion text,
    id_beneficiaire text,
    id_entreprise text,
    id_organisation text,
    type_contrat text,
    statut text,
    date_debut date,
    date_fin date,
    remuneration_classe text,
    metier text,
    raw_payload jsonb,
    import_source text NOT NULL,
    import_batch uuid,
    imported_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE stage.insertion_raw OWNER TO postgres;

--
-- Name: intrant_comptoir_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.intrant_comptoir_raw (
    id bigint NOT NULL,
    submission_uuid uuid,
    submission_time timestamp with time zone,
    enumerator_id text,
    deviceid text,
    project_code text,
    region text,
    prefecture text,
    commune text,
    localite text,
    geom public.geometry(Point,4326),
    enreg_type text,
    filiere_intrant text,
    type_intrant text,
    intrant_autres text,
    campagne_intrant integer,
    quantite numeric(14,2),
    unite_intrant text,
    menages_ben_intr integer,
    source_intrant text,
    intrant_conforme text,
    motif_non_conf text,
    obs_intrant text,
    nom_comptoir text,
    filiere_comptoir text,
    filiere_autres text,
    type_comptoir text,
    frequence_marche text,
    gestionnaire text,
    obs_comptoir text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp with time zone DEFAULT now()
);


ALTER TABLE stage.intrant_comptoir_raw OWNER TO postgres;

--
-- Name: intrant_comptoir_raw_id_seq; Type: SEQUENCE; Schema: stage; Owner: postgres
--

CREATE SEQUENCE stage.intrant_comptoir_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE stage.intrant_comptoir_raw_id_seq OWNER TO postgres;

--
-- Name: intrant_comptoir_raw_id_seq; Type: SEQUENCE OWNED BY; Schema: stage; Owner: postgres
--

ALTER SEQUENCE stage.intrant_comptoir_raw_id_seq OWNED BY stage.intrant_comptoir_raw.id;


--
-- Name: intrant_distribution_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.intrant_distribution_raw (
    raw_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_code text NOT NULL,
    id_intrant text,
    filiere text,
    type_intrant text,
    campagne_yyyy integer,
    id_commune text,
    quantite numeric(14,2),
    menages_beneficiaires integer,
    geom public.geometry(Point,4326),
    raw_payload jsonb,
    import_source text NOT NULL,
    import_batch uuid,
    imported_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE stage.intrant_distribution_raw OWNER TO postgres;

--
-- Name: kit_distribution_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.kit_distribution_raw (
    raw_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_code text NOT NULL,
    id_kit text,
    kit_type text,
    id_beneficiaire text,
    id_organisation text,
    quantite integer,
    date_dotation date,
    raw_payload jsonb,
    import_source text NOT NULL,
    import_batch uuid,
    imported_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE stage.kit_distribution_raw OWNER TO postgres;

--
-- Name: marche_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.marche_raw (
    raw_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_code text NOT NULL,
    id_marche text,
    filiere text,
    campagne_yyyy integer,
    id_commune text,
    volume numeric(14,2),
    prix_unitaire numeric(14,2),
    devise text,
    acheteur text,
    date_vente date,
    organisation_code text,
    raw_payload jsonb,
    import_source text NOT NULL,
    import_batch uuid,
    imported_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE stage.marche_raw OWNER TO postgres;

--
-- Name: meteo_mesure_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.meteo_mesure_raw (
    raw_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_code text NOT NULL,
    code_station text,
    ts_obs timestamp with time zone,
    pluie_mm numeric(8,2),
    t_min numeric(5,2),
    t_max numeric(5,2),
    raw_payload jsonb,
    import_source text NOT NULL,
    import_batch uuid,
    imported_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE stage.meteo_mesure_raw OWNER TO postgres;

--
-- Name: meteo_station_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.meteo_station_raw (
    raw_uuid uuid NOT NULL,
    project_code text,
    id_commune text,
    localite text,
    geom public.geometry(Point,4326),
    station_presente text,
    code_station text,
    nom_station text,
    type_station text,
    type_station_autres text,
    proprietaire text,
    proprietaire_autres text,
    statut_station text,
    date_mise_service date,
    frequence_mesure text,
    type_releve text,
    etat_equipements text,
    obs_station text,
    saisie_pluie text,
    date_obs date,
    pluie_mm numeric(14,2),
    t_min numeric(14,2),
    t_max numeric(14,2),
    obs_pluie text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone DEFAULT now()
);


ALTER TABLE stage.meteo_station_raw OWNER TO postgres;

--
-- Name: ouvrage_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.ouvrage_raw (
    raw_uuid uuid NOT NULL,
    project_code text,
    enumerator_id text,
    deviceid text,
    today date,
    region text,
    prefecture text,
    commune text,
    localite text,
    geom public.geometry(Point,4326),
    ouv_present text,
    code_ouvrage text,
    ouv_types text,
    autre_ouv_preciser text,
    longueur_anti_m numeric(14,2),
    etat_anti text,
    surface_couv_ha numeric(14,2),
    etat_couv text,
    photo_ouvr text,
    obs_ouvr text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp with time zone DEFAULT now()
);


ALTER TABLE stage.ouvrage_raw OWNER TO postgres;

--
-- Name: participation_formation_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.participation_formation_raw (
    raw_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_code text NOT NULL,
    id_session text,
    id_beneficiaire text,
    id_organisation text,
    heures_suivies numeric(6,2),
    attestation boolean,
    raw_payload jsonb,
    import_source text NOT NULL,
    import_batch uuid,
    imported_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE stage.participation_formation_raw OWNER TO postgres;

--
-- Name: pratiques_agro_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.pratiques_agro_raw (
    raw_uuid uuid NOT NULL,
    project_code text,
    id_commune text,
    localite text,
    geom public.geometry(Point,4326),
    id_cep text,
    campagne integer,
    culture_principale text,
    culture_principale_autres text,
    surface_ha numeric(14,2),
    production_totale numeric(14,2),
    rendement_calc numeric(14,2),
    rendement_observe numeric(14,2),
    pratiques_appliquees text,
    pratiques_agro text,
    pratiques_autres text,
    nb_annees_pratiques integer,
    effet_rendement text,
    effet_sols text,
    obs_pratiques text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone DEFAULT now()
);


ALTER TABLE stage.pratiques_agro_raw OWNER TO postgres;

--
-- Name: session_formation_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.session_formation_raw (
    raw_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    project_code text NOT NULL,
    id_session text,
    type_formation text,
    theme text,
    date_debut date,
    date_fin date,
    id_site text,
    id_commune text,
    nb_heures numeric(6,2),
    raw_payload jsonb,
    import_source text NOT NULL,
    import_batch uuid,
    imported_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE stage.session_formation_raw OWNER TO postgres;

--
-- Name: tete_source_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.tete_source_raw (
    raw_uuid uuid NOT NULL,
    project_code text,
    id_commune text,
    localite text,
    geom public.geometry(Point,4326),
    source_presente text,
    id_ts text,
    type_source text,
    type_source_autres text,
    usage_principal text,
    pop_desservie integer,
    protection_exist text,
    type_protection text,
    protections_autres text,
    etat_fonctionnel text,
    annee_protection integer,
    entretien_regulier text,
    resp_entretien text,
    obs_ts text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone DEFAULT now()
);


ALTER TABLE stage.tete_source_raw OWNER TO postgres;

--
-- Name: zone_degradee_raw; Type: TABLE; Schema: stage; Owner: postgres
--

CREATE TABLE stage.zone_degradee_raw (
    raw_uuid uuid NOT NULL,
    project_code text,
    id_commune text,
    localite text,
    geom_point public.geometry(Point,4326),
    geom_zone public.geometry(Polygon,4326),
    zone_degrad_pres text,
    id_zone text,
    type_degradation text,
    severite text,
    surface_degrad_ha numeric(14,2),
    cause_detail text,
    obs_degrad text,
    restauration_real text,
    type_intervention text,
    autre_interv_prec text,
    surface_restaur_ha numeric(14,2),
    nb_plants integer,
    densite_plants_ha numeric(14,2),
    especes text,
    especes_autres text,
    annee_plantation integer,
    suivi_plantation text,
    taux_survie_pct integer,
    surf_regen_ha numeric(14,2),
    pratiques_regen text,
    nb_terrasses integer,
    longueur_terr_m numeric(14,2),
    autre_interv_descr text,
    etat_restaur text,
    obs_restaur text,
    raw_payload jsonb,
    import_source text,
    import_batch text,
    imported_at timestamp without time zone DEFAULT now()
);


ALTER TABLE stage.zone_degradee_raw OWNER TO postgres;

--
-- Name: agglomeration id; Type: DEFAULT; Schema: import; Owner: postgres
--

ALTER TABLE ONLY import.agglomeration ALTER COLUMN id SET DEFAULT nextval('import.agglomeration_id_seq'::regclass);


--
-- Name: localite_osm id; Type: DEFAULT; Schema: import; Owner: postgres
--

ALTER TABLE ONLY import.localite_osm ALTER COLUMN id SET DEFAULT nextval('import.localite_osm_id_seq'::regclass);


--
-- Name: pref_adm2 id; Type: DEFAULT; Schema: import; Owner: postgres
--

ALTER TABLE ONLY import.pref_adm2 ALTER COLUMN id SET DEFAULT nextval('import.pref_adm2_id_seq'::regclass);


--
-- Name: region_adm1 id; Type: DEFAULT; Schema: import; Owner: postgres
--

ALTER TABLE ONLY import.region_adm1 ALTER COLUMN id SET DEFAULT nextval('import.region_adm1_id_seq'::regclass);


--
-- Name: souspref_adm3 id; Type: DEFAULT; Schema: import; Owner: postgres
--

ALTER TABLE ONLY import.souspref_adm3 ALTER COLUMN id SET DEFAULT nextval('import.souspref_adm3_id_seq'::regclass);


--
-- Name: agglomeration agglom_id; Type: DEFAULT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.agglomeration ALTER COLUMN agglom_id SET DEFAULT nextval('ref.agglomeration_agglom_id_seq'::regclass);


--
-- Name: aire_protegee ap_id; Type: DEFAULT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.aire_protegee ALTER COLUMN ap_id SET DEFAULT nextval('ref.aire_protegee_ap_id_seq'::regclass);


--
-- Name: equipement equip_id; Type: DEFAULT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.equipement ALTER COLUMN equip_id SET DEFAULT nextval('ref.equipement_equip_id_seq'::regclass);


--
-- Name: habitation_dispersee hab_id; Type: DEFAULT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.habitation_dispersee ALTER COLUMN hab_id SET DEFAULT nextval('ref.habitation_dispersee_hab_id_seq'::regclass);


--
-- Name: hydrographie id; Type: DEFAULT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.hydrographie ALTER COLUMN id SET DEFAULT nextval('ref.hydrographie_id_seq'::regclass);


--
-- Name: localite localite_id; Type: DEFAULT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.localite ALTER COLUMN localite_id SET DEFAULT nextval('ref.localite_localite_id_seq'::regclass);


--
-- Name: occupation_sol occsol_id; Type: DEFAULT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.occupation_sol ALTER COLUMN occsol_id SET DEFAULT nextval('ref.occupation_sol_occsol_id_seq'::regclass);


--
-- Name: reseau_routier id; Type: DEFAULT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.reseau_routier ALTER COLUMN id SET DEFAULT nextval('ref.reseau_routier_id_seq'::regclass);


--
-- Name: zone_humide zh_id; Type: DEFAULT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.zone_humide ALTER COLUMN zh_id SET DEFAULT nextval('ref.zone_humide_zh_id_seq'::regclass);


--
-- Name: zone_sableuse zs_id; Type: DEFAULT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.zone_sableuse ALTER COLUMN zs_id SET DEFAULT nextval('ref.zone_sableuse_zs_id_seq'::regclass);


--
-- Name: agr_cep_raw id; Type: DEFAULT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.agr_cep_raw ALTER COLUMN id SET DEFAULT nextval('stage.agr_cep_raw_id_seq'::regclass);


--
-- Name: fiere_emploi_dom_raw id; Type: DEFAULT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.fiere_emploi_dom_raw ALTER COLUMN id SET DEFAULT nextval('stage.fiere_emploi_dom_raw_id_seq'::regclass);


--
-- Name: fiere_formation_part_cat_raw id; Type: DEFAULT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.fiere_formation_part_cat_raw ALTER COLUMN id SET DEFAULT nextval('stage.fiere_formation_part_cat_raw_id_seq'::regclass);


--
-- Name: fiere_insertion_dom_raw id; Type: DEFAULT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.fiere_insertion_dom_raw ALTER COLUMN id SET DEFAULT nextval('stage.fiere_insertion_dom_raw_id_seq'::regclass);


--
-- Name: intrant_comptoir_raw id; Type: DEFAULT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.intrant_comptoir_raw ALTER COLUMN id SET DEFAULT nextval('stage.intrant_comptoir_raw_id_seq'::regclass);


--
-- Name: etl_run etl_run_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY audit.etl_run
    ADD CONSTRAINT etl_run_pkey PRIMARY KEY (run_id);


--
-- Name: import_log import_log_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY audit.import_log
    ADD CONSTRAINT import_log_pkey PRIMARY KEY (import_uuid);


--
-- Name: acteur_participation acteur_participation_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.acteur_participation
    ADD CONSTRAINT acteur_participation_pkey PRIMARY KEY (participation_uuid);


--
-- Name: acteur_participation acteur_participation_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.acteur_participation
    ADD CONSTRAINT acteur_participation_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: agr_comite agr_comite_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_comite
    ADD CONSTRAINT agr_comite_pkey PRIMARY KEY (comite_uuid);


--
-- Name: agr_comite agr_comite_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_comite
    ADD CONSTRAINT agr_comite_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: agr_menage agr_menage_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_menage
    ADD CONSTRAINT agr_menage_pkey PRIMARY KEY (menage_uuid);


--
-- Name: agr_menage agr_menage_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_menage
    ADD CONSTRAINT agr_menage_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: agr_organisation agr_org_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_organisation
    ADD CONSTRAINT agr_org_pkey PRIMARY KEY (org_uuid);


--
-- Name: agr_organisation agr_org_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_organisation
    ADD CONSTRAINT agr_org_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: beneficiaire beneficiaire_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.beneficiaire
    ADD CONSTRAINT beneficiaire_pkey PRIMARY KEY (beneficiaire_uuid);


--
-- Name: cep_parcelle cep_parcelle_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.cep_parcelle
    ADD CONSTRAINT cep_parcelle_pkey PRIMARY KEY (cep_uuid);


--
-- Name: cluster_organisation cluster_organisation_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.cluster_organisation
    ADD CONSTRAINT cluster_organisation_pkey PRIMARY KEY (cluster_uuid, organisation_uuid);


--
-- Name: cluster cluster_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.cluster
    ADD CONSTRAINT cluster_pkey PRIMARY KEY (cluster_uuid);


--
-- Name: couloir couloir_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.couloir
    ADD CONSTRAINT couloir_pkey PRIMARY KEY (couloir_uuid);


--
-- Name: couloir couloir_project_code_id_uk; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.couloir
    ADD CONSTRAINT couloir_project_code_id_uk UNIQUE (project_code, id_couloir);


--
-- Name: ent_emploi_dom ent_emploi_dom_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.ent_emploi_dom
    ADD CONSTRAINT ent_emploi_dom_pkey PRIMARY KEY (emploi_dom_uuid);


--
-- Name: ent_emploi ent_emploi_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.ent_emploi
    ADD CONSTRAINT ent_emploi_pkey PRIMARY KEY (emploi_uuid);


--
-- Name: ent_emploi ent_emploi_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.ent_emploi
    ADD CONSTRAINT ent_emploi_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: ent_insertion_dom ent_insertion_dom_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.ent_insertion_dom
    ADD CONSTRAINT ent_insertion_dom_pkey PRIMARY KEY (insertion_dom_uuid);


--
-- Name: ent_insertion ent_insertion_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.ent_insertion
    ADD CONSTRAINT ent_insertion_pkey PRIMARY KEY (insertion_uuid);


--
-- Name: ent_insertion ent_insertion_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.ent_insertion
    ADD CONSTRAINT ent_insertion_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: entreprise_econ entreprise_econ_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.entreprise_econ
    ADD CONSTRAINT entreprise_econ_pkey PRIMARY KEY (ent_uuid);


--
-- Name: entreprise_econ entreprise_econ_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.entreprise_econ
    ADD CONSTRAINT entreprise_econ_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: entreprise entreprise_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.entreprise
    ADD CONSTRAINT entreprise_pkey PRIMARY KEY (entreprise_uuid);


--
-- Name: fiere_suivi_sortant fiere_suivi_sortant_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.fiere_suivi_sortant
    ADD CONSTRAINT fiere_suivi_sortant_pkey PRIMARY KEY (suivi_uuid);


--
-- Name: fiere_suivi_sortant fiere_suivi_sortant_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.fiere_suivi_sortant
    ADD CONSTRAINT fiere_suivi_sortant_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: formation_eco formation_eco_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.formation_eco
    ADD CONSTRAINT formation_eco_pkey PRIMARY KEY (formation_uuid);


--
-- Name: formation_eco formation_eco_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.formation_eco
    ADD CONSTRAINT formation_eco_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: formation_part_cat formation_part_cat_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.formation_part_cat
    ADD CONSTRAINT formation_part_cat_pkey PRIMARY KEY (formation_part_uuid);


--
-- Name: insertion insertion_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.insertion
    ADD CONSTRAINT insertion_pkey PRIMARY KEY (insertion_uuid);


--
-- Name: intrant_distribution intrant_distribution_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.intrant_distribution
    ADD CONSTRAINT intrant_distribution_pkey PRIMARY KEY (intrant_uuid);


--
-- Name: intrant_distribution intrant_distribution_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.intrant_distribution
    ADD CONSTRAINT intrant_distribution_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: kit_distribution kit_distribution_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.kit_distribution
    ADD CONSTRAINT kit_distribution_pkey PRIMARY KEY (kit_uuid);


--
-- Name: marche marche_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.marche
    ADD CONSTRAINT marche_pkey PRIMARY KEY (marche_uuid);


--
-- Name: marche marche_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.marche
    ADD CONSTRAINT marche_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: meteo_mesure meteo_mesure_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.meteo_mesure
    ADD CONSTRAINT meteo_mesure_pkey PRIMARY KEY (mesure_uuid);


--
-- Name: meteo_mesure meteo_mesure_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.meteo_mesure
    ADD CONSTRAINT meteo_mesure_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: meteo_station meteo_station_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.meteo_station
    ADD CONSTRAINT meteo_station_pkey PRIMARY KEY (station_uuid);


--
-- Name: meteo_station meteo_station_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.meteo_station
    ADD CONSTRAINT meteo_station_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: org_acteur org_acteur_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.org_acteur
    ADD CONSTRAINT org_acteur_pkey PRIMARY KEY (org_uuid);


--
-- Name: organisation organisation_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.organisation
    ADD CONSTRAINT organisation_pkey PRIMARY KEY (organisation_uuid);


--
-- Name: ouvrage ouvrage_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.ouvrage
    ADD CONSTRAINT ouvrage_pkey PRIMARY KEY (ouvrage_uuid);


--
-- Name: ouvrage ouvrage_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.ouvrage
    ADD CONSTRAINT ouvrage_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: participation_formation participation_formation_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.participation_formation
    ADD CONSTRAINT participation_formation_pkey PRIMARY KEY (participation_uuid);


--
-- Name: pratiques_agro_parcelle pratiques_agro_parcelle_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.pratiques_agro_parcelle
    ADD CONSTRAINT pratiques_agro_parcelle_pkey PRIMARY KEY (pratique_uuid);


--
-- Name: pratiques_agro_parcelle pratiques_agro_parcelle_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.pratiques_agro_parcelle
    ADD CONSTRAINT pratiques_agro_parcelle_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: session_formation session_formation_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.session_formation
    ADD CONSTRAINT session_formation_pkey PRIMARY KEY (session_uuid);


--
-- Name: site site_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.site
    ADD CONSTRAINT site_pkey PRIMARY KEY (site_uuid);


--
-- Name: tete_source tete_source_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.tete_source
    ADD CONSTRAINT tete_source_pkey PRIMARY KEY (ts_uuid);


--
-- Name: tete_source tete_source_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.tete_source
    ADD CONSTRAINT tete_source_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: agr_comite uq_agr_comite; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_comite
    ADD CONSTRAINT uq_agr_comite UNIQUE (project_code, id_comite);


--
-- Name: agr_menage uq_agr_menage; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_menage
    ADD CONSTRAINT uq_agr_menage UNIQUE (project_code, id_menage);


--
-- Name: agr_organisation uq_agr_org_code; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_organisation
    ADD CONSTRAINT uq_agr_org_code UNIQUE (project_code, id_org);


--
-- Name: entreprise_econ uq_ent_econ_code; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.entreprise_econ
    ADD CONSTRAINT uq_ent_econ_code UNIQUE (project_code, id_ent);


--
-- Name: fiere_suivi_sortant uq_fiere_suivi; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.fiere_suivi_sortant
    ADD CONSTRAINT uq_fiere_suivi UNIQUE (project_code, id_sortant, periode_suivi);


--
-- Name: formation_eco uq_formation_code; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.formation_eco
    ADD CONSTRAINT uq_formation_code UNIQUE (project_code, id_formation);


--
-- Name: meteo_station uq_meteo_station_code; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.meteo_station
    ADD CONSTRAINT uq_meteo_station_code UNIQUE (project_code, code_station);


--
-- Name: tete_source uq_ts_code; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.tete_source
    ADD CONSTRAINT uq_ts_code UNIQUE (project_code, id_ts);


--
-- Name: zone_degradee uq_zone_code; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.zone_degradee
    ADD CONSTRAINT uq_zone_code UNIQUE (project_code, id_zone);


--
-- Name: zone_degradee zone_degradee_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.zone_degradee
    ADD CONSTRAINT zone_degradee_pkey PRIMARY KEY (zone_uuid);


--
-- Name: zone_degradee zone_degradee_raw_uuid_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.zone_degradee
    ADD CONSTRAINT zone_degradee_raw_uuid_key UNIQUE (raw_uuid);


--
-- Name: agglomeration agglomeration_pkey; Type: CONSTRAINT; Schema: import; Owner: postgres
--

ALTER TABLE ONLY import.agglomeration
    ADD CONSTRAINT agglomeration_pkey PRIMARY KEY (id);


--
-- Name: localite_osm localite_osm_pkey; Type: CONSTRAINT; Schema: import; Owner: postgres
--

ALTER TABLE ONLY import.localite_osm
    ADD CONSTRAINT localite_osm_pkey PRIMARY KEY (id);


--
-- Name: pref_adm2 pref_adm2_pkey; Type: CONSTRAINT; Schema: import; Owner: postgres
--

ALTER TABLE ONLY import.pref_adm2
    ADD CONSTRAINT pref_adm2_pkey PRIMARY KEY (id);


--
-- Name: region_adm1 region_adm1_pkey; Type: CONSTRAINT; Schema: import; Owner: postgres
--

ALTER TABLE ONLY import.region_adm1
    ADD CONSTRAINT region_adm1_pkey PRIMARY KEY (id);


--
-- Name: souspref_adm3 souspref_adm3_pkey; Type: CONSTRAINT; Schema: import; Owner: postgres
--

ALTER TABLE ONLY import.souspref_adm3
    ADD CONSTRAINT souspref_adm3_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_projects accounts_user_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_projects
    ADD CONSTRAINT accounts_user_projects_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_projects accounts_user_projects_user_id_refproject_id_158565e1_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_projects
    ADD CONSTRAINT accounts_user_projects_user_id_refproject_id_158565e1_uniq UNIQUE (user_id, refproject_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: accounts_user accounts_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_username_key UNIQUE (username);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: data_quality_report data_quality_report_pkey; Type: CONSTRAINT; Schema: qa; Owner: postgres
--

ALTER TABLE ONLY qa.data_quality_report
    ADD CONSTRAINT data_quality_report_pkey PRIMARY KEY (qa_uuid);


--
-- Name: run_metrics run_metrics_pkey; Type: CONSTRAINT; Schema: qa; Owner: postgres
--

ALTER TABLE ONLY qa.run_metrics
    ADD CONSTRAINT run_metrics_pkey PRIMARY KEY (run_id);


--
-- Name: activite_organisation activite_org_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.activite_organisation
    ADD CONSTRAINT activite_org_pkey PRIMARY KEY (code);


--
-- Name: admin_commune admin_commune_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.admin_commune
    ADD CONSTRAINT admin_commune_pkey PRIMARY KEY (id_commune);


--
-- Name: admin_prefecture admin_prefecture_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.admin_prefecture
    ADD CONSTRAINT admin_prefecture_pkey PRIMARY KEY (id_prefecture);


--
-- Name: admin_region admin_region_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.admin_region
    ADD CONSTRAINT admin_region_pkey PRIMARY KEY (id_region);


--
-- Name: agglomeration agglomeration_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.agglomeration
    ADD CONSTRAINT agglomeration_pkey PRIMARY KEY (agglom_id);


--
-- Name: aire_protegee aire_protegee_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.aire_protegee
    ADD CONSTRAINT aire_protegee_pkey PRIMARY KEY (ap_id);


--
-- Name: app_global app_global_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.app_global
    ADD CONSTRAINT app_global_pkey PRIMARY KEY (code);


--
-- Name: appui_type appui_type_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.appui_type
    ADD CONSTRAINT appui_type_pkey PRIMARY KEY (code);


--
-- Name: categorie_participant categorie_participant_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.categorie_participant
    ADD CONSTRAINT categorie_participant_pkey PRIMARY KEY (code);


--
-- Name: cluster_type cluster_type_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.cluster_type
    ADD CONSTRAINT cluster_type_pkey PRIMARY KEY (code);


--
-- Name: comptoir_type comptoir_type_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.comptoir_type
    ADD CONSTRAINT comptoir_type_pkey PRIMARY KEY (code);


--
-- Name: controle_resultat controle_resultat_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.controle_resultat
    ADD CONSTRAINT controle_resultat_pkey PRIMARY KEY (code);


--
-- Name: couloir_appreciation couloir_appreciation_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.couloir_appreciation
    ADD CONSTRAINT couloir_appreciation_pkey PRIMARY KEY (code);


--
-- Name: culture culture_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.culture
    ADD CONSTRAINT culture_pkey PRIMARY KEY (code);


--
-- Name: domaine_emploi domaine_emploi_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.domaine_emploi
    ADD CONSTRAINT domaine_emploi_pkey PRIMARY KEY (code);


--
-- Name: domaine_formation domaine_formation_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.domaine_formation
    ADD CONSTRAINT domaine_formation_pkey PRIMARY KEY (code);


--
-- Name: effet_niveau effet_niveau_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.effet_niveau
    ADD CONSTRAINT effet_niveau_pkey PRIMARY KEY (code);


--
-- Name: equipement equipement_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.equipement
    ADD CONSTRAINT equipement_pkey PRIMARY KEY (equip_id);


--
-- Name: espece_reboisement espece_reboisement_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.espece_reboisement
    ADD CONSTRAINT espece_reboisement_pkey PRIMARY KEY (code);


--
-- Name: espece_troupeau espece_troupeau_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.espece_troupeau
    ADD CONSTRAINT espece_troupeau_pkey PRIMARY KEY (code);


--
-- Name: etat_equip etat_equip_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.etat_equip
    ADD CONSTRAINT etat_equip_pkey PRIMARY KEY (code);


--
-- Name: etat_fonctionnel etat_fonctionnel_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.etat_fonctionnel
    ADD CONSTRAINT etat_fonctionnel_pkey PRIMARY KEY (code);


--
-- Name: etat_ouvrage etat_ouvrage_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.etat_ouvrage
    ADD CONSTRAINT etat_ouvrage_pkey PRIMARY KEY (code);


--
-- Name: etat_restaur etat_restaur_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.etat_restaur
    ADD CONSTRAINT etat_restaur_pkey PRIMARY KEY (code);


--
-- Name: filiere filiere_libelle_key; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.filiere
    ADD CONSTRAINT filiere_libelle_key UNIQUE (libelle);


--
-- Name: filiere filiere_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.filiere
    ADD CONSTRAINT filiere_pkey PRIMARY KEY (code);


--
-- Name: formation_type formation_type_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.formation_type
    ADD CONSTRAINT formation_type_pkey PRIMARY KEY (code);


--
-- Name: forme_propriete_ent forme_propriete_ent_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.forme_propriete_ent
    ADD CONSTRAINT forme_propriete_ent_pkey PRIMARY KEY (code);


--
-- Name: freq_mesure freq_mesure_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.freq_mesure
    ADD CONSTRAINT freq_mesure_pkey PRIMARY KEY (code);


--
-- Name: freq_participation freq_participation_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.freq_participation
    ADD CONSTRAINT freq_participation_pkey PRIMARY KEY (code);


--
-- Name: freq_pratique freq_pratique_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.freq_pratique
    ADD CONSTRAINT freq_pratique_pkey PRIMARY KEY (code);


--
-- Name: frequence_marche frequence_marche_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.frequence_marche
    ADD CONSTRAINT frequence_marche_pkey PRIMARY KEY (code);


--
-- Name: habitation_dispersee habitation_dispersee_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.habitation_dispersee
    ADD CONSTRAINT habitation_dispersee_pkey PRIMARY KEY (hab_id);


--
-- Name: hydrographie hydrographie_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.hydrographie
    ADD CONSTRAINT hydrographie_pkey PRIMARY KEY (id);


--
-- Name: infra_pastorale infra_pastorale_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.infra_pastorale
    ADD CONSTRAINT infra_pastorale_pkey PRIMARY KEY (code);


--
-- Name: intrant_conforme intrant_conforme_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.intrant_conforme
    ADD CONSTRAINT intrant_conforme_pkey PRIMARY KEY (code);


--
-- Name: intrant_type intrant_type_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.intrant_type
    ADD CONSTRAINT intrant_type_pkey PRIMARY KEY (code);


--
-- Name: kit_type kit_type_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.kit_type
    ADD CONSTRAINT kit_type_pkey PRIMARY KEY (code);


--
-- Name: localite localite_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.localite
    ADD CONSTRAINT localite_pkey PRIMARY KEY (localite_id);


--
-- Name: marche_principal marche_principal_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.marche_principal
    ADD CONSTRAINT marche_principal_pkey PRIMARY KEY (code);


--
-- Name: modalite_formation modalite_formation_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.modalite_formation
    ADD CONSTRAINT modalite_formation_pkey PRIMARY KEY (code);


--
-- Name: niveau_etude niveau_etude_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.niveau_etude
    ADD CONSTRAINT niveau_etude_pkey PRIMARY KEY (code);


--
-- Name: niveau_implication niveau_implication_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.niveau_implication
    ADD CONSTRAINT niveau_implication_pkey PRIMARY KEY (code);


--
-- Name: objet_participation objet_participation_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.objet_participation
    ADD CONSTRAINT objet_participation_pkey PRIMARY KEY (code);


--
-- Name: occupation_sol occupation_sol_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.occupation_sol
    ADD CONSTRAINT occupation_sol_pkey PRIMARY KEY (occsol_id);


--
-- Name: organisation_type organisation_type_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.organisation_type
    ADD CONSTRAINT organisation_type_pkey PRIMARY KEY (code);


--
-- Name: periode_ref periode_ref_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.periode_ref
    ADD CONSTRAINT periode_ref_pkey PRIMARY KEY (code);


--
-- Name: periode_suivi periode_suivi_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.periode_suivi
    ADD CONSTRAINT periode_suivi_pkey PRIMARY KEY (code);


--
-- Name: pratique_agro pratique_agro_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.pratique_agro
    ADD CONSTRAINT pratique_agro_pkey PRIMARY KEY (code);


--
-- Name: pratique_nutrition pratique_nutrition_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.pratique_nutrition
    ADD CONSTRAINT pratique_nutrition_pkey PRIMARY KEY (code);


--
-- Name: projet projet_code_fonc_key; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.projet
    ADD CONSTRAINT projet_code_fonc_key UNIQUE (code_fonc);


--
-- Name: projet projet_code_kobo_key; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.projet
    ADD CONSTRAINT projet_code_kobo_key UNIQUE (code_kobo);


--
-- Name: projet projet_code_kobo_uk; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.projet
    ADD CONSTRAINT projet_code_kobo_uk UNIQUE (code_kobo);


--
-- Name: projet projet_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.projet
    ADD CONSTRAINT projet_pkey PRIMARY KEY (project_id);


--
-- Name: proprietaire_station proprietaire_station_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.proprietaire_station
    ADD CONSTRAINT proprietaire_station_pkey PRIMARY KEY (code);


--
-- Name: reseau_routier reseau_routier_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.reseau_routier
    ADD CONSTRAINT reseau_routier_pkey PRIMARY KEY (id);


--
-- Name: saison_usage saison_usage_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.saison_usage
    ADD CONSTRAINT saison_usage_pkey PRIMARY KEY (code);


--
-- Name: satisfaction_globale satisfaction_globale_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.satisfaction_globale
    ADD CONSTRAINT satisfaction_globale_pkey PRIMARY KEY (code);


--
-- Name: secteur_eco secteur_eco_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.secteur_eco
    ADD CONSTRAINT secteur_eco_pkey PRIMARY KEY (code);


--
-- Name: severite_degradation severite_degradation_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.severite_degradation
    ADD CONSTRAINT severite_degradation_pkey PRIMARY KEY (code);


--
-- Name: sexe_sortant sexe_sortant_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.sexe_sortant
    ADD CONSTRAINT sexe_sortant_pkey PRIMARY KEY (code);


--
-- Name: source_info source_info_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.source_info
    ADD CONSTRAINT source_info_pkey PRIMARY KEY (code);


--
-- Name: statut_comite statut_comite_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.statut_comite
    ADD CONSTRAINT statut_comite_pkey PRIMARY KEY (code);


--
-- Name: statut_convention_cfpa statut_convention_cfpa_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.statut_convention_cfpa
    ADD CONSTRAINT statut_convention_cfpa_pkey PRIMARY KEY (code);


--
-- Name: statut_couloir statut_couloir_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.statut_couloir
    ADD CONSTRAINT statut_couloir_pkey PRIMARY KEY (code);


--
-- Name: statut_juridique_ent statut_juridique_ent_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.statut_juridique_ent
    ADD CONSTRAINT statut_juridique_ent_pkey PRIMARY KEY (code);


--
-- Name: statut_juridique statut_juridique_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.statut_juridique
    ADD CONSTRAINT statut_juridique_pkey PRIMARY KEY (code);


--
-- Name: statut_station statut_station_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.statut_station
    ADD CONSTRAINT statut_station_pkey PRIMARY KEY (code);


--
-- Name: taille_entreprise taille_entreprise_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.taille_entreprise
    ADD CONSTRAINT taille_entreprise_pkey PRIMARY KEY (code);


--
-- Name: theme_comite theme_comite_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.theme_comite
    ADD CONSTRAINT theme_comite_pkey PRIMARY KEY (code);


--
-- Name: theme_sensib theme_sensib_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.theme_sensib
    ADD CONSTRAINT theme_sensib_pkey PRIMARY KEY (code);


--
-- Name: type_acteur type_acteur_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_acteur
    ADD CONSTRAINT type_acteur_pkey PRIMARY KEY (code);


--
-- Name: type_appui_ent type_appui_ent_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_appui_ent
    ADD CONSTRAINT type_appui_ent_pkey PRIMARY KEY (code);


--
-- Name: type_comite type_comite_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_comite
    ADD CONSTRAINT type_comite_pkey PRIMARY KEY (code);


--
-- Name: type_conflit type_conflit_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_conflit
    ADD CONSTRAINT type_conflit_pkey PRIMARY KEY (code);


--
-- Name: type_couloir type_couloir_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_couloir
    ADD CONSTRAINT type_couloir_pkey PRIMARY KEY (code);


--
-- Name: type_degradation type_degradation_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_degradation
    ADD CONSTRAINT type_degradation_pkey PRIMARY KEY (code);


--
-- Name: type_formation type_formation_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_formation
    ADD CONSTRAINT type_formation_pkey PRIMARY KEY (code);


--
-- Name: type_foyer type_foyer_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_foyer
    ADD CONSTRAINT type_foyer_pkey PRIMARY KEY (code);


--
-- Name: type_insertion type_insertion_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_insertion
    ADD CONSTRAINT type_insertion_pkey PRIMARY KEY (code);


--
-- Name: type_intervention type_intervention_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_intervention
    ADD CONSTRAINT type_intervention_pkey PRIMARY KEY (code);


--
-- Name: type_intrant type_intrant_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_intrant
    ADD CONSTRAINT type_intrant_pkey PRIMARY KEY (code);


--
-- Name: type_menage type_menage_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_menage
    ADD CONSTRAINT type_menage_pkey PRIMARY KEY (code);


--
-- Name: type_organisation type_org_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_organisation
    ADD CONSTRAINT type_org_pkey PRIMARY KEY (code);


--
-- Name: type_ouvrage type_ouvrage_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_ouvrage
    ADD CONSTRAINT type_ouvrage_pkey PRIMARY KEY (code);


--
-- Name: type_participation type_participation_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_participation
    ADD CONSTRAINT type_participation_pkey PRIMARY KEY (code);


--
-- Name: type_protection type_protection_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_protection
    ADD CONSTRAINT type_protection_pkey PRIMARY KEY (code);


--
-- Name: type_releve type_releve_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_releve
    ADD CONSTRAINT type_releve_pkey PRIMARY KEY (code);


--
-- Name: type_site type_site_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_site
    ADD CONSTRAINT type_site_pkey PRIMARY KEY (code);


--
-- Name: type_source type_source_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_source
    ADD CONSTRAINT type_source_pkey PRIMARY KEY (code);


--
-- Name: type_station type_station_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_station
    ADD CONSTRAINT type_station_pkey PRIMARY KEY (code);


--
-- Name: type_tech type_tech_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.type_tech
    ADD CONSTRAINT type_tech_pkey PRIMARY KEY (code);


--
-- Name: types_conflit types_conflit_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.types_conflit
    ADD CONSTRAINT types_conflit_pkey PRIMARY KEY (code);


--
-- Name: unite_intrant unite_intrant_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.unite_intrant
    ADD CONSTRAINT unite_intrant_pkey PRIMARY KEY (code);


--
-- Name: usage_source usage_source_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.usage_source
    ADD CONSTRAINT usage_source_pkey PRIMARY KEY (code);


--
-- Name: zone_humide zone_humide_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.zone_humide
    ADD CONSTRAINT zone_humide_pkey PRIMARY KEY (zh_id);


--
-- Name: zone_sableuse zone_sableuse_pkey; Type: CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.zone_sableuse
    ADD CONSTRAINT zone_sableuse_pkey PRIMARY KEY (zs_id);


--
-- Name: user_project user_project_pkey; Type: CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.user_project
    ADD CONSTRAINT user_project_pkey PRIMARY KEY (user_email, project_id);


--
-- Name: agr_cep_raw agr_cep_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.agr_cep_raw
    ADD CONSTRAINT agr_cep_raw_pkey PRIMARY KEY (id);


--
-- Name: agr_comite_raw agr_comite_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.agr_comite_raw
    ADD CONSTRAINT agr_comite_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: agr_menage_raw agr_menage_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.agr_menage_raw
    ADD CONSTRAINT agr_menage_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: agr_org_raw agr_org_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.agr_org_raw
    ADD CONSTRAINT agr_org_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: cep_raw cep_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.cep_raw
    ADD CONSTRAINT cep_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: cluster_raw cluster_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.cluster_raw
    ADD CONSTRAINT cluster_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: couloir_raw couloir_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.couloir_raw
    ADD CONSTRAINT couloir_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: entreprise_raw entreprise_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.entreprise_raw
    ADD CONSTRAINT entreprise_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: fiere_empins_ent_raw fiere_empins_ent_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.fiere_empins_ent_raw
    ADD CONSTRAINT fiere_empins_ent_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: fiere_emploi_dom_raw fiere_emploi_dom_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.fiere_emploi_dom_raw
    ADD CONSTRAINT fiere_emploi_dom_raw_pkey PRIMARY KEY (id);


--
-- Name: fiere_entreprise_raw fiere_entreprise_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.fiere_entreprise_raw
    ADD CONSTRAINT fiere_entreprise_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: fiere_formation_part_cat_raw fiere_formation_part_cat_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.fiere_formation_part_cat_raw
    ADD CONSTRAINT fiere_formation_part_cat_raw_pkey PRIMARY KEY (id);


--
-- Name: fiere_formation_raw fiere_formation_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.fiere_formation_raw
    ADD CONSTRAINT fiere_formation_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: fiere_insertion_dom_raw fiere_insertion_dom_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.fiere_insertion_dom_raw
    ADD CONSTRAINT fiere_insertion_dom_raw_pkey PRIMARY KEY (id);


--
-- Name: fiere_participation_raw fiere_participation_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.fiere_participation_raw
    ADD CONSTRAINT fiere_participation_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: fiere_suivi_sortant_raw fiere_suivi_sortant_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.fiere_suivi_sortant_raw
    ADD CONSTRAINT fiere_suivi_sortant_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: insertion_raw insertion_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.insertion_raw
    ADD CONSTRAINT insertion_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: intrant_comptoir_raw intrant_comptoir_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.intrant_comptoir_raw
    ADD CONSTRAINT intrant_comptoir_raw_pkey PRIMARY KEY (id);


--
-- Name: intrant_distribution_raw intrant_distribution_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.intrant_distribution_raw
    ADD CONSTRAINT intrant_distribution_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: kit_distribution_raw kit_distribution_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.kit_distribution_raw
    ADD CONSTRAINT kit_distribution_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: marche_raw marche_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.marche_raw
    ADD CONSTRAINT marche_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: meteo_mesure_raw meteo_mesure_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.meteo_mesure_raw
    ADD CONSTRAINT meteo_mesure_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: meteo_station_raw meteo_station_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.meteo_station_raw
    ADD CONSTRAINT meteo_station_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: ouvrage_raw ouvrage_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.ouvrage_raw
    ADD CONSTRAINT ouvrage_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: participation_formation_raw participation_formation_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.participation_formation_raw
    ADD CONSTRAINT participation_formation_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: pratiques_agro_raw pratiques_agro_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.pratiques_agro_raw
    ADD CONSTRAINT pratiques_agro_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: session_formation_raw session_formation_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.session_formation_raw
    ADD CONSTRAINT session_formation_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: tete_source_raw tete_source_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.tete_source_raw
    ADD CONSTRAINT tete_source_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: zone_degradee_raw zone_degradee_raw_pkey; Type: CONSTRAINT; Schema: stage; Owner: postgres
--

ALTER TABLE ONLY stage.zone_degradee_raw
    ADD CONSTRAINT zone_degradee_raw_pkey PRIMARY KEY (raw_uuid);


--
-- Name: core_benef_uq; Type: INDEX; Schema: core; Owner: postgres
--

CREATE UNIQUE INDEX core_benef_uq ON core.beneficiaire USING btree (project_id, id_beneficiaire);


--
-- Name: core_cep_commune_idx; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX core_cep_commune_idx ON core.cep_parcelle USING btree (id_commune);


--
-- Name: core_cep_geom_gist; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX core_cep_geom_gist ON core.cep_parcelle USING gist (geom);


--
-- Name: core_cep_uq; Type: INDEX; Schema: core; Owner: postgres
--

CREATE UNIQUE INDEX core_cep_uq ON core.cep_parcelle USING btree (project_code, id_cep);


--
-- Name: core_cluster_geom_gist; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX core_cluster_geom_gist ON core.cluster USING gist (geom);


--
-- Name: core_cluster_uq; Type: INDEX; Schema: core; Owner: postgres
--

CREATE UNIQUE INDEX core_cluster_uq ON core.cluster USING btree (project_id, id_cluster);


--
-- Name: core_ent_geom_gist; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX core_ent_geom_gist ON core.entreprise USING gist (geom);


--
-- Name: core_ent_uq; Type: INDEX; Schema: core; Owner: postgres
--

CREATE UNIQUE INDEX core_ent_uq ON core.entreprise USING btree (project_id, id_entreprise);


--
-- Name: core_insertion_uq; Type: INDEX; Schema: core; Owner: postgres
--

CREATE UNIQUE INDEX core_insertion_uq ON core.insertion USING btree (project_id, id_insertion);


--
-- Name: core_kit_uq; Type: INDEX; Schema: core; Owner: postgres
--

CREATE UNIQUE INDEX core_kit_uq ON core.kit_distribution USING btree (project_id, id_kit);


--
-- Name: core_org_geom_gist; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX core_org_geom_gist ON core.organisation USING gist (geom);


--
-- Name: core_org_uq; Type: INDEX; Schema: core; Owner: postgres
--

CREATE UNIQUE INDEX core_org_uq ON core.organisation USING btree (project_id, id_organisation);


--
-- Name: core_session_uq; Type: INDEX; Schema: core; Owner: postgres
--

CREATE UNIQUE INDEX core_session_uq ON core.session_formation USING btree (project_id, id_session);


--
-- Name: core_site_commune_idx; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX core_site_commune_idx ON core.site USING btree (id_commune);


--
-- Name: core_site_geom_gist; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX core_site_geom_gist ON core.site USING gist (geom);


--
-- Name: core_site_uq; Type: INDEX; Schema: core; Owner: postgres
--

CREATE UNIQUE INDEX core_site_uq ON core.site USING btree (project_id, id_site);


--
-- Name: idx_agr_comite_commune; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_agr_comite_commune ON core.agr_comite USING btree (id_commune);


--
-- Name: idx_agr_comite_type; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_agr_comite_type ON core.agr_comite USING btree (type_comite);


--
-- Name: idx_agr_menage_commune; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_agr_menage_commune ON core.agr_menage USING btree (id_commune);


--
-- Name: idx_agr_menage_type; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_agr_menage_type ON core.agr_menage USING btree (type_menage);


--
-- Name: idx_agr_org_commune; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_agr_org_commune ON core.agr_organisation USING btree (id_commune);


--
-- Name: idx_agr_org_type; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_agr_org_type ON core.agr_organisation USING btree (type_org);


--
-- Name: idx_ent_econ_commune; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_ent_econ_commune ON core.entreprise_econ USING btree (id_commune);


--
-- Name: idx_ent_econ_proj_ent; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_ent_econ_proj_ent ON core.entreprise_econ USING btree (project_code, id_ent);


--
-- Name: idx_ent_econ_secteur_princ; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_ent_econ_secteur_princ ON core.entreprise_econ USING btree (secteur_principal);


--
-- Name: idx_ent_emploi_commune; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_ent_emploi_commune ON core.ent_emploi USING btree (id_commune);


--
-- Name: idx_ent_emploi_dom_domaine; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_ent_emploi_dom_domaine ON core.ent_emploi_dom USING btree (domaine_code);


--
-- Name: idx_ent_emploi_dom_emploi; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_ent_emploi_dom_emploi ON core.ent_emploi_dom USING btree (emploi_uuid);


--
-- Name: idx_ent_emploi_entref; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_ent_emploi_entref ON core.ent_emploi USING btree (project_code, id_ent, annee_ref, periode_ref);


--
-- Name: idx_ent_insertion_commune; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_ent_insertion_commune ON core.ent_insertion USING btree (id_commune);


--
-- Name: idx_ent_insertion_dom_dom_type; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_ent_insertion_dom_dom_type ON core.ent_insertion_dom USING btree (domaine_code, type_insertion_code);


--
-- Name: idx_ent_insertion_dom_ins; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_ent_insertion_dom_ins ON core.ent_insertion_dom USING btree (insertion_uuid);


--
-- Name: idx_ent_insertion_entref; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_ent_insertion_entref ON core.ent_insertion USING btree (project_code, id_ent, annee_ref, periode_ref);


--
-- Name: idx_formation_eco_commune; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_formation_eco_commune ON core.formation_eco USING btree (id_commune);


--
-- Name: idx_formation_eco_proj_formation; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_formation_eco_proj_formation ON core.formation_eco USING btree (project_code, id_formation);


--
-- Name: idx_participation_commune; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_participation_commune ON core.acteur_participation USING btree (id_commune);


--
-- Name: idx_participation_type_part; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_participation_type_part ON core.acteur_participation USING btree (type_participation);


--
-- Name: idx_tete_source_commune; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_tete_source_commune ON core.tete_source USING btree (id_commune);


--
-- Name: idx_tete_source_etat; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_tete_source_etat ON core.tete_source USING btree (etat_fonctionnel);


--
-- Name: idx_tete_source_type; Type: INDEX; Schema: core; Owner: postgres
--

CREATE INDEX idx_tete_source_type ON core.tete_source USING btree (type_source);


--
-- Name: sidx_agglomeration_geom; Type: INDEX; Schema: import; Owner: postgres
--

CREATE INDEX sidx_agglomeration_geom ON import.agglomeration USING gist (geom);


--
-- Name: sidx_localite_osm_geom; Type: INDEX; Schema: import; Owner: postgres
--

CREATE INDEX sidx_localite_osm_geom ON import.localite_osm USING gist (geom);


--
-- Name: sidx_pref_adm2_geom; Type: INDEX; Schema: import; Owner: postgres
--

CREATE INDEX sidx_pref_adm2_geom ON import.pref_adm2 USING gist (geom);


--
-- Name: sidx_region_adm1_geom; Type: INDEX; Schema: import; Owner: postgres
--

CREATE INDEX sidx_region_adm1_geom ON import.region_adm1 USING gist (geom);


--
-- Name: sidx_souspref_adm3_geom; Type: INDEX; Schema: import; Owner: postgres
--

CREATE INDEX sidx_souspref_adm3_geom ON import.souspref_adm3 USING gist (geom);


--
-- Name: accounts_user_default_project_id_29956eeb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_default_project_id_29956eeb ON public.accounts_user USING btree (default_project_id);


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_projects_refproject_id_c7118212; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_projects_refproject_id_c7118212 ON public.accounts_user_projects USING btree (refproject_id);


--
-- Name: accounts_user_projects_user_id_9a2779cc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_projects_user_id_9a2779cc ON public.accounts_user_projects USING btree (user_id);


--
-- Name: accounts_user_region_id_6f4e501a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_region_id_6f4e501a ON public.accounts_user USING btree (region_id);


--
-- Name: accounts_user_region_id_6f4e501a_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_region_id_6f4e501a_like ON public.accounts_user USING btree (region_id varchar_pattern_ops);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: accounts_user_username_6088629e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_username_6088629e_like ON public.accounts_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: admin_comm_geom_gist; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX admin_comm_geom_gist ON ref.admin_commune USING gist (geom);


--
-- Name: admin_comm_prefecture_idx; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX admin_comm_prefecture_idx ON ref.admin_commune USING btree (id_prefecture);


--
-- Name: admin_comm_region_idx; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX admin_comm_region_idx ON ref.admin_commune USING btree (id_region);


--
-- Name: admin_pref_geom_gist; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX admin_pref_geom_gist ON ref.admin_prefecture USING gist (geom);


--
-- Name: admin_pref_region_idx; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX admin_pref_region_idx ON ref.admin_prefecture USING btree (id_region);


--
-- Name: admin_region_geom_gist; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX admin_region_geom_gist ON ref.admin_region USING gist (geom);


--
-- Name: agglomeration_commune_idx; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX agglomeration_commune_idx ON ref.agglomeration USING btree (id_commune);


--
-- Name: agglomeration_geom_gist; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX agglomeration_geom_gist ON ref.agglomeration USING gist (geom);


--
-- Name: aire_protegee_commune_idx; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX aire_protegee_commune_idx ON ref.aire_protegee USING btree (id_commune);


--
-- Name: aire_protegee_geom_gist; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX aire_protegee_geom_gist ON ref.aire_protegee USING gist (geom);


--
-- Name: equipement_commune_idx; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX equipement_commune_idx ON ref.equipement USING btree (id_commune);


--
-- Name: equipement_geom_gist; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX equipement_geom_gist ON ref.equipement USING gist (geom);


--
-- Name: habitation_disp_commune_idx; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX habitation_disp_commune_idx ON ref.habitation_dispersee USING btree (id_commune);


--
-- Name: habitation_disp_geom_gist; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX habitation_disp_geom_gist ON ref.habitation_dispersee USING gist (geom);


--
-- Name: localite_commune_idx; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX localite_commune_idx ON ref.localite USING btree (id_commune);


--
-- Name: localite_geom_gist; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX localite_geom_gist ON ref.localite USING gist (geom);


--
-- Name: occsol_commune_idx; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX occsol_commune_idx ON ref.occupation_sol USING btree (id_commune);


--
-- Name: occsol_geom_gist; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX occsol_geom_gist ON ref.occupation_sol USING gist (geom);


--
-- Name: ref_projet_code_fonc_idx; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX ref_projet_code_fonc_idx ON ref.projet USING btree (code_fonc);


--
-- Name: ref_projet_code_kobo_idx; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX ref_projet_code_kobo_idx ON ref.projet USING btree (code_kobo);


--
-- Name: sidx_hydrographie_geom; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX sidx_hydrographie_geom ON ref.hydrographie USING gist (geom);


--
-- Name: sidx_reseau_routier_geom; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX sidx_reseau_routier_geom ON ref.reseau_routier USING gist (geom);


--
-- Name: zone_humide_commune_idx; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX zone_humide_commune_idx ON ref.zone_humide USING btree (id_commune);


--
-- Name: zone_humide_geom_gist; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX zone_humide_geom_gist ON ref.zone_humide USING gist (geom);


--
-- Name: zone_sableuse_commune_idx; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX zone_sableuse_commune_idx ON ref.zone_sableuse USING btree (id_commune);


--
-- Name: zone_sableuse_geom_gist; Type: INDEX; Schema: ref; Owner: postgres
--

CREATE INDEX zone_sableuse_geom_gist ON ref.zone_sableuse USING gist (geom);


--
-- Name: etl_run etl_run_project_id_fkey; Type: FK CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY audit.etl_run
    ADD CONSTRAINT etl_run_project_id_fkey FOREIGN KEY (project_id) REFERENCES ref.projet(project_id);


--
-- Name: import_log import_log_project_id_fkey; Type: FK CONSTRAINT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY audit.import_log
    ADD CONSTRAINT import_log_project_id_fkey FOREIGN KEY (project_id) REFERENCES ref.projet(project_id);


--
-- Name: beneficiaire beneficiaire_id_commune_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.beneficiaire
    ADD CONSTRAINT beneficiaire_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: beneficiaire beneficiaire_organisation_uuid_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.beneficiaire
    ADD CONSTRAINT beneficiaire_organisation_uuid_fkey FOREIGN KEY (organisation_uuid) REFERENCES core.organisation(organisation_uuid);


--
-- Name: beneficiaire beneficiaire_project_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.beneficiaire
    ADD CONSTRAINT beneficiaire_project_id_fkey FOREIGN KEY (project_id) REFERENCES ref.projet(project_id);


--
-- Name: cep_parcelle cep_parcelle_filiere_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.cep_parcelle
    ADD CONSTRAINT cep_parcelle_filiere_fkey FOREIGN KEY (filiere) REFERENCES ref.filiere(code);


--
-- Name: cep_parcelle cep_parcelle_id_commune_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.cep_parcelle
    ADD CONSTRAINT cep_parcelle_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: cep_parcelle cep_parcelle_project_code_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.cep_parcelle
    ADD CONSTRAINT cep_parcelle_project_code_fkey FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: cluster cluster_filiere_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.cluster
    ADD CONSTRAINT cluster_filiere_fkey FOREIGN KEY (filiere) REFERENCES ref.filiere(code);


--
-- Name: cluster cluster_id_commune_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.cluster
    ADD CONSTRAINT cluster_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: cluster_organisation cluster_organisation_cluster_uuid_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.cluster_organisation
    ADD CONSTRAINT cluster_organisation_cluster_uuid_fkey FOREIGN KEY (cluster_uuid) REFERENCES core.cluster(cluster_uuid);


--
-- Name: cluster_organisation cluster_organisation_organisation_uuid_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.cluster_organisation
    ADD CONSTRAINT cluster_organisation_organisation_uuid_fkey FOREIGN KEY (organisation_uuid) REFERENCES core.organisation(organisation_uuid);


--
-- Name: cluster cluster_project_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.cluster
    ADD CONSTRAINT cluster_project_id_fkey FOREIGN KEY (project_id) REFERENCES ref.projet(project_id);


--
-- Name: cluster cluster_type_cluster_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.cluster
    ADD CONSTRAINT cluster_type_cluster_fkey FOREIGN KEY (type_cluster) REFERENCES ref.cluster_type(code);


--
-- Name: couloir couloir_commune_fk; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.couloir
    ADD CONSTRAINT couloir_commune_fk FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: couloir couloir_project_fk; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.couloir
    ADD CONSTRAINT couloir_project_fk FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: entreprise entreprise_filiere_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.entreprise
    ADD CONSTRAINT entreprise_filiere_fkey FOREIGN KEY (filiere) REFERENCES ref.filiere(code);


--
-- Name: entreprise entreprise_id_commune_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.entreprise
    ADD CONSTRAINT entreprise_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: entreprise entreprise_organisation_type_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.entreprise
    ADD CONSTRAINT entreprise_organisation_type_fkey FOREIGN KEY (organisation_type) REFERENCES ref.organisation_type(code);


--
-- Name: entreprise entreprise_project_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.entreprise
    ADD CONSTRAINT entreprise_project_id_fkey FOREIGN KEY (project_id) REFERENCES ref.projet(project_id);


--
-- Name: entreprise entreprise_type_cluster_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.entreprise
    ADD CONSTRAINT entreprise_type_cluster_fkey FOREIGN KEY (type_cluster) REFERENCES ref.cluster_type(code);


--
-- Name: agr_comite fk_agr_comite_commune; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_comite
    ADD CONSTRAINT fk_agr_comite_commune FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: agr_comite fk_agr_comite_proj; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_comite
    ADD CONSTRAINT fk_agr_comite_proj FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: agr_menage fk_agr_menage_commune; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_menage
    ADD CONSTRAINT fk_agr_menage_commune FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: agr_menage fk_agr_menage_proj; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_menage
    ADD CONSTRAINT fk_agr_menage_proj FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: agr_organisation fk_agr_org_commune; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_organisation
    ADD CONSTRAINT fk_agr_org_commune FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: agr_organisation fk_agr_org_projet; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.agr_organisation
    ADD CONSTRAINT fk_agr_org_projet FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: entreprise_econ fk_ent_econ_commune; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.entreprise_econ
    ADD CONSTRAINT fk_ent_econ_commune FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: entreprise_econ fk_ent_econ_projet; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.entreprise_econ
    ADD CONSTRAINT fk_ent_econ_projet FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: ent_emploi fk_ent_emploi_commune; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.ent_emploi
    ADD CONSTRAINT fk_ent_emploi_commune FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: ent_emploi fk_ent_emploi_projet; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.ent_emploi
    ADD CONSTRAINT fk_ent_emploi_projet FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: ent_insertion fk_ent_insert_commune; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.ent_insertion
    ADD CONSTRAINT fk_ent_insert_commune FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: ent_insertion fk_ent_insert_projet; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.ent_insertion
    ADD CONSTRAINT fk_ent_insert_projet FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: fiere_suivi_sortant fk_fiere_suivi_commune; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.fiere_suivi_sortant
    ADD CONSTRAINT fk_fiere_suivi_commune FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: fiere_suivi_sortant fk_fiere_suivi_projet; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.fiere_suivi_sortant
    ADD CONSTRAINT fk_fiere_suivi_projet FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: formation_eco fk_formation_commune; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.formation_eco
    ADD CONSTRAINT fk_formation_commune FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: formation_part_cat fk_formation_part_formation; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.formation_part_cat
    ADD CONSTRAINT fk_formation_part_formation FOREIGN KEY (formation_uuid) REFERENCES core.formation_eco(formation_uuid);


--
-- Name: formation_eco fk_formation_projet; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.formation_eco
    ADD CONSTRAINT fk_formation_projet FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: meteo_mesure fk_meteo_mesure_commune; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.meteo_mesure
    ADD CONSTRAINT fk_meteo_mesure_commune FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: meteo_mesure fk_meteo_mesure_projet; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.meteo_mesure
    ADD CONSTRAINT fk_meteo_mesure_projet FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: meteo_mesure fk_meteo_mesure_station; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.meteo_mesure
    ADD CONSTRAINT fk_meteo_mesure_station FOREIGN KEY (station_uuid) REFERENCES core.meteo_station(station_uuid);


--
-- Name: meteo_station fk_meteo_station_commune; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.meteo_station
    ADD CONSTRAINT fk_meteo_station_commune FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: meteo_station fk_meteo_station_projet; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.meteo_station
    ADD CONSTRAINT fk_meteo_station_projet FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: acteur_participation fk_part_commune; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.acteur_participation
    ADD CONSTRAINT fk_part_commune FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: acteur_participation fk_part_projet; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.acteur_participation
    ADD CONSTRAINT fk_part_projet FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: pratiques_agro_parcelle fk_prat_commune; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.pratiques_agro_parcelle
    ADD CONSTRAINT fk_prat_commune FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: pratiques_agro_parcelle fk_prat_proj; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.pratiques_agro_parcelle
    ADD CONSTRAINT fk_prat_proj FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: tete_source fk_ts_commune; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.tete_source
    ADD CONSTRAINT fk_ts_commune FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: tete_source fk_ts_projet; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.tete_source
    ADD CONSTRAINT fk_ts_projet FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: zone_degradee fk_zone_commune; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.zone_degradee
    ADD CONSTRAINT fk_zone_commune FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: zone_degradee fk_zone_projet; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.zone_degradee
    ADD CONSTRAINT fk_zone_projet FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: insertion insertion_beneficiaire_uuid_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.insertion
    ADD CONSTRAINT insertion_beneficiaire_uuid_fkey FOREIGN KEY (beneficiaire_uuid) REFERENCES core.beneficiaire(beneficiaire_uuid);


--
-- Name: insertion insertion_entreprise_uuid_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.insertion
    ADD CONSTRAINT insertion_entreprise_uuid_fkey FOREIGN KEY (entreprise_uuid) REFERENCES core.entreprise(entreprise_uuid);


--
-- Name: insertion insertion_organisation_uuid_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.insertion
    ADD CONSTRAINT insertion_organisation_uuid_fkey FOREIGN KEY (organisation_uuid) REFERENCES core.organisation(organisation_uuid);


--
-- Name: insertion insertion_project_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.insertion
    ADD CONSTRAINT insertion_project_id_fkey FOREIGN KEY (project_id) REFERENCES ref.projet(project_id);


--
-- Name: intrant_distribution intrant_distribution_commune_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.intrant_distribution
    ADD CONSTRAINT intrant_distribution_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: intrant_distribution intrant_distribution_project_code_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.intrant_distribution
    ADD CONSTRAINT intrant_distribution_project_code_fkey FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: kit_distribution kit_distribution_beneficiaire_uuid_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.kit_distribution
    ADD CONSTRAINT kit_distribution_beneficiaire_uuid_fkey FOREIGN KEY (beneficiaire_uuid) REFERENCES core.beneficiaire(beneficiaire_uuid);


--
-- Name: kit_distribution kit_distribution_kit_type_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.kit_distribution
    ADD CONSTRAINT kit_distribution_kit_type_fkey FOREIGN KEY (kit_type) REFERENCES ref.kit_type(code);


--
-- Name: kit_distribution kit_distribution_organisation_uuid_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.kit_distribution
    ADD CONSTRAINT kit_distribution_organisation_uuid_fkey FOREIGN KEY (organisation_uuid) REFERENCES core.organisation(organisation_uuid);


--
-- Name: kit_distribution kit_distribution_project_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.kit_distribution
    ADD CONSTRAINT kit_distribution_project_id_fkey FOREIGN KEY (project_id) REFERENCES ref.projet(project_id);


--
-- Name: marche marche_commune_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.marche
    ADD CONSTRAINT marche_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: marche marche_project_code_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.marche
    ADD CONSTRAINT marche_project_code_fkey FOREIGN KEY (project_code) REFERENCES ref.projet(code_kobo);


--
-- Name: organisation organisation_id_commune_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.organisation
    ADD CONSTRAINT organisation_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: organisation organisation_project_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.organisation
    ADD CONSTRAINT organisation_project_id_fkey FOREIGN KEY (project_id) REFERENCES ref.projet(project_id);


--
-- Name: organisation organisation_type_organisation_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.organisation
    ADD CONSTRAINT organisation_type_organisation_fkey FOREIGN KEY (type_organisation) REFERENCES ref.organisation_type(code);


--
-- Name: participation_formation participation_formation_beneficiaire_uuid_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.participation_formation
    ADD CONSTRAINT participation_formation_beneficiaire_uuid_fkey FOREIGN KEY (beneficiaire_uuid) REFERENCES core.beneficiaire(beneficiaire_uuid);


--
-- Name: participation_formation participation_formation_organisation_uuid_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.participation_formation
    ADD CONSTRAINT participation_formation_organisation_uuid_fkey FOREIGN KEY (organisation_uuid) REFERENCES core.organisation(organisation_uuid);


--
-- Name: participation_formation participation_formation_project_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.participation_formation
    ADD CONSTRAINT participation_formation_project_id_fkey FOREIGN KEY (project_id) REFERENCES ref.projet(project_id);


--
-- Name: participation_formation participation_formation_session_uuid_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.participation_formation
    ADD CONSTRAINT participation_formation_session_uuid_fkey FOREIGN KEY (session_uuid) REFERENCES core.session_formation(session_uuid);


--
-- Name: session_formation session_formation_id_commune_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.session_formation
    ADD CONSTRAINT session_formation_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: session_formation session_formation_project_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.session_formation
    ADD CONSTRAINT session_formation_project_id_fkey FOREIGN KEY (project_id) REFERENCES ref.projet(project_id);


--
-- Name: session_formation session_formation_site_uuid_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.session_formation
    ADD CONSTRAINT session_formation_site_uuid_fkey FOREIGN KEY (site_uuid) REFERENCES core.site(site_uuid);


--
-- Name: session_formation session_formation_type_formation_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.session_formation
    ADD CONSTRAINT session_formation_type_formation_fkey FOREIGN KEY (type_formation) REFERENCES ref.formation_type(code);


--
-- Name: site site_id_commune_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.site
    ADD CONSTRAINT site_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: site site_project_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.site
    ADD CONSTRAINT site_project_id_fkey FOREIGN KEY (project_id) REFERENCES ref.projet(project_id);


--
-- Name: site site_type_site_fkey; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.site
    ADD CONSTRAINT site_type_site_fkey FOREIGN KEY (type_site) REFERENCES ref.type_site(code);


--
-- Name: accounts_user accounts_user_default_project_id_29956eeb_fk_projet_project_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_default_project_id_29956eeb_fk_projet_project_id FOREIGN KEY (default_project_id) REFERENCES ref.projet(project_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_projects accounts_user_projec_refproject_id_c7118212_fk_projet_pr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_projects
    ADD CONSTRAINT accounts_user_projec_refproject_id_c7118212_fk_projet_pr FOREIGN KEY (refproject_id) REFERENCES ref.projet(project_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_projects accounts_user_projects_user_id_9a2779cc_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_projects
    ADD CONSTRAINT accounts_user_projects_user_id_9a2779cc_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user accounts_user_region_id_6f4e501a_fk_admin_region_id_region; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_region_id_6f4e501a_fk_admin_region_id_region FOREIGN KEY (region_id) REFERENCES ref.admin_region(id_region) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: data_quality_report data_quality_report_project_id_fkey; Type: FK CONSTRAINT; Schema: qa; Owner: postgres
--

ALTER TABLE ONLY qa.data_quality_report
    ADD CONSTRAINT data_quality_report_project_id_fkey FOREIGN KEY (project_id) REFERENCES ref.projet(project_id);


--
-- Name: run_metrics run_metrics_project_id_fkey; Type: FK CONSTRAINT; Schema: qa; Owner: postgres
--

ALTER TABLE ONLY qa.run_metrics
    ADD CONSTRAINT run_metrics_project_id_fkey FOREIGN KEY (project_id) REFERENCES ref.projet(project_id);


--
-- Name: admin_commune admin_commune_id_prefecture_fkey; Type: FK CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.admin_commune
    ADD CONSTRAINT admin_commune_id_prefecture_fkey FOREIGN KEY (id_prefecture) REFERENCES ref.admin_prefecture(id_prefecture);


--
-- Name: admin_commune admin_commune_id_region_fkey; Type: FK CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.admin_commune
    ADD CONSTRAINT admin_commune_id_region_fkey FOREIGN KEY (id_region) REFERENCES ref.admin_region(id_region);


--
-- Name: admin_prefecture admin_prefecture_id_region_fkey; Type: FK CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.admin_prefecture
    ADD CONSTRAINT admin_prefecture_id_region_fkey FOREIGN KEY (id_region) REFERENCES ref.admin_region(id_region);


--
-- Name: agglomeration agglomeration_id_commune_fkey; Type: FK CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.agglomeration
    ADD CONSTRAINT agglomeration_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: aire_protegee aire_protegee_id_commune_fkey; Type: FK CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.aire_protegee
    ADD CONSTRAINT aire_protegee_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: equipement equipement_id_commune_fkey; Type: FK CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.equipement
    ADD CONSTRAINT equipement_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: habitation_dispersee habitation_dispersee_id_commune_fkey; Type: FK CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.habitation_dispersee
    ADD CONSTRAINT habitation_dispersee_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: localite localite_id_commune_fkey; Type: FK CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.localite
    ADD CONSTRAINT localite_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: occupation_sol occupation_sol_id_commune_fkey; Type: FK CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.occupation_sol
    ADD CONSTRAINT occupation_sol_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: zone_humide zone_humide_id_commune_fkey; Type: FK CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.zone_humide
    ADD CONSTRAINT zone_humide_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: zone_sableuse zone_sableuse_id_commune_fkey; Type: FK CONSTRAINT; Schema: ref; Owner: postgres
--

ALTER TABLE ONLY ref.zone_sableuse
    ADD CONSTRAINT zone_sableuse_id_commune_fkey FOREIGN KEY (id_commune) REFERENCES ref.admin_commune(id_commune);


--
-- Name: user_project user_project_project_id_fkey; Type: FK CONSTRAINT; Schema: security; Owner: postgres
--

ALTER TABLE ONLY security.user_project
    ADD CONSTRAINT user_project_project_id_fkey FOREIGN KEY (project_id) REFERENCES ref.projet(project_id);


--
-- PostgreSQL database dump complete
--

