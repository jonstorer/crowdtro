authenticate = (req, res, next) ->
  return next() if req.isAuthenticated() || process.env.NODE_ENV == 'test'
  res.redirect('/login')

module.exports =
  authenticate: authenticate
