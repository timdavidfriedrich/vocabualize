BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ai_usage" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "kind" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "ai_usage_owner_kind_created_idx" ON "ai_usage" USING btree ("authUserId", "kind", "createdAt");


--
-- MIGRATION VERSION FOR vocabualize
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('vocabualize', '20261025143436401', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261025143436401', "timestamp" = now();

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
