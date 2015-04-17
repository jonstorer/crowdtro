mongoPort = process.env.BOXEN_MONGODB_PORT || 27017

config =
  mongo: { url: "mongodb://localhost:#{mongoPort}/crowdtro_development" }
  logger: 'dev'
  port: process.env.PORT || 3000
  raygun: { apiKey: 'SBuL7PyTCi3Qgx2UkUqgGA==' }
  cookie: { secret: 'super-sekret' }
  session: { secret: 'sekret-so-super' }
  google:
    clientID: '533546687609-p8p1p5rggtvidudf5vifev2bh2rsm7ct.apps.googleusercontent.com'
    clientSecret: 'bX0Dm_dV3_FRGxTnNNGsHjSX'
    callbackURL: 'http://localhost:3000/auth/google/callback'

envMap =
  production: JSON.parse(JSON.stringify(config))
  local: JSON.parse(JSON.stringify(config))
  test: JSON.parse(JSON.stringify(config))

envMap.production.google.callbackURL = 'http://crowdtro.herokuapp.com/auth/google/callback'
envMap.production.logger = 'tiny'
envMap.production.mongo.url = process.env.MONGOLAB_URI

delete envMap.test.raygun
delete envMap.test.google
envMap.test.mongo.url = "mongodb://localhost:#{mongoPort}/crowdtro_test_#{mongoPort}"

module.exports = envMap[process.env.NODE_ENV] || envMap.local
