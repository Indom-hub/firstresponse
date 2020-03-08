Locales = {}

function Locales.Add(key, locale)
  Locales[key] = locale
end

function Locales.Get(key)
  return Locales[key]
end