-- Schema public = registre global des tenants
CREATE TABLE IF NOT EXISTS tenants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    schema_name VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
    );

CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'USER',
    tenant_id UUID NOT NULL REFERENCES tenants(id),
    created_at TIMESTAMP DEFAULT NOW()
    );

-- Tenants de démo pour le dev
INSERT INTO tenants (slug, name, schema_name)
VALUES ('a', 'Cave de démonstration A', 'tenant_a')
    ON CONFLICT DO NOTHING;

INSERT INTO tenants (slug, name, schema_name)
VALUES ('b', 'Cave de démonstration B', 'tenant_b')
    ON CONFLICT DO NOTHING;

-- Schemas isolés pour les tenants a et b
CREATE SCHEMA IF NOT EXISTS tenant_a;
CREATE SCHEMA IF NOT EXISTS tenant_b;