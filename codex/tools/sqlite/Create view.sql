CREATE VIEW over_view AS
  SELECT sites.site_id, sites.site_status, sites.site_name,
         sites.address_1, contracts.plan_id,
         plans.plan_name AS plan_name, contracts.contract_status
    FROM sites
    INNER JOIN contracts USING (site_id)
    INNER JOIN plans USING (plan_id)
    ORDER BY sites.site_id;
