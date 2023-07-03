
CREATE TABLE "public"."users" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "email" varchar NOT NULL, "phone" varchar NOT NULL, "org_id" uuid NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "deleted_at" timestamptz, "is_active" boolean NOT NULL DEFAULT false, PRIMARY KEY ("id") , UNIQUE ("id"), UNIQUE ("email"), UNIQUE ("phone"));
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_users_updated_at"
BEFORE UPDATE ON "public"."users"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_users_updated_at" ON "public"."users"
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;

alter table "public"."users" drop constraint "users_phone_key";

alter table "public"."users" drop constraint "users_email_key";

alter table "public"."users" add constraint "users_email_phone_id_key" unique ("email", "phone", "id");

alter table "public"."users" drop constraint "users_email_phone_id_key";
alter table "public"."users" add constraint "users_email_phone_id_org_id_key" unique ("email", "phone", "id", "org_id");
