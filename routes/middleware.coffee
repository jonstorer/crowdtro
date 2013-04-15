authenticate = (req, res, next) ->
  return next() if req.isAuthenticated()
  res.redirect('/login')

module.exports =
  authenticate: authenticate
