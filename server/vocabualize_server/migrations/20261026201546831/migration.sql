BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "ai_usage" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "account_tier" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "tier" text NOT NULL,
    "grantedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "account_tier_auth_user_idx" ON "account_tier" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "install" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "secretHash" text NOT NULL,
    "ipHash" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "lastUsedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "install_ip_hash_created_idx" ON "install" USING btree ("ipHash", "createdAt");
CREATE INDEX "install_created_idx" ON "install" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "service_usage" (
    "id" bigserial PRIMARY KEY,
    "ownerId" uuid NOT NULL,
    "kind" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "service_usage_owner_kind_created_idx" ON "service_usage" USING btree ("ownerId", "kind", "createdAt");
CREATE INDEX "service_usage_kind_created_idx" ON "service_usage" USING btree ("kind", "createdAt");


--
-- MIGRATION VERSION FOR vocabualize
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('vocabualize', '20261026201546831', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261026201546831', "timestamp" = now();

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
