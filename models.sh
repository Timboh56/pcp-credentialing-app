#!/bin/bash
# ============================================================
# PCP Credentialing SaaS — Rails Model Generator Commands
# Run these in order from your Rails app root
# ============================================================

# ── 1. Account (SaaS billing/tenant anchor) ─────────────────
rails g model Account \
  name:string \
  subdomain:string \
  stripe_customer_id:string \
  plan:string \
  status:string

# ── 2. Organization (practice / hospital / clinic) ──────────
rails g model Organization \
  account:references \
  name:string \
  npi:string \
  tax_id:string

# ── 3. Provider (portable PCP identity) ─────────────────────
rails g model Provider \
  npi:string \
  first_name:string \
  last_name:string \
  degree:string \
  specialty:string \
  dea_expiry:date \
  license_expiry:date \
  caqh_id:string

# ── 4. ProviderMembership (provider ↔ org join, credentialing anchor) ──
rails g model ProviderMembership \
  provider:references \
  organization:references \
  status:string \
  effective_date:date \
  termination_date:date

# ── 5. Payor ────────────────────────────────────────────────
rails g model Payor \
  name:string \
  payor_id:string \
  credential_type:string

# ── 6. CredentialingApplication ─────────────────────────────
rails g model CredentialingApplication \
  provider_membership:references \
  payor:references \
  status:string \
  submitted_at:date \
  approved_at:date \
  effective_date:date \
  revalidation_due:date

# ── 7. PrivilegeType ─────────────────────────────────────────
rails g model PrivilegeType \
  organization:references \
  name:string \
  category:string \
  requires_committee_review:boolean

# ── 8. PrivilegeRequest ──────────────────────────────────────
rails g model PrivilegeRequest \
  provider_membership:references \
  privilege_type:references \
  status:string \
  requested_at:date \
  reviewed_at:date \
  expires_at:date \
  denial_reason:text

# ── 9. Committee ─────────────────────────────────────────────
rails g model Committee \
  organization:references \
  name:string \
  meeting_cadence:string

# ── 10. CommitteePrivilegeType (join: committee ↔ privilege_type) ──
rails g model CommitteePrivilegeType \
  committee:references \
  privilege_type:references

# ── 11. CommitteeReview ──────────────────────────────────────
rails g model CommitteeReview \
  committee:references \
  privilege_request:references \
  reviewed_by:references \
  decision:string \
  meeting_date:date \
  notes:text

# ============================================================
# After generating, run:
#   rails db:migrate
# ============================================================
