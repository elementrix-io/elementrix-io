-- 1. Create schema if not exists
CREATE SCHEMA IF NOT EXISTS elementrix;

-- 2. Create 'permission' table if it does not exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM information_schema.tables
    WHERE table_schema = 'elementrix'
      AND table_name = 'permission'
  ) THEN
    CREATE TABLE elementrix.permission (
      id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
      access_level VARCHAR(255),
      client_id BIGINT,
      created_at TIMESTAMP,
      created_by VARCHAR(255),
      deletedAt TIMESTAMP,
      deleted_by VARCHAR(255),
      last_modified_at TIMESTAMP,
      last_modified_by VARCHAR(255),
      model_id BIGINT
      -- We will add rate_per_day and rate_per_hour separately for IF NOT EXISTS handling
    );
  END IF;
END
$$;

-- 3. Add 'rate_per_day' column if not exists
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_schema = 'elementrix'
      AND table_name = 'permission'
      AND column_name = 'rate_per_day'
  ) THEN
    ALTER TABLE elementrix.permission ADD COLUMN rate_per_day NUMERIC;
  END IF;
END
$$;

-- 4. Add 'rate_per_hour' column if not exists
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_schema = 'elementrix'
      AND table_name = 'permission'
      AND column_name = 'rate_per_hour'
  ) THEN
    ALTER TABLE elementrix.permission ADD COLUMN rate_per_hour NUMERIC;
  END IF;
END

