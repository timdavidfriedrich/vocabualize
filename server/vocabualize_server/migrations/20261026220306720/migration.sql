BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "activity" DROP COLUMN "type";
ALTER TABLE "activity" DROP COLUMN "occurredAt";
ALTER TABLE "activity" ADD COLUMN "deviceId" uuid;
ALTER TABLE "activity" ADD COLUMN "practicedCount" bigint NOT NULL DEFAULT 0;

--
-- ACTION DELETE SYNC METADATA OF DROPPED COLUMNS
--
DELETE FROM "crdt_data_attempted_value" WHERE "fieldId" IN (
    SELECT f."id" FROM "crdt_data_fields" f
    JOIN "crdt_schema_columns" c ON c."id" = f."columnId"
    JOIN "crdt_schema_tables" t ON t."id" = c."tblId"
    WHERE t."name" = 'activity' AND c."name" IN ('type', 'occurredAt')
);
DELETE FROM "crdt_data_fields" WHERE "columnId" IN (
    SELECT c."id" FROM "crdt_schema_columns" c
    JOIN "crdt_schema_tables" t ON t."id" = c."tblId"
    WHERE t."name" = 'activity' AND c."name" IN ('type', 'occurredAt')
);
DELETE FROM "crdt_schema_columns" WHERE "name" IN ('type', 'occurredAt') AND "tblId" IN (
    SELECT "id" FROM "crdt_schema_tables" WHERE "name" = 'activity'
);

--
-- MIGRATION VERSION FOR vocabualize
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('vocabualize', '20261026220306720', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261026220306720', "timestamp" = now();

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
