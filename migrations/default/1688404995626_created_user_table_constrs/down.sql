
alter table "public"."users" drop constraint "users_email_phone_id_org_id_key";
alter table "public"."users" add constraint "users_email_phone_id_key" unique ("email", "phone", "id");

alter table "public"."users" drop constraint "users_email_phone_id_key";

alter table "public"."users" add constraint "users_email_key" unique ("email");

alter table "public"."users" add constraint "users_phone_key" unique ("phone");

DROP TABLE "public"."users";
