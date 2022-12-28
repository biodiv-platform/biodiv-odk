-- CreateEnum
CREATE TYPE "dateformat" AS ENUM ('DAY', 'MONTH', 'YEAR');

-- CreateEnum
CREATE TYPE "status" AS ENUM ('PENDING', 'CURATED', 'REJECTED_OTHER_COMMUNICATION', 'REJECTED_NOT_ACCESSIBLE', 'REJECTED_OTHER_ORGANISM', 'REJECTED_INCOMPLETE');

-- CreateTable
CREATE TABLE "accepted_synonym" (
    "id" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,
    "accepted_id" BIGINT NOT NULL,
    "synonym_id" BIGINT NOT NULL,

    CONSTRAINT "accepted_synonym_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "activity_feed" (
    "id" BIGINT NOT NULL,
    "activity_descrption" VARCHAR(2000),
    "activity_holder_id" BIGINT,
    "activity_holder_type" VARCHAR(255),
    "activity_type" VARCHAR(255),
    "author_id" BIGINT NOT NULL,
    "date_created" TIMESTAMP(6) NOT NULL,
    "last_updated" TIMESTAMP(6) NOT NULL,
    "root_holder_id" BIGINT,
    "root_holder_type" VARCHAR(255),
    "sub_root_holder_id" BIGINT,
    "sub_root_holder_type" VARCHAR(255),
    "is_showable" BOOLEAN,
    "activity_root_type" VARCHAR(255),
    "version" BIGINT,

    CONSTRAINT "activity_feed_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bibtex_field_type" (
    "id" BIGINT NOT NULL,
    "field_type" VARCHAR(255),

    CONSTRAINT "bibtex_field_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bibtex_item_field_mapping" (
    "id" BIGSERIAL NOT NULL,
    "field_id" BIGINT,
    "is_required" BOOLEAN,
    "item_type_id" BIGINT,

    CONSTRAINT "bibtex_item_field_mapping_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bibtex_item_type" (
    "id" BIGINT NOT NULL,
    "item_type" VARCHAR(255),

    CONSTRAINT "bibtex_item_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cca_permission_request" (
    "id" BIGINT NOT NULL,
    "cca_id" BIGINT,
    "encryptkey" VARCHAR(255),
    "owner_id" BIGINT,
    "requested_on" TIMESTAMP(6),
    "requestor_id" BIGINT,
    "requestormessage" VARCHAR(255),
    "role" VARCHAR(255),
    "short_name" VARCHAR(255),

    CONSTRAINT "cca_permission_request_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "character_entity" (
    "name" TEXT NOT NULL,
    "ch" CHAR(1),

    CONSTRAINT "character_entity_pkey" PRIMARY KEY ("name")
);

-- CreateTable
CREATE TABLE "classification" (
    "id" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "citation" VARCHAR(255),
    "language_id" BIGINT NOT NULL,

    CONSTRAINT "classification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "comment" (
    "id" BIGINT NOT NULL,
    "author_id" BIGINT NOT NULL,
    "body" TEXT NOT NULL,
    "comment_holder_id" BIGINT NOT NULL,
    "comment_holder_type" VARCHAR(255) NOT NULL,
    "date_created" TIMESTAMP(6) NOT NULL,
    "last_updated" TIMESTAMP(6) NOT NULL,
    "root_holder_id" BIGINT NOT NULL,
    "root_holder_type" VARCHAR(255) NOT NULL,
    "main_parent_id" BIGINT,
    "parent_id" BIGINT,
    "language_id" BIGINT NOT NULL,

    CONSTRAINT "comment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "common_names" (
    "id" BIGINT NOT NULL,
    "language_id" BIGINT,
    "name" VARCHAR(255) NOT NULL,
    "taxon_concept_id" BIGINT NOT NULL,
    "upload_time" TIMESTAMP(6),
    "uploader_id" BIGINT,
    "transliteration" VARCHAR(255),
    "status" VARCHAR(255),
    "position" VARCHAR(255),
    "author_year" VARCHAR(255),
    "match_database_name" VARCHAR(255),
    "match_id" VARCHAR(255),
    "ibp_source" VARCHAR(255),
    "via_datasource" VARCHAR(255),
    "lowercase_name" VARCHAR(255),
    "name_source_id" VARCHAR(255),
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "is_preffered" BOOLEAN,

    CONSTRAINT "common_names_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contributor" (
    "id" BIGINT NOT NULL,
    "name" TEXT NOT NULL,
    "user_id" BIGINT,

    CONSTRAINT "contributor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "country" (
    "id" BIGINT NOT NULL,
    "country_name" VARCHAR(255) NOT NULL,
    "two_letter_code" VARCHAR(255) NOT NULL,

    CONSTRAINT "country_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "coverage" (
    "id" BIGINT NOT NULL,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "place_name" VARCHAR(255),

    CONSTRAINT "coverage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "custom_field" (
    "id" BIGINT NOT NULL,
    "allowed_multiple" BOOLEAN,
    "allowed_participation" BOOLEAN,
    "author_id" BIGINT,
    "data_type" VARCHAR(255),
    "default_value" VARCHAR(255),
    "display_order" INTEGER,
    "is_mandatory" BOOLEAN,
    "name" VARCHAR(255),
    "notes" VARCHAR(255),
    "options" VARCHAR(255),
    "user_group_id" BIGINT,
    "version" BIGINT,

    CONSTRAINT "custom_field_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "custom_field_values" (
    "id" BIGINT NOT NULL,
    "author_id" BIGINT,
    "custom_field_id" BIGINT,
    "icon_url" VARCHAR(255),
    "notes" VARCHAR(255),
    "value" VARCHAR(255),

    CONSTRAINT "custom_field_values_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "custom_fields" (
    "id" BIGINT NOT NULL,
    "author_id" BIGINT,
    "data_type" VARCHAR(255),
    "field_type" VARCHAR(255),
    "icon_url" VARCHAR(255),
    "name" VARCHAR(255),
    "notes" VARCHAR(255),
    "units" VARCHAR(255),

    CONSTRAINT "custom_fields_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "data_package" (
    "id" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,
    "allowed_data_table_types" TEXT NOT NULL,
    "author_id" BIGINT NOT NULL,
    "created_on" TIMESTAMP(6) NOT NULL,
    "description" TEXT NOT NULL,
    "is_deleted" BOOLEAN NOT NULL,
    "last_revised" TIMESTAMP(6) NOT NULL,
    "supporting_modules" TEXT,
    "title" VARCHAR(255) NOT NULL,
    "has_role_user_allowed" BOOLEAN,
    "uploader_ids" VARCHAR(255),

    CONSTRAINT "data_package_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "data_table" (
    "id" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,
    "access_license_id" BIGINT NOT NULL,
    "access_rights" TEXT,
    "agree_terms" BOOLEAN NOT NULL,
    "checklist_id" BIGINT,
    "columns" TEXT NOT NULL,
    "created_on" TIMESTAMP(6) NOT NULL,
    "custom_fields" TEXT,
    "data_table_type" VARCHAR(255) NOT NULL,
    "dataset_id" BIGINT,
    "description" TEXT,
    "external_id" VARCHAR(255),
    "external_url" VARCHAR(255),
    "feature_count" INTEGER NOT NULL,
    "flag_count" INTEGER NOT NULL,
    "geographical_coverage_geo_privacy" BOOLEAN NOT NULL,
    "geographical_coverage_latitude" DOUBLE PRECISION NOT NULL,
    "geographical_coverage_location_accuracy" VARCHAR(255),
    "geographical_coverage_location_scale" VARCHAR(255) NOT NULL,
    "geographical_coverage_longitude" DOUBLE PRECISION NOT NULL,
    "geographical_coverage_place_name" TEXT,
    "geographical_coverage_topology" geometry,
    "is_deleted" BOOLEAN NOT NULL,
    "language_id" BIGINT NOT NULL,
    "last_revised" TIMESTAMP(6) NOT NULL,
    "methods" TEXT,
    "party_attributions" TEXT,
    "party_contributor_id" BIGINT NOT NULL,
    "party_uploader_id" BIGINT NOT NULL,
    "project" TEXT,
    "rating" INTEGER NOT NULL,
    "taxonomic_coverage_group_ids" VARCHAR(255) NOT NULL,
    "temporal_coverage_from_date" TIMESTAMP(6),
    "temporal_coverage_to_date" TIMESTAMP(6),
    "title" TEXT NOT NULL,
    "u_file_id" BIGINT NOT NULL,
    "uploader_id" BIGINT NOT NULL,
    "via_code" VARCHAR(255),
    "via_id" VARCHAR(255),
    "temporal_coverage_date_accuracy" VARCHAR(100),
    "upload_log_id" BIGINT,
    "trait_value_file_id" BIGINT,
    "summary" VARCHAR(10000) NOT NULL,
    "images_file_id" BIGINT,
    "basis_of_data" VARCHAR(255),
    "basis_of_record" VARCHAR(255),
    "field_mapping" VARCHAR(255),
    "is_verified" BOOLEAN,

    CONSTRAINT "data_table_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dataset" (
    "id" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,
    "additional_info" TEXT,
    "author_id" BIGINT NOT NULL,
    "created_on" TIMESTAMP(6) NOT NULL,
    "data_language_id" BIGINT NOT NULL,
    "datasource_id" BIGINT NOT NULL,
    "description" TEXT NOT NULL,
    "external_id" VARCHAR(255),
    "external_url" VARCHAR(255),
    "geographic_description" VARCHAR(255),
    "is_deleted" BOOLEAN NOT NULL,
    "language_id" BIGINT NOT NULL,
    "last_revised" TIMESTAMP(6) NOT NULL,
    "license_id" BIGINT NOT NULL,
    "original_author_id" BIGINT,
    "publication_date" TIMESTAMP(6) NOT NULL,
    "purpose" TEXT,
    "rights" TEXT,
    "title" VARCHAR(255) NOT NULL,
    "type" VARCHAR(255) NOT NULL,
    "u_file_id" BIGINT,
    "via_code" VARCHAR(255),
    "via_id" VARCHAR(255),
    "attribution" TEXT NOT NULL,

    CONSTRAINT "dataset_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dataset1" (
    "id" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,
    "access_license_id" BIGINT NOT NULL,
    "access_rights" TEXT,
    "created_on" TIMESTAMP(6) NOT NULL,
    "custom_fields" TEXT,
    "data_package_id" BIGINT NOT NULL,
    "description" TEXT,
    "external_id" VARCHAR(255),
    "external_url" VARCHAR(255),
    "feature_count" INTEGER NOT NULL,
    "flag_count" INTEGER NOT NULL,
    "geographical_coverage_geo_privacy" BOOLEAN NOT NULL,
    "geographical_coverage_latitude" DOUBLE PRECISION NOT NULL,
    "geographical_coverage_location_accuracy" VARCHAR(255),
    "geographical_coverage_location_scale" VARCHAR(255) NOT NULL,
    "geographical_coverage_longitude" DOUBLE PRECISION NOT NULL,
    "geographical_coverage_place_name" TEXT,
    "geographical_coverage_topology" geometry,
    "is_deleted" BOOLEAN NOT NULL,
    "language_id" BIGINT NOT NULL,
    "last_revised" TIMESTAMP(6) NOT NULL,
    "methods" TEXT,
    "party_attributions" TEXT,
    "party_contributor_id" BIGINT NOT NULL,
    "party_uploader_id" BIGINT NOT NULL,
    "project" TEXT,
    "rating" INTEGER NOT NULL,
    "taxonomic_coverage_group_ids" VARCHAR(255) NOT NULL,
    "temporal_coverage_from_date" TIMESTAMP(6) NOT NULL,
    "temporal_coverage_to_date" TIMESTAMP(6),
    "title" TEXT NOT NULL,
    "u_file_id" BIGINT,
    "uploader_id" BIGINT NOT NULL,
    "via_code" VARCHAR(255),
    "via_id" VARCHAR(255),
    "temporal_coverage_date_accuracy" VARCHAR(100),
    "summary" VARCHAR(5000) NOT NULL,

    CONSTRAINT "dataset1_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "discussion" (
    "id" BIGINT NOT NULL,
    "agree_terms" BOOLEAN NOT NULL,
    "author_id" BIGINT NOT NULL,
    "body" TEXT NOT NULL,
    "created_on" TIMESTAMP(6) NOT NULL,
    "feature_count" INTEGER NOT NULL,
    "flag_count" INTEGER NOT NULL,
    "is_deleted" BOOLEAN NOT NULL,
    "language_id" BIGINT NOT NULL,
    "last_revised" TIMESTAMP(6) NOT NULL,
    "plain_text" TEXT NOT NULL,
    "subject" TEXT NOT NULL,
    "visit_count" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,

    CONSTRAINT "discussion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "doc_sci_name" (
    "id" BIGINT NOT NULL,
    "canonical_form" VARCHAR(255),
    "display_order" INTEGER NOT NULL,
    "document_id" BIGINT NOT NULL,
    "frequency" INTEGER NOT NULL,
    "offset_values" TEXT NOT NULL,
    "scientific_name" VARCHAR(255) NOT NULL,
    "taxon_concept_id" BIGINT,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "doc_sci_name_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "document" (
    "id" BIGINT NOT NULL,
    "agree_terms" BOOLEAN NOT NULL,
    "attribution" TEXT,
    "author_id" BIGINT,
    "contributors" TEXT,
    "created_on" TIMESTAMP(6) NOT NULL,
    "notes" TEXT,
    "doi" VARCHAR(255),
    "last_revised" TIMESTAMP(6) NOT NULL,
    "license_id" BIGINT NOT NULL,
    "title" TEXT NOT NULL,
    "type" TEXT,
    "u_file_id" BIGINT,
    "from_date" TIMESTAMP(6),
    "to_date" TIMESTAMP(6),
    "feature_count" INTEGER,
    "flag_count" INTEGER,
    "language_id" BIGINT NOT NULL,
    "external_url" VARCHAR(255),
    "visit_count" INTEGER NOT NULL DEFAULT 0,
    "rating" INTEGER NOT NULL DEFAULT 0,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "data_table_id" BIGINT,
    "address" TEXT,
    "author" TEXT,
    "book_title" TEXT,
    "chapter" TEXT,
    "edition" TEXT,
    "editor" TEXT,
    "extra" TEXT,
    "file" TEXT,
    "how_published" VARCHAR(255),
    "institution" VARCHAR(255),
    "isbn" VARCHAR(255),
    "item_type" VARCHAR(255),
    "journal" TEXT,
    "language" VARCHAR(255),
    "month" VARCHAR(255),
    "note" TEXT,
    "number" VARCHAR(255),
    "organization" TEXT,
    "pages" VARCHAR(255),
    "publisher" TEXT,
    "school" VARCHAR(255),
    "series" TEXT,
    "url" TEXT,
    "volume" VARCHAR(255),
    "year" VARCHAR(255),
    "coverage_id" BIGINT,
    "latitude" DOUBLE PRECISION,
    "location_accuracy" VARCHAR(255),
    "longitude" DOUBLE PRECISION,
    "place_name" VARCHAR(255),
    "reverse_geocoded_name" VARCHAR(255),
    "topology" geometry,

    CONSTRAINT "document_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "document_coverage" (
    "id" BIGINT NOT NULL,
    "document_id" BIGINT,
    "geoentity_id" BIGINT,
    "placename" VARCHAR(255),
    "topology" geometry NOT NULL,

    CONSTRAINT "document_coverage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "document_habitat" (
    "document_habitats_id" BIGINT,
    "habitat_id" BIGINT
);

-- CreateTable
CREATE TABLE "document_species_group" (
    "document_species_groups_id" BIGINT,
    "species_group_id" BIGINT
);

-- CreateTable
CREATE TABLE "download_log" (
    "id" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,
    "author_id" BIGINT NOT NULL,
    "created_on" TIMESTAMP(6) NOT NULL,
    "file_path" VARCHAR(255),
    "filter_url" VARCHAR NOT NULL,
    "notes" TEXT,
    "params_map_as_text" TEXT,
    "status" VARCHAR(255) NOT NULL,
    "type" VARCHAR(255) NOT NULL,
    "source_type" VARCHAR(255),
    "offset_param" BIGINT NOT NULL,

    CONSTRAINT "download_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "external_links" (
    "id" BIGINT NOT NULL,
    "col_id" VARCHAR(255),
    "eol_fetch_date" TIMESTAMP(6),
    "eol_id" VARCHAR(255),
    "gbif_id" VARCHAR(255),
    "itis_id" VARCHAR(255),
    "iucn_id" VARCHAR(255),
    "ncbi_id" VARCHAR(255),
    "no_of_data_objects" INTEGER,
    "frlht_url" VARCHAR,
    "fishbase_url" VARCHAR(255),

    CONSTRAINT "external_links_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fact" (
    "id" BIGINT NOT NULL,
    "attribution" TEXT NOT NULL,
    "contributor_id" BIGINT NOT NULL,
    "is_deleted" BOOLEAN NOT NULL,
    "license_id" BIGINT NOT NULL,
    "object_id" BIGINT NOT NULL,
    "page_taxon_id" BIGINT,
    "trait_instance_id" BIGINT NOT NULL,
    "trait_value_id" BIGINT,
    "value" VARCHAR(255),
    "object_type" VARCHAR(255) NOT NULL,
    "to_value" VARCHAR(255),
    "from_date" TIMESTAMP(6),
    "to_date" TIMESTAMP(6),

    CONSTRAINT "fact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "featured" (
    "id" BIGINT NOT NULL,
    "author_id" BIGINT NOT NULL,
    "created_on" TIMESTAMP(6) NOT NULL,
    "notes" VARCHAR(400) NOT NULL,
    "object_id" BIGINT NOT NULL,
    "object_type" VARCHAR(255) NOT NULL,
    "user_group_id" BIGINT,
    "language_id" BIGINT NOT NULL,

    CONSTRAINT "featured_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "field" (
    "id" BIGINT NOT NULL,
    "category" VARCHAR(255),
    "concept" VARCHAR(255),
    "connection" BIGINT,
    "description" TEXT,
    "display_order" INTEGER,
    "language_id" BIGINT,
    "sub_category" VARCHAR(255),
    "url_identifier" VARCHAR(255),

    CONSTRAINT "field_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "field_content" (
    "id" BIGINT NOT NULL,
    "content" TEXT,
    "field_id" BIGINT,
    "is_deleted" BOOLEAN,
    "language_id" BIGINT,

    CONSTRAINT "field_content_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "field_header" (
    "id" BIGINT NOT NULL,
    "description" TEXT,
    "field_id" BIGINT,
    "header" VARCHAR(255),
    "language_id" BIGINT,
    "url_identifier" VARCHAR(255),

    CONSTRAINT "field_header_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "field_new" (
    "id" BIGINT NOT NULL,
    "display_order" BIGINT,
    "header" VARCHAR(255),
    "label" VARCHAR(255),
    "parent_id" BIGINT,
    "path" ltree,

    CONSTRAINT "field_new_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "field_template" (
    "id" BIGINT NOT NULL,
    "created_on" TIMESTAMP(6),
    "field_index" BIGINT NOT NULL,
    "is_deleted" BOOLEAN,
    "modified_on" TIMESTAMP(6),
    "parent_id" BIGINT NOT NULL,

    CONSTRAINT "field_template_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "file_download_credentials" (
    "id" SERIAL NOT NULL,
    "access_key" VARCHAR(255) NOT NULL,
    "is_deleted" BOOLEAN NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "file_download_credentials_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "file_downloads" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(6) NOT NULL,
    "file_name" VARCHAR(255) NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "file_downloads_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "firebase_tokens" (
    "id" BIGINT NOT NULL,
    "token" VARCHAR(255),
    "user_id" BIGINT,

    CONSTRAINT "firebase_tokens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "flag" (
    "id" BIGINT NOT NULL,
    "author_id" BIGINT NOT NULL,
    "created_on" TIMESTAMP(6) NOT NULL,
    "flag" VARCHAR(255) NOT NULL,
    "notes" TEXT,
    "object_id" BIGINT NOT NULL,
    "object_type" VARCHAR(255) NOT NULL,

    CONSTRAINT "observation_flag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "follow" (
    "id" BIGINT NOT NULL,
    "object_id" BIGINT NOT NULL,
    "object_type" VARCHAR(255) NOT NULL,
    "author_id" BIGINT NOT NULL,
    "created_on" TIMESTAMP(6),

    CONSTRAINT "follow_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gallery_slider" (
    "id" BIGINT NOT NULL,
    "author_id" BIGINT,
    "custom_desc" TEXT,
    "file_name" VARCHAR(255),
    "more_links" VARCHAR(255),
    "observation_id" BIGINT,
    "title" VARCHAR(255),
    "ug_id" BIGINT,
    "display_order" BIGINT,
    "is_truncated" BOOLEAN DEFAULT true,

    CONSTRAINT "gallery_slider_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "geoentities" (
    "id" BIGINT NOT NULL,
    "placename" VARCHAR(255),
    "topology" geometry NOT NULL,

    CONSTRAINT "geoentities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "group_gallery_slider" (
    "id" BIGINT NOT NULL,
    "author_id" BIGINT,
    "custom_desc" TEXT,
    "display_order" BIGINT NOT NULL,
    "file_name" VARCHAR(255),
    "more_links" VARCHAR(255),
    "observation_id" BIGINT,
    "title" VARCHAR(255),
    "ug_id" BIGINT,

    CONSTRAINT "group_gallery_slider_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "habitat" (
    "id" BIGINT NOT NULL,
    "habitat_order" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "habitat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "landscape" (
    "id" BIGINT NOT NULL,
    "geo_entity_id" BIGINT,
    "is_deleted" BOOLEAN,
    "short_name" VARCHAR(255),
    "site_number" BIGINT,
    "thumbnail_path" VARCHAR(255),

    CONSTRAINT "landscape_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "language" (
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "three_letter_code" VARCHAR(255) NOT NULL,
    "two_letter_code" VARCHAR(255),
    "is_dirty" BOOLEAN,
    "region" VARCHAR(255),

    CONSTRAINT "language_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "license" (
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "url" VARCHAR(255),

    CONSTRAINT "license_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "newsletter" (
    "id" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,
    "date" TIMESTAMP(6) NOT NULL,
    "newsitem" TEXT NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "sticky" BOOLEAN,
    "user_group_id" BIGINT,
    "display_order" INTEGER,
    "language_id" BIGINT NOT NULL,
    "parent_id" BIGINT NOT NULL,
    "show_in_footer" BOOLEAN NOT NULL,

    CONSTRAINT "newsletter_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "observation" (
    "id" BIGINT NOT NULL,
    "author_id" BIGINT NOT NULL,
    "created_on" TIMESTAMP(6) NOT NULL,
    "group_id" BIGINT NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "notes" TEXT,
    "from_date" TIMESTAMP(6),
    "place_name" TEXT,
    "rating" INTEGER NOT NULL,
    "reverse_geocoded_name" TEXT,
    "flag_count" INTEGER,
    "geo_privacy" BOOLEAN,
    "is_deleted" BOOLEAN,
    "last_revised" TIMESTAMP(6),
    "location_accuracy" VARCHAR(255),
    "visit_count" BIGINT,
    "max_voted_reco_id" BIGINT,
    "agree_terms" BOOLEAN,
    "is_checklist" BOOLEAN NOT NULL,
    "is_showable" BOOLEAN NOT NULL,
    "source_id" BIGINT,
    "to_date" TIMESTAMP(6),
    "topology" geometry NOT NULL,
    "checklist_annotations" TEXT,
    "feature_count" INTEGER,
    "is_locked" BOOLEAN,
    "license_id" BIGINT NOT NULL,
    "language_id" BIGINT NOT NULL,
    "location_scale" VARCHAR(255) NOT NULL,
    "dataset_id" BIGINT,
    "repr_image_id" BIGINT,
    "protocol" VARCHAR(255) NOT NULL,
    "basis_of_record" VARCHAR(255) NOT NULL,
    "no_of_images" INTEGER NOT NULL DEFAULT 0,
    "no_of_videos" INTEGER NOT NULL DEFAULT 0,
    "no_of_audio" INTEGER NOT NULL DEFAULT 0,
    "no_of_identifications" INTEGER NOT NULL DEFAULT 0,
    "data_table_id" BIGINT,
    "date_accuracy" VARCHAR(100),
    "is_verified" BOOLEAN DEFAULT false,

    CONSTRAINT "observation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "observation_custom_field" (
    "id" BIGINT NOT NULL,
    "author_id" BIGINT,
    "created_on" TIMESTAMP(6),
    "custom_field_id" BIGINT,
    "custom_field_value_id" BIGINT,
    "last_modified" TIMESTAMP(6),
    "observation_id" BIGINT,
    "user_group_id" BIGINT,
    "value_date" TIMESTAMP(6),
    "value_numeric" DOUBLE PRECISION,
    "value_string" TEXT,

    CONSTRAINT "observation_custom_field_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "observation_resource" (
    "resource_id" BIGINT NOT NULL,
    "observation_id" BIGINT NOT NULL,

    CONSTRAINT "observation_resource_pkey" PRIMARY KEY ("observation_id","resource_id")
);

-- CreateTable
CREATE TABLE "observationesdocument" (
    "observation_id" BIGINT NOT NULL,
    "all_reco_vote" JSON,
    "author_id" BIGINT,
    "created_by" VARCHAR(255),
    "created_on" TIMESTAMP(6),
    "custom_fields" JSON,
    "data_table_id" BIGINT,
    "dataset_id" BIGINT,
    "dataset_title" VARCHAR(255),
    "date_accuracy" VARCHAR(255),
    "facts" JSON,
    "featured" JSON,
    "flag_count" BIGINT,
    "flags" JSON,
    "from_date" TIMESTAMP(6),
    "geo_privacy" BOOLEAN,
    "group_id" BIGINT,
    "group_name" VARCHAR(255),
    "is_checklist" BOOLEAN,
    "is_locked" BOOLEAN,
    "language_id" INTEGER,
    "last_revised" TIMESTAMP(6),
    "location" JSON,
    "location_information" JSON,
    "location_scale" VARCHAR(255),
    "max_voted_reco" JSON,
    "no_media" INTEGER,
    "no_of_audio" INTEGER,
    "no_of_identifications" INTEGER,
    "no_of_images" INTEGER,
    "no_of_videos" INTEGER,
    "notes" VARCHAR(255),
    "observation_resource" JSON,
    "observed_in_month" VARCHAR(255),
    "place_name" VARCHAR(255),
    "profile_pic" VARCHAR(255),
    "protocol" VARCHAR(255),
    "repr_image_id" BIGINT,
    "repr_image_url" VARCHAR(255),
    "reverse_geocoded_name" VARCHAR(255),
    "sgroup_filter" VARCHAR(255),
    "tags" JSON,
    "to_date" TIMESTAMP(6),
    "user_group_observations" JSON,
    "visit_count" BIGINT,
    "is_publication_grade" BOOLEAN,
    "reco_vote_count" INTEGER,
    "data_table_title" VARCHAR(255),
    "basis_of_data" VARCHAR(255),
    "basis_of_record" VARCHAR(255),
    "checklist_annotation" VARCHAR(255),
    "checklist_annotations" VARCHAR(255),

    CONSTRAINT "observationesdocument_pkey" PRIMARY KEY ("observation_id")
);

-- CreateTable
CREATE TABLE "page" (
    "id" BIGINT NOT NULL,
    "auther_id" BIGINT,
    "auther_name" VARCHAR(255),
    "content" TEXT NOT NULL,
    "date" TIMESTAMP(6) NOT NULL,
    "description" TEXT,
    "is_deleted" BOOLEAN DEFAULT false,
    "language_id" BIGINT NOT NULL,
    "pageindex" INTEGER NOT NULL,
    "pagetype" INTEGER NOT NULL,
    "parent_id" BIGINT NOT NULL,
    "show_in_footer" BOOLEAN NOT NULL,
    "sticky" BOOLEAN NOT NULL,
    "title" TEXT NOT NULL,
    "url" VARCHAR(255),
    "user_group_id" BIGINT,
    "social_preview" TEXT,

    CONSTRAINT "page_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "page_field" (
    "id" BIGINT NOT NULL,
    "author_id" BIGINT,
    "created_on" TIMESTAMP(6),
    "is_deleted" BOOLEAN,
    "modified_on" TIMESTAMP(6),
    "protected_area_id" BIGINT,
    "template_id" BIGINT,

    CONSTRAINT "page_field_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "page_gallery_slider" (
    "id" BIGINT NOT NULL,
    "author_id" BIGINT,
    "display_order" BIGINT NOT NULL,
    "file_name" VARCHAR(255) NOT NULL,
    "page_id" BIGINT,
    "attribution" VARCHAR(255),
    "caption" VARCHAR(255),
    "license_id" BIGINT,

    CONSTRAINT "page_gallery_slider_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rating" (
    "id" BIGINT NOT NULL,
    "stars" BIGINT,

    CONSTRAINT "rating_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rating_link" (
    "id" BIGINT NOT NULL,
    "rating_id" BIGINT,
    "rating_ref" BIGINT,
    "type" VARCHAR(255),

    CONSTRAINT "rating_link_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "recommendation" (
    "id" BIGINT NOT NULL,
    "last_modified" TIMESTAMP(6) NOT NULL,
    "name" TEXT NOT NULL,
    "taxon_concept_id" BIGINT,
    "is_scientific_name" BOOLEAN,
    "language_id" BIGINT,
    "lowercase_name" VARCHAR(255),
    "flagging_reason" VARCHAR(1500),
    "is_flagged" BOOLEAN,
    "accepted_name_id" BIGINT,
    "canonical_name" VARCHAR(255),

    CONSTRAINT "recommendation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "recommendation_vote" (
    "id" BIGINT NOT NULL,
    "author_id" BIGINT NOT NULL,
    "observation_id" BIGINT NOT NULL,
    "recommendation_id" BIGINT NOT NULL,
    "voted_on" TIMESTAMP(6) NOT NULL,
    "common_name_reco_id" BIGINT,
    "given_common_name" TEXT,
    "given_sci_name" TEXT,
    "flag" BOOLEAN,
    "source" TEXT,

    CONSTRAINT "recommendation_vote_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "reference" (
    "id" BIGINT NOT NULL,
    "species_field_id" BIGINT NOT NULL,
    "title" TEXT,
    "url" TEXT,

    CONSTRAINT "reference_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "resource" (
    "id" BIGINT NOT NULL,
    "description" TEXT,
    "file_name" VARCHAR(255) NOT NULL,
    "mime_type" VARCHAR(255),
    "type" VARCHAR(255) NOT NULL,
    "url" VARCHAR(255),
    "rating" INTEGER,
    "upload_time" TIMESTAMP(6),
    "uploader_id" BIGINT,
    "context" VARCHAR(255),
    "language_id" BIGINT NOT NULL,
    "license_id" BIGINT NOT NULL,
    "contributor" TEXT,
    "access_rights" VARCHAR(255),
    "annotations" VARCHAR(255),
    "gbifid" BIGINT,
    "version" BIGINT,

    CONSTRAINT "resource_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "resource_contributor" (
    "resource_attributors_id" BIGINT NOT NULL,
    "contributor_id" BIGINT,
    "resource_contributors_id" BIGINT,

    CONSTRAINT "resource_contributor_pkey" PRIMARY KEY ("resource_attributors_id")
);

-- CreateTable
CREATE TABLE "resource_crop_info" (
    "id" BIGINT NOT NULL,
    "x" BIGINT,
    "y" BIGINT,
    "width" BIGINT,
    "height" BIGINT,
    "selection_status" VARCHAR,

    CONSTRAINT "extended_resource_data_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role" (
    "id" BIGINT NOT NULL,
    "authority" VARCHAR(255) NOT NULL,

    CONSTRAINT "role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "species" (
    "id" BIGINT NOT NULL,
    "taxon_concept_id" BIGINT NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "created_on" TIMESTAMP(6),
    "updated_on" TIMESTAMP(6),
    "date_created" TIMESTAMP(6),
    "last_updated" TIMESTAMP(6),
    "feature_count" INTEGER,
    "habitat_id" BIGINT,
    "has_media" BOOLEAN,
    "repr_image_id" BIGINT,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "data_table_id" BIGINT,

    CONSTRAINT "species_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "species_bulk_upload" (
    "id" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,
    "author_id" BIGINT NOT NULL,
    "end_date" TIMESTAMP(6),
    "file_path" VARCHAR(255),
    "notes" TEXT,
    "start_date" TIMESTAMP(6) NOT NULL,
    "status" VARCHAR(255) NOT NULL,
    "error_file_path" VARCHAR(255),
    "images_dir" VARCHAR(255),
    "species_created" INTEGER,
    "species_updated" INTEGER,
    "stubs_created" INTEGER,
    "upload_type" VARCHAR(255),
    "log_file_path" VARCHAR(255),

    CONSTRAINT "species_bulk_upload_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "species_data_table" (
    "species_data_tables_id" BIGINT,
    "data_table_id" BIGINT
);

-- CreateTable
CREATE TABLE "species_field" (
    "id" BIGINT NOT NULL,
    "description" TEXT NOT NULL,
    "field_id" BIGINT NOT NULL,
    "species_id" BIGINT NOT NULL,
    "status" VARCHAR(255) NOT NULL,
    "class" VARCHAR(255) NOT NULL,
    "date_created" TIMESTAMP(6),
    "last_updated" TIMESTAMP(6),
    "upload_time" TIMESTAMP(6),
    "uploader_id" BIGINT,
    "language_id" BIGINT NOT NULL,
    "data_table_id" BIGINT,
    "is_deleted" BOOLEAN DEFAULT false,

    CONSTRAINT "species_field_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "species_field_audience_types" (
    "species_field_id" BIGINT,
    "species_field$audience_type" VARCHAR(255)
);

-- CreateTable
CREATE TABLE "species_field_contributor" (
    "species_field_attributors_id" BIGINT,
    "contributor_id" BIGINT,
    "attributors_idx" INTEGER
);

-- CreateTable
CREATE TABLE "species_field_license" (
    "species_field_licenses_id" BIGINT,
    "license_id" BIGINT
);

-- CreateTable
CREATE TABLE "species_field_resources" (
    "species_field_id" BIGINT NOT NULL,
    "resource_id" BIGINT NOT NULL,

    CONSTRAINT "species_field_resources_pkey" PRIMARY KEY ("species_field_id","resource_id")
);

-- CreateTable
CREATE TABLE "species_field_suser" (
    "species_field_contributors_id" BIGINT,
    "suser_id" BIGINT,
    "contributors_idx" INTEGER
);

-- CreateTable
CREATE TABLE "species_group" (
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "parent_group_id" BIGINT,
    "group_order" INTEGER,

    CONSTRAINT "species_group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "species_group_mapping" (
    "id" BIGINT NOT NULL,
    "rank" INTEGER NOT NULL,
    "species_group_id" BIGINT NOT NULL,
    "taxon_concept_id" BIGINT,
    "taxon_name" VARCHAR(255) NOT NULL,

    CONSTRAINT "species_group_mapping_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "species_permission" (
    "id" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,
    "author_id" BIGINT NOT NULL,
    "created_on" TIMESTAMP(6) NOT NULL,
    "taxon_concept_id" BIGINT NOT NULL,
    "permission_type" BIGINT NOT NULL,

    CONSTRAINT "species_permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "species_permission_request" (
    "id" BIGINT NOT NULL,
    "role" VARCHAR(255),
    "taxon_id" BIGINT,
    "user_id" BIGINT,

    CONSTRAINT "species_permission_request_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "species_resource" (
    "species_resources_id" BIGINT NOT NULL,
    "resource_id" BIGINT NOT NULL,

    CONSTRAINT "species_resource_pkey" PRIMARY KEY ("species_resources_id","resource_id")
);

-- CreateTable
CREATE TABLE "suser" (
    "id" BIGINT NOT NULL,
    "account_expired" BOOLEAN NOT NULL,
    "account_locked" BOOLEAN NOT NULL,
    "enabled" BOOLEAN NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "password_expired" BOOLEAN NOT NULL,
    "username" VARCHAR(255) NOT NULL,
    "about_me" TEXT,
    "date_created" TIMESTAMP(6),
    "email" VARCHAR(255),
    "hide_email_id" BOOLEAN,
    "last_login_date" TIMESTAMP(6),
    "location" VARCHAR(255),
    "name" VARCHAR(255),
    "profile_pic" VARCHAR(255),
    "send_notification" BOOLEAN,
    "timezone" REAL,
    "website" VARCHAR(255),
    "allow_identifaction_mail" BOOLEAN,
    "icon" VARCHAR(255),
    "language_id" BIGINT NOT NULL,
    "institution_type" VARCHAR(255),
    "occupation_type" VARCHAR(255),
    "sex_type" VARCHAR(255),
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "email_validation" BOOLEAN,
    "mobile_number" VARCHAR(255),
    "mobile_validation" BOOLEAN,
    "send_push_notification" BOOLEAN DEFAULT false,
    "is_deleted" BOOLEAN DEFAULT false,

    CONSTRAINT "suser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "suser_habitat" (
    "suser_habitats_id" BIGINT,
    "habitat_id" BIGINT
);

-- CreateTable
CREATE TABLE "suser_odk_mapping" (
    "id" SERIAL NOT NULL,
    "s_user_id" BIGINT NOT NULL,
    "app_user_id" BIGINT,
    "project_id" BIGINT,
    "web_user_id" BIGINT,

    CONSTRAINT "suser_odk_mapping_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "suser_role" (
    "role_id" BIGINT NOT NULL,
    "s_user_id" BIGINT NOT NULL,

    CONSTRAINT "suser_role_pkey" PRIMARY KEY ("role_id","s_user_id")
);

-- CreateTable
CREATE TABLE "suser_species_group" (
    "suser_species_groups_id" BIGINT,
    "species_group_id" BIGINT
);

-- CreateTable
CREATE TABLE "suser_verification" (
    "id" BIGINT NOT NULL,
    "action" VARCHAR(255),
    "creation_date" TIMESTAMP(6),
    "no_of_attempts" INTEGER DEFAULT 0,
    "otp" VARCHAR(255),
    "timeout" BIGINT,
    "user_id" BIGINT,
    "verification_id" VARCHAR(255),
    "verification_type" VARCHAR(255),

    CONSTRAINT "suser_verification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "synonyms" (
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "relationship" VARCHAR(255),
    "taxon_concept_id" BIGINT NOT NULL,
    "binomial_form" VARCHAR(255),
    "canonical_form" VARCHAR(255),
    "italicised_form" VARCHAR(255),
    "normalized_form" VARCHAR(255),
    "upload_time" TIMESTAMP(6),
    "uploader_id" BIGINT,
    "status" VARCHAR(255),
    "position" VARCHAR(255),
    "author_year" VARCHAR(255),
    "match_database_name" VARCHAR(255),
    "match_id" VARCHAR(255),
    "ibp_source" VARCHAR(255),
    "via_datasource" VARCHAR(255),
    "drop_reason" VARCHAR(255),
    "activity_description" VARCHAR(255),
    "name_source_id" VARCHAR(255),

    CONSTRAINT "synonyms_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "synonyms_suser" (
    "synonyms_contributors_id" BIGINT,
    "suser_id" BIGINT,
    "contributors_idx" INTEGER,
    "synonyms_curators_id" BIGINT,
    "curators_idx" INTEGER
);

-- CreateTable
CREATE TABLE "tag_links" (
    "id" BIGINT NOT NULL,
    "tag_id" BIGINT NOT NULL,
    "tag_ref" BIGINT NOT NULL,
    "type" VARCHAR(255) NOT NULL,

    CONSTRAINT "tag_links_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tags" (
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "tags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "taxonomic_coverage" (
    "id" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,
    "rank" VARCHAR(255) NOT NULL,
    "scientific_name" VARCHAR(255) NOT NULL,

    CONSTRAINT "taxonomic_coverage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "taxonomic_coverages" (
    "id" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,
    "general_taxonomic_coverage" VARCHAR(255) NOT NULL,

    CONSTRAINT "taxonomic_coverages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "taxonomy_definition" (
    "id" BIGINT NOT NULL,
    "binomial_form" VARCHAR(255),
    "canonical_form" VARCHAR(255) NOT NULL,
    "external_links_id" BIGINT,
    "group_id" BIGINT,
    "italicised_form" VARCHAR(255),
    "name" VARCHAR(255) NOT NULL,
    "normalized_form" VARCHAR(255),
    "rank" VARCHAR NOT NULL,
    "threatened_status" VARCHAR(255),
    "upload_time" TIMESTAMP(6),
    "uploader_id" BIGINT,
    "status" VARCHAR(255),
    "position" VARCHAR(255),
    "author_year" VARCHAR(255),
    "match_database_name" TEXT,
    "match_id" VARCHAR(255),
    "ibp_source" VARCHAR(255),
    "via_datasource" TEXT,
    "is_flagged" BOOLEAN,
    "lowercase_match_name" VARCHAR(255),
    "col_name_status" VARCHAR(255),
    "old_id" VARCHAR(255),
    "relationship" VARCHAR(255),
    "class" VARCHAR(255) NOT NULL,
    "flagging_reason" VARCHAR(1500),
    "no_ofcolmatches" INTEGER,
    "is_deleted" BOOLEAN,
    "dirty_list_reason" VARCHAR(1000),
    "activity_description" VARCHAR(2000),
    "default_hierarchy" TEXT,
    "species_id" BIGINT,
    "name_source_id" VARCHAR(255),
    "traits" BIGINT[],
    "traits_json" JSON,

    CONSTRAINT "taxonomy_definition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "taxonomy_definition_author" (
    "taxonomy_definition_id" BIGINT,
    "author_string" VARCHAR(255)
);

-- CreateTable
CREATE TABLE "taxonomy_definition_backup" (
    "id" BIGINT,
    "binomial_form" VARCHAR(255),
    "canonical_form" VARCHAR(255),
    "external_links_id" BIGINT,
    "group_id" BIGINT,
    "italicised_form" VARCHAR(255),
    "name" VARCHAR(255),
    "normalized_form" VARCHAR(255),
    "rank" INTEGER,
    "threatened_status" VARCHAR(255),
    "upload_time" TIMESTAMP(6),
    "uploader_id" BIGINT,
    "status" VARCHAR(255),
    "position" VARCHAR(255),
    "author_year" VARCHAR(255),
    "match_database_name" TEXT,
    "match_id" VARCHAR(255),
    "ibp_source" VARCHAR(255),
    "via_datasource" TEXT,
    "is_flagged" BOOLEAN,
    "lowercase_match_name" VARCHAR(255),
    "col_name_status" VARCHAR(255),
    "old_id" VARCHAR(255),
    "relationship" VARCHAR(255),
    "class" VARCHAR(255),
    "flagging_reason" VARCHAR(1500),
    "no_ofcolmatches" INTEGER,
    "is_deleted" BOOLEAN,
    "dirty_list_reason" VARCHAR(1000),
    "activity_description" VARCHAR(2000),
    "default_hierarchy" TEXT,
    "species_id" BIGINT,
    "name_source_id" VARCHAR(255),
    "traits" BIGINT[],
    "traits_json" JSON
);

-- CreateTable
CREATE TABLE "taxonomy_definition_suser" (
    "taxonomy_definition_contributors_id" BIGINT,
    "suser_id" BIGINT,
    "contributors_idx" INTEGER,
    "taxonomy_definition_curators_id" BIGINT,
    "curators_idx" INTEGER
);

-- CreateTable
CREATE TABLE "taxonomy_definition_year" (
    "taxonomy_definition_id" BIGINT,
    "year_string" VARCHAR(255)
);

-- CreateTable
CREATE TABLE "taxonomy_rank" (
    "id" BIGINT NOT NULL,
    "isdeleted" BOOLEAN,
    "isrequired" BOOLEAN,
    "name" VARCHAR(255),
    "rankvalue" DOUBLE PRECISION,

    CONSTRAINT "taxonomy_rank_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "taxonomy_registry" (
    "id" BIGINT NOT NULL,
    "classification_id" BIGINT,
    "path" ltree,
    "rank" VARCHAR(255) NOT NULL,
    "taxon_definition_id" BIGINT,
    "upload_time" TIMESTAMP(6),
    "uploader_id" BIGINT,

    CONSTRAINT "taxonomy_registry_pkey1" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "taxonomy_registry_backup" (
    "id" BIGINT,
    "version" BIGINT,
    "classification_id" BIGINT,
    "parent_taxon_id" BIGINT,
    "taxon_definition_id" BIGINT,
    "upload_time" TIMESTAMP(6),
    "uploader_id" BIGINT,
    "parent_taxon_definition_id" BIGINT,
    "rank" VARCHAR(255) NOT NULL,
    "path" ltree
);

-- CreateTable
CREATE TABLE "taxonomy_registry_backup_without_correction" (
    "id" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,
    "classification_id" BIGINT NOT NULL,
    "parent_taxon_id" BIGINT,
    "path" VARCHAR(255) NOT NULL,
    "taxon_definition_id" BIGINT NOT NULL,
    "upload_time" TIMESTAMP(6),
    "uploader_id" BIGINT,
    "parent_taxon_definition_id" BIGINT,

    CONSTRAINT "taxonomy_registry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "taxonomy_registry_suser" (
    "taxonomy_registry_contributors_id" BIGINT,
    "suser_id" BIGINT,
    "contributors_idx" INTEGER
);

-- CreateTable
CREATE TABLE "taxonomyesdocument" (
    "id" BIGINT NOT NULL,
    "accepted_ids" BIGINT[],
    "accepted_names" TEXT[],
    "canonical_form" VARCHAR(255),
    "common_names" JSON,
    "group_id" BIGINT,
    "group_name" VARCHAR(255),
    "hierarchy" JSON,
    "italicised_form" VARCHAR(255),
    "name" VARCHAR(255),
    "path" VARCHAR(255),
    "position" VARCHAR(255),
    "rank" VARCHAR(255),
    "status" VARCHAR(255),

    CONSTRAINT "taxonomyesdocument_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "template_header" (
    "id" BIGINT NOT NULL,
    "header" TEXT,
    "is_deleted" BOOLEAN,
    "language_id" BIGINT,
    "template_id" BIGINT,

    CONSTRAINT "template_header_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "text_curation_sheets" (
    "id" BIGSERIAL NOT NULL,
    "locations" VARCHAR,
    "scientificNamesGNRD" VARCHAR,
    "scientificNamesFlashtext" VARCHAR,
    "day" VARCHAR,
    "month" VARCHAR,
    "year" VARCHAR,
    "checklistAnnotations" TEXT,
    "snamesInputs" TEXT,
    "locationsInputs" TEXT,
    "datesInputs" TEXT,
    "uploader" BIGINT,
    "curatedSName" VARCHAR,
    "curatedLocation" VARCHAR,
    "curatedDate" VARCHAR,
    "curatedDateFormat" "dateformat",
    "sheetId" BIGINT NOT NULL,
    "lastUpdated" TIMESTAMP(6),
    "peliasLocations" TEXT,
    "taxonomyMatchedNames" TEXT,
    "taxonId" TEXT,
    "rank" TEXT,
    "hierarchy" TEXT,
    "longitude" DOUBLE PRECISION,
    "latitude" DOUBLE PRECISION,
    "curatedStatus" "status" DEFAULT 'PENDING',
    "locationAccuracy" TEXT,
    "validatedStatus" TEXT DEFAULT 'Not validated',
    "country" TEXT,
    "countryCode" TEXT,
    "curatedBy" TEXT,
    "verifiedBy" TEXT,

    CONSTRAINT "text_curation_sheets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "text_curation_sheets_metadata" (
    "id" BIGSERIAL NOT NULL,
    "title" VARCHAR,
    "description" VARCHAR,
    "contributors" VARCHAR,
    "validators" TEXT,

    CONSTRAINT "text_curation_sheets_metadata_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "trait" (
    "id" BIGINT NOT NULL,
    "created_on" TIMESTAMP(6) NOT NULL,
    "data_types" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "field_id" BIGINT NOT NULL,
    "icon" TEXT,
    "is_deleted" BOOLEAN NOT NULL,
    "last_revised" TIMESTAMP(6) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "source" VARCHAR(255),
    "trait_types" VARCHAR(255) NOT NULL,
    "units" VARCHAR(255),
    "is_not_observation_trait" BOOLEAN DEFAULT false,
    "show_in_observation" BOOLEAN DEFAULT false,
    "is_participatory" BOOLEAN DEFAULT true,

    CONSTRAINT "trait_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "trait_taxonomy_definition" (
    "trait_taxon_id" BIGINT,
    "taxonomy_definition_id" BIGINT
);

-- CreateTable
CREATE TABLE "trait_value" (
    "id" BIGINT NOT NULL,
    "description" TEXT,
    "icon" VARCHAR(255),
    "source" VARCHAR(255) NOT NULL,
    "trait_instance_id" BIGINT NOT NULL,
    "value" VARCHAR(255) NOT NULL,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "trait_value_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ufile" (
    "id" BIGINT NOT NULL,
    "mimetype" VARCHAR(255),
    "path" VARCHAR(255) NOT NULL,
    "size" VARCHAR(255) NOT NULL,
    "weight" INTEGER NOT NULL,

    CONSTRAINT "ufile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ug_filter_rule" (
    "id" BIGINT NOT NULL,
    "has_created_date_rule" BOOLEAN,
    "has_observed_date_rule" BOOLEAN,
    "has_spatial_rule" BOOLEAN,
    "has_taxonomic_rule" BOOLEAN,
    "has_user_rule" BOOLEAN,
    "ug_id" BIGINT,

    CONSTRAINT "ug_filter_rule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ug_obv_created_date_rule" (
    "id" BIGINT NOT NULL,
    "from_date" TIMESTAMP(6),
    "is_enabled" BOOLEAN,
    "to_date" TIMESTAMP(6),
    "ug_id" BIGINT,

    CONSTRAINT "ug_obv_created_date_rule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ug_obv_obsered_date_rule" (
    "id" BIGINT NOT NULL,
    "from_date" TIMESTAMP(6),
    "is_enabled" BOOLEAN,
    "to_date" TIMESTAMP(6),
    "ug_id" BIGINT,

    CONSTRAINT "ug_obv_obsered_date_rule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ug_spatial_data" (
    "id" BIGINT NOT NULL,
    "is_enabled" BOOLEAN,
    "spatial_data" TEXT,
    "ug_id" BIGINT,

    CONSTRAINT "ug_spatial_data_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ug_taxonomic_rule" (
    "id" BIGINT NOT NULL,
    "is_enabled" BOOLEAN,
    "taxonomy_id" BIGINT,
    "ug_id" BIGINT,

    CONSTRAINT "ug_taxonomic_rule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "upload_log" (
    "id" BIGINT NOT NULL,
    "version" BIGINT NOT NULL,
    "author_id" BIGINT NOT NULL,
    "end_date" TIMESTAMP(6),
    "error_file_path" VARCHAR(255),
    "file_path" VARCHAR(255),
    "log_file" BYTEA,
    "log_file_path" VARCHAR(255),
    "notes" TEXT,
    "params_map_as_text" TEXT,
    "start_date" TIMESTAMP(6) NOT NULL,
    "status" VARCHAR(255) NOT NULL,
    "upload_type" VARCHAR(255),
    "class" VARCHAR(255) NOT NULL,
    "images_dir" VARCHAR(255),
    "species_created" INTEGER,
    "species_updated" INTEGER,
    "stubs_created" INTEGER,
    "data_table_id" BIGINT,
    "no_created" INTEGER,
    "no_updated" INTEGER,

    CONSTRAINT "upload_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "uploaded_file_metadata" (
    "id" BIGINT NOT NULL,
    "file_new_name" VARCHAR(255) NOT NULL,
    "file_original_name" VARCHAR(255) NOT NULL,
    "movement_date" TIMESTAMP(6) NOT NULL,
    "type" VARCHAR(255) NOT NULL,
    "user_id" BIGINT NOT NULL,

    CONSTRAINT "uploaded_file_metadata_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_group" (
    "id" BIGINT NOT NULL,
    "allow_members_to_make_species_call" BOOLEAN NOT NULL,
    "allow_non_members_to_comment" BOOLEAN NOT NULL,
    "allow_obv_cross_posting" BOOLEAN NOT NULL,
    "allow_users_to_join" BOOLEAN NOT NULL,
    "description" TEXT NOT NULL,
    "domain_name" VARCHAR(255),
    "founded_on" TIMESTAMP(6) NOT NULL,
    "home_page" VARCHAR(255),
    "icon" VARCHAR(255),
    "is_deleted" BOOLEAN NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "ne_latitude" REAL NOT NULL,
    "ne_longitude" REAL NOT NULL,
    "sw_latitude" REAL NOT NULL,
    "sw_longitude" REAL NOT NULL,
    "theme" VARCHAR(255),
    "visit_count" BIGINT NOT NULL,
    "webaddress" VARCHAR(255) NOT NULL,
    "language_id" BIGINT NOT NULL,
    "stat_start_date" TIMESTAMP(6) NOT NULL,
    "show_gallery" BOOLEAN DEFAULT true,
    "show_grid_map" BOOLEAN DEFAULT true,
    "show_partners" BOOLEAN DEFAULT true,
    "show_recent_obv" BOOLEAN DEFAULT true,
    "show_stats" BOOLEAN DEFAULT true,
    "show_desc" BOOLEAN DEFAULT false,
    "filter_rule" VARCHAR(255),
    "new_filter_rule" TEXT,
    "send_digest_mail" BOOLEAN,

    CONSTRAINT "user_group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_group_cf_mapping" (
    "id" BIGINT NOT NULL,
    "allowed_participation" BOOLEAN,
    "author_id" BIGINT,
    "custom_field_id" BIGINT,
    "deafult_value" VARCHAR(255),
    "display_order" INTEGER,
    "is_mandatory" BOOLEAN,
    "user_group_id" BIGINT,

    CONSTRAINT "user_group_cf_mapping_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_group_data_tables" (
    "data_table_id" BIGINT NOT NULL,
    "user_group_id" BIGINT NOT NULL,

    CONSTRAINT "user_group_data_tables_pkey" PRIMARY KEY ("user_group_id","data_table_id")
);

-- CreateTable
CREATE TABLE "user_group_datasets" (
    "dataset1_id" BIGINT NOT NULL,
    "user_group_id" BIGINT NOT NULL,

    CONSTRAINT "user_group_datasets_pkey" PRIMARY KEY ("user_group_id","dataset1_id")
);

-- CreateTable
CREATE TABLE "user_group_discussions" (
    "user_group_id" BIGINT NOT NULL,
    "discussion_id" BIGINT NOT NULL,

    CONSTRAINT "user_group_discussions_pkey" PRIMARY KEY ("user_group_id","discussion_id")
);

-- CreateTable
CREATE TABLE "user_group_documents" (
    "user_group_id" BIGINT NOT NULL,
    "document_id" BIGINT NOT NULL,

    CONSTRAINT "user_group_documents_pkey" PRIMARY KEY ("user_group_id","document_id")
);

-- CreateTable
CREATE TABLE "user_group_habitat" (
    "user_group_habitats_id" BIGINT,
    "habitat_id" BIGINT
);

-- CreateTable
CREATE TABLE "user_group_invitaion" (
    "id" BIGINT NOT NULL,
    "email" VARCHAR(255),
    "invitee_id" BIGINT,
    "inviter_id" BIGINT,
    "role_id" BIGINT,
    "user_group_id" BIGINT,

    CONSTRAINT "user_group_invitaion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_group_join_request" (
    "id" BIGINT NOT NULL,
    "user_group_id" BIGINT,
    "user_id" BIGINT,

    CONSTRAINT "user_group_join_request_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_group_member_role" (
    "user_group_id" BIGINT NOT NULL,
    "role_id" BIGINT NOT NULL,
    "s_user_id" BIGINT NOT NULL,

    CONSTRAINT "user_group_member_role_pkey" PRIMARY KEY ("user_group_id","role_id","s_user_id")
);

-- CreateTable
CREATE TABLE "user_group_observations" (
    "user_group_id" BIGINT NOT NULL,
    "observation_id" BIGINT NOT NULL,

    CONSTRAINT "user_group_observations_pkey" PRIMARY KEY ("user_group_id","observation_id")
);

-- CreateTable
CREATE TABLE "user_group_species" (
    "species_id" BIGINT NOT NULL,
    "user_group_id" BIGINT NOT NULL,

    CONSTRAINT "user_group_species_pkey" PRIMARY KEY ("user_group_id","species_id")
);

-- CreateTable
CREATE TABLE "user_group_species_group" (
    "user_group_species_groups_id" BIGINT,
    "species_group_id" BIGINT
);

-- CreateTable
CREATE TABLE "usergroup_user_join_request" (
    "id" BIGINT NOT NULL,
    "user_group_id" BIGINT,
    "user_id" BIGINT,

    CONSTRAINT "usergroup_user_join_request_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "accepted_synonym_synonym_id_accepted_id_key" ON "accepted_synonym"("synonym_id", "accepted_id");

-- CreateIndex
CREATE UNIQUE INDEX "unique_accepted_id" ON "accepted_synonym"("synonym_id", "accepted_id");

-- CreateIndex
CREATE INDEX "activity_feed_root_holder_type_activity_type_is_showable_da_idx" ON "activity_feed"("root_holder_type", "activity_type", "is_showable", "date_created");

-- CreateIndex
CREATE INDEX "last_updated_idx" ON "activity_feed"("last_updated");

-- CreateIndex
CREATE INDEX "lastupdated_index" ON "activity_feed"("last_updated");

-- CreateIndex
CREATE INDEX "root_holder_id_idx" ON "activity_feed"("root_holder_id");

-- CreateIndex
CREATE INDEX "root_holder_type_idx" ON "activity_feed"("root_holder_type");

-- CreateIndex
CREATE INDEX "rootholderid_index" ON "activity_feed"("root_holder_id");

-- CreateIndex
CREATE INDEX "rootholdertype_index" ON "activity_feed"("root_holder_type");

-- CreateIndex
CREATE INDEX "sub_root_holder_id_idx" ON "activity_feed"("sub_root_holder_id");

-- CreateIndex
CREATE INDEX "sub_root_holder_type_idx" ON "activity_feed"("sub_root_holder_type");

-- CreateIndex
CREATE INDEX "subrootholderid_index" ON "activity_feed"("sub_root_holder_id");

-- CreateIndex
CREATE INDEX "subrootholdertype_index" ON "activity_feed"("sub_root_holder_type");

-- CreateIndex
CREATE UNIQUE INDEX "character_entity_ch_key" ON "character_entity"("ch");

-- CreateIndex
CREATE UNIQUE INDEX "classification_name_key" ON "classification"("name");

-- CreateIndex
CREATE INDEX "comment_holder_id_idx" ON "comment"("comment_holder_id");

-- CreateIndex
CREATE INDEX "comment_holder_type_idx" ON "comment"("comment_holder_type");

-- CreateIndex
CREATE INDEX "comment_lastupdated_index" ON "comment"("last_updated");

-- CreateIndex
CREATE INDEX "comment_rootholderid_index" ON "comment"("root_holder_id");

-- CreateIndex
CREATE INDEX "comment_rootholdertype_index" ON "comment"("root_holder_type");

-- CreateIndex
CREATE INDEX "commentholderid_index" ON "comment"("comment_holder_id");

-- CreateIndex
CREATE INDEX "commentholdertype_index" ON "comment"("comment_holder_type");

-- CreateIndex
CREATE INDEX "common_names_lowercase_name" ON "common_names"("lowercase_name");

-- CreateIndex
CREATE UNIQUE INDEX "common_names_taxon_concept_id_key" ON "common_names"("taxon_concept_id", "language_id", "name");

-- CreateIndex
CREATE UNIQUE INDEX "unique_name" ON "common_names"("taxon_concept_id", "language_id", "name");

-- CreateIndex
CREATE UNIQUE INDEX "country_two_letter_code_key" ON "country"("two_letter_code");

-- CreateIndex
CREATE INDEX "fact_trait_value_id_object_id_object_type_trait_id_key" ON "fact"("trait_value_id", "object_id", "object_type", "trait_instance_id");

-- CreateIndex
CREATE UNIQUE INDEX "fact_object_id_page_taxon_id_trait_id_trait_value_id_key" ON "fact"("object_id", "page_taxon_id", "trait_instance_id", "trait_value_id");

-- CreateIndex
CREATE UNIQUE INDEX "unique_trait_instance_id" ON "fact"("trait_value_id", "object_id", "object_type", "trait_instance_id");

-- CreateIndex
CREATE UNIQUE INDEX "featured_user_group_id_key" ON "featured"("user_group_id", "object_type", "object_id", "author_id");

-- CreateIndex
CREATE UNIQUE INDEX "unique_author_id" ON "featured"("user_group_id", "object_type", "object_id", "author_id");

-- CreateIndex
CREATE UNIQUE INDEX "flag_author_type_id" ON "flag"("author_id", "object_id", "object_type");

-- CreateIndex
CREATE UNIQUE INDEX "follow_user_id_key" ON "follow"("author_id", "object_id", "object_type");

-- CreateIndex
CREATE UNIQUE INDEX "unique_object_type" ON "follow"("author_id", "object_id", "object_type");

-- CreateIndex
CREATE UNIQUE INDEX "habitat_name_key" ON "habitat"("name");

-- CreateIndex
CREATE UNIQUE INDEX "language_three_letter_code_key" ON "language"("three_letter_code");

-- CreateIndex
CREATE INDEX "observation_dataset_id_idx" ON "observation"("dataset_id");

-- CreateIndex
CREATE INDEX "observation_group_id_idx" ON "observation"("group_id");

-- CreateIndex
CREATE INDEX "observation_ischecklist_isdeleted_isshowable_idx" ON "observation"("is_checklist", "is_deleted", "is_showable");

-- CreateIndex
CREATE INDEX "observation_last_revised_id_idx" ON "observation"("last_revised" DESC, "id");

-- CreateIndex
CREATE INDEX "observation_max_voted_reco_id_idx" ON "observation"("max_voted_reco_id");

-- CreateIndex
CREATE INDEX "observation_topology_gist" ON "observation" USING GIST ("topology");

-- CreateIndex
CREATE INDEX "recommendation_lowercase_name" ON "recommendation"("lowercase_name");

-- CreateIndex
CREATE INDEX "recommendation_name_idx" ON "recommendation" USING GIST ("name" gist_trgm_ops);

-- CreateIndex
CREATE INDEX "recommendation_taxon_concept_id_idx" ON "recommendation"("taxon_concept_id");

-- CreateIndex
CREATE INDEX "recommendation_taxon_concept_id_idx1" ON "recommendation"("taxon_concept_id");

-- CreateIndex
CREATE UNIQUE INDEX "recommendation_taxon_concept_id_key" ON "recommendation"("taxon_concept_id", "accepted_name_id", "name", "language_id");

-- CreateIndex
CREATE UNIQUE INDEX "recommendation_vote_author_id_key" ON "recommendation_vote"("author_id", "observation_id");

-- CreateIndex
CREATE UNIQUE INDEX "role_authority_key" ON "role"("authority");

-- CreateIndex
CREATE INDEX "species_is_deleted_idx" ON "species"("is_deleted");

-- CreateIndex
CREATE UNIQUE INDEX "species_group_name_key" ON "species_group"("name");

-- CreateIndex
CREATE UNIQUE INDEX "species_group_mapping_rank_key" ON "species_group_mapping"("rank", "taxon_name");

-- CreateIndex
CREATE UNIQUE INDEX "unique_taxon_name" ON "species_group_mapping"("rank", "taxon_name");

-- CreateIndex
CREATE UNIQUE INDEX "suser_email_key" ON "suser"("email");

-- CreateIndex
CREATE UNIQUE INDEX "synonyms_canonical_form_key" ON "synonyms"("canonical_form", "taxon_concept_id", "relationship");

-- CreateIndex
CREATE UNIQUE INDEX "unique_canonical_form" ON "synonyms"("taxon_concept_id", "relationship", "canonical_form");

-- CreateIndex
CREATE INDEX "tag_links_tag_id_type_idx" ON "tag_links"("tag_id", "type");

-- CreateIndex
CREATE UNIQUE INDEX "tags_name_key" ON "tags"("name");

-- CreateIndex
CREATE INDEX "idx_canonical_form" ON "taxonomy_definition"("canonical_form", "rank", "is_deleted");

-- CreateIndex
CREATE INDEX "match_id_idx" ON "taxonomy_definition"("match_id");

-- CreateIndex
CREATE INDEX "normalized_form_idx" ON "taxonomy_definition"("normalized_form");

-- CreateIndex
CREATE INDEX "position_idx" ON "taxonomy_definition"("position");

-- CreateIndex
CREATE INDEX "rank_idx" ON "taxonomy_definition"("rank");

-- CreateIndex
CREATE INDEX "status_idx" ON "taxonomy_definition"("status");

-- CreateIndex
CREATE INDEX "taxonomy_definition_canonical_form_idx" ON "taxonomy_definition" USING GIST ("canonical_form" gist_trgm_ops);

-- CreateIndex
CREATE INDEX "taxonomy_definition_lowercase_match_name" ON "taxonomy_definition"("lowercase_match_name");

-- CreateIndex
CREATE INDEX "taxonomy_definition_traits" ON "taxonomy_definition" USING GIN ("traits");

-- CreateIndex
CREATE INDEX "idx_path" ON "taxonomy_registry" USING GIST ("path");

-- CreateIndex
CREATE INDEX "taxon_registry_path_idx" ON "taxonomy_registry_backup_without_correction" USING GIN ("path" gin_trgm_ops);

-- CreateIndex
CREATE UNIQUE INDEX "taxonomy_registry_path_key" ON "taxonomy_registry_backup_without_correction"("path", "classification_id", "taxon_definition_id");

-- CreateIndex
CREATE UNIQUE INDEX "unique_taxon_definition_id" ON "taxonomy_registry_backup_without_correction"("path", "classification_id", "taxon_definition_id");

-- CreateIndex
CREATE UNIQUE INDEX "trait_value_value_trait_id_key" ON "trait_value"("value", "trait_instance_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_group_name_key" ON "user_group"("name");

-- CreateIndex
CREATE UNIQUE INDEX "user_group_webaddress_key" ON "user_group"("webaddress");

-- CreateIndex
CREATE UNIQUE INDEX "uknhbb6rd8n7x28b6ft6ijuq3g6" ON "user_group_member_role"("user_group_id", "s_user_id");

-- AddForeignKey
ALTER TABLE "accepted_synonym" ADD CONSTRAINT "fkf05ceb6330c91a49" FOREIGN KEY ("accepted_id") REFERENCES "taxonomy_definition"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "accepted_synonym" ADD CONSTRAINT "fkf05ceb6357b8c415" FOREIGN KEY ("synonym_id") REFERENCES "taxonomy_definition"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "classification" ADD CONSTRAINT "language_id" FOREIGN KEY ("language_id") REFERENCES "language"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "common_names" ADD CONSTRAINT "fk1b2d07f4a2a94b4c" FOREIGN KEY ("language_id") REFERENCES "language"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "common_names" ADD CONSTRAINT "fk1b2d07f4b3cf407d" FOREIGN KEY ("taxon_concept_id") REFERENCES "taxonomy_definition"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "common_names" ADD CONSTRAINT "fk1b2d07f4bf80ff76" FOREIGN KEY ("uploader_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "data_package" ADD CONSTRAINT "fka7b680b1d7a6cb39" FOREIGN KEY ("author_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "data_table" ADD CONSTRAINT "data_table_upload_log_id_fkey" FOREIGN KEY ("upload_log_id") REFERENCES "upload_log"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "data_table" ADD CONSTRAINT "fk608fa6f934c02b86" FOREIGN KEY ("u_file_id") REFERENCES "ufile"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "data_table" ADD CONSTRAINT "fk608fa6f97145fa89" FOREIGN KEY ("images_file_id") REFERENCES "ufile"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "data_table" ADD CONSTRAINT "fk608fa6f999501411" FOREIGN KEY ("trait_value_file_id") REFERENCES "ufile"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "data_table" ADD CONSTRAINT "fk608fa6f9a2a94b4c" FOREIGN KEY ("language_id") REFERENCES "language"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "data_table" ADD CONSTRAINT "fk608fa6f9bf80ff76" FOREIGN KEY ("uploader_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "data_table" ADD CONSTRAINT "fk608fa6f9e8469043" FOREIGN KEY ("dataset_id") REFERENCES "dataset1"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dataset" ADD CONSTRAINT "fk5605b47813516b48" FOREIGN KEY ("license_id") REFERENCES "license"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dataset" ADD CONSTRAINT "fk5605b47834c02b86" FOREIGN KEY ("u_file_id") REFERENCES "ufile"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dataset" ADD CONSTRAINT "fk5605b4785ed86a37" FOREIGN KEY ("data_language_id") REFERENCES "language"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dataset" ADD CONSTRAINT "fk5605b478a2a94b4c" FOREIGN KEY ("language_id") REFERENCES "language"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dataset" ADD CONSTRAINT "fk5605b478d7a6cb39" FOREIGN KEY ("author_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dataset1" ADD CONSTRAINT "fk6ab0dab934c02b86" FOREIGN KEY ("u_file_id") REFERENCES "ufile"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dataset1" ADD CONSTRAINT "fk6ab0dab9838c205d" FOREIGN KEY ("data_package_id") REFERENCES "data_package"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dataset1" ADD CONSTRAINT "fk6ab0dab9a2a94b4c" FOREIGN KEY ("language_id") REFERENCES "language"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dataset1" ADD CONSTRAINT "fk6ab0dab9bf80ff76" FOREIGN KEY ("uploader_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "discussion" ADD CONSTRAINT "fk2a233828a2a94b4c" FOREIGN KEY ("language_id") REFERENCES "language"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "discussion" ADD CONSTRAINT "fk2a233828d7a6cb39" FOREIGN KEY ("author_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "document_habitat" ADD CONSTRAINT "fk4e67cd8333ba4988" FOREIGN KEY ("habitat_id") REFERENCES "habitat"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "document_habitat" ADD CONSTRAINT "fk4e67cd83ff170ae4" FOREIGN KEY ("document_habitats_id") REFERENCES "document"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "document_species_group" ADD CONSTRAINT "fk8014d5984280079" FOREIGN KEY ("document_species_groups_id") REFERENCES "document"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "document_species_group" ADD CONSTRAINT "fk8014d598500b4369" FOREIGN KEY ("species_group_id") REFERENCES "species_group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "download_log" ADD CONSTRAINT "fk4220170dd7a6cb39" FOREIGN KEY ("author_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "file_downloads" ADD CONSTRAINT "fkpumnqroc2jntuxed6vstyh990" FOREIGN KEY ("user_id") REFERENCES "file_download_credentials"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "firebase_tokens" ADD CONSTRAINT "fkrnu6jh1q2jtanlp44d0nnd7st" FOREIGN KEY ("user_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "newsletter" ADD CONSTRAINT "fk41b804b9159e68fb" FOREIGN KEY ("user_group_id") REFERENCES "user_group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "newsletter" ADD CONSTRAINT "fk41b804b9a2a94b4c" FOREIGN KEY ("language_id") REFERENCES "language"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "resource_crop_info" ADD CONSTRAINT "resource_crop_info_id_fkey" FOREIGN KEY ("id") REFERENCES "resource"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "species_bulk_upload" ADD CONSTRAINT "fk759f674bd7a6cb39" FOREIGN KEY ("author_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "species_data_table" ADD CONSTRAINT "fk_5dohryes6w8xcmtyffg2stx2f" FOREIGN KEY ("species_data_tables_id") REFERENCES "species"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "species_data_table" ADD CONSTRAINT "fk_udvmhk40d35wajfle1e38t4b" FOREIGN KEY ("data_table_id") REFERENCES "data_table"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "species_group" ADD CONSTRAINT "fkf087bdbc7f47f7bb" FOREIGN KEY ("parent_group_id") REFERENCES "species_group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "species_group_mapping" ADD CONSTRAINT "fka038014b500b4369" FOREIGN KEY ("species_group_id") REFERENCES "species_group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "species_group_mapping" ADD CONSTRAINT "fka038014bb3cf407d" FOREIGN KEY ("taxon_concept_id") REFERENCES "taxonomy_definition"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "species_permission" ADD CONSTRAINT "fkaabafcb2b3cf407d" FOREIGN KEY ("taxon_concept_id") REFERENCES "taxonomy_definition"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "species_permission" ADD CONSTRAINT "fkaabafcb2d7a6cb39" FOREIGN KEY ("author_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "suser_habitat" ADD CONSTRAINT "fka870242633ba4988" FOREIGN KEY ("habitat_id") REFERENCES "habitat"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "suser_habitat" ADD CONSTRAINT "fka87024266dbe4477" FOREIGN KEY ("suser_habitats_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "suser_role" ADD CONSTRAINT "fk7wmffpkjywyqxt0g3c9fhwpgp" FOREIGN KEY ("role_id") REFERENCES "role"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "suser_role" ADD CONSTRAINT "fkeyo72av5xp29aj6mjrpoqpsnx" FOREIGN KEY ("s_user_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "suser_species_group" ADD CONSTRAINT "fk3a9c65fb500b4369" FOREIGN KEY ("species_group_id") REFERENCES "species_group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "suser_species_group" ADD CONSTRAINT "fk3a9c65fba99b93cc" FOREIGN KEY ("suser_species_groups_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "synonyms" ADD CONSTRAINT "fk6cfe43d8b3cf407d" FOREIGN KEY ("taxon_concept_id") REFERENCES "taxonomy_definition"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "synonyms" ADD CONSTRAINT "fk6cfe43d8bf80ff76" FOREIGN KEY ("uploader_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "synonyms_suser" ADD CONSTRAINT "fkc2e9df9721150126" FOREIGN KEY ("suser_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "synonyms_suser" ADD CONSTRAINT "fkc2e9df97c09419c5" FOREIGN KEY ("synonyms_contributors_id") REFERENCES "synonyms"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_definition" ADD CONSTRAINT "fkaf4cb01a9dfafc6" FOREIGN KEY ("group_id") REFERENCES "species_group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_definition" ADD CONSTRAINT "fkaf4cb01bf80ff76" FOREIGN KEY ("uploader_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_definition" ADD CONSTRAINT "fkaf4cb01c6232b1" FOREIGN KEY ("external_links_id") REFERENCES "external_links"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_definition" ADD CONSTRAINT "taxonomy_definition_species_id_fkey" FOREIGN KEY ("species_id") REFERENCES "species"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_definition_author" ADD CONSTRAINT "fkbe9f20897d7f8af" FOREIGN KEY ("taxonomy_definition_id") REFERENCES "taxonomy_definition"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_definition_suser" ADD CONSTRAINT "fk727ea40021150126" FOREIGN KEY ("suser_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_definition_suser" ADD CONSTRAINT "fk727ea40086e8f01a" FOREIGN KEY ("taxonomy_definition_contributors_id") REFERENCES "taxonomy_definition"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_definition_year" ADD CONSTRAINT "fk1c7a2ebb7d7f8af" FOREIGN KEY ("taxonomy_definition_id") REFERENCES "taxonomy_definition"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_registry_backup_without_correction" ADD CONSTRAINT "fk9ded596b7e532be5" FOREIGN KEY ("parent_taxon_id") REFERENCES "taxonomy_registry_backup_without_correction"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_registry_backup_without_correction" ADD CONSTRAINT "fk9ded596b7f084c68" FOREIGN KEY ("taxon_definition_id") REFERENCES "taxonomy_definition"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_registry_backup_without_correction" ADD CONSTRAINT "fk9ded596bb929a30c" FOREIGN KEY ("classification_id") REFERENCES "classification"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_registry_backup_without_correction" ADD CONSTRAINT "fk9ded596bbf80ff76" FOREIGN KEY ("uploader_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_registry_backup_without_correction" ADD CONSTRAINT "td_fk" FOREIGN KEY ("parent_taxon_definition_id") REFERENCES "taxonomy_definition"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_registry_suser" ADD CONSTRAINT "fk87a93aea21150126" FOREIGN KEY ("suser_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "taxonomy_registry_suser" ADD CONSTRAINT "fk87a93aea76e99a2e" FOREIGN KEY ("taxonomy_registry_contributors_id") REFERENCES "taxonomy_registry_backup_without_correction"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "text_curation_sheets" ADD CONSTRAINT "text_curation_sheets_sheetId_fkey" FOREIGN KEY ("sheetId") REFERENCES "text_curation_sheets_metadata"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "upload_log" ADD CONSTRAINT "fkf187f80650fa501d" FOREIGN KEY ("data_table_id") REFERENCES "data_table"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "upload_log" ADD CONSTRAINT "fkf187f806d7a6cb39" FOREIGN KEY ("author_id") REFERENCES "suser"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

