--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Debian 16.9-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Homebrew)

-- Started on 2025-08-09 19:14:23 +07

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA IF NOT EXISTS public;


--
-- TOC entry 4237 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 249 (class 1259 OID 17017)
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


--
-- TOC entry 276 (class 1259 OID 17460)
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


--
-- TOC entry 252 (class 1259 OID 17032)
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


--
-- TOC entry 251 (class 1259 OID 17027)
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


--
-- TOC entry 250 (class 1259 OID 17022)
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


--
-- TOC entry 253 (class 1259 OID 17037)
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 277 (class 1259 OID 17475)
-- Name: broker_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 16398)
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


--
-- TOC entry 236 (class 1259 OID 16756)
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- TOC entry 288 (class 1259 OID 17724)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


--
-- TOC entry 287 (class 1259 OID 17599)
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


--
-- TOC entry 237 (class 1259 OID 16766)
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


--
-- TOC entry 265 (class 1259 OID 17265)
-- Name: client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


--
-- TOC entry 266 (class 1259 OID 17279)
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


--
-- TOC entry 289 (class 1259 OID 17765)
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- TOC entry 267 (class 1259 OID 17284)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- TOC entry 285 (class 1259 OID 17520)
-- Name: component; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


--
-- TOC entry 284 (class 1259 OID 17515)
-- Name: component_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- TOC entry 218 (class 1259 OID 16417)
-- Name: composite_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 16420)
-- Name: credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer,
    version integer DEFAULT 0
);


--
-- TOC entry 216 (class 1259 OID 16390)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


--
-- TOC entry 215 (class 1259 OID 16385)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


--
-- TOC entry 290 (class 1259 OID 17781)
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 16425)
-- Name: event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


--
-- TOC entry 278 (class 1259 OID 17480)
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


--
-- TOC entry 279 (class 1259 OID 17485)
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- TOC entry 292 (class 1259 OID 17807)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 280 (class 1259 OID 17494)
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- TOC entry 281 (class 1259 OID 17503)
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 282 (class 1259 OID 17506)
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 283 (class 1259 OID 17512)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 240 (class 1259 OID 16802)
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


--
-- TOC entry 286 (class 1259 OID 17577)
-- Name: federated_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 262 (class 1259 OID 17204)
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 261 (class 1259 OID 17201)
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 241 (class 1259 OID 16807)
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


--
-- TOC entry 242 (class 1259 OID 16816)
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 246 (class 1259 OID 16920)
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 16925)
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 301 (class 1259 OID 18006)
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


--
-- TOC entry 260 (class 1259 OID 17198)
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL,
    description character varying(255)
);


--
-- TOC entry 221 (class 1259 OID 16433)
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


--
-- TOC entry 245 (class 1259 OID 16917)
-- Name: migration_model; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


--
-- TOC entry 259 (class 1259 OID 17189)
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


--
-- TOC entry 258 (class 1259 OID 17184)
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


--
-- TOC entry 298 (class 1259 OID 17969)
-- Name: org; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


--
-- TOC entry 299 (class 1259 OID 17980)
-- Name: org_domain; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


--
-- TOC entry 272 (class 1259 OID 17403)
-- Name: policy_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- TOC entry 238 (class 1259 OID 16791)
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


--
-- TOC entry 239 (class 1259 OID 16797)
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 16439)
-- Name: realm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


--
-- TOC entry 223 (class 1259 OID 16456)
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


--
-- TOC entry 264 (class 1259 OID 17213)
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 244 (class 1259 OID 16909)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 16464)
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 297 (class 1259 OID 17915)
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 16467)
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 16474)
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 243 (class 1259 OID 16825)
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 16484)
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 257 (class 1259 OID 17148)
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 256 (class 1259 OID 17141)
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


--
-- TOC entry 294 (class 1259 OID 17846)
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


--
-- TOC entry 274 (class 1259 OID 17430)
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- TOC entry 273 (class 1259 OID 17415)
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 268 (class 1259 OID 17353)
-- Name: resource_server; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


--
-- TOC entry 293 (class 1259 OID 17822)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


--
-- TOC entry 271 (class 1259 OID 17389)
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


--
-- TOC entry 269 (class 1259 OID 17361)
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


--
-- TOC entry 270 (class 1259 OID 17375)
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


--
-- TOC entry 295 (class 1259 OID 17864)
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 300 (class 1259 OID 17997)
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


--
-- TOC entry 296 (class 1259 OID 17874)
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


--
-- TOC entry 228 (class 1259 OID 16487)
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- TOC entry 275 (class 1259 OID 17445)
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- TOC entry 302 (class 1259 OID 18013)
-- Name: server_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.server_config (
    server_config_key character varying(255) NOT NULL,
    value text NOT NULL,
    version integer DEFAULT 0
);


--
-- TOC entry 229 (class 1259 OID 16493)
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


--
-- TOC entry 248 (class 1259 OID 16930)
-- Name: user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- TOC entry 291 (class 1259 OID 17797)
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 16498)
-- Name: user_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 16506)
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 254 (class 1259 OID 17042)
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 255 (class 1259 OID 17047)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 232 (class 1259 OID 16511)
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


--
-- TOC entry 263 (class 1259 OID 17210)
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


--
-- TOC entry 233 (class 1259 OID 16516)
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


--
-- TOC entry 234 (class 1259 OID 16519)
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- TOC entry 235 (class 1259 OID 16533)
-- Name: web_origins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 4178 (class 0 OID 17017)
-- Dependencies: 249
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4205 (class 0 OID 17460)
-- Dependencies: 276
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4181 (class 0 OID 17032)
-- Dependencies: 252
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.authentication_execution VALUES ('66045398-2e8d-4262-80a2-6d712743c9c2', NULL, 'auth-cookie', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'b26204cf-678e-46c9-a023-74745aa1821f', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('7ddbf720-587c-480f-b4b8-847711c99777', NULL, 'auth-spnego', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'b26204cf-678e-46c9-a023-74745aa1821f', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('e37a23e0-a710-4f02-85f8-4a492415fb9a', NULL, 'identity-provider-redirector', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'b26204cf-678e-46c9-a023-74745aa1821f', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b576d6d8-4bfc-4cd8-8dfa-6348612047df', NULL, NULL, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'b26204cf-678e-46c9-a023-74745aa1821f', 2, 30, true, 'ae48705f-43a4-4184-a50b-6dfd63d653bf', NULL);
INSERT INTO public.authentication_execution VALUES ('a95aceb3-a5ee-48d5-ad47-277a62f08d7d', NULL, 'auth-username-password-form', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'ae48705f-43a4-4184-a50b-6dfd63d653bf', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('d11ed2a3-267e-41d3-aa04-28b886af1bcc', NULL, NULL, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'ae48705f-43a4-4184-a50b-6dfd63d653bf', 1, 20, true, '0fb44463-6239-4fdd-8e28-638179d62ede', NULL);
INSERT INTO public.authentication_execution VALUES ('732224b8-901d-4227-a264-067e91403879', NULL, 'conditional-user-configured', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '0fb44463-6239-4fdd-8e28-638179d62ede', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('9dc62844-bde4-4f05-ae44-df27d7a47834', NULL, 'auth-otp-form', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '0fb44463-6239-4fdd-8e28-638179d62ede', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('7fafbb77-5fb4-4b82-8ea3-ff344ca50cff', NULL, 'webauthn-authenticator', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '0fb44463-6239-4fdd-8e28-638179d62ede', 3, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('de7cbf21-9f28-411a-964b-39aa78ee07a2', NULL, 'auth-recovery-authn-code-form', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '0fb44463-6239-4fdd-8e28-638179d62ede', 3, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('41494e7b-2bb9-47f9-948a-2525b88a829b', NULL, 'direct-grant-validate-username', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '2b2d788a-1bb0-4dae-a3d2-f5e431aca6f8', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b33184a4-60a2-4eaf-b427-6ade8fef0785', NULL, 'direct-grant-validate-password', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '2b2d788a-1bb0-4dae-a3d2-f5e431aca6f8', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('003cf2fa-4f00-4df5-8e63-fa2d9de6611e', NULL, NULL, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '2b2d788a-1bb0-4dae-a3d2-f5e431aca6f8', 1, 30, true, '6cbf79c3-c168-4bf7-b1ca-e27a414e6551', NULL);
INSERT INTO public.authentication_execution VALUES ('d4262ede-34b2-4c92-9f73-d0e0d15a1857', NULL, 'conditional-user-configured', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '6cbf79c3-c168-4bf7-b1ca-e27a414e6551', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('cdaea788-c1a3-4cf7-91e7-de59aef35f86', NULL, 'direct-grant-validate-otp', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '6cbf79c3-c168-4bf7-b1ca-e27a414e6551', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('6c33438f-f85c-486c-a3e0-92ddd5efeea8', NULL, 'registration-page-form', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '71333b67-7e86-4bd9-b813-eebb5c42c37d', 0, 10, true, 'a7ec06d6-1bb7-4585-a750-1932afde823c', NULL);
INSERT INTO public.authentication_execution VALUES ('caf590db-268c-4a04-aa37-58134c66efab', NULL, 'registration-user-creation', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'a7ec06d6-1bb7-4585-a750-1932afde823c', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('eb3cce85-9996-4caa-898d-c514f6587f0d', NULL, 'registration-password-action', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'a7ec06d6-1bb7-4585-a750-1932afde823c', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('a028163a-dde3-4b9b-be97-e10b9f23d1a2', NULL, 'registration-recaptcha-action', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'a7ec06d6-1bb7-4585-a750-1932afde823c', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('532c09df-2d28-41ac-9f1c-bcd1a83e7ada', NULL, 'registration-terms-and-conditions', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'a7ec06d6-1bb7-4585-a750-1932afde823c', 3, 70, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('ee588aa9-aa0e-4c25-a9cc-4dd7521f4f71', NULL, 'reset-credentials-choose-user', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '607542c6-81ed-4955-944f-190efff9ed5d', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('3b36a9bd-2fb0-44ea-a679-b053930480ff', NULL, 'reset-credential-email', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '607542c6-81ed-4955-944f-190efff9ed5d', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('0c2c126b-e585-41cf-81dc-b18b0ab533b0', NULL, 'reset-password', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '607542c6-81ed-4955-944f-190efff9ed5d', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('39b80f75-40a2-4f20-8b6b-2a02ad5bf071', NULL, NULL, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '607542c6-81ed-4955-944f-190efff9ed5d', 1, 40, true, 'ecd96e9a-c155-48c2-89d3-5ea289c8c0db', NULL);
INSERT INTO public.authentication_execution VALUES ('d3442f31-5c8f-4ca5-93dc-a0436cac596d', NULL, 'conditional-user-configured', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'ecd96e9a-c155-48c2-89d3-5ea289c8c0db', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('9cffa104-44de-41a2-b9ae-4193871e46c5', NULL, 'reset-otp', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'ecd96e9a-c155-48c2-89d3-5ea289c8c0db', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('507445cf-3d41-40e5-9c98-50ae0e858435', NULL, 'client-secret', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'd26e6e21-7416-47b8-bc27-5d8cba7930f7', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('5c7d3dc4-5ea8-49dd-b854-f7fde424ec5b', NULL, 'client-jwt', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'd26e6e21-7416-47b8-bc27-5d8cba7930f7', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('1c50fd42-0dfe-4d42-a9eb-1d484142670c', NULL, 'client-secret-jwt', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'd26e6e21-7416-47b8-bc27-5d8cba7930f7', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('1175f78d-869e-4a1e-913d-cffc37a3e3f7', NULL, 'client-x509', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'd26e6e21-7416-47b8-bc27-5d8cba7930f7', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('618e148d-bb31-4f5a-91db-427708879e20', NULL, 'idp-review-profile', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '7954f2d5-849f-4ba2-905e-e522cd61bcee', 0, 10, false, NULL, '0b76e8ff-c995-45ca-8fee-65ae0df5570d');
INSERT INTO public.authentication_execution VALUES ('da879251-d96b-4cb6-9eb5-f23d4e2dea8b', NULL, NULL, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '7954f2d5-849f-4ba2-905e-e522cd61bcee', 0, 20, true, '2a3eff12-10bd-4b14-8300-6ffd41c5b618', NULL);
INSERT INTO public.authentication_execution VALUES ('461378aa-ca1e-4379-b75b-74321b8315ae', NULL, 'idp-create-user-if-unique', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '2a3eff12-10bd-4b14-8300-6ffd41c5b618', 2, 10, false, NULL, '65213203-880e-41bc-9774-a3fea9b30d5c');
INSERT INTO public.authentication_execution VALUES ('fa4e10ce-8e44-4873-81d3-3557c9d7b330', NULL, NULL, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '2a3eff12-10bd-4b14-8300-6ffd41c5b618', 2, 20, true, '50879a00-3999-4699-b86c-5733e68f8926', NULL);
INSERT INTO public.authentication_execution VALUES ('0a29ee74-7b33-4f6b-a050-fb02b689f0e4', NULL, 'idp-confirm-link', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '50879a00-3999-4699-b86c-5733e68f8926', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('71265551-82a7-4bc7-beb8-45df36cfba5c', NULL, NULL, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '50879a00-3999-4699-b86c-5733e68f8926', 0, 20, true, '2aca65f0-1262-4a80-a07c-bb248b916471', NULL);
INSERT INTO public.authentication_execution VALUES ('d7e4c06d-41e5-4428-ac7b-bc0392c3eeff', NULL, 'idp-email-verification', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '2aca65f0-1262-4a80-a07c-bb248b916471', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('c9395ee9-ac38-4e48-ba8b-25a763ab4760', NULL, NULL, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '2aca65f0-1262-4a80-a07c-bb248b916471', 2, 20, true, '2a67a181-f62b-43fb-b018-e99ccd38d4bb', NULL);
INSERT INTO public.authentication_execution VALUES ('db17fb26-e4d4-438d-b6b5-524e88647b4e', NULL, 'idp-username-password-form', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '2a67a181-f62b-43fb-b018-e99ccd38d4bb', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('53970448-4b7b-4007-a70e-a3acf65f3615', NULL, NULL, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '2a67a181-f62b-43fb-b018-e99ccd38d4bb', 1, 20, true, 'd8666121-6148-4990-8af0-f6b7dd60a4d4', NULL);
INSERT INTO public.authentication_execution VALUES ('4306605f-7e55-4221-95ae-10d1e5ef687a', NULL, 'conditional-user-configured', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'd8666121-6148-4990-8af0-f6b7dd60a4d4', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('57c42a0e-d918-4866-b291-18da8d449624', NULL, 'auth-otp-form', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'd8666121-6148-4990-8af0-f6b7dd60a4d4', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('53c5d1b3-3f62-4e83-801b-f0724d9c3815', NULL, 'webauthn-authenticator', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'd8666121-6148-4990-8af0-f6b7dd60a4d4', 3, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('18e5b9a9-abc3-4b65-a94c-bc22c9c90bff', NULL, 'auth-recovery-authn-code-form', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'd8666121-6148-4990-8af0-f6b7dd60a4d4', 3, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('1ad0f57e-75ab-4f1a-8289-af04cb1f379a', NULL, 'http-basic-authenticator', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '48cbedd0-1dab-44e0-af62-8519e275a429', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('fb5adf70-047f-48a1-a21a-05d2dd196fc1', NULL, 'docker-http-basic-authenticator', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '2456f684-ccea-4725-87d5-0d8e22d2619d', 0, 10, false, NULL, NULL);


--
-- TOC entry 4180 (class 0 OID 17027)
-- Dependencies: 251
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.authentication_flow VALUES ('b26204cf-678e-46c9-a023-74745aa1821f', 'browser', 'Browser based authentication', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('ae48705f-43a4-4184-a50b-6dfd63d653bf', 'forms', 'Username, password, otp and other auth forms.', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('0fb44463-6239-4fdd-8e28-638179d62ede', 'Browser - Conditional 2FA', 'Flow to determine if any 2FA is required for the authentication', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('2b2d788a-1bb0-4dae-a3d2-f5e431aca6f8', 'direct grant', 'OpenID Connect Resource Owner Grant', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('6cbf79c3-c168-4bf7-b1ca-e27a414e6551', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('71333b67-7e86-4bd9-b813-eebb5c42c37d', 'registration', 'Registration flow', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('a7ec06d6-1bb7-4585-a750-1932afde823c', 'registration form', 'Registration form', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'form-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('607542c6-81ed-4955-944f-190efff9ed5d', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('ecd96e9a-c155-48c2-89d3-5ea289c8c0db', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('d26e6e21-7416-47b8-bc27-5d8cba7930f7', 'clients', 'Base authentication for clients', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'client-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('7954f2d5-849f-4ba2-905e-e522cd61bcee', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('2a3eff12-10bd-4b14-8300-6ffd41c5b618', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('50879a00-3999-4699-b86c-5733e68f8926', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('2aca65f0-1262-4a80-a07c-bb248b916471', 'Account verification options', 'Method with which to verity the existing account', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('2a67a181-f62b-43fb-b018-e99ccd38d4bb', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('d8666121-6148-4990-8af0-f6b7dd60a4d4', 'First broker login - Conditional 2FA', 'Flow to determine if any 2FA is required for the authentication', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('48cbedd0-1dab-44e0-af62-8519e275a429', 'saml ecp', 'SAML ECP Profile Authentication Flow', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('2456f684-ccea-4725-87d5-0d8e22d2619d', 'docker auth', 'Used by Docker clients to authenticate against the IDP', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'basic-flow', true, true);


--
-- TOC entry 4179 (class 0 OID 17022)
-- Dependencies: 250
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.authenticator_config VALUES ('0b76e8ff-c995-45ca-8fee-65ae0df5570d', 'review profile config', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19');
INSERT INTO public.authenticator_config VALUES ('65213203-880e-41bc-9774-a3fea9b30d5c', 'create unique user config', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19');


--
-- TOC entry 4182 (class 0 OID 17037)
-- Dependencies: 253
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.authenticator_config_entry VALUES ('0b76e8ff-c995-45ca-8fee-65ae0df5570d', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry VALUES ('65213203-880e-41bc-9774-a3fea9b30d5c', 'false', 'require.password.update.after.registration');


--
-- TOC entry 4206 (class 0 OID 17475)
-- Dependencies: 277
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4146 (class 0 OID 16398)
-- Dependencies: 217
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client VALUES ('252ff2ff-c027-4c62-b86f-841a8c3ec810', true, false, 'master-realm', 0, false, NULL, NULL, true, NULL, false, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('3fc07da3-0fd4-4e49-a71e-b188598c0024', true, false, 'account', 0, true, NULL, '/realms/master/account/', false, NULL, false, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', true, false, 'account-console', 0, true, NULL, '/realms/master/account/', false, NULL, false, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('86645e61-3636-45a6-a125-08434364f99c', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', true, true, 'security-admin-console', 0, true, NULL, '/admin/master/console/', false, NULL, false, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('a48b92bd-d74c-4c09-ae95-e7d12cbcce7e', true, true, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);


--
-- TOC entry 4165 (class 0 OID 16756)
-- Dependencies: 236
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client_attributes VALUES ('3fc07da3-0fd4-4e49-a71e-b188598c0024', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO public.client_attributes VALUES ('a48b92bd-d74c-4c09-ae95-e7d12cbcce7e', 'client.use.lightweight.access.token.enabled', 'true');


--
-- TOC entry 4217 (class 0 OID 17724)
-- Dependencies: 288
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4216 (class 0 OID 17599)
-- Dependencies: 287
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4166 (class 0 OID 16766)
-- Dependencies: 237
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4194 (class 0 OID 17265)
-- Dependencies: 265
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client_scope VALUES ('db062b7e-2ec7-41d6-aae2-00a857d16c0d', 'offline_access', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope VALUES ('3a8488a7-132d-4771-aa80-82ff9d81ba6a', 'role_list', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'SAML role list', 'saml');
INSERT INTO public.client_scope VALUES ('6c6cb177-1549-42dc-8c37-bbe9a9ae22d0', 'saml_organization', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'Organization Membership', 'saml');
INSERT INTO public.client_scope VALUES ('5fe73bd2-47fa-4191-b448-1f01f03f4f37', 'profile', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope VALUES ('4e9ecc3a-e6fc-4ca8-a06f-43db0cb3148f', 'email', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope VALUES ('791101d1-ddab-4c9a-8b8f-93fce929571b', 'address', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope VALUES ('be9e2169-cfe2-49f8-a116-9c6ed1b41751', 'phone', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope VALUES ('a55e4127-da19-44c5-8fad-26dbf0629840', 'roles', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('93c79cf5-50bd-4695-af47-6a70ce2c7965', 'web-origins', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('f7552d7d-3145-4861-8f5a-2abbc34f93dd', 'microprofile-jwt', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope VALUES ('c6b71531-38b5-46e0-ade9-f209cfed1a93', 'acr', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('7c6ccafc-a670-44e1-9793-81ddf2d8e3c3', 'basic', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'OpenID Connect scope for add all basic claims to the token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('004b9d7d-0cb2-4dfc-9fd6-60cc9f93a5b2', 'service_account', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'Specific scope for a client enabled for service accounts', 'openid-connect');
INSERT INTO public.client_scope VALUES ('9231bd6f-e952-4c69-9d48-af6062643f4e', 'organization', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'Additional claims about the organization a subject belongs to', 'openid-connect');


--
-- TOC entry 4195 (class 0 OID 17279)
-- Dependencies: 266
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client_scope_attributes VALUES ('db062b7e-2ec7-41d6-aae2-00a857d16c0d', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('db062b7e-2ec7-41d6-aae2-00a857d16c0d', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('3a8488a7-132d-4771-aa80-82ff9d81ba6a', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('3a8488a7-132d-4771-aa80-82ff9d81ba6a', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('6c6cb177-1549-42dc-8c37-bbe9a9ae22d0', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('5fe73bd2-47fa-4191-b448-1f01f03f4f37', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('5fe73bd2-47fa-4191-b448-1f01f03f4f37', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('5fe73bd2-47fa-4191-b448-1f01f03f4f37', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('4e9ecc3a-e6fc-4ca8-a06f-43db0cb3148f', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('4e9ecc3a-e6fc-4ca8-a06f-43db0cb3148f', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('4e9ecc3a-e6fc-4ca8-a06f-43db0cb3148f', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('791101d1-ddab-4c9a-8b8f-93fce929571b', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('791101d1-ddab-4c9a-8b8f-93fce929571b', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('791101d1-ddab-4c9a-8b8f-93fce929571b', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('be9e2169-cfe2-49f8-a116-9c6ed1b41751', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('be9e2169-cfe2-49f8-a116-9c6ed1b41751', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('be9e2169-cfe2-49f8-a116-9c6ed1b41751', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('a55e4127-da19-44c5-8fad-26dbf0629840', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('a55e4127-da19-44c5-8fad-26dbf0629840', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('a55e4127-da19-44c5-8fad-26dbf0629840', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('93c79cf5-50bd-4695-af47-6a70ce2c7965', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('93c79cf5-50bd-4695-af47-6a70ce2c7965', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('93c79cf5-50bd-4695-af47-6a70ce2c7965', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('f7552d7d-3145-4861-8f5a-2abbc34f93dd', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('f7552d7d-3145-4861-8f5a-2abbc34f93dd', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('c6b71531-38b5-46e0-ade9-f209cfed1a93', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('c6b71531-38b5-46e0-ade9-f209cfed1a93', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('7c6ccafc-a670-44e1-9793-81ddf2d8e3c3', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('7c6ccafc-a670-44e1-9793-81ddf2d8e3c3', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('004b9d7d-0cb2-4dfc-9fd6-60cc9f93a5b2', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('004b9d7d-0cb2-4dfc-9fd6-60cc9f93a5b2', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('9231bd6f-e952-4c69-9d48-af6062643f4e', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('9231bd6f-e952-4c69-9d48-af6062643f4e', '${organizationScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('9231bd6f-e952-4c69-9d48-af6062643f4e', 'true', 'include.in.token.scope');


--
-- TOC entry 4218 (class 0 OID 17765)
-- Dependencies: 289
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client_scope_client VALUES ('3fc07da3-0fd4-4e49-a71e-b188598c0024', '93c79cf5-50bd-4695-af47-6a70ce2c7965', true);
INSERT INTO public.client_scope_client VALUES ('3fc07da3-0fd4-4e49-a71e-b188598c0024', 'c6b71531-38b5-46e0-ade9-f209cfed1a93', true);
INSERT INTO public.client_scope_client VALUES ('3fc07da3-0fd4-4e49-a71e-b188598c0024', '4e9ecc3a-e6fc-4ca8-a06f-43db0cb3148f', true);
INSERT INTO public.client_scope_client VALUES ('3fc07da3-0fd4-4e49-a71e-b188598c0024', 'a55e4127-da19-44c5-8fad-26dbf0629840', true);
INSERT INTO public.client_scope_client VALUES ('3fc07da3-0fd4-4e49-a71e-b188598c0024', '5fe73bd2-47fa-4191-b448-1f01f03f4f37', true);
INSERT INTO public.client_scope_client VALUES ('3fc07da3-0fd4-4e49-a71e-b188598c0024', '7c6ccafc-a670-44e1-9793-81ddf2d8e3c3', true);
INSERT INTO public.client_scope_client VALUES ('3fc07da3-0fd4-4e49-a71e-b188598c0024', '9231bd6f-e952-4c69-9d48-af6062643f4e', false);
INSERT INTO public.client_scope_client VALUES ('3fc07da3-0fd4-4e49-a71e-b188598c0024', 'db062b7e-2ec7-41d6-aae2-00a857d16c0d', false);
INSERT INTO public.client_scope_client VALUES ('3fc07da3-0fd4-4e49-a71e-b188598c0024', 'f7552d7d-3145-4861-8f5a-2abbc34f93dd', false);
INSERT INTO public.client_scope_client VALUES ('3fc07da3-0fd4-4e49-a71e-b188598c0024', 'be9e2169-cfe2-49f8-a116-9c6ed1b41751', false);
INSERT INTO public.client_scope_client VALUES ('3fc07da3-0fd4-4e49-a71e-b188598c0024', '791101d1-ddab-4c9a-8b8f-93fce929571b', false);
INSERT INTO public.client_scope_client VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', '93c79cf5-50bd-4695-af47-6a70ce2c7965', true);
INSERT INTO public.client_scope_client VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', 'c6b71531-38b5-46e0-ade9-f209cfed1a93', true);
INSERT INTO public.client_scope_client VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', '4e9ecc3a-e6fc-4ca8-a06f-43db0cb3148f', true);
INSERT INTO public.client_scope_client VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', 'a55e4127-da19-44c5-8fad-26dbf0629840', true);
INSERT INTO public.client_scope_client VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', '5fe73bd2-47fa-4191-b448-1f01f03f4f37', true);
INSERT INTO public.client_scope_client VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', '7c6ccafc-a670-44e1-9793-81ddf2d8e3c3', true);
INSERT INTO public.client_scope_client VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', '9231bd6f-e952-4c69-9d48-af6062643f4e', false);
INSERT INTO public.client_scope_client VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', 'db062b7e-2ec7-41d6-aae2-00a857d16c0d', false);
INSERT INTO public.client_scope_client VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', 'f7552d7d-3145-4861-8f5a-2abbc34f93dd', false);
INSERT INTO public.client_scope_client VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', 'be9e2169-cfe2-49f8-a116-9c6ed1b41751', false);
INSERT INTO public.client_scope_client VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', '791101d1-ddab-4c9a-8b8f-93fce929571b', false);
INSERT INTO public.client_scope_client VALUES ('a48b92bd-d74c-4c09-ae95-e7d12cbcce7e', '93c79cf5-50bd-4695-af47-6a70ce2c7965', true);
INSERT INTO public.client_scope_client VALUES ('a48b92bd-d74c-4c09-ae95-e7d12cbcce7e', 'c6b71531-38b5-46e0-ade9-f209cfed1a93', true);
INSERT INTO public.client_scope_client VALUES ('a48b92bd-d74c-4c09-ae95-e7d12cbcce7e', '4e9ecc3a-e6fc-4ca8-a06f-43db0cb3148f', true);
INSERT INTO public.client_scope_client VALUES ('a48b92bd-d74c-4c09-ae95-e7d12cbcce7e', 'a55e4127-da19-44c5-8fad-26dbf0629840', true);
INSERT INTO public.client_scope_client VALUES ('a48b92bd-d74c-4c09-ae95-e7d12cbcce7e', '5fe73bd2-47fa-4191-b448-1f01f03f4f37', true);
INSERT INTO public.client_scope_client VALUES ('a48b92bd-d74c-4c09-ae95-e7d12cbcce7e', '7c6ccafc-a670-44e1-9793-81ddf2d8e3c3', true);
INSERT INTO public.client_scope_client VALUES ('a48b92bd-d74c-4c09-ae95-e7d12cbcce7e', '9231bd6f-e952-4c69-9d48-af6062643f4e', false);
INSERT INTO public.client_scope_client VALUES ('a48b92bd-d74c-4c09-ae95-e7d12cbcce7e', 'db062b7e-2ec7-41d6-aae2-00a857d16c0d', false);
INSERT INTO public.client_scope_client VALUES ('a48b92bd-d74c-4c09-ae95-e7d12cbcce7e', 'f7552d7d-3145-4861-8f5a-2abbc34f93dd', false);
INSERT INTO public.client_scope_client VALUES ('a48b92bd-d74c-4c09-ae95-e7d12cbcce7e', 'be9e2169-cfe2-49f8-a116-9c6ed1b41751', false);
INSERT INTO public.client_scope_client VALUES ('a48b92bd-d74c-4c09-ae95-e7d12cbcce7e', '791101d1-ddab-4c9a-8b8f-93fce929571b', false);
INSERT INTO public.client_scope_client VALUES ('86645e61-3636-45a6-a125-08434364f99c', '93c79cf5-50bd-4695-af47-6a70ce2c7965', true);
INSERT INTO public.client_scope_client VALUES ('86645e61-3636-45a6-a125-08434364f99c', 'c6b71531-38b5-46e0-ade9-f209cfed1a93', true);
INSERT INTO public.client_scope_client VALUES ('86645e61-3636-45a6-a125-08434364f99c', '4e9ecc3a-e6fc-4ca8-a06f-43db0cb3148f', true);
INSERT INTO public.client_scope_client VALUES ('86645e61-3636-45a6-a125-08434364f99c', 'a55e4127-da19-44c5-8fad-26dbf0629840', true);
INSERT INTO public.client_scope_client VALUES ('86645e61-3636-45a6-a125-08434364f99c', '5fe73bd2-47fa-4191-b448-1f01f03f4f37', true);
INSERT INTO public.client_scope_client VALUES ('86645e61-3636-45a6-a125-08434364f99c', '7c6ccafc-a670-44e1-9793-81ddf2d8e3c3', true);
INSERT INTO public.client_scope_client VALUES ('86645e61-3636-45a6-a125-08434364f99c', '9231bd6f-e952-4c69-9d48-af6062643f4e', false);
INSERT INTO public.client_scope_client VALUES ('86645e61-3636-45a6-a125-08434364f99c', 'db062b7e-2ec7-41d6-aae2-00a857d16c0d', false);
INSERT INTO public.client_scope_client VALUES ('86645e61-3636-45a6-a125-08434364f99c', 'f7552d7d-3145-4861-8f5a-2abbc34f93dd', false);
INSERT INTO public.client_scope_client VALUES ('86645e61-3636-45a6-a125-08434364f99c', 'be9e2169-cfe2-49f8-a116-9c6ed1b41751', false);
INSERT INTO public.client_scope_client VALUES ('86645e61-3636-45a6-a125-08434364f99c', '791101d1-ddab-4c9a-8b8f-93fce929571b', false);
INSERT INTO public.client_scope_client VALUES ('252ff2ff-c027-4c62-b86f-841a8c3ec810', '93c79cf5-50bd-4695-af47-6a70ce2c7965', true);
INSERT INTO public.client_scope_client VALUES ('252ff2ff-c027-4c62-b86f-841a8c3ec810', 'c6b71531-38b5-46e0-ade9-f209cfed1a93', true);
INSERT INTO public.client_scope_client VALUES ('252ff2ff-c027-4c62-b86f-841a8c3ec810', '4e9ecc3a-e6fc-4ca8-a06f-43db0cb3148f', true);
INSERT INTO public.client_scope_client VALUES ('252ff2ff-c027-4c62-b86f-841a8c3ec810', 'a55e4127-da19-44c5-8fad-26dbf0629840', true);
INSERT INTO public.client_scope_client VALUES ('252ff2ff-c027-4c62-b86f-841a8c3ec810', '5fe73bd2-47fa-4191-b448-1f01f03f4f37', true);
INSERT INTO public.client_scope_client VALUES ('252ff2ff-c027-4c62-b86f-841a8c3ec810', '7c6ccafc-a670-44e1-9793-81ddf2d8e3c3', true);
INSERT INTO public.client_scope_client VALUES ('252ff2ff-c027-4c62-b86f-841a8c3ec810', '9231bd6f-e952-4c69-9d48-af6062643f4e', false);
INSERT INTO public.client_scope_client VALUES ('252ff2ff-c027-4c62-b86f-841a8c3ec810', 'db062b7e-2ec7-41d6-aae2-00a857d16c0d', false);
INSERT INTO public.client_scope_client VALUES ('252ff2ff-c027-4c62-b86f-841a8c3ec810', 'f7552d7d-3145-4861-8f5a-2abbc34f93dd', false);
INSERT INTO public.client_scope_client VALUES ('252ff2ff-c027-4c62-b86f-841a8c3ec810', 'be9e2169-cfe2-49f8-a116-9c6ed1b41751', false);
INSERT INTO public.client_scope_client VALUES ('252ff2ff-c027-4c62-b86f-841a8c3ec810', '791101d1-ddab-4c9a-8b8f-93fce929571b', false);
INSERT INTO public.client_scope_client VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', '93c79cf5-50bd-4695-af47-6a70ce2c7965', true);
INSERT INTO public.client_scope_client VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', 'c6b71531-38b5-46e0-ade9-f209cfed1a93', true);
INSERT INTO public.client_scope_client VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', '4e9ecc3a-e6fc-4ca8-a06f-43db0cb3148f', true);
INSERT INTO public.client_scope_client VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', 'a55e4127-da19-44c5-8fad-26dbf0629840', true);
INSERT INTO public.client_scope_client VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', '5fe73bd2-47fa-4191-b448-1f01f03f4f37', true);
INSERT INTO public.client_scope_client VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', '7c6ccafc-a670-44e1-9793-81ddf2d8e3c3', true);
INSERT INTO public.client_scope_client VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', '9231bd6f-e952-4c69-9d48-af6062643f4e', false);
INSERT INTO public.client_scope_client VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', 'db062b7e-2ec7-41d6-aae2-00a857d16c0d', false);
INSERT INTO public.client_scope_client VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', 'f7552d7d-3145-4861-8f5a-2abbc34f93dd', false);
INSERT INTO public.client_scope_client VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', 'be9e2169-cfe2-49f8-a116-9c6ed1b41751', false);
INSERT INTO public.client_scope_client VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', '791101d1-ddab-4c9a-8b8f-93fce929571b', false);


--
-- TOC entry 4196 (class 0 OID 17284)
-- Dependencies: 267
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client_scope_role_mapping VALUES ('db062b7e-2ec7-41d6-aae2-00a857d16c0d', '93acccf8-fc46-46b8-8880-2fa4156bee5d');


--
-- TOC entry 4214 (class 0 OID 17520)
-- Dependencies: 285
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.component VALUES ('6bcaee47-0ca3-406d-a40c-49efaa9cc8a4', 'Trusted Hosts', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'anonymous');
INSERT INTO public.component VALUES ('bb51af92-c9b9-415f-af2f-411e0c0e10c8', 'Consent Required', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'anonymous');
INSERT INTO public.component VALUES ('0dc02d36-2ae7-4bba-95b8-33595907b794', 'Full Scope Disabled', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'anonymous');
INSERT INTO public.component VALUES ('39a6a897-294f-40ba-8bdd-125bfff00e2f', 'Max Clients Limit', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'anonymous');
INSERT INTO public.component VALUES ('d0fcfb94-b88e-46c9-97d6-4f91b5497368', 'Allowed Protocol Mapper Types', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'anonymous');
INSERT INTO public.component VALUES ('a3337954-651f-4ba2-a2f4-4036d21f3a57', 'Allowed Client Scopes', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'anonymous');
INSERT INTO public.component VALUES ('df85326e-e107-4eae-b297-60f1a982c157', 'Allowed Protocol Mapper Types', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'authenticated');
INSERT INTO public.component VALUES ('9c3f8dc5-d486-4221-bfe8-b6c4b317f57f', 'Allowed Client Scopes', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'authenticated');
INSERT INTO public.component VALUES ('2f50dbfb-70e1-44b7-999b-3b83099eacc7', 'rsa-generated', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'rsa-generated', 'org.keycloak.keys.KeyProvider', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', NULL);
INSERT INTO public.component VALUES ('5357d41c-2eff-4913-b53e-d31d613e47af', 'rsa-enc-generated', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', NULL);
INSERT INTO public.component VALUES ('1671aac9-1756-471c-b169-f0195747a66c', 'hmac-generated-hs512', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'hmac-generated', 'org.keycloak.keys.KeyProvider', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', NULL);
INSERT INTO public.component VALUES ('333bb7cb-31d1-426e-a542-ea8bf5ef089b', 'aes-generated', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'aes-generated', 'org.keycloak.keys.KeyProvider', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', NULL);
INSERT INTO public.component VALUES ('04e71297-b8ff-4fad-8f5e-995e44514fcc', NULL, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'declarative-user-profile', 'org.keycloak.userprofile.UserProfileProvider', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', NULL);


--
-- TOC entry 4213 (class 0 OID 17515)
-- Dependencies: 284
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.component_config VALUES ('9250b0cb-5430-4191-987a-7018c23a162a', '6bcaee47-0ca3-406d-a40c-49efaa9cc8a4', 'client-uris-must-match', 'true');
INSERT INTO public.component_config VALUES ('73294815-2f01-4db1-a90f-3731e6feca90', '6bcaee47-0ca3-406d-a40c-49efaa9cc8a4', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config VALUES ('03e26185-cb6c-4225-bf0a-eb61d83c4d46', 'df85326e-e107-4eae-b297-60f1a982c157', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('e625f810-d42d-4e31-829d-204e70558236', 'df85326e-e107-4eae-b297-60f1a982c157', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('151795e6-c594-42ed-af31-29779577bcdf', 'df85326e-e107-4eae-b297-60f1a982c157', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('c7c95de6-9357-4581-90ac-06d25b8c1d5c', 'df85326e-e107-4eae-b297-60f1a982c157', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('7a38db8a-e81f-496e-9d4c-d7a061552309', 'df85326e-e107-4eae-b297-60f1a982c157', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('e757a4c9-fd44-410e-bbf0-47c013a29d50', 'df85326e-e107-4eae-b297-60f1a982c157', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('423a2429-0971-4492-874e-5b81c620d3e1', 'df85326e-e107-4eae-b297-60f1a982c157', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('05bbb0b7-4688-4e8c-944a-127c9fcafd3b', 'df85326e-e107-4eae-b297-60f1a982c157', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('23ba0517-bbca-41b3-b3e9-1b3093e6d40e', 'a3337954-651f-4ba2-a2f4-4036d21f3a57', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('d769b317-d9d4-40ca-acc6-204f41dd0551', '39a6a897-294f-40ba-8bdd-125bfff00e2f', 'max-clients', '200');
INSERT INTO public.component_config VALUES ('dbe32e24-edf5-4a0b-953c-5b47b6d925ae', '9c3f8dc5-d486-4221-bfe8-b6c4b317f57f', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('e28fb70f-8406-40bb-803b-4318878ebde3', 'd0fcfb94-b88e-46c9-97d6-4f91b5497368', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('d60c5955-b42e-4698-8bcf-73ff469271b0', 'd0fcfb94-b88e-46c9-97d6-4f91b5497368', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('79912074-5a6b-47a6-be5d-8b79bdb6cf83', 'd0fcfb94-b88e-46c9-97d6-4f91b5497368', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('6a212459-e737-47a9-837d-63246f06f900', 'd0fcfb94-b88e-46c9-97d6-4f91b5497368', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('95096867-a5ed-4d3a-a17e-ead7d502951d', 'd0fcfb94-b88e-46c9-97d6-4f91b5497368', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('d7684657-498e-4374-84b8-2e8a1b3e41b5', 'd0fcfb94-b88e-46c9-97d6-4f91b5497368', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('5ea03aab-aa1c-4b8c-86cb-8de280d4634a', 'd0fcfb94-b88e-46c9-97d6-4f91b5497368', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('769c022e-9cd5-4d97-81c3-fefd40a113d1', 'd0fcfb94-b88e-46c9-97d6-4f91b5497368', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('0117fca3-a24d-4c51-b5fe-e5b19f42639f', '5357d41c-2eff-4913-b53e-d31d613e47af', 'certificate', 'MIICmzCCAYMCBgGYjrlmSDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwODA5MTIwNDMxWhcNMzUwODA5MTIwNjExWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCr5g2tJ5V59mZVUr4CIeCTC+YINfp0K3e8aa9jBwAXGfLBXF1BFtrmzlqWfoEGpi7y7Y5rrIJOfONpujsPPGVSUqkkntO/ELkVEk8mQ6YzNFVKZGsI//2e9FG879WdviDxPrSY5CPHEDfp44XdXs0J8iDlcEJooN61EpTJimYtPqZ5DjNafRZWCYBE5OZNIzX8qHej73pwnUe106KeCzRPgN/gZf5+Yh43D95q6a4YXfL0QhF9HBQ1TWxseDjQj76l78TEs+4zF8BQDvSF2wFBeYsIfkpqlURuh8CJExCbhfX4wV6d/7XJjOvKHQxJ/bcS0Tj8gPuqeowa2MLgbRXNAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADj0xffpnxK2cprqO9OYJVtFMvdBSmmvkf8/34x3VpXIRNxR3OO4c5A71gD4ad+sgceB2pLqmEBQEEBiCFM/w8wbc1rDTCEc6VKtKLxArPLzuAPULnHOXejQ3l14Tq2X+O4pAI403O4yydwIbVFWkd00NweqeqYzQPXOk3H7ydnDmT85yUxwpNJPE/126AF6Vqb8cZzUjX12M4gp1+RNOk+YUOjxHFqeEkf91+WWFeoEg6NemQdARjDMfqSFJWoBtkY6HbtkDXOmKcdM8zfEqr3fBcpMHXDr+oyGKp+XjTD6rODrNiDRiyTFGu3kRSfsTqVPaDofSSmAKbD2pI6TEGo=');
INSERT INTO public.component_config VALUES ('de02589f-d4ca-434e-a42f-3d30a2a0c7ea', '5357d41c-2eff-4913-b53e-d31d613e47af', 'priority', '100');
INSERT INTO public.component_config VALUES ('7fc852d7-c57c-44a8-8757-8677f953961c', '5357d41c-2eff-4913-b53e-d31d613e47af', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config VALUES ('42b6d283-0627-400b-af5f-ddcacec41a23', '5357d41c-2eff-4913-b53e-d31d613e47af', 'keyUse', 'ENC');
INSERT INTO public.component_config VALUES ('61fbb5c9-86b4-47df-81d4-c742da90e377', '5357d41c-2eff-4913-b53e-d31d613e47af', 'privateKey', 'MIIEowIBAAKCAQEAq+YNrSeVefZmVVK+AiHgkwvmCDX6dCt3vGmvYwcAFxnywVxdQRba5s5aln6BBqYu8u2Oa6yCTnzjabo7DzxlUlKpJJ7TvxC5FRJPJkOmMzRVSmRrCP/9nvRRvO/Vnb4g8T60mOQjxxA36eOF3V7NCfIg5XBCaKDetRKUyYpmLT6meQ4zWn0WVgmAROTmTSM1/Kh3o+96cJ1HtdOings0T4Df4GX+fmIeNw/eaumuGF3y9EIRfRwUNU1sbHg40I++pe/ExLPuMxfAUA70hdsBQXmLCH5KapVEbofAiRMQm4X1+MFenf+1yYzryh0MSf23EtE4/ID7qnqMGtjC4G0VzQIDAQABAoIBADhJDMNcybn0r09S13p1Q0aCx+B6ZDazoPIlnNMNEL9/tJgRuUs9w5F9kfXjGDZoJclPdanWA5jVldUhsILtoLOS82VVSDowrJm0tAvwbLQpd5/zP4Tj5VSt5TG7SjPrdHfps1K4qOpeaiCAam2ww+x0xsa5ulTuD940ZlmTop8/cfMYjpR9E+HoMM5X8zspaXMgCx1WvMeaQL01Be2y8mWG3dRTwKIxUDrXGHk2gEbIyLeGe5NQlangWliPLCik4kHNHG25gXQ79NPnTi8doLvmi/KYoB+hJcNC3gIrR2NkUzDqwq5vepCpqkY6pI9w++9LAMt48VM9mjzjNpxtfZUCgYEA1qWr8iJ+eW7THLFETrefqhg4KwiJ0wPBsXq2canR6+GlH1dpB5Tb4H7TN5shehj652LydabmIV6qq1DIJUyxNCqYtvlo2nsFvCmOkDYONn4Vo6VUKrsTnTOreEB5tw+TgLsaHvv6k4GpBjWCD9sg3uD+F2b/ebJdzJTX7b4TTf8CgYEAzQQKA7JTef8540csL9qOMUF8Ei6+Lt8MeIU5bWGh/S7FWAQ3HEbZ7E80J2YDbamZeXwDl2ChIy8hWZVB6JgaAwYEy7GGnby0xdG6MLj5hLShPIQktgVciQHOFTAp3B8XfilQTzwRE1fWZ6/2FX8UoqaU6qdkRTV6y+B2AybDdDMCgYBqQRS/BihJgHztBStlNCzLjLWxR8bCOGfXrYFG/uO1urt8qk6JvDykAuQX8Kk/wcHibO7NItNkzXH64EBThoVp53Q1j31COgf6vy+dX8TlYMDhg2QIyxbIiN1m57PY1NMVtIkXsXC3OEYtlqtNohHBgusFNq1c1tjr/vps69yujQKBgFDkrhrlSyDQ/wNZuuqq3v46a301Kl+OLPqE/rLVGjivMrjW+PPUVPp0Cg0dqG6lw+P2dehN/WbHmu4hAZ+IHINi5ZOF2ar1oZKIfWHqKrIdH52kOmQD245HwwwDNBEhx4BFRuXsuoQaXYQOHxg+S2MePZYVNHBGeMxnJcl6ixaXAoGBAMsusLWPa2ab45bD+LObcE8g6l4KYdZsoCh5gtqXmTZ87Jb8njPR/TISoEN3mJnEQGcL2aXXqYPFgczHPbAvPMosLi2nTApJGKYvzTtSbHWHYQhuK4WsWBtLsWO/X95h23NuLAQXAxiIPw4BQs0ifEHmuGZONZagUKSrw1t44Dd6');
INSERT INTO public.component_config VALUES ('8e42727a-8bf9-46e3-9746-819f92c49cfa', '333bb7cb-31d1-426e-a542-ea8bf5ef089b', 'priority', '100');
INSERT INTO public.component_config VALUES ('286d1918-68a4-4b06-82e9-055cf7374ea3', '333bb7cb-31d1-426e-a542-ea8bf5ef089b', 'secret', 'rTAF658Ct8rYlzQHisQ-CA');
INSERT INTO public.component_config VALUES ('ab935b2d-7fa9-49ab-b4ea-f5b087756f02', '333bb7cb-31d1-426e-a542-ea8bf5ef089b', 'kid', '64326601-f5df-4c4b-b4b1-ce5a226609cd');
INSERT INTO public.component_config VALUES ('ba84241a-b206-4917-840a-859188f9da58', '1671aac9-1756-471c-b169-f0195747a66c', 'algorithm', 'HS512');
INSERT INTO public.component_config VALUES ('65dc45b2-844d-4d3e-acc0-b0aa1cfcd417', '1671aac9-1756-471c-b169-f0195747a66c', 'priority', '100');
INSERT INTO public.component_config VALUES ('d44483cf-7ddc-486e-9bac-35c9ddfa1f81', '1671aac9-1756-471c-b169-f0195747a66c', 'kid', 'd0c0f90f-fb09-4f35-87f5-206d4e8f498c');
INSERT INTO public.component_config VALUES ('55ef3779-9106-4dcc-9a79-d17fe35590ec', '1671aac9-1756-471c-b169-f0195747a66c', 'secret', 'kHoQEabUWUkGMOdzluZo62pOS0d9-CxH0lOCC_UREAEf8qrzhLsiPN73uywZ3kKIXyOlAESonGWiXkAX9qcWgz9SIFESzyemstdXPv7z2NmpFxpSfGyeDr67sgmtnjdVGFBWBvdBZ5dWUdRgVBwWyRW9mlu0aCBo7q0sQq0x84E');
INSERT INTO public.component_config VALUES ('b8d93602-fb54-443d-877d-63ccd5d13bdf', '2f50dbfb-70e1-44b7-999b-3b83099eacc7', 'privateKey', 'MIIEpAIBAAKCAQEAyDthQ912oPkJuhctmivGDw8Exe/2v+YBH0HXyNe7L6BgLGZkoZuCYiMPWFzYF0EVf1SsW/nZXOclwRvMTlkMU3N7FLbemkxryROio5QUz3b0dFHpAjX3pW+4FgSGqYe3gnK+/V6zXwBNAPwv9Nc3UpZfEUn0a8clPe4rnTnFHeeS6kkNkzAtsXNYajV+AHy6ncV7MBByWWXzB0Gf0kgONG7mgbj1Kt1GIQmBzefyLMly935c0SJ2HmtRMPXOjDLkU0Eh+qO6OfhTWgbzfI93DWWlkK/taAAmUuuvo2JgX7uCgi6/UVM5f/qWtmV1n/loeE+Uie1O7RLMGB3yuXObBwIDAQABAoIBADBuKF79VIGn6sHfdFC7cLrYs5taqLCOpcvVJae3AlgJLuneVE3Aat9own/paPzq6ZO0O8I9YuU1JW0ZV6fFoxUWM/l1J89jV5i5jpeJLCVoDMWLwFOgEQerR3fP3XBo2qqLLYXkH3eFf5qS5NiQK5nmtBTe8ecVsnzRvCvZusM5/0on8TAZ6OgCyQw37a0vCKyuCbrWtsmtCnCtODOzZ/cvhHVDsK10voFtIhbCZkviEZNLJ4LTnUMCCcT7reofDOqMynjh+wpKc7kJ+3hx7WiObQ9ifALeHbWzdY87InMae62r3YK51fBxsrMrcHiE8Sszca1J4uqa7RnLaG8Ne20CgYEA+QjE7uFR9rOGXov5urC/9GrR38rOYZtEfyEiBaQVEEMFUttfKwL9nfliIpc2RyArcu+SqdhsBFmuBNybEs+1IpGOhPhwXP4q9P8/+idcWHMoZsFxQUK6fDI5cj4MFkfoCXvyvnYLfwlR0/pofqrxUxuSAx7TmQq6ZBc8nckFA1sCgYEAzdUoXeefEZDYomJS5CqnYs8kTvfZ/lNVjvh/24pVI2KTMVUx9Pd9ZsslHV9NmC6AeIDW3F9BH0G6CAoS5njdN+AUlAS0Yw0e/3tx9fVqlKRut/ong+Lk3nLASTj6bxrSrUZbWOuialjzA/tmAFU0oUAUqIZsznLCnNmzTxoE8sUCgYEA2SREUuY0yZ+PsjDq91XWig/6H+B+Q61W9GK3f6OqmhtWMQEG4kIhUfV5FCA1O59ZQ0aR43bJ+KEZkzOoI6bokdPJKThXAT69xhIqfryDULxYpgBV+EluwYwpeuuPLn5UXLCu4FOdgo9lwie9pXT4JzcLAZ2HcxJfo5Z/TDVTIbECgYBgDjGgYQ8iq23tmeUFBcLHodNX5uKchVdQOTexxISm1sHKK+/8WeLzranMY0Va15iso7Ohc/J4G7wtNEZNt+nEwZXY3bkw4Fau83TjS3xJkdL5mIwISEJ2bSa/BRAZ+XKH2mWWwaAx8QC3wwJ+9URyW+1IGDN+xJ99gzril0nn4QKBgQCnTvCrhA83dGvrRfJu3p4nB/uCkxqAK4Szzn6m9aroVBJJwgQKpE+mZDR78ywK8BqISETtX0MIALhJmt21/EsivCZ+uXXG8l7DrZa9kKHdpFx4rvwSK57mmd7j1Fd555DsFmkkoRxk7ofsLlt4VnRCdQyeHgc9r3jzgltaJSO+Yg==');
INSERT INTO public.component_config VALUES ('186e180a-a5e7-4e7e-b97d-f7c4c74d9ee2', '2f50dbfb-70e1-44b7-999b-3b83099eacc7', 'certificate', 'MIICmzCCAYMCBgGYjrllqTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwODA5MTIwNDMxWhcNMzUwODA5MTIwNjExWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDIO2FD3Xag+Qm6Fy2aK8YPDwTF7/a/5gEfQdfI17svoGAsZmShm4JiIw9YXNgXQRV/VKxb+dlc5yXBG8xOWQxTc3sUtt6aTGvJE6KjlBTPdvR0UekCNfelb7gWBIaph7eCcr79XrNfAE0A/C/01zdSll8RSfRrxyU97iudOcUd55LqSQ2TMC2xc1hqNX4AfLqdxXswEHJZZfMHQZ/SSA40buaBuPUq3UYhCYHN5/IsyXL3flzRInYea1Ew9c6MMuRTQSH6o7o5+FNaBvN8j3cNZaWQr+1oACZS66+jYmBfu4KCLr9RUzl/+pa2ZXWf+Wh4T5SJ7U7tEswYHfK5c5sHAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAA4fhWdVMCJJU1j+BACHzoNTYVTrI1jYNxw/2Tu6ld0YXjfhMD9CkpWJ6YyOHBdo7btXy4ciHIPPYn8ffZCoi1y9eVFEgndLbj+DFYh03o6QxC3OJESs79G2pnghx85dtsq3lGfQU+V/MQbkjJZzuKPWP3P3mvN6atjbonp1ey2CEiIeC+e5bf/nG07xt58nzPqC0pb2ksPUyK3ukleT7J852Cp+Pn1kMfW5uueyQo7ODxo/6uQy8fD1X15Fgk7XVjJUbruOH/31egW3vR7ROD/K6L9lScN/yS/halA7R4oCUSzjlG9J4g3ogZbOXYcAMW21UM4Jr1oB+0oIY0fqAkE=');
INSERT INTO public.component_config VALUES ('6b605295-6e82-4e77-821e-da1f511b0b46', '2f50dbfb-70e1-44b7-999b-3b83099eacc7', 'priority', '100');
INSERT INTO public.component_config VALUES ('7394c282-bdf8-4dba-9b6a-877114ef8d82', '2f50dbfb-70e1-44b7-999b-3b83099eacc7', 'keyUse', 'SIG');
INSERT INTO public.component_config VALUES ('f3353b29-191c-442c-ba72-67d013e9c775', '04e71297-b8ff-4fad-8f5e-995e44514fcc', 'kc.user.profile.config', '{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}');


--
-- TOC entry 4147 (class 0 OID 16417)
-- Dependencies: 218
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', '93ba64ea-a111-4ecf-a062-789880e20617');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', 'c6e31f4a-4bfd-4de2-b85d-0b840833f545');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', '1da15cf9-cb4d-449e-9ae3-5135d534e85b');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', 'b164ca38-4c6f-4d12-9936-e3599cda406d');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', 'bfaebba8-6a08-48e9-a9cd-c3b6d5daf2df');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', '5f0fa3bc-ff0e-4c5a-85d0-a7afd926c2a4');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', 'e6ce01e8-33bc-47ab-bb18-4ce5b78c171e');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', 'cd5fdf02-742d-4482-af32-826e8444ab57');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', '1c8522e9-8ef9-4e54-8d22-1b982f884a05');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', 'd0ee5bdd-4603-4e87-bc57-4ab7e7bc1392');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', '66422d60-14c8-42b8-b2f3-d65ff008bb83');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', '398c48fe-1fc2-42f3-8474-cc1495e94b2a');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', 'fcc68475-cab7-4a32-a087-67a5589cc63f');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', 'fd098fe6-ccef-42d8-a7c3-bf70fcbf4b5e');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', 'e6a7fc4e-b051-4636-9f59-bd59cf042b94');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', 'f7f4aedf-88ed-43ac-a26c-fd3347df2c4f');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', 'e2049d2c-913b-4806-9bba-810428491dc3');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', '784744a7-bfaf-4a1a-9608-7099d2ae2d73');
INSERT INTO public.composite_role VALUES ('1865d20a-574f-4e3c-bf7f-0376dcc30186', '0ec2348f-c686-420e-a008-b55580886975');
INSERT INTO public.composite_role VALUES ('b164ca38-4c6f-4d12-9936-e3599cda406d', 'e6a7fc4e-b051-4636-9f59-bd59cf042b94');
INSERT INTO public.composite_role VALUES ('b164ca38-4c6f-4d12-9936-e3599cda406d', '784744a7-bfaf-4a1a-9608-7099d2ae2d73');
INSERT INTO public.composite_role VALUES ('bfaebba8-6a08-48e9-a9cd-c3b6d5daf2df', 'f7f4aedf-88ed-43ac-a26c-fd3347df2c4f');
INSERT INTO public.composite_role VALUES ('1865d20a-574f-4e3c-bf7f-0376dcc30186', '47ad8d38-3a7e-424f-ae98-ecd22a4f3981');
INSERT INTO public.composite_role VALUES ('47ad8d38-3a7e-424f-ae98-ecd22a4f3981', '20f3c50e-c5dc-4077-a61c-a2cc8fd6f9c9');
INSERT INTO public.composite_role VALUES ('3e37e49a-feb5-4a4c-9ad6-a98cfa3b03bb', '9d793455-36d4-4294-9496-57e4beefb697');
INSERT INTO public.composite_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', '3e4d7938-f076-4192-a287-8eedddbed000');
INSERT INTO public.composite_role VALUES ('1865d20a-574f-4e3c-bf7f-0376dcc30186', '93acccf8-fc46-46b8-8880-2fa4156bee5d');
INSERT INTO public.composite_role VALUES ('1865d20a-574f-4e3c-bf7f-0376dcc30186', '06b2dcfd-39b8-4bfa-974f-e37b4c17ee87');


--
-- TOC entry 4148 (class 0 OID 16420)
-- Dependencies: 219
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.credential VALUES ('f998c45a-a597-41cd-b46d-3cf86a1f1519', NULL, 'password', '36a14a5a-74aa-4072-ac88-2688c77a4c51', 1754741171927, NULL, '{"value":"2zLwLsQH5OyWU9UNnw8bW1FQCYz8nTO8fTZ6fBWtZPY=","salt":"OhHjOHHAC1McP6x+cOsJzQ==","additionalParameters":{}}', '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}', 10, 0);


--
-- TOC entry 4145 (class 0 OID 16390)
-- Dependencies: 216
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2025-08-09 12:06:06.196756', 1, 'EXECUTED', '9:6f1016664e21e16d26517a4418f5e3df', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2025-08-09 12:06:06.204607', 2, 'MARK_RAN', '9:828775b1596a07d1200ba1d49e5e3941', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2025-08-09 12:06:06.221661', 3, 'EXECUTED', '9:5f090e44a7d595883c1fb61f4b41fd38', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2025-08-09 12:06:06.223027', 4, 'EXECUTED', '9:c07e577387a3d2c04d1adc9aaad8730e', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2025-08-09 12:06:06.260704', 5, 'EXECUTED', '9:b68ce996c655922dbcd2fe6b6ae72686', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2025-08-09 12:06:06.263447', 6, 'MARK_RAN', '9:543b5c9989f024fe35c6f6c5a97de88e', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2025-08-09 12:06:06.294798', 7, 'EXECUTED', '9:765afebbe21cf5bbca048e632df38336', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2025-08-09 12:06:06.297299', 8, 'MARK_RAN', '9:db4a145ba11a6fdaefb397f6dbf829a1', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2025-08-09 12:06:06.299541', 9, 'EXECUTED', '9:9d05c7be10cdb873f8bcb41bc3a8ab23', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2025-08-09 12:06:06.348924', 10, 'EXECUTED', '9:18593702353128d53111f9b1ff0b82b8', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2025-08-09 12:06:06.369164', 11, 'EXECUTED', '9:6122efe5f090e41a85c0f1c9e52cbb62', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2025-08-09 12:06:06.370759', 12, 'MARK_RAN', '9:e1ff28bf7568451453f844c5d54bb0b5', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2025-08-09 12:06:06.377533', 13, 'EXECUTED', '9:7af32cd8957fbc069f796b61217483fd', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-08-09 12:06:06.384793', 14, 'EXECUTED', '9:6005e15e84714cd83226bf7879f54190', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-08-09 12:06:06.385425', 15, 'MARK_RAN', '9:bf656f5a2b055d07f314431cae76f06c', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-08-09 12:06:06.386428', 16, 'MARK_RAN', '9:f8dadc9284440469dcf71e25ca6ab99b', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-08-09 12:06:06.387431', 17, 'EXECUTED', '9:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2025-08-09 12:06:06.404471', 18, 'EXECUTED', '9:3368ff0be4c2855ee2dd9ca813b38d8e', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2025-08-09 12:06:06.418583', 19, 'EXECUTED', '9:8ac2fb5dd030b24c0570a763ed75ed20', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2025-08-09 12:06:06.419939', 20, 'EXECUTED', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2025-08-09 12:06:06.420953', 21, 'MARK_RAN', '9:831e82914316dc8a57dc09d755f23c51', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2025-08-09 12:06:06.421813', 22, 'MARK_RAN', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2025-08-09 12:06:06.450326', 23, 'EXECUTED', '9:bc3d0f9e823a69dc21e23e94c7a94bb1', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2025-08-09 12:06:06.452693', 24, 'EXECUTED', '9:c9999da42f543575ab790e76439a2679', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2025-08-09 12:06:06.453294', 25, 'MARK_RAN', '9:0d6c65c6f58732d81569e77b10ba301d', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2025-08-09 12:06:06.61233', 26, 'EXECUTED', '9:fc576660fc016ae53d2d4778d84d86d0', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2025-08-09 12:06:06.638835', 27, 'EXECUTED', '9:43ed6b0da89ff77206289e87eaa9c024', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2025-08-09 12:06:06.6399', 28, 'EXECUTED', '9:44bae577f551b3738740281eceb4ea70', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2025-08-09 12:06:06.659475', 29, 'EXECUTED', '9:bd88e1f833df0420b01e114533aee5e8', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2025-08-09 12:06:06.665999', 30, 'EXECUTED', '9:a7022af5267f019d020edfe316ef4371', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2025-08-09 12:06:06.671587', 31, 'EXECUTED', '9:fc155c394040654d6a79227e56f5e25a', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2025-08-09 12:06:06.67306', 32, 'EXECUTED', '9:eac4ffb2a14795e5dc7b426063e54d88', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-08-09 12:06:06.674982', 33, 'EXECUTED', '9:54937c05672568c4c64fc9524c1e9462', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-08-09 12:06:06.675909', 34, 'MARK_RAN', '9:f9753208029f582525ed12011a19d054', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-08-09 12:06:06.684523', 35, 'EXECUTED', '9:33d72168746f81f98ae3a1e8e0ca3554', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2025-08-09 12:06:06.686321', 36, 'EXECUTED', '9:61b6d3d7a4c0e0024b0c839da283da0c', 'addColumn tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-08-09 12:06:06.687927', 37, 'EXECUTED', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2025-08-09 12:06:06.688867', 38, 'EXECUTED', '9:a2b870802540cb3faa72098db5388af3', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2025-08-09 12:06:06.689946', 39, 'EXECUTED', '9:132a67499ba24bcc54fb5cbdcfe7e4c0', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-08-09 12:06:06.69034', 40, 'MARK_RAN', '9:938f894c032f5430f2b0fafb1a243462', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-08-09 12:06:06.690863', 41, 'MARK_RAN', '9:845c332ff1874dc5d35974b0babf3006', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2025-08-09 12:06:06.692396', 42, 'EXECUTED', '9:fc86359c079781adc577c5a217e4d04c', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-08-09 12:06:07.412201', 43, 'EXECUTED', '9:59a64800e3c0d09b825f8a3b444fa8f4', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2025-08-09 12:06:07.414914', 44, 'EXECUTED', '9:d48d6da5c6ccf667807f633fe489ce88', 'addColumn tableName=USER_ENTITY', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-08-09 12:06:07.416304', 45, 'EXECUTED', '9:dde36f7973e80d71fceee683bc5d2951', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-08-09 12:06:07.417936', 46, 'EXECUTED', '9:b855e9b0a406b34fa323235a0cf4f640', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-08-09 12:06:07.418379', 47, 'MARK_RAN', '9:51abbacd7b416c50c4421a8cabf7927e', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-08-09 12:06:07.493077', 48, 'EXECUTED', '9:bdc99e567b3398bac83263d375aad143', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-08-09 12:06:07.494898', 49, 'EXECUTED', '9:d198654156881c46bfba39abd7769e69', 'addColumn tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2025-08-09 12:06:07.514003', 50, 'EXECUTED', '9:cfdd8736332ccdd72c5256ccb42335db', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2025-08-09 12:06:07.759473', 51, 'EXECUTED', '9:7c84de3d9bd84d7f077607c1a4dcb714', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2025-08-09 12:06:07.761208', 52, 'EXECUTED', '9:5a6bb36cbefb6a9d6928452c0852af2d', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2025-08-09 12:06:07.762278', 53, 'EXECUTED', '9:8f23e334dbc59f82e0a328373ca6ced0', 'update tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2025-08-09 12:06:07.763116', 54, 'EXECUTED', '9:9156214268f09d970cdf0e1564d866af', 'update tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-08-09 12:06:07.765952', 55, 'EXECUTED', '9:db806613b1ed154826c02610b7dbdf74', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-08-09 12:06:07.767344', 56, 'EXECUTED', '9:229a041fb72d5beac76bb94a5fa709de', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-08-09 12:06:07.799244', 57, 'EXECUTED', '9:079899dade9c1e683f26b2aa9ca6ff04', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-08-09 12:06:08.036136', 58, 'EXECUTED', '9:139b79bcbbfe903bb1c2d2a4dbf001d9', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2025-08-09 12:06:08.04647', 59, 'EXECUTED', '9:b55738ad889860c625ba2bf483495a04', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2025-08-09 12:06:08.049706', 60, 'EXECUTED', '9:e0057eac39aa8fc8e09ac6cfa4ae15fe', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2025-08-09 12:06:08.052395', 61, 'EXECUTED', '9:42a33806f3a0443fe0e7feeec821326c', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2025-08-09 12:06:08.054102', 62, 'EXECUTED', '9:9968206fca46eecc1f51db9c024bfe56', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2025-08-09 12:06:08.05495', 63, 'EXECUTED', '9:92143a6daea0a3f3b8f598c97ce55c3d', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2025-08-09 12:06:08.055738', 64, 'EXECUTED', '9:82bab26a27195d889fb0429003b18f40', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2025-08-09 12:06:08.05733', 65, 'EXECUTED', '9:e590c88ddc0b38b0ae4249bbfcb5abc3', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2025-08-09 12:06:08.085468', 66, 'EXECUTED', '9:5c1f475536118dbdc38d5d7977950cc0', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2025-08-09 12:06:08.103904', 67, 'EXECUTED', '9:e7c9f5f9c4d67ccbbcc215440c718a17', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2025-08-09 12:06:08.108021', 68, 'EXECUTED', '9:88e0bfdda924690d6f4e430c53447dd5', 'addColumn tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2025-08-09 12:06:08.133438', 69, 'EXECUTED', '9:f53177f137e1c46b6a88c59ec1cb5218', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2025-08-09 12:06:08.135231', 70, 'EXECUTED', '9:a74d33da4dc42a37ec27121580d1459f', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2025-08-09 12:06:08.136619', 71, 'EXECUTED', '9:fd4ade7b90c3b67fae0bfcfcb42dfb5f', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-08-09 12:06:08.139806', 72, 'EXECUTED', '9:aa072ad090bbba210d8f18781b8cebf4', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-08-09 12:06:08.141968', 73, 'EXECUTED', '9:1ae6be29bab7c2aa376f6983b932be37', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-08-09 12:06:08.143584', 74, 'MARK_RAN', '9:14706f286953fc9a25286dbd8fb30d97', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-08-09 12:06:08.155542', 75, 'EXECUTED', '9:2b9cc12779be32c5b40e2e67711a218b', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-08-09 12:06:08.183282', 76, 'EXECUTED', '9:91fa186ce7a5af127a2d7a91ee083cc5', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-08-09 12:06:08.185271', 77, 'EXECUTED', '9:6335e5c94e83a2639ccd68dd24e2e5ad', 'addColumn tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-08-09 12:06:08.186121', 78, 'MARK_RAN', '9:6bdb5658951e028bfe16fa0a8228b530', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-08-09 12:06:08.195413', 79, 'EXECUTED', '9:d5bc15a64117ccad481ce8792d4c608f', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-08-09 12:06:08.196188', 80, 'MARK_RAN', '9:077cba51999515f4d3e7ad5619ab592c', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-08-09 12:06:08.230021', 81, 'EXECUTED', '9:be969f08a163bf47c6b9e9ead8ac2afb', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-08-09 12:06:08.23076', 82, 'MARK_RAN', '9:6d3bb4408ba5a72f39bd8a0b301ec6e3', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-08-09 12:06:08.232301', 83, 'EXECUTED', '9:966bda61e46bebf3cc39518fbed52fa7', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-08-09 12:06:08.232673', 84, 'MARK_RAN', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-08-09 12:06:08.262539', 85, 'EXECUTED', '9:7d93d602352a30c0c317e6a609b56599', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2025-08-09 12:06:08.264469', 86, 'EXECUTED', '9:71c5969e6cdd8d7b6f47cebc86d37627', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2025-08-09 12:06:08.267209', 87, 'EXECUTED', '9:a9ba7d47f065f041b7da856a81762021', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2025-08-09 12:06:08.271147', 88, 'EXECUTED', '9:fffabce2bc01e1a8f5110d5278500065', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-09 12:06:08.274416', 89, 'EXECUTED', '9:fa8a5b5445e3857f4b010bafb5009957', 'addColumn tableName=REALM; customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-09 12:06:08.277475', 90, 'EXECUTED', '9:67ac3241df9a8582d591c5ed87125f39', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-09 12:06:08.304325', 91, 'EXECUTED', '9:ad1194d66c937e3ffc82386c050ba089', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-09 12:06:08.308446', 92, 'EXECUTED', '9:d9be619d94af5a2f5d07b9f003543b91', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-09 12:06:08.309108', 93, 'MARK_RAN', '9:544d201116a0fcc5a5da0925fbbc3bde', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-09 12:06:08.311998', 94, 'EXECUTED', '9:43c0c1055b6761b4b3e89de76d612ccf', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-09 12:06:08.312673', 95, 'MARK_RAN', '9:8bd711fd0330f4fe980494ca43ab1139', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-09 12:06:08.317497', 96, 'EXECUTED', '9:e07d2bc0970c348bb06fb63b1f82ddbf', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-08-09 12:06:08.395327', 97, 'EXECUTED', '9:24fb8611e97f29989bea412aa38d12b7', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-08-09 12:06:08.396201', 98, 'MARK_RAN', '9:259f89014ce2506ee84740cbf7163aa7', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-08-09 12:06:08.405796', 99, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-08-09 12:06:08.433843', 100, 'EXECUTED', '9:60ca84a0f8c94ec8c3504a5a3bc88ee8', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-08-09 12:06:08.434706', 101, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-08-09 12:06:08.465739', 102, 'EXECUTED', '9:0b305d8d1277f3a89a0a53a659ad274c', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-08-09 12:06:08.467582', 103, 'EXECUTED', '9:2c374ad2cdfe20e2905a84c8fac48460', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2025-08-09 12:06:08.470403', 104, 'EXECUTED', '9:47a760639ac597360a8219f5b768b4de', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', '2025-08-09 12:06:08.518112', 105, 'EXECUTED', '9:a6272f0576727dd8cad2522335f5d99e', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml', '2025-08-09 12:06:08.59439', 106, 'EXECUTED', '9:015479dbd691d9cc8669282f4828c41d', 'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('18.0.15-30992-index-consent', 'keycloak', 'META-INF/jpa-changelog-18.0.15.xml', '2025-08-09 12:06:08.622324', 107, 'EXECUTED', '9:80071ede7a05604b1f4906f3bf3b00f0', 'createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', '2025-08-09 12:06:08.623987', 108, 'EXECUTED', '9:9518e495fdd22f78ad6425cc30630221', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('20.0.0-12964-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2025-08-09 12:06:08.64284', 109, 'EXECUTED', '9:e5f243877199fd96bcc842f27a1656ac', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('20.0.0-12964-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2025-08-09 12:06:08.643448', 110, 'MARK_RAN', '9:1a6fcaa85e20bdeae0a9ce49b41946a5', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('client-attributes-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2025-08-09 12:06:08.646315', 111, 'EXECUTED', '9:3f332e13e90739ed0c35b0b25b7822ca', 'addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('21.0.2-17277', 'keycloak', 'META-INF/jpa-changelog-21.0.2.xml', '2025-08-09 12:06:08.6476', 112, 'EXECUTED', '9:7ee1f7a3fb8f5588f171fb9a6ab623c0', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('21.1.0-19404', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2025-08-09 12:06:08.659467', 113, 'EXECUTED', '9:3d7e830b52f33676b9d64f7f2b2ea634', 'modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('21.1.0-19404-2', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2025-08-09 12:06:08.661025', 114, 'MARK_RAN', '9:627d032e3ef2c06c0e1f73d2ae25c26c', 'addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('22.0.0-17484-updated', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2025-08-09 12:06:08.6658', 115, 'EXECUTED', '9:90af0bfd30cafc17b9f4d6eccd92b8b3', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('22.0.5-24031', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2025-08-09 12:06:08.666376', 116, 'MARK_RAN', '9:a60d2d7b315ec2d3eba9e2f145f9df28', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('23.0.0-12062', 'keycloak', 'META-INF/jpa-changelog-23.0.0.xml', '2025-08-09 12:06:08.668363', 117, 'EXECUTED', '9:2168fbe728fec46ae9baf15bf80927b8', 'addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('23.0.0-17258', 'keycloak', 'META-INF/jpa-changelog-23.0.0.xml', '2025-08-09 12:06:08.669266', 118, 'EXECUTED', '9:36506d679a83bbfda85a27ea1864dca8', 'addColumn tableName=EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('24.0.0-9758', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-08-09 12:06:08.778292', 119, 'EXECUTED', '9:502c557a5189f600f0f445a9b49ebbce', 'addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('24.0.0-9758-2', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-08-09 12:06:08.780677', 120, 'EXECUTED', '9:bf0fdee10afdf597a987adbf291db7b2', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('24.0.0-26618-drop-index-if-present', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-08-09 12:06:08.782667', 121, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('24.0.0-26618-reindex', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-08-09 12:06:08.803575', 122, 'EXECUTED', '9:08707c0f0db1cef6b352db03a60edc7f', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('24.0.2-27228', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2025-08-09 12:06:08.805012', 123, 'EXECUTED', '9:eaee11f6b8aa25d2cc6a84fb86fc6238', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('24.0.2-27967-drop-index-if-present', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2025-08-09 12:06:08.806186', 124, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('24.0.2-27967-reindex', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2025-08-09 12:06:08.806782', 125, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-tables', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-09 12:06:08.808461', 126, 'EXECUTED', '9:deda2df035df23388af95bbd36c17cef', 'addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-creation', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-09 12:06:08.830002', 127, 'EXECUTED', '9:3e96709818458ae49f3c679ae58d263a', 'createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-uss-createdon', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-09 12:06:08.954643', 128, 'EXECUTED', '9:78ab4fc129ed5e8265dbcc3485fba92f', 'dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-uss-preload', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-09 12:06:09.0354', 129, 'EXECUTED', '9:de5f7c1f7e10994ed8b62e621d20eaab', 'dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-uss-by-usersess', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-09 12:06:09.114265', 130, 'EXECUTED', '9:6eee220d024e38e89c799417ec33667f', 'dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-css-preload', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-09 12:06:09.196741', 131, 'EXECUTED', '9:5411d2fb2891d3e8d63ddb55dfa3c0c9', 'dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-2-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-09 12:06:09.197697', 132, 'MARK_RAN', '9:b7ef76036d3126bb83c2423bf4d449d6', 'createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-2-not-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-09 12:06:09.235808', 133, 'EXECUTED', '9:23396cf51ab8bc1ae6f0cac7f9f6fcf7', 'createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('25.0.0-org', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-09 12:06:09.245224', 134, 'EXECUTED', '9:5c859965c2c9b9c72136c360649af157', 'createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('unique-consentuser', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-09 12:06:09.250771', 135, 'EXECUTED', '9:5857626a2ea8767e9a6c66bf3a2cb32f', 'customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('unique-consentuser-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-09 12:06:09.251455', 136, 'MARK_RAN', '9:b79478aad5adaa1bc428e31563f55e8e', 'customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28861-index-creation', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-09 12:06:09.293096', 137, 'EXECUTED', '9:b9acb58ac958d9ada0fe12a5d4794ab1', 'createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-alias', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-09 12:06:09.296372', 138, 'EXECUTED', '9:6ef7d63e4412b3c2d66ed179159886a4', 'addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-group', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-09 12:06:09.299278', 139, 'EXECUTED', '9:da8e8087d80ef2ace4f89d8c5b9ca223', 'addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-indexes', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-09 12:06:09.329718', 140, 'EXECUTED', '9:79b05dcd610a8c7f25ec05135eec0857', 'createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-group-membership', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-09 12:06:09.332169', 141, 'EXECUTED', '9:a6ace2ce583a421d89b01ba2a28dc2d4', 'addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('31296-persist-revoked-access-tokens', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-09 12:06:09.336869', 142, 'EXECUTED', '9:64ef94489d42a358e8304b0e245f0ed4', 'createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('31725-index-persist-revoked-access-tokens', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-09 12:06:09.368595', 143, 'EXECUTED', '9:b994246ec2bf7c94da881e1d28782c7b', 'createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.0.0-idps-for-login', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-09 12:06:09.46813', 144, 'EXECUTED', '9:51f5fffadf986983d4bd59582c6c1604', 'addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.0.0-32583-drop-redundant-index-on-client-session', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-09 12:06:09.569472', 145, 'EXECUTED', '9:24972d83bf27317a055d234187bb4af9', 'dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-09 12:06:09.574808', 146, 'EXECUTED', '9:febdc0f47f2ed241c59e60f58c3ceea5', 'dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.0.0-33201-org-redirect-url', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-09 12:06:09.57664', 147, 'EXECUTED', '9:4d0e22b0ac68ebe9794fa9cb752ea660', 'addColumn tableName=ORG', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('29399-jdbc-ping-default', 'keycloak', 'META-INF/jpa-changelog-26.1.0.xml', '2025-08-09 12:06:09.580204', 148, 'EXECUTED', '9:007dbe99d7203fca403b89d4edfdf21e', 'createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.1.0-34013', 'keycloak', 'META-INF/jpa-changelog-26.1.0.xml', '2025-08-09 12:06:09.593483', 149, 'EXECUTED', '9:e6b686a15759aef99a6d758a5c4c6a26', 'addColumn tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.1.0-34380', 'keycloak', 'META-INF/jpa-changelog-26.1.0.xml', '2025-08-09 12:06:09.595465', 150, 'EXECUTED', '9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01', 'dropTable tableName=USERNAME_LOGIN_FAILURE', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.2.0-36750', 'keycloak', 'META-INF/jpa-changelog-26.2.0.xml', '2025-08-09 12:06:09.601423', 151, 'EXECUTED', '9:b49ce951c22f7eb16480ff085640a33a', 'createTable tableName=SERVER_CONFIG', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.2.0-26106', 'keycloak', 'META-INF/jpa-changelog-26.2.0.xml', '2025-08-09 12:06:09.602664', 152, 'EXECUTED', '9:b5877d5dab7d10ff3a9d209d7beb6680', 'addColumn tableName=CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.2.6-39866-duplicate', 'keycloak', 'META-INF/jpa-changelog-26.2.6.xml', '2025-08-09 12:06:09.604273', 153, 'EXECUTED', '9:1dc67ccee24f30331db2cba4f372e40e', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.2.6-39866-uk', 'keycloak', 'META-INF/jpa-changelog-26.2.6.xml', '2025-08-09 12:06:09.606423', 154, 'EXECUTED', '9:b70b76f47210cf0a5f4ef0e219eac7cd', 'addUniqueConstraint constraintName=UK_MIGRATION_VERSION, tableName=MIGRATION_MODEL', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.2.6-40088-duplicate', 'keycloak', 'META-INF/jpa-changelog-26.2.6.xml', '2025-08-09 12:06:09.607618', 155, 'EXECUTED', '9:cc7e02ed69ab31979afb1982f9670e8f', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.2.6-40088-uk', 'keycloak', 'META-INF/jpa-changelog-26.2.6.xml', '2025-08-09 12:06:09.609111', 156, 'EXECUTED', '9:5bb848128da7bc4595cc507383325241', 'addUniqueConstraint constraintName=UK_MIGRATION_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.29.1', NULL, NULL, '4741166018');
INSERT INTO public.databasechangelog VALUES ('26.3.0-groups-description', 'keycloak', 'META-INF/jpa-changelog-26.3.0.xml', '2025-08-09 12:06:09.612549', 157, 'EXECUTED', '9:e1a3c05574326fb5b246b73b9a4c4d49', 'addColumn tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '4741166018');


--
-- TOC entry 4144 (class 0 OID 16385)
-- Dependencies: 215
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.databasechangeloglock VALUES (1, false, NULL, NULL);
INSERT INTO public.databasechangeloglock VALUES (1000, false, NULL, NULL);


--
-- TOC entry 4219 (class 0 OID 17781)
-- Dependencies: 290
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.default_client_scope VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'db062b7e-2ec7-41d6-aae2-00a857d16c0d', false);
INSERT INTO public.default_client_scope VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '3a8488a7-132d-4771-aa80-82ff9d81ba6a', true);
INSERT INTO public.default_client_scope VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '6c6cb177-1549-42dc-8c37-bbe9a9ae22d0', true);
INSERT INTO public.default_client_scope VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '5fe73bd2-47fa-4191-b448-1f01f03f4f37', true);
INSERT INTO public.default_client_scope VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '4e9ecc3a-e6fc-4ca8-a06f-43db0cb3148f', true);
INSERT INTO public.default_client_scope VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '791101d1-ddab-4c9a-8b8f-93fce929571b', false);
INSERT INTO public.default_client_scope VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'be9e2169-cfe2-49f8-a116-9c6ed1b41751', false);
INSERT INTO public.default_client_scope VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'a55e4127-da19-44c5-8fad-26dbf0629840', true);
INSERT INTO public.default_client_scope VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '93c79cf5-50bd-4695-af47-6a70ce2c7965', true);
INSERT INTO public.default_client_scope VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'f7552d7d-3145-4861-8f5a-2abbc34f93dd', false);
INSERT INTO public.default_client_scope VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'c6b71531-38b5-46e0-ade9-f209cfed1a93', true);
INSERT INTO public.default_client_scope VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '7c6ccafc-a670-44e1-9793-81ddf2d8e3c3', true);
INSERT INTO public.default_client_scope VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '9231bd6f-e952-4c69-9d48-af6062643f4e', false);


--
-- TOC entry 4149 (class 0 OID 16425)
-- Dependencies: 220
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4207 (class 0 OID 17480)
-- Dependencies: 278
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4208 (class 0 OID 17485)
-- Dependencies: 279
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4221 (class 0 OID 17807)
-- Dependencies: 292
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4209 (class 0 OID 17494)
-- Dependencies: 280
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4210 (class 0 OID 17503)
-- Dependencies: 281
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4211 (class 0 OID 17506)
-- Dependencies: 282
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4212 (class 0 OID 17512)
-- Dependencies: 283
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4169 (class 0 OID 16802)
-- Dependencies: 240
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4215 (class 0 OID 17577)
-- Dependencies: 286
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4191 (class 0 OID 17204)
-- Dependencies: 262
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4190 (class 0 OID 17201)
-- Dependencies: 261
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4170 (class 0 OID 16807)
-- Dependencies: 241
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4171 (class 0 OID 16816)
-- Dependencies: 242
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4175 (class 0 OID 16920)
-- Dependencies: 246
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4176 (class 0 OID 16925)
-- Dependencies: 247
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4230 (class 0 OID 18006)
-- Dependencies: 301
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4189 (class 0 OID 17198)
-- Dependencies: 260
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4150 (class 0 OID 16433)
-- Dependencies: 221
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.keycloak_role VALUES ('1865d20a-574f-4e3c-bf7f-0376dcc30186', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', false, '${role_default-roles}', 'default-roles-master', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('93ba64ea-a111-4ecf-a062-789880e20617', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', false, '${role_create-realm}', 'create-realm', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', false, '${role_admin}', 'admin', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('c6e31f4a-4bfd-4de2-b85d-0b840833f545', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_create-client}', 'create-client', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('1da15cf9-cb4d-449e-9ae3-5135d534e85b', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_view-realm}', 'view-realm', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('b164ca38-4c6f-4d12-9936-e3599cda406d', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_view-users}', 'view-users', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('bfaebba8-6a08-48e9-a9cd-c3b6d5daf2df', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_view-clients}', 'view-clients', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('5f0fa3bc-ff0e-4c5a-85d0-a7afd926c2a4', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_view-events}', 'view-events', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('e6ce01e8-33bc-47ab-bb18-4ce5b78c171e', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_view-identity-providers}', 'view-identity-providers', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('cd5fdf02-742d-4482-af32-826e8444ab57', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_view-authorization}', 'view-authorization', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('1c8522e9-8ef9-4e54-8d22-1b982f884a05', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_manage-realm}', 'manage-realm', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('d0ee5bdd-4603-4e87-bc57-4ab7e7bc1392', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_manage-users}', 'manage-users', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('66422d60-14c8-42b8-b2f3-d65ff008bb83', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_manage-clients}', 'manage-clients', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('398c48fe-1fc2-42f3-8474-cc1495e94b2a', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_manage-events}', 'manage-events', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('fcc68475-cab7-4a32-a087-67a5589cc63f', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_manage-identity-providers}', 'manage-identity-providers', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('fd098fe6-ccef-42d8-a7c3-bf70fcbf4b5e', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_manage-authorization}', 'manage-authorization', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('e6a7fc4e-b051-4636-9f59-bd59cf042b94', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_query-users}', 'query-users', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('f7f4aedf-88ed-43ac-a26c-fd3347df2c4f', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_query-clients}', 'query-clients', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('e2049d2c-913b-4806-9bba-810428491dc3', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_query-realms}', 'query-realms', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('784744a7-bfaf-4a1a-9608-7099d2ae2d73', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_query-groups}', 'query-groups', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('0ec2348f-c686-420e-a008-b55580886975', '3fc07da3-0fd4-4e49-a71e-b188598c0024', true, '${role_view-profile}', 'view-profile', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '3fc07da3-0fd4-4e49-a71e-b188598c0024', NULL);
INSERT INTO public.keycloak_role VALUES ('47ad8d38-3a7e-424f-ae98-ecd22a4f3981', '3fc07da3-0fd4-4e49-a71e-b188598c0024', true, '${role_manage-account}', 'manage-account', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '3fc07da3-0fd4-4e49-a71e-b188598c0024', NULL);
INSERT INTO public.keycloak_role VALUES ('20f3c50e-c5dc-4077-a61c-a2cc8fd6f9c9', '3fc07da3-0fd4-4e49-a71e-b188598c0024', true, '${role_manage-account-links}', 'manage-account-links', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '3fc07da3-0fd4-4e49-a71e-b188598c0024', NULL);
INSERT INTO public.keycloak_role VALUES ('84717adf-56c3-41ad-befc-547387a214f9', '3fc07da3-0fd4-4e49-a71e-b188598c0024', true, '${role_view-applications}', 'view-applications', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '3fc07da3-0fd4-4e49-a71e-b188598c0024', NULL);
INSERT INTO public.keycloak_role VALUES ('9d793455-36d4-4294-9496-57e4beefb697', '3fc07da3-0fd4-4e49-a71e-b188598c0024', true, '${role_view-consent}', 'view-consent', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '3fc07da3-0fd4-4e49-a71e-b188598c0024', NULL);
INSERT INTO public.keycloak_role VALUES ('3e37e49a-feb5-4a4c-9ad6-a98cfa3b03bb', '3fc07da3-0fd4-4e49-a71e-b188598c0024', true, '${role_manage-consent}', 'manage-consent', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '3fc07da3-0fd4-4e49-a71e-b188598c0024', NULL);
INSERT INTO public.keycloak_role VALUES ('3c111393-5260-4cb1-a81d-17be77440859', '3fc07da3-0fd4-4e49-a71e-b188598c0024', true, '${role_view-groups}', 'view-groups', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '3fc07da3-0fd4-4e49-a71e-b188598c0024', NULL);
INSERT INTO public.keycloak_role VALUES ('79b933cc-6376-4db0-ab0f-e1a0b9d22ee1', '3fc07da3-0fd4-4e49-a71e-b188598c0024', true, '${role_delete-account}', 'delete-account', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '3fc07da3-0fd4-4e49-a71e-b188598c0024', NULL);
INSERT INTO public.keycloak_role VALUES ('aa1efbe3-283e-47d4-9a11-1945e9ede447', '86645e61-3636-45a6-a125-08434364f99c', true, '${role_read-token}', 'read-token', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '86645e61-3636-45a6-a125-08434364f99c', NULL);
INSERT INTO public.keycloak_role VALUES ('3e4d7938-f076-4192-a287-8eedddbed000', '252ff2ff-c027-4c62-b86f-841a8c3ec810', true, '${role_impersonation}', 'impersonation', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '252ff2ff-c027-4c62-b86f-841a8c3ec810', NULL);
INSERT INTO public.keycloak_role VALUES ('93acccf8-fc46-46b8-8880-2fa4156bee5d', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', false, '${role_offline-access}', 'offline_access', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('06b2dcfd-39b8-4bfa-974f-e37b4c17ee87', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', false, '${role_uma_authorization}', 'uma_authorization', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', NULL, NULL);


--
-- TOC entry 4174 (class 0 OID 16917)
-- Dependencies: 245
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.migration_model VALUES ('yeu3s', '26.3.2', 1754741170);


--
-- TOC entry 4188 (class 0 OID 17189)
-- Dependencies: 259
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4187 (class 0 OID 17184)
-- Dependencies: 258
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4227 (class 0 OID 17969)
-- Dependencies: 298
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4228 (class 0 OID 17980)
-- Dependencies: 299
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4201 (class 0 OID 17403)
-- Dependencies: 272
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4167 (class 0 OID 16791)
-- Dependencies: 238
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.protocol_mapper VALUES ('8899e907-f9ad-4473-b988-f57aa531da12', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', 'def27c3b-2f8b-4a91-8398-fb1157df1deb', NULL);
INSERT INTO public.protocol_mapper VALUES ('8436801d-93d4-43f6-9aaf-f41576c1a5d4', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', 'd895d904-c429-4770-a0a2-ae7825ddfab4', NULL);
INSERT INTO public.protocol_mapper VALUES ('1034b22b-8a8d-470c-8277-6252f1dc804e', 'role list', 'saml', 'saml-role-list-mapper', NULL, '3a8488a7-132d-4771-aa80-82ff9d81ba6a');
INSERT INTO public.protocol_mapper VALUES ('0fec02c1-621a-4966-b2d9-3fb521fc3256', 'organization', 'saml', 'saml-organization-membership-mapper', NULL, '6c6cb177-1549-42dc-8c37-bbe9a9ae22d0');
INSERT INTO public.protocol_mapper VALUES ('143c1425-fcf3-45ed-b60b-705e91047585', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, '5fe73bd2-47fa-4191-b448-1f01f03f4f37');
INSERT INTO public.protocol_mapper VALUES ('ea3c5e78-cb0f-47a3-87db-3ded8c16568d', 'family name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5fe73bd2-47fa-4191-b448-1f01f03f4f37');
INSERT INTO public.protocol_mapper VALUES ('794e7222-cf48-4cd0-b576-a7f30de231b7', 'given name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5fe73bd2-47fa-4191-b448-1f01f03f4f37');
INSERT INTO public.protocol_mapper VALUES ('fc8db675-5239-4b79-8563-0928fded6ed1', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5fe73bd2-47fa-4191-b448-1f01f03f4f37');
INSERT INTO public.protocol_mapper VALUES ('e5b33dbc-7280-44aa-8f34-4ee4e25d09f3', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5fe73bd2-47fa-4191-b448-1f01f03f4f37');
INSERT INTO public.protocol_mapper VALUES ('24a95ed1-68df-4c6a-93b8-f0c9e187a7e6', 'username', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5fe73bd2-47fa-4191-b448-1f01f03f4f37');
INSERT INTO public.protocol_mapper VALUES ('05f5714b-64c5-4a86-a6eb-7269b3fb7f48', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5fe73bd2-47fa-4191-b448-1f01f03f4f37');
INSERT INTO public.protocol_mapper VALUES ('a1eb7b07-b72f-4fbd-86c9-0df355efee9e', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5fe73bd2-47fa-4191-b448-1f01f03f4f37');
INSERT INTO public.protocol_mapper VALUES ('c34a1208-8b65-445e-8315-503636f525c7', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5fe73bd2-47fa-4191-b448-1f01f03f4f37');
INSERT INTO public.protocol_mapper VALUES ('6112ffe8-d09a-401e-97ca-c8d00f7cec42', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5fe73bd2-47fa-4191-b448-1f01f03f4f37');
INSERT INTO public.protocol_mapper VALUES ('3b7dfe16-5991-4f1d-91aa-6064055bfaca', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5fe73bd2-47fa-4191-b448-1f01f03f4f37');
INSERT INTO public.protocol_mapper VALUES ('9e81b48a-4d1c-4986-90e9-ecda3ab2ded0', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5fe73bd2-47fa-4191-b448-1f01f03f4f37');
INSERT INTO public.protocol_mapper VALUES ('efcac09f-3fac-4dc0-8c37-dfe869d80f98', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5fe73bd2-47fa-4191-b448-1f01f03f4f37');
INSERT INTO public.protocol_mapper VALUES ('27b00d8b-b4f8-4edd-a948-ffacbbf0ee45', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5fe73bd2-47fa-4191-b448-1f01f03f4f37');
INSERT INTO public.protocol_mapper VALUES ('08ed9c7c-7e59-44b8-95fc-b457dc9b6894', 'email', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '4e9ecc3a-e6fc-4ca8-a06f-43db0cb3148f');
INSERT INTO public.protocol_mapper VALUES ('36c4647b-a59c-4ebf-9b48-e6962a106644', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '4e9ecc3a-e6fc-4ca8-a06f-43db0cb3148f');
INSERT INTO public.protocol_mapper VALUES ('75983364-84d3-4fb4-a650-f1af33dcaa01', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '791101d1-ddab-4c9a-8b8f-93fce929571b');
INSERT INTO public.protocol_mapper VALUES ('110bb0c8-66bb-4a4a-b3e8-4d507c7ca2a8', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'be9e2169-cfe2-49f8-a116-9c6ed1b41751');
INSERT INTO public.protocol_mapper VALUES ('8654f56e-9552-4715-9e72-0cb21bb735f6', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'be9e2169-cfe2-49f8-a116-9c6ed1b41751');
INSERT INTO public.protocol_mapper VALUES ('1e1d2e14-e4ab-4dcb-a03a-378744db51c6', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'a55e4127-da19-44c5-8fad-26dbf0629840');
INSERT INTO public.protocol_mapper VALUES ('29beb349-17d7-480a-8eeb-6cc418b37fd3', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, 'a55e4127-da19-44c5-8fad-26dbf0629840');
INSERT INTO public.protocol_mapper VALUES ('0afc34a2-6279-4aa5-b5d6-6ab4dea22eea', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, 'a55e4127-da19-44c5-8fad-26dbf0629840');
INSERT INTO public.protocol_mapper VALUES ('7d13e707-e3fe-4b52-906e-a24546acf50e', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '93c79cf5-50bd-4695-af47-6a70ce2c7965');
INSERT INTO public.protocol_mapper VALUES ('5f4f0603-0e38-4118-a9a2-42559ee54129', 'upn', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f7552d7d-3145-4861-8f5a-2abbc34f93dd');
INSERT INTO public.protocol_mapper VALUES ('d8b449df-57a2-4012-96db-c2218d376c0a', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'f7552d7d-3145-4861-8f5a-2abbc34f93dd');
INSERT INTO public.protocol_mapper VALUES ('ed06aca3-dbb6-4740-8529-b79ef892b22a', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, 'c6b71531-38b5-46e0-ade9-f209cfed1a93');
INSERT INTO public.protocol_mapper VALUES ('4855caeb-cce5-4569-af3d-84f72c3c60c9', 'auth_time', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '7c6ccafc-a670-44e1-9793-81ddf2d8e3c3');
INSERT INTO public.protocol_mapper VALUES ('59693b04-becf-4ead-9be1-ec966d3817b7', 'sub', 'openid-connect', 'oidc-sub-mapper', NULL, '7c6ccafc-a670-44e1-9793-81ddf2d8e3c3');
INSERT INTO public.protocol_mapper VALUES ('d6d79493-b228-451a-9d19-b934e6ba12cd', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '004b9d7d-0cb2-4dfc-9fd6-60cc9f93a5b2');
INSERT INTO public.protocol_mapper VALUES ('a438b2f3-c14f-4811-8ba0-852de812bde2', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '004b9d7d-0cb2-4dfc-9fd6-60cc9f93a5b2');
INSERT INTO public.protocol_mapper VALUES ('14cf96a7-21d6-4e8b-af66-79c625344333', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '004b9d7d-0cb2-4dfc-9fd6-60cc9f93a5b2');
INSERT INTO public.protocol_mapper VALUES ('96f798f8-5b3f-41ec-b304-57e4996636e6', 'organization', 'openid-connect', 'oidc-organization-membership-mapper', NULL, '9231bd6f-e952-4c69-9d48-af6062643f4e');


--
-- TOC entry 4168 (class 0 OID 16797)
-- Dependencies: 239
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.protocol_mapper_config VALUES ('8436801d-93d4-43f6-9aaf-f41576c1a5d4', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8436801d-93d4-43f6-9aaf-f41576c1a5d4', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8436801d-93d4-43f6-9aaf-f41576c1a5d4', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('8436801d-93d4-43f6-9aaf-f41576c1a5d4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8436801d-93d4-43f6-9aaf-f41576c1a5d4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8436801d-93d4-43f6-9aaf-f41576c1a5d4', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('8436801d-93d4-43f6-9aaf-f41576c1a5d4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('1034b22b-8a8d-470c-8277-6252f1dc804e', 'false', 'single');
INSERT INTO public.protocol_mapper_config VALUES ('1034b22b-8a8d-470c-8277-6252f1dc804e', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config VALUES ('1034b22b-8a8d-470c-8277-6252f1dc804e', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config VALUES ('05f5714b-64c5-4a86-a6eb-7269b3fb7f48', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('05f5714b-64c5-4a86-a6eb-7269b3fb7f48', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('05f5714b-64c5-4a86-a6eb-7269b3fb7f48', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('05f5714b-64c5-4a86-a6eb-7269b3fb7f48', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('05f5714b-64c5-4a86-a6eb-7269b3fb7f48', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('05f5714b-64c5-4a86-a6eb-7269b3fb7f48', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('05f5714b-64c5-4a86-a6eb-7269b3fb7f48', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('143c1425-fcf3-45ed-b60b-705e91047585', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('143c1425-fcf3-45ed-b60b-705e91047585', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('143c1425-fcf3-45ed-b60b-705e91047585', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('143c1425-fcf3-45ed-b60b-705e91047585', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('24a95ed1-68df-4c6a-93b8-f0c9e187a7e6', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('24a95ed1-68df-4c6a-93b8-f0c9e187a7e6', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('24a95ed1-68df-4c6a-93b8-f0c9e187a7e6', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('24a95ed1-68df-4c6a-93b8-f0c9e187a7e6', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('24a95ed1-68df-4c6a-93b8-f0c9e187a7e6', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('24a95ed1-68df-4c6a-93b8-f0c9e187a7e6', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('24a95ed1-68df-4c6a-93b8-f0c9e187a7e6', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('27b00d8b-b4f8-4edd-a948-ffacbbf0ee45', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('27b00d8b-b4f8-4edd-a948-ffacbbf0ee45', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('27b00d8b-b4f8-4edd-a948-ffacbbf0ee45', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('27b00d8b-b4f8-4edd-a948-ffacbbf0ee45', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('27b00d8b-b4f8-4edd-a948-ffacbbf0ee45', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('27b00d8b-b4f8-4edd-a948-ffacbbf0ee45', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('27b00d8b-b4f8-4edd-a948-ffacbbf0ee45', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('3b7dfe16-5991-4f1d-91aa-6064055bfaca', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3b7dfe16-5991-4f1d-91aa-6064055bfaca', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3b7dfe16-5991-4f1d-91aa-6064055bfaca', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('3b7dfe16-5991-4f1d-91aa-6064055bfaca', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3b7dfe16-5991-4f1d-91aa-6064055bfaca', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3b7dfe16-5991-4f1d-91aa-6064055bfaca', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('3b7dfe16-5991-4f1d-91aa-6064055bfaca', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('6112ffe8-d09a-401e-97ca-c8d00f7cec42', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6112ffe8-d09a-401e-97ca-c8d00f7cec42', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6112ffe8-d09a-401e-97ca-c8d00f7cec42', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('6112ffe8-d09a-401e-97ca-c8d00f7cec42', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6112ffe8-d09a-401e-97ca-c8d00f7cec42', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6112ffe8-d09a-401e-97ca-c8d00f7cec42', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('6112ffe8-d09a-401e-97ca-c8d00f7cec42', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('794e7222-cf48-4cd0-b576-a7f30de231b7', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('794e7222-cf48-4cd0-b576-a7f30de231b7', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('794e7222-cf48-4cd0-b576-a7f30de231b7', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('794e7222-cf48-4cd0-b576-a7f30de231b7', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('794e7222-cf48-4cd0-b576-a7f30de231b7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('794e7222-cf48-4cd0-b576-a7f30de231b7', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('794e7222-cf48-4cd0-b576-a7f30de231b7', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('9e81b48a-4d1c-4986-90e9-ecda3ab2ded0', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9e81b48a-4d1c-4986-90e9-ecda3ab2ded0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9e81b48a-4d1c-4986-90e9-ecda3ab2ded0', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('9e81b48a-4d1c-4986-90e9-ecda3ab2ded0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9e81b48a-4d1c-4986-90e9-ecda3ab2ded0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9e81b48a-4d1c-4986-90e9-ecda3ab2ded0', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('9e81b48a-4d1c-4986-90e9-ecda3ab2ded0', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('a1eb7b07-b72f-4fbd-86c9-0df355efee9e', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a1eb7b07-b72f-4fbd-86c9-0df355efee9e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a1eb7b07-b72f-4fbd-86c9-0df355efee9e', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('a1eb7b07-b72f-4fbd-86c9-0df355efee9e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a1eb7b07-b72f-4fbd-86c9-0df355efee9e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a1eb7b07-b72f-4fbd-86c9-0df355efee9e', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('a1eb7b07-b72f-4fbd-86c9-0df355efee9e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('c34a1208-8b65-445e-8315-503636f525c7', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c34a1208-8b65-445e-8315-503636f525c7', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c34a1208-8b65-445e-8315-503636f525c7', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('c34a1208-8b65-445e-8315-503636f525c7', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c34a1208-8b65-445e-8315-503636f525c7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c34a1208-8b65-445e-8315-503636f525c7', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('c34a1208-8b65-445e-8315-503636f525c7', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('e5b33dbc-7280-44aa-8f34-4ee4e25d09f3', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e5b33dbc-7280-44aa-8f34-4ee4e25d09f3', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e5b33dbc-7280-44aa-8f34-4ee4e25d09f3', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('e5b33dbc-7280-44aa-8f34-4ee4e25d09f3', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e5b33dbc-7280-44aa-8f34-4ee4e25d09f3', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e5b33dbc-7280-44aa-8f34-4ee4e25d09f3', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('e5b33dbc-7280-44aa-8f34-4ee4e25d09f3', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('ea3c5e78-cb0f-47a3-87db-3ded8c16568d', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ea3c5e78-cb0f-47a3-87db-3ded8c16568d', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ea3c5e78-cb0f-47a3-87db-3ded8c16568d', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('ea3c5e78-cb0f-47a3-87db-3ded8c16568d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ea3c5e78-cb0f-47a3-87db-3ded8c16568d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ea3c5e78-cb0f-47a3-87db-3ded8c16568d', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('ea3c5e78-cb0f-47a3-87db-3ded8c16568d', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('efcac09f-3fac-4dc0-8c37-dfe869d80f98', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('efcac09f-3fac-4dc0-8c37-dfe869d80f98', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('efcac09f-3fac-4dc0-8c37-dfe869d80f98', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('efcac09f-3fac-4dc0-8c37-dfe869d80f98', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('efcac09f-3fac-4dc0-8c37-dfe869d80f98', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('efcac09f-3fac-4dc0-8c37-dfe869d80f98', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('efcac09f-3fac-4dc0-8c37-dfe869d80f98', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('fc8db675-5239-4b79-8563-0928fded6ed1', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fc8db675-5239-4b79-8563-0928fded6ed1', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fc8db675-5239-4b79-8563-0928fded6ed1', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('fc8db675-5239-4b79-8563-0928fded6ed1', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fc8db675-5239-4b79-8563-0928fded6ed1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fc8db675-5239-4b79-8563-0928fded6ed1', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('fc8db675-5239-4b79-8563-0928fded6ed1', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('08ed9c7c-7e59-44b8-95fc-b457dc9b6894', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('08ed9c7c-7e59-44b8-95fc-b457dc9b6894', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('08ed9c7c-7e59-44b8-95fc-b457dc9b6894', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('08ed9c7c-7e59-44b8-95fc-b457dc9b6894', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('08ed9c7c-7e59-44b8-95fc-b457dc9b6894', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('08ed9c7c-7e59-44b8-95fc-b457dc9b6894', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('08ed9c7c-7e59-44b8-95fc-b457dc9b6894', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('36c4647b-a59c-4ebf-9b48-e6962a106644', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('36c4647b-a59c-4ebf-9b48-e6962a106644', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('36c4647b-a59c-4ebf-9b48-e6962a106644', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('36c4647b-a59c-4ebf-9b48-e6962a106644', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('36c4647b-a59c-4ebf-9b48-e6962a106644', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('36c4647b-a59c-4ebf-9b48-e6962a106644', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('36c4647b-a59c-4ebf-9b48-e6962a106644', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('75983364-84d3-4fb4-a650-f1af33dcaa01', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config VALUES ('75983364-84d3-4fb4-a650-f1af33dcaa01', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config VALUES ('75983364-84d3-4fb4-a650-f1af33dcaa01', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('75983364-84d3-4fb4-a650-f1af33dcaa01', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config VALUES ('75983364-84d3-4fb4-a650-f1af33dcaa01', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('75983364-84d3-4fb4-a650-f1af33dcaa01', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config VALUES ('75983364-84d3-4fb4-a650-f1af33dcaa01', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('75983364-84d3-4fb4-a650-f1af33dcaa01', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config VALUES ('75983364-84d3-4fb4-a650-f1af33dcaa01', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('75983364-84d3-4fb4-a650-f1af33dcaa01', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config VALUES ('110bb0c8-66bb-4a4a-b3e8-4d507c7ca2a8', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('110bb0c8-66bb-4a4a-b3e8-4d507c7ca2a8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('110bb0c8-66bb-4a4a-b3e8-4d507c7ca2a8', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('110bb0c8-66bb-4a4a-b3e8-4d507c7ca2a8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('110bb0c8-66bb-4a4a-b3e8-4d507c7ca2a8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('110bb0c8-66bb-4a4a-b3e8-4d507c7ca2a8', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('110bb0c8-66bb-4a4a-b3e8-4d507c7ca2a8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('8654f56e-9552-4715-9e72-0cb21bb735f6', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8654f56e-9552-4715-9e72-0cb21bb735f6', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8654f56e-9552-4715-9e72-0cb21bb735f6', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('8654f56e-9552-4715-9e72-0cb21bb735f6', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8654f56e-9552-4715-9e72-0cb21bb735f6', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8654f56e-9552-4715-9e72-0cb21bb735f6', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('8654f56e-9552-4715-9e72-0cb21bb735f6', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('0afc34a2-6279-4aa5-b5d6-6ab4dea22eea', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0afc34a2-6279-4aa5-b5d6-6ab4dea22eea', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1e1d2e14-e4ab-4dcb-a03a-378744db51c6', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1e1d2e14-e4ab-4dcb-a03a-378744db51c6', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('1e1d2e14-e4ab-4dcb-a03a-378744db51c6', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('1e1d2e14-e4ab-4dcb-a03a-378744db51c6', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1e1d2e14-e4ab-4dcb-a03a-378744db51c6', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('1e1d2e14-e4ab-4dcb-a03a-378744db51c6', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('29beb349-17d7-480a-8eeb-6cc418b37fd3', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('29beb349-17d7-480a-8eeb-6cc418b37fd3', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('29beb349-17d7-480a-8eeb-6cc418b37fd3', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('29beb349-17d7-480a-8eeb-6cc418b37fd3', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('29beb349-17d7-480a-8eeb-6cc418b37fd3', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('29beb349-17d7-480a-8eeb-6cc418b37fd3', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('7d13e707-e3fe-4b52-906e-a24546acf50e', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7d13e707-e3fe-4b52-906e-a24546acf50e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5f4f0603-0e38-4118-a9a2-42559ee54129', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5f4f0603-0e38-4118-a9a2-42559ee54129', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5f4f0603-0e38-4118-a9a2-42559ee54129', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('5f4f0603-0e38-4118-a9a2-42559ee54129', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5f4f0603-0e38-4118-a9a2-42559ee54129', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5f4f0603-0e38-4118-a9a2-42559ee54129', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('5f4f0603-0e38-4118-a9a2-42559ee54129', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('d8b449df-57a2-4012-96db-c2218d376c0a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d8b449df-57a2-4012-96db-c2218d376c0a', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('d8b449df-57a2-4012-96db-c2218d376c0a', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('d8b449df-57a2-4012-96db-c2218d376c0a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d8b449df-57a2-4012-96db-c2218d376c0a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d8b449df-57a2-4012-96db-c2218d376c0a', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('d8b449df-57a2-4012-96db-c2218d376c0a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('ed06aca3-dbb6-4740-8529-b79ef892b22a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ed06aca3-dbb6-4740-8529-b79ef892b22a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ed06aca3-dbb6-4740-8529-b79ef892b22a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4855caeb-cce5-4569-af3d-84f72c3c60c9', 'AUTH_TIME', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('4855caeb-cce5-4569-af3d-84f72c3c60c9', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4855caeb-cce5-4569-af3d-84f72c3c60c9', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4855caeb-cce5-4569-af3d-84f72c3c60c9', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4855caeb-cce5-4569-af3d-84f72c3c60c9', 'auth_time', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('4855caeb-cce5-4569-af3d-84f72c3c60c9', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('59693b04-becf-4ead-9be1-ec966d3817b7', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('59693b04-becf-4ead-9be1-ec966d3817b7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('14cf96a7-21d6-4e8b-af66-79c625344333', 'clientAddress', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('14cf96a7-21d6-4e8b-af66-79c625344333', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('14cf96a7-21d6-4e8b-af66-79c625344333', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('14cf96a7-21d6-4e8b-af66-79c625344333', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('14cf96a7-21d6-4e8b-af66-79c625344333', 'clientAddress', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('14cf96a7-21d6-4e8b-af66-79c625344333', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('a438b2f3-c14f-4811-8ba0-852de812bde2', 'clientHost', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('a438b2f3-c14f-4811-8ba0-852de812bde2', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a438b2f3-c14f-4811-8ba0-852de812bde2', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a438b2f3-c14f-4811-8ba0-852de812bde2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a438b2f3-c14f-4811-8ba0-852de812bde2', 'clientHost', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('a438b2f3-c14f-4811-8ba0-852de812bde2', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('d6d79493-b228-451a-9d19-b934e6ba12cd', 'client_id', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('d6d79493-b228-451a-9d19-b934e6ba12cd', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d6d79493-b228-451a-9d19-b934e6ba12cd', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d6d79493-b228-451a-9d19-b934e6ba12cd', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d6d79493-b228-451a-9d19-b934e6ba12cd', 'client_id', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('d6d79493-b228-451a-9d19-b934e6ba12cd', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('96f798f8-5b3f-41ec-b304-57e4996636e6', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('96f798f8-5b3f-41ec-b304-57e4996636e6', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('96f798f8-5b3f-41ec-b304-57e4996636e6', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('96f798f8-5b3f-41ec-b304-57e4996636e6', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('96f798f8-5b3f-41ec-b304-57e4996636e6', 'organization', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('96f798f8-5b3f-41ec-b304-57e4996636e6', 'String', 'jsonType.label');


--
-- TOC entry 4151 (class 0 OID 16439)
-- Dependencies: 222
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.realm VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, '252ff2ff-c027-4c62-b86f-841a8c3ec810', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', 'b26204cf-678e-46c9-a023-74745aa1821f', '71333b67-7e86-4bd9-b813-eebb5c42c37d', '2b2d788a-1bb0-4dae-a3d2-f5e431aca6f8', '607542c6-81ed-4955-944f-190efff9ed5d', 'd26e6e21-7416-47b8-bc27-5d8cba7930f7', 2592000, false, 900, true, false, '2456f684-ccea-4725-87d5-0d8e22d2619d', 0, false, 0, 0, '1865d20a-574f-4e3c-bf7f-0376dcc30186');


--
-- TOC entry 4152 (class 0 OID 16456)
-- Dependencies: 223
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicyReportOnly', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xContentTypeOptions', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'nosniff');
INSERT INTO public.realm_attribute VALUES ('_browser_header.referrerPolicy', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'no-referrer');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xRobotsTag', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'none');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xFrameOptions', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'SAMEORIGIN');
INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicy', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute VALUES ('_browser_header.strictTransportSecurity', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'max-age=31536000; includeSubDomains');
INSERT INTO public.realm_attribute VALUES ('bruteForceProtected', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'false');
INSERT INTO public.realm_attribute VALUES ('permanentLockout', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'false');
INSERT INTO public.realm_attribute VALUES ('maxTemporaryLockouts', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '0');
INSERT INTO public.realm_attribute VALUES ('bruteForceStrategy', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'MULTIPLE');
INSERT INTO public.realm_attribute VALUES ('maxFailureWaitSeconds', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '900');
INSERT INTO public.realm_attribute VALUES ('minimumQuickLoginWaitSeconds', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '60');
INSERT INTO public.realm_attribute VALUES ('waitIncrementSeconds', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '60');
INSERT INTO public.realm_attribute VALUES ('quickLoginCheckMilliSeconds', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '1000');
INSERT INTO public.realm_attribute VALUES ('maxDeltaTimeSeconds', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '43200');
INSERT INTO public.realm_attribute VALUES ('failureFactor', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '30');
INSERT INTO public.realm_attribute VALUES ('realmReusableOtpCode', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'false');
INSERT INTO public.realm_attribute VALUES ('firstBrokerLoginFlowId', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '7954f2d5-849f-4ba2-905e-e522cd61bcee');
INSERT INTO public.realm_attribute VALUES ('displayName', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'Keycloak');
INSERT INTO public.realm_attribute VALUES ('displayNameHtml', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '<div class="kc-logo-text"><span>Keycloak</span></div>');
INSERT INTO public.realm_attribute VALUES ('defaultSignatureAlgorithm', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'RS256');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespanEnabled', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'false');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespan', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', '5184000');


--
-- TOC entry 4193 (class 0 OID 17213)
-- Dependencies: 264
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4173 (class 0 OID 16909)
-- Dependencies: 244
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4153 (class 0 OID 16464)
-- Dependencies: 224
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.realm_events_listeners VALUES ('8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'jboss-logging');


--
-- TOC entry 4226 (class 0 OID 17915)
-- Dependencies: 297
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4154 (class 0 OID 16467)
-- Dependencies: 225
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.realm_required_credential VALUES ('password', 'password', true, true, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19');


--
-- TOC entry 4155 (class 0 OID 16474)
-- Dependencies: 226
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4172 (class 0 OID 16825)
-- Dependencies: 243
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4156 (class 0 OID 16484)
-- Dependencies: 227
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.redirect_uris VALUES ('3fc07da3-0fd4-4e49-a71e-b188598c0024', '/realms/master/account/*');
INSERT INTO public.redirect_uris VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', '/realms/master/account/*');
INSERT INTO public.redirect_uris VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', '/admin/master/console/*');


--
-- TOC entry 4186 (class 0 OID 17148)
-- Dependencies: 257
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4185 (class 0 OID 17141)
-- Dependencies: 256
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.required_action_provider VALUES ('8cee97f6-1602-49ae-a7ea-5aa2ecfa6a1d', 'VERIFY_EMAIL', 'Verify Email', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider VALUES ('576c3fcd-fcf8-46a5-b8cd-f3a1e68bcd31', 'UPDATE_PROFILE', 'Update Profile', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider VALUES ('51c87bc2-2b1a-46d6-b63a-e1e477bbfad6', 'CONFIGURE_TOTP', 'Configure OTP', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider VALUES ('b9262fe3-066f-42c3-b605-23a7efa7345a', 'UPDATE_PASSWORD', 'Update Password', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider VALUES ('0d3414e0-06dc-4a2d-bcd5-320bcbbde6ec', 'TERMS_AND_CONDITIONS', 'Terms and Conditions', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', false, false, 'TERMS_AND_CONDITIONS', 20);
INSERT INTO public.required_action_provider VALUES ('879566e3-018c-4f47-8617-300e6c6a46ec', 'delete_account', 'Delete Account', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', false, false, 'delete_account', 60);
INSERT INTO public.required_action_provider VALUES ('70d4b3de-e89e-4c87-af7d-e5b8d280f8be', 'delete_credential', 'Delete Credential', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', true, false, 'delete_credential', 100);
INSERT INTO public.required_action_provider VALUES ('0bbd134c-e639-4dde-b7b3-0d22ec629b7c', 'update_user_locale', 'Update User Locale', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider VALUES ('62d0e937-9d4e-4b04-8a65-8423d4174e98', 'CONFIGURE_RECOVERY_AUTHN_CODES', 'Recovery Authentication Codes', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', true, false, 'CONFIGURE_RECOVERY_AUTHN_CODES', 120);
INSERT INTO public.required_action_provider VALUES ('889a07f1-a4f5-42d7-a494-f9b545b65df7', 'webauthn-register', 'Webauthn Register', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', true, false, 'webauthn-register', 70);
INSERT INTO public.required_action_provider VALUES ('8a7dc1ce-f085-4478-9ec8-0ffabcc8ebf7', 'webauthn-register-passwordless', 'Webauthn Register Passwordless', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', true, false, 'webauthn-register-passwordless', 80);
INSERT INTO public.required_action_provider VALUES ('601161ca-f199-4ea0-a4a3-f951010bcc78', 'VERIFY_PROFILE', 'Verify Profile', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', true, false, 'VERIFY_PROFILE', 90);
INSERT INTO public.required_action_provider VALUES ('b428ea2b-6027-48a9-b27b-e6d45ab9e434', 'idp_link', 'Linking Identity Provider', '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', true, false, 'idp_link', 110);


--
-- TOC entry 4223 (class 0 OID 17846)
-- Dependencies: 294
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4203 (class 0 OID 17430)
-- Dependencies: 274
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4202 (class 0 OID 17415)
-- Dependencies: 273
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4197 (class 0 OID 17353)
-- Dependencies: 268
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4222 (class 0 OID 17822)
-- Dependencies: 293
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4200 (class 0 OID 17389)
-- Dependencies: 271
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4198 (class 0 OID 17361)
-- Dependencies: 269
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4199 (class 0 OID 17375)
-- Dependencies: 270
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4224 (class 0 OID 17864)
-- Dependencies: 295
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4229 (class 0 OID 17997)
-- Dependencies: 300
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4225 (class 0 OID 17874)
-- Dependencies: 296
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4157 (class 0 OID 16487)
-- Dependencies: 228
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.scope_mapping VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', '47ad8d38-3a7e-424f-ae98-ecd22a4f3981');
INSERT INTO public.scope_mapping VALUES ('def27c3b-2f8b-4a91-8398-fb1157df1deb', '3c111393-5260-4cb1-a81d-17be77440859');


--
-- TOC entry 4204 (class 0 OID 17445)
-- Dependencies: 275
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4231 (class 0 OID 18013)
-- Dependencies: 302
-- Data for Name: server_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4158 (class 0 OID 16493)
-- Dependencies: 229
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_attribute VALUES ('is_temporary_admin', 'true', '36a14a5a-74aa-4072-ac88-2688c77a4c51', '5be7d764-6331-4c37-a864-695976e8676a', NULL, NULL, NULL);


--
-- TOC entry 4177 (class 0 OID 16930)
-- Dependencies: 248
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4220 (class 0 OID 17797)
-- Dependencies: 291
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4159 (class 0 OID 16498)
-- Dependencies: 230
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_entity VALUES ('36a14a5a-74aa-4072-ac88-2688c77a4c51', NULL, '2c64d20f-36ed-41bf-a966-1b827e00a792', false, true, NULL, NULL, NULL, '8c5fdaa5-9f2e-46d3-a48b-b63a952b0b19', 'admin', 1754741171842, NULL, 0);


--
-- TOC entry 4160 (class 0 OID 16506)
-- Dependencies: 231
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4183 (class 0 OID 17042)
-- Dependencies: 254
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4184 (class 0 OID 17047)
-- Dependencies: 255
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4161 (class 0 OID 16511)
-- Dependencies: 232
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4192 (class 0 OID 17210)
-- Dependencies: 263
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4162 (class 0 OID 16516)
-- Dependencies: 233
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4163 (class 0 OID 16519)
-- Dependencies: 234
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_role_mapping VALUES ('1865d20a-574f-4e3c-bf7f-0376dcc30186', '36a14a5a-74aa-4072-ac88-2688c77a4c51');
INSERT INTO public.user_role_mapping VALUES ('c49ae9de-8e7a-4a14-ba8a-a672109d818e', '36a14a5a-74aa-4072-ac88-2688c77a4c51');


--
-- TOC entry 4164 (class 0 OID 16533)
-- Dependencies: 235
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.web_origins VALUES ('d895d904-c429-4770-a0a2-ae7825ddfab4', '+');


--
-- TOC entry 3925 (class 2606 OID 17986)
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- TOC entry 3917 (class 2606 OID 17975)
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- TOC entry 3933 (class 2606 OID 18020)
-- Name: server_config SERVER_CONFIG_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.server_config
    ADD CONSTRAINT "SERVER_CONFIG_pkey" PRIMARY KEY (server_config_key);


--
-- TOC entry 3647 (class 2606 OID 17898)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3886 (class 2606 OID 17728)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3888 (class 2606 OID 17927)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3883 (class 2606 OID 17603)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3798 (class 2606 OID 17251)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3846 (class 2606 OID 17526)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3874 (class 2606 OID 17546)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3877 (class 2606 OID 17544)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3866 (class 2606 OID 17542)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3848 (class 2606 OID 17528)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3853 (class 2606 OID 17530)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3858 (class 2606 OID 17536)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3862 (class 2606 OID 17538)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3870 (class 2606 OID 17540)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3881 (class 2606 OID 17583)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3800 (class 2606 OID 17687)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3729 (class 2606 OID 17704)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3661 (class 2606 OID 17706)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3726 (class 2606 OID 17708)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3717 (class 2606 OID 16837)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3702 (class 2606 OID 16771)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3644 (class 2606 OID 16545)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3713 (class 2606 OID 16839)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3653 (class 2606 OID 16547)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3690 (class 2606 OID 16553)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3632 (class 2606 OID 16557)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3671 (class 2606 OID 16561)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3705 (class 2606 OID 16775)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3658 (class 2606 OID 16563)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3664 (class 2606 OID 16565)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3649 (class 2606 OID 16567)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3751 (class 2606 OID 17691)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3764 (class 2606 OID 17068)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3760 (class 2606 OID 17066)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3757 (class 2606 OID 17064)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3754 (class 2606 OID 17062)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3696 (class 2606 OID 16569)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3637 (class 2606 OID 17685)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3724 (class 2606 OID 16841)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3832 (class 2606 OID 17409)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3666 (class 2606 OID 16571)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3641 (class 2606 OID 16573)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3688 (class 2606 OID 16575)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3902 (class 2606 OID 17826)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3817 (class 2606 OID 17367)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3827 (class 2606 OID 17395)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3843 (class 2606 OID 17464)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3837 (class 2606 OID 17434)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3822 (class 2606 OID 17381)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3834 (class 2606 OID 17419)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3840 (class 2606 OID 17449)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3680 (class 2606 OID 16577)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3770 (class 2606 OID 17076)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3766 (class 2606 OID 17074)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3900 (class 2606 OID 17811)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3896 (class 2606 OID 17801)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3744 (class 2606 OID 16949)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3784 (class 2606 OID 17218)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3791 (class 2606 OID 17225)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3788 (class 2606 OID 17239)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3739 (class 2606 OID 16945)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3742 (class 2606 OID 17125)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3931 (class 2606 OID 18012)
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- TOC entry 3732 (class 2606 OID 16943)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3782 (class 2606 OID 17904)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3777 (class 2606 OID 17195)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3707 (class 2606 OID 16835)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3711 (class 2606 OID 17118)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3668 (class 2606 OID 17710)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3775 (class 2606 OID 17158)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3772 (class 2606 OID 17156)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3693 (class 2606 OID 17070)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3910 (class 2606 OID 17873)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3912 (class 2606 OID 17880)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3928 (class 2606 OID 18001)
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- TOC entry 3674 (class 2606 OID 17154)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3795 (class 2606 OID 17232)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3699 (class 2606 OID 17712)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3630 (class 2606 OID 16389)
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3809 (class 2606 OID 17335)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3804 (class 2606 OID 17294)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3815 (class 2606 OID 17665)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3813 (class 2606 OID 17323)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3894 (class 2606 OID 17786)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3915 (class 2606 OID 17921)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3908 (class 2606 OID 17853)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3786 (class 2606 OID 17595)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3722 (class 2606 OID 16892)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3635 (class 2606 OID 16581)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3806 (class 2606 OID 17739)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3684 (class 2606 OID 16585)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3747 (class 2606 OID 17990)
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3820 (class 2606 OID 17912)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3906 (class 2606 OID 17908)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3830 (class 2606 OID 17656)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3825 (class 2606 OID 17660)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3749 (class 2606 OID 17988)
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- TOC entry 3735 (class 2606 OID 18025)
-- Name: migration_model uk_migration_update_time; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_update_time UNIQUE (update_time);


--
-- TOC entry 3737 (class 2606 OID 18023)
-- Name: migration_model uk_migration_version; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_version UNIQUE (version);


--
-- TOC entry 3919 (class 2606 OID 17994)
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- TOC entry 3921 (class 2606 OID 17979)
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- TOC entry 3923 (class 2606 OID 17977)
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- TOC entry 3656 (class 2606 OID 16593)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3686 (class 2606 OID 17585)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3849 (class 1259 OID 17961)
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- TOC entry 3850 (class 1259 OID 17963)
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- TOC entry 3752 (class 1259 OID 17937)
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- TOC entry 3844 (class 1259 OID 17609)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3755 (class 1259 OID 17613)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- TOC entry 3761 (class 1259 OID 17611)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- TOC entry 3762 (class 1259 OID 17610)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3758 (class 1259 OID 17612)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- TOC entry 3889 (class 1259 OID 17928)
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- TOC entry 3703 (class 1259 OID 17964)
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- TOC entry 3633 (class 1259 OID 17913)
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- TOC entry 3884 (class 1259 OID 17653)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- TOC entry 3807 (class 1259 OID 17816)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3890 (class 1259 OID 17925)
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- TOC entry 3708 (class 1259 OID 17813)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3810 (class 1259 OID 17814)
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3875 (class 1259 OID 17619)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- TOC entry 3878 (class 1259 OID 17887)
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- TOC entry 3879 (class 1259 OID 17618)
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- TOC entry 3638 (class 1259 OID 17620)
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- TOC entry 3639 (class 1259 OID 17621)
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- TOC entry 3891 (class 1259 OID 17819)
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- TOC entry 3892 (class 1259 OID 17820)
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- TOC entry 3645 (class 1259 OID 17914)
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3714 (class 1259 OID 17352)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3715 (class 1259 OID 17351)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- TOC entry 3851 (class 1259 OID 17713)
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3854 (class 1259 OID 17733)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3855 (class 1259 OID 17896)
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3856 (class 1259 OID 17715)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3859 (class 1259 OID 17716)
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3860 (class 1259 OID 17717)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3863 (class 1259 OID 17718)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3864 (class 1259 OID 17719)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3867 (class 1259 OID 17720)
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3868 (class 1259 OID 17721)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3871 (class 1259 OID 17722)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3872 (class 1259 OID 17723)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3792 (class 1259 OID 17939)
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- TOC entry 3793 (class 1259 OID 17624)
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- TOC entry 3789 (class 1259 OID 17625)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- TOC entry 3740 (class 1259 OID 17627)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3718 (class 1259 OID 17626)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- TOC entry 3719 (class 1259 OID 18005)
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- TOC entry 3720 (class 1259 OID 18004)
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- TOC entry 3650 (class 1259 OID 17628)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- TOC entry 3651 (class 1259 OID 17629)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- TOC entry 3778 (class 1259 OID 17968)
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- TOC entry 3779 (class 1259 OID 17967)
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- TOC entry 3780 (class 1259 OID 17932)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 3926 (class 1259 OID 17996)
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- TOC entry 3903 (class 1259 OID 17992)
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- TOC entry 3904 (class 1259 OID 17991)
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- TOC entry 3709 (class 1259 OID 17630)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- TOC entry 3659 (class 1259 OID 17633)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- TOC entry 3802 (class 1259 OID 17812)
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- TOC entry 3801 (class 1259 OID 17634)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3662 (class 1259 OID 17637)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3730 (class 1259 OID 17636)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3654 (class 1259 OID 17632)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- TOC entry 3727 (class 1259 OID 17638)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3669 (class 1259 OID 17639)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- TOC entry 3773 (class 1259 OID 17640)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- TOC entry 3838 (class 1259 OID 17641)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- TOC entry 3835 (class 1259 OID 17642)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- TOC entry 3828 (class 1259 OID 17661)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3818 (class 1259 OID 17662)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3823 (class 1259 OID 17663)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3929 (class 1259 OID 18002)
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- TOC entry 3913 (class 1259 OID 17886)
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- TOC entry 3811 (class 1259 OID 17815)
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3672 (class 1259 OID 17646)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- TOC entry 3841 (class 1259 OID 17647)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- TOC entry 3733 (class 1259 OID 17894)
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- TOC entry 3897 (class 1259 OID 17821)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3898 (class 1259 OID 17938)
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- TOC entry 3675 (class 1259 OID 17348)
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- TOC entry 3676 (class 1259 OID 17935)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- TOC entry 3745 (class 1259 OID 17345)
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- TOC entry 3642 (class 1259 OID 17349)
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- TOC entry 3681 (class 1259 OID 17342)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- TOC entry 3796 (class 1259 OID 17344)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- TOC entry 3694 (class 1259 OID 17350)
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- TOC entry 3697 (class 1259 OID 17343)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- TOC entry 3682 (class 1259 OID 17936)
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- TOC entry 3767 (class 1259 OID 17649)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3768 (class 1259 OID 17650)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3691 (class 1259 OID 17651)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3700 (class 1259 OID 17652)
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- TOC entry 3677 (class 1259 OID 17960)
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- TOC entry 3678 (class 1259 OID 17962)
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- TOC entry 3956 (class 2606 OID 16846)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3950 (class 2606 OID 16776)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3955 (class 2606 OID 16856)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3951 (class 2606 OID 17003)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3942 (class 2606 OID 16601)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3946 (class 2606 OID 16606)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3940 (class 2606 OID 16616)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3998 (class 2606 OID 17854)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3944 (class 2606 OID 16621)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3947 (class 2606 OID 16631)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3937 (class 2606 OID 16636)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- TOC entry 3941 (class 2606 OID 16641)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3938 (class 2606 OID 16656)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3934 (class 2606 OID 16661)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3965 (class 2606 OID 17097)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- TOC entry 3966 (class 2606 OID 17092)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3964 (class 2606 OID 17087)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3963 (class 2606 OID 17082)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3948 (class 2606 OID 16671)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3975 (class 2606 OID 17760)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3976 (class 2606 OID 17750)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3952 (class 2606 OID 17745)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3991 (class 2606 OID 17604)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3989 (class 2606 OID 17552)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- TOC entry 3990 (class 2606 OID 17547)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3974 (class 2606 OID 17252)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3969 (class 2606 OID 17112)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- TOC entry 3967 (class 2606 OID 17107)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3968 (class 2606 OID 17102)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3987 (class 2606 OID 17470)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3985 (class 2606 OID 17455)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3994 (class 2606 OID 17827)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3977 (class 2606 OID 17671)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3995 (class 2606 OID 17832)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3996 (class 2606 OID 17837)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3988 (class 2606 OID 17465)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3986 (class 2606 OID 17450)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3997 (class 2606 OID 17859)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3979 (class 2606 OID 17666)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3981 (class 2606 OID 17420)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3983 (class 2606 OID 17435)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3984 (class 2606 OID 17440)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3982 (class 2606 OID 17425)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3978 (class 2606 OID 17676)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3935 (class 2606 OID 16686)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3993 (class 2606 OID 17802)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- TOC entry 3962 (class 2606 OID 16966)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3972 (class 2606 OID 17226)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3971 (class 2606 OID 17240)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3959 (class 2606 OID 16912)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3939 (class 2606 OID 16696)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3960 (class 2606 OID 16956)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3961 (class 2606 OID 17126)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- TOC entry 3949 (class 2606 OID 16706)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3943 (class 2606 OID 16716)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3953 (class 2606 OID 16851)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3936 (class 2606 OID 16731)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3954 (class 2606 OID 17119)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- TOC entry 3992 (class 2606 OID 17787)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3970 (class 2606 OID 17161)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3999 (class 2606 OID 17867)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 4000 (class 2606 OID 17881)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3958 (class 2606 OID 16881)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3945 (class 2606 OID 16751)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3973 (class 2606 OID 17233)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3980 (class 2606 OID 17410)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3957 (class 2606 OID 16861)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


-- Completed on 2025-08-09 19:14:23 +07

--
-- PostgreSQL database dump complete
--

