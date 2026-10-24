BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "activity" ADD COLUMN "extras" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "stored_image" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "imageId" uuid NOT NULL,
    "variant" text NOT NULL,
    "byteSize" bigint NOT NULL,
    "uploadedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "stored_image_owner_image_variant_idx" ON "stored_image" USING btree ("authUserId", "imageId", "variant");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "vocabulary_tag" ADD COLUMN "extras" text;

--
-- MIGRATION VERSION FOR vocabualize
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('vocabualize', '20261024132625738', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261024132625738', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_offline_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_offline_sync', '20260914143806119', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260914143806119', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
