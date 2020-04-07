local jobLocales = Locales.Get("en"):GetValue("jobs")

Configs.Add("jobs", Config.New({
  lspd = {
    label = jobLocales.lspd.label,
    roles = {
      officer = { label = jobLocales.lspd.roles.officer, perm = 1 },
      patrol = { label = jobLocales.lspd.roles.patrol, perm = 2 },
      detective = { label = jobLocales.lspd.roles.detective, perm = 3 },
      corporal = { label = jobLocales.lspd.roles.corporal, perm = 4 },
      sergeant = { label = jobLocales.lspd.roles.sergeant, perm = 5 },
      lieutenant = { label = jobLocales.lspd.roles.lieutenant, perm = 6 },
      captain = { label = jobLocales.lspd.roles.captain, perm = 7 },
      depchief = { label = jobLocales.lspd.roles.depchief, perm = 8 },
      chief = { label = jobLocales.lspd.roles.chief, perm = 9 }
    },
    certs = {
      k9 = { label = jobLocales.lspd.certs.k9 }
    }
  }
}))